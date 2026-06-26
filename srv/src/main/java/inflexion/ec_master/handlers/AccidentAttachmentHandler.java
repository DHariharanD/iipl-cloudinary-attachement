package inflexion.ec_master.handlers;

import java.io.IOException;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sap.cds.ql.Delete;
import com.sap.cds.ql.Insert;
import com.sap.cds.ql.Select;
import com.sap.cds.services.ErrorStatuses;
import com.sap.cds.services.ServiceException;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;

import cds.gen.accidentservice.AccidentAttachments;
import cds.gen.accidentservice.AccidentAttachments_;
import cds.gen.accidentservice.AccidentService_;
import cds.gen.accidentservice.DeleteAccidentFileContext;
import cds.gen.accidentservice.UploadAccidentFileContext;
import cds.gen.accidentservice.Accident;
import cds.gen.accidentservice.Accident_;
import inflexion.ec_master.external.CloudinaryService;

/**
 * Handles the custom OData actions for accident attachment management:
 *   - uploadAccidentFile  : uploads to Cloudinary, writes metadata to PostgreSQL
 *   - deleteAccidentFile  : removes from Cloudinary and PostgreSQL
 *
 * Fix: onUploadAccidentFile previously used Select.byId() to look up the
 * Accident record, which fails for draft-enabled entities because they have a
 * composite key (ID + IsActiveEntity). Replaced with a .where() clause
 * filtering on ID = accidentId AND IsActiveEntity = true.
 *
 * Fix: CloudinaryService.upload() now accepts mediaType as a fourth parameter
 * so it can choose the correct Cloudinary resource_type (image / raw / video)
 * explicitly rather than relying on auto-detection, which misclassifies PDFs.
 */
@Component
@ServiceName(AccidentService_.CDS_NAME)
public class AccidentAttachmentHandler implements EventHandler
{

    private static final Logger log = LoggerFactory.getLogger(AccidentAttachmentHandler.class);

    private final CloudinaryService cloudinaryService;
    private final PersistenceService db;

    @Autowired
    public AccidentAttachmentHandler(CloudinaryService cloudinaryService,
                                     PersistenceService db)
    {
        this.cloudinaryService = cloudinaryService;
        this.db = db;
    }

    // ── uploadAccidentFile ────────────────────────────────────────────────────

    @On(event = "uploadAccidentFile")
    public void onUploadAccidentFile(UploadAccidentFileContext context)
    {

        // ── 1. Extract and validate parameters ───────────────────────────────
        String accidentId    = context.getAccidentId();
        String fileName      = context.getFileName();
        String mediaType     = context.getMediaType();
        String base64Content = context.getContent();
        String description   = context.getDescription();

        if (isBlank(accidentId))
        {
            throw new ServiceException(ErrorStatuses.BAD_REQUEST,
                    "accident_ID is required and cannot be blank.");
        }
        if (isBlank(fileName))
        {
            throw new ServiceException(ErrorStatuses.BAD_REQUEST,
                    "fileName is required and cannot be blank.");
        }
        if (isBlank(base64Content))
        {
            throw new ServiceException(ErrorStatuses.BAD_REQUEST,
                    "File content (base64) is required and cannot be blank.");
        }
        if (isBlank(mediaType))
        {
            mediaType = "application/octet-stream";
        }

        // ── 2. Fetch vehicleNo from active Accident record ────────────────────
        // Accident has @odata.draft.enabled, so its generated key is composite:
        // (ID, IsActiveEntity). byId(accidentId) only passes a single value and
        // CAP throws "must have a single key". We use a where() clause instead,
        // filtering ID = accidentId AND IsActiveEntity = true to hit the active
        // table row rather than a draft row.
        String vehicleNo = "unknown";
        try
        {
            var accidentResult = db.run(
                Select.from(Accident_.class)
                      .columns(a -> a.vehicleNo())
                      .where(a -> a.ID().eq(accidentId)
                                   .and(a.IsActiveEntity().eq(true)))
            );
            Accident accident = accidentResult.first(Accident.class).orElse(null);
            if (accident != null && !isBlank(accident.getVehicleNo()))
            {
                vehicleNo = accident.getVehicleNo();
                log.info("Resolved vehicleNo='{}' for accidentId='{}'", vehicleNo, accidentId);
            }
            else
            {
                log.warn("Accident not found or vehicleNo blank for accidentId='{}' — " +
                         "using 'unknown' as Cloudinary subfolder.", accidentId);
            }
        }
        catch (Exception e)
        {
            // Non-fatal — proceed with 'unknown' subfolder rather than blocking.
            log.warn("Could not fetch vehicleNo for accidentId='{}': {} — " +
                     "using 'unknown' as Cloudinary subfolder.", accidentId, e.getMessage());
        }

        // ── 3. Upload to Cloudinary ───────────────────────────────────────────
        // mediaType is forwarded so CloudinaryService can pick the correct
        // resource_type (image / raw / video) without relying on auto-detection.
        Map<String, Object> cloudinaryResult;
        try
        {
            cloudinaryResult = cloudinaryService.upload(base64Content, fileName,
                                                        vehicleNo, mediaType);
        }
        catch (IOException e)
        {
            log.error("Cloudinary upload failed for '{}' (accidentId={}): {}",
                    fileName, accidentId, e.getMessage(), e);
            throw new ServiceException(ErrorStatuses.SERVER_ERROR,
                    "File upload to Cloudinary failed: " + e.getMessage(), e);
        }

        String secureUrl     = (String) cloudinaryResult.get("secure_url");
        String publicId      = (String) cloudinaryResult.get("public_id");
        Number fileSizeBytes = (Number) cloudinaryResult.get("bytes");

        log.info("Cloudinary upload success: file='{}', publicId='{}', url='{}'",
                fileName, publicId, secureUrl);

        // ── 4. Persist attachment metadata in PostgreSQL ──────────────────────
        AccidentAttachments attachment = AccidentAttachments.create();
        attachment.setId(UUID.randomUUID().toString());
        attachment.setAccidentId(accidentId);
        attachment.setFileName(fileName);
        attachment.setMediaType(mediaType);
        attachment.setUrl(secureUrl);
        attachment.setPublicId(publicId);
        attachment.setFileSize(fileSizeBytes != null ? fileSizeBytes.longValue() : null);
        attachment.setDescription(description != null ? description.trim() : null);

        db.run(Insert.into(AccidentAttachments_.class).entry(attachment));

        log.info("AccidentAttachment saved: id='{}', accidentId='{}', file='{}'",
                attachment.getId(), accidentId, fileName);

        // ── 5. Return the created row ─────────────────────────────────────────
        context.setResult(attachment);
        context.setCompleted();
    }

    // ── deleteAccidentFile ────────────────────────────────────────────────────

    @On(event = "deleteAccidentFile")
    public void onDeleteAccidentFile(DeleteAccidentFileContext context)
    {

        String attachmentId = context.getAttachmentId();

        if (isBlank(attachmentId))
        {
            throw new ServiceException(ErrorStatuses.BAD_REQUEST,
                    "attachment_ID is required and cannot be blank.");
        }

        var result = db.run(Select.from(AccidentAttachments_.class).byId(attachmentId));
        AccidentAttachments attachment = result.first(AccidentAttachments.class).orElse(null);

        if (attachment == null)
        {
            log.warn("Attachment not found for deletion: id='{}'", attachmentId);
            throw new ServiceException(ErrorStatuses.NOT_FOUND,
                    "Attachment with ID '" + attachmentId + "' was not found.");
        }

        String publicId = attachment.getPublicId();
        String fileName = attachment.getFileName();

        if (!isBlank(publicId))
        {
            try
            {
                cloudinaryService.delete(publicId);
                log.info("Cloudinary deletion complete: publicId='{}'", publicId);
            }
            catch (IOException e)
            {
                log.error("Cloudinary deletion failed for publicId='{}': {}", publicId, e.getMessage(), e);
                throw new ServiceException(ErrorStatuses.SERVER_ERROR,
                        "File deletion from Cloudinary failed: " + e.getMessage(), e);
            }
        }
        else
        {
            log.warn("No publicId on attachment '{}' (file='{}') — skipping Cloudinary deletion.",
                    attachmentId, fileName);
        }

        db.run(Delete.from(AccidentAttachments_.class).byId(attachmentId));

        log.info("AccidentAttachment deleted: id='{}', file='{}'", attachmentId, fileName);

        context.setCompleted();
    }

    // ── helpers ───────────────────────────────────────────────────────────────

    private static boolean isBlank(String s)
    {
        return s == null || s.isBlank();
    }
}