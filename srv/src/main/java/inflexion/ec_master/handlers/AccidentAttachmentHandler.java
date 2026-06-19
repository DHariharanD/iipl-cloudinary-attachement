package inflexion.ec_master.handlers;

import cds.gen.accidentservice.AccidentAttachments;
import cds.gen.accidentservice.AccidentDraftActivateContext;
import cds.gen.accidentservice.AccidentService_;
import cds.gen.accidentservice.DeleteAccidentFileContext;
import cds.gen.accidentservice.UploadAccidentFileContext;

import com.sap.cds.Result;
import com.sap.cds.Row;
import com.sap.cds.ql.Delete;
import com.sap.cds.ql.Insert;
import com.sap.cds.ql.Select;
import com.sap.cds.ql.cqn.CqnAnalyzer;
import com.sap.cds.reflect.CdsModel;
import com.sap.cds.services.ErrorStatuses;
import com.sap.cds.services.ServiceException;
import com.sap.cds.services.EventContext;
import com.sap.cds.services.cds.CdsDeleteEventContext;
import com.sap.cds.services.cds.CdsUpdateEventContext;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.Before;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

@Component
@ServiceName(AccidentService_.CDS_NAME)
public class AccidentAttachmentHandler implements EventHandler
{
    private static final Logger log = LoggerFactory.getLogger(AccidentAttachmentHandler.class);

    private static final String ACTIVE_TABLE    = "AccidentService.AccidentAttachments";
    private static final String DRAFT_TABLE     = "AccidentService.AccidentAttachments.drafts";
    private static final String ACCIDENT_ACTIVE = "AccidentService.Accident";

    @Autowired
    private CloudinaryService cloudinaryService;

    @Autowired
    private PersistenceService db;

    // FIX 4 — inject CdsModel so CqnAnalyzer can extract keys from CQN references
    @Autowired
    private CdsModel model;

    // ── uploadAccidentFile ───────────────────────────────────────────────────

    @On(event = UploadAccidentFileContext.CDS_NAME)
    public void onUploadAccidentFile(UploadAccidentFileContext ctx)
    {
        String accidentId = ctx.getAccidentId();
        String fileName   = ctx.getFileName();
        String mediaType  = ctx.getMediaType();
        String content    = ctx.getContent();

        if (accidentId == null || accidentId.isBlank())
        {
            throw new ServiceException(ErrorStatuses.BAD_REQUEST, "accident_ID is required");
        }
        if (fileName == null || fileName.isBlank())
        {
            throw new ServiceException(ErrorStatuses.BAD_REQUEST, "fileName is required");
        }
        if (content == null || content.isBlank())
        {
            throw new ServiceException(ErrorStatuses.BAD_REQUEST, "content (base64) is required");
        }

        log.info("uploadAccidentFile: accidentId={}, fileName={}, mediaType={}",
                accidentId, fileName, mediaType);

        // ── Detect create-vs-edit ────────────────────────────────────────────
        Result existCheck = db.run(
                Select.from(ACCIDENT_ACTIVE)
                      .columns("ID")
                      .where(a -> a.get("ID").eq(accidentId)
                              .and(a.get("IsActiveEntity").eq(true)))
        );
        boolean isEditFlow = existCheck.rowCount() > 0;
        log.info("uploadAccidentFile: isEditFlow={}", isEditFlow);

        // ── Upload to Cloudinary ─────────────────────────────────────────────
        Map<String, Object> cloudinaryResult;
        try
        {
            cloudinaryResult = cloudinaryService.upload(content, fileName);
        }
        catch (IOException e)
        {
            log.error("Cloudinary upload failed for '{}': {}", fileName, e.getMessage(), e);
            throw new ServiceException(ErrorStatuses.SERVER_ERROR,
                    "File upload to external storage failed: " + e.getMessage(), e);
        }

        String newId    = UUID.randomUUID().toString();
        String url      = (String) cloudinaryResult.get("secure_url");
        String pubId    = (String) cloudinaryResult.get("public_id");
        long   fileSize = 0L;
        Object bytesObj = cloudinaryResult.get("bytes");
        if (bytesObj instanceof Number)
        {
            fileSize = ((Number) bytesObj).longValue();
        }

        // ── Build row and insert ─────────────────────────────────────────────
        Map<String, Object> row = new HashMap<>();
        row.put("ID",            newId);
        row.put("accident_ID",   accidentId);
        row.put("fileName",      fileName);
        row.put("mediaType",     mediaType != null ? mediaType : "application/octet-stream");
        row.put("url",           url);
        row.put("publicId",      pubId);
        row.put("fileSize",      fileSize);
        row.put("HasActiveEntity", false);
        row.put("HasDraftEntity",  false);

        if (isEditFlow)
        {
            row.put("IsActiveEntity", true);
            db.run(Insert.into(ACTIVE_TABLE).entry(row));
            log.info("Inserted into ACTIVE attachments: id={}", newId);
        }
        else
        {
            row.put("IsActiveEntity", false);
            db.run(Insert.into(DRAFT_TABLE).entry(row));
            log.info("Inserted into DRAFT attachments: id={}", newId);
        }

        // ── FIX 2: Return typed AccidentAttachments POJO, not a raw Map ──────
        // ctx.setResult() requires cds.gen.accidentservice.AccidentAttachments,
        // not Map<String,Object>. Use the generated create() factory + setters.
        AccidentAttachments result = AccidentAttachments.create();
        result.setId(newId);
        result.setFileName(fileName);
        result.setMediaType(mediaType != null ? mediaType : "application/octet-stream");
        result.setUrl(url);
        result.setFileSize(fileSize);

        ctx.setResult(result);
        ctx.setCompleted();
    }

    // ── @Before draftActivate — copy active attachments into draft ───────────
    //
    // SDK 4.4.1 requires the generated entity-specific context for each draft
    // lifecycle event. The exact type for draftActivate on Accident is the
    // generated AccidentDraftActivateContext. CdsUpdateEventContext does not
    // "exactly fit" the registered event in this SDK version.
    // We adapt via .as() to access getCqn(), then use CqnAnalyzer for keys.
    @Before(event = "draftActivate")
    public void beforeDraftActivate(AccidentDraftActivateContext ctx)
    {
        Object accidentId = null;
        try
        {
            CqnAnalyzer analyzer = CqnAnalyzer.create(model);
            Map<String, Object> keys = analyzer.analyze(ctx.as(CdsUpdateEventContext.class).getCqn()).targetKeys();
            accidentId = keys.get("ID");
        }
        catch (Exception e)
        {
            log.warn("beforeDraftActivate: could not extract accidentId, skipping. {}", e.getMessage());
            return;
        }

        if (accidentId == null)
        {
            return;
        }

        log.info("beforeDraftActivate: accidentId={}", accidentId);

        final Object finalAccidentId = accidentId;
        Result activeResult = db.run(
                Select.from(ACTIVE_TABLE)
                      .where(a -> a.get("accident_ID").eq(finalAccidentId)
                              .and(a.get("IsActiveEntity").eq(true)))
        );

        List<Row> activeRows = activeResult.list();
        if (activeRows.isEmpty())
        {
            log.info("beforeDraftActivate: no active attachments to copy");
            return;
        }

        List<Map<String, Object>> draftRows = new ArrayList<>();
        for (Row active : activeRows)
        {
            Map<String, Object> draft = new HashMap<>(active);
            draft.put("IsActiveEntity",  false);
            draft.put("HasActiveEntity", false);
            draft.put("HasDraftEntity",  false);
            draftRows.add(draft);
        }

        db.run(Insert.into(DRAFT_TABLE).entries(draftRows));
        log.info("beforeDraftActivate: copied {} active attachments to draft", draftRows.size());
    }

    // ── @Before draftCancel — delete uploads from Cloudinary + DB ───────────
    //
    // FIX 5 — DraftCancelEventContext does not exactly fit the registered 'draftCancel'
    //          event in SDK 4.4.1. Use base EventContext (always accepted), then
    //          adapt via ctx.as() — the official CAP Java context-adaptation pattern —
    //          to get CdsDeleteEventContext which exposes getCqn().
    @Before(event = "draftCancel")
    public void beforeDraftCancel(EventContext ctx)
    {
        Object accidentId = null;
        try
        {
            CdsDeleteEventContext deleteCtx = ctx.as(CdsDeleteEventContext.class);
            CqnAnalyzer analyzer = CqnAnalyzer.create(model);
            Map<String, Object> keys = analyzer.analyze(deleteCtx.getCqn()).targetKeys();
            accidentId = keys.get("ID");
        }
        catch (Exception e)
        {
            log.warn("beforeDraftCancel: could not extract accidentId, skipping. {}", e.getMessage());
            return;
        }

        if (accidentId == null)
        {
            return;
        }

        log.info("beforeDraftCancel: cleaning draft attachments for accidentId={}", accidentId);

        final Object finalAccidentId = accidentId;
        Result draftResult = db.run(
                Select.from(DRAFT_TABLE)
                      .where(a -> a.get("accident_ID").eq(finalAccidentId)
                              .and(a.get("IsActiveEntity").eq(false)))
        );

        List<Row> draftRows = draftResult.list();
        if (draftRows.isEmpty())
        {
            log.info("beforeDraftCancel: no draft attachments to clean up");
            return;
        }

        for (Row attachment : draftRows)
        {
            String publicId     = (String) attachment.get("publicId");
            String attachmentId = (String) attachment.get("ID");
            String fileName     = (String) attachment.get("fileName");

            log.info("beforeDraftCancel: deleting '{}' publicId={}", fileName, publicId);

            if (publicId != null && !publicId.isBlank())
            {
                try
                {
                    cloudinaryService.delete(publicId);
                }
                catch (IOException e)
                {
                    // Log but don't block discard
                    log.error("Cloudinary delete failed for publicId='{}': {}",
                            publicId, e.getMessage(), e);
                }
            }

            final String aid = attachmentId;
            db.run(Delete.from(DRAFT_TABLE).where(a -> a.get("ID").eq(aid)));
        }

        log.info("beforeDraftCancel: cleaned up {} draft attachments", draftRows.size());
    }

    // ── deleteAccidentFile ───────────────────────────────────────────────────

    @On(event = DeleteAccidentFileContext.CDS_NAME)
    public void onDeleteAccidentFile(DeleteAccidentFileContext ctx)
    {
        String attachmentId = ctx.getAttachmentId();
        if (attachmentId == null || attachmentId.isBlank())
        {
            throw new ServiceException(ErrorStatuses.BAD_REQUEST, "attachment_ID is required");
        }

        log.info("deleteAccidentFile: attachmentId={}", attachmentId);

        // Search active table first, then draft table
        Optional<Row> found = db.run(
                Select.from(ACTIVE_TABLE)
                      .where(a -> a.get("ID").eq(attachmentId))
        ).first();

        String sourceTable;
        Row attachment;

        if (found.isPresent())
        {
            attachment  = found.get();
            sourceTable = ACTIVE_TABLE;
        }
        else
        {
            Optional<Row> draftFound = db.run(
                    Select.from(DRAFT_TABLE)
                          .where(a -> a.get("ID").eq(attachmentId))
            ).first();

            if (!draftFound.isPresent())
            {
                throw new ServiceException(ErrorStatuses.NOT_FOUND,
                        "Attachment not found: " + attachmentId);
            }

            attachment  = draftFound.get();
            sourceTable = DRAFT_TABLE;
        }

        String publicId = (String) attachment.get("publicId");
        log.info("Loaded attachment: fileName={}, publicId={}, table={}",
                attachment.get("fileName"), publicId, sourceTable);

        // Delete from Cloudinary
        if (publicId != null && !publicId.isBlank())
        {
            try
            {
                cloudinaryService.delete(publicId);
            }
            catch (IOException e)
            {
                log.error("Cloudinary delete failed for publicId='{}': {}", publicId, e.getMessage(), e);
                throw new ServiceException(ErrorStatuses.SERVER_ERROR,
                        "Failed to delete file from external storage: " + e.getMessage(), e);
            }
        }

        // Delete from DB
        final String table = sourceTable;
        db.run(Delete.from(table).where(a -> a.get("ID").eq(attachmentId)));

        log.info("AccidentAttachment deleted from {}: id={}", table, attachmentId);
        ctx.setCompleted();
    }
}