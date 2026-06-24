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
import inflexion.ec_master.external.CloudinaryService;

/**
 * Handles the custom OData actions for accident attachment management:
 *   - uploadAccidentFile  : uploads to Cloudinary, writes metadata to HANA
 *   - deleteAccidentFile  : removes from Cloudinary and HANA
 *
 * Design constraints:
 *   - Only operates on ACTIVE (saved) Accident records.
 *     The UI hides both buttons when HasActiveEntity === false (new-record draft),
 *     so accident_ID received here is always a committed, active entity UUID.
 *   - CloudinaryService handles the actual HTTP communication with Cloudinary.
 *   - PersistenceService (db) is used for direct DB operations on AccidentAttachments,
 *     bypassing the OData layer intentionally (uploads are not standard CRUD).
 */
@Component
@ServiceName(AccidentService_.CDS_NAME)
public class AccidentAttachmentHandler implements EventHandler {

    private static final Logger log = LoggerFactory.getLogger(AccidentAttachmentHandler.class);

    private final CloudinaryService cloudinaryService;
    private final PersistenceService db;

    @Autowired
    public AccidentAttachmentHandler(CloudinaryService cloudinaryService,
                                     PersistenceService db) {
        this.cloudinaryService = cloudinaryService;
        this.db = db;
    }

    // ── uploadAccidentFile ────────────────────────────────────────────────────

    /**
     * Uploads a file to Cloudinary, then persists its metadata as an
     * AccidentAttachments row linked to the given Accident record.
     *
     * Expected parameters (from UploadAccidentFileContext):
     *   accident_ID  – UUID of the active Accident record
     *   fileName     – original file name (e.g. "police_report.pdf")
     *   mediaType    – MIME type (e.g. "application/pdf")
     *   content      – raw base64 string, no "data:...;base64," prefix
     *   description  – optional human-readable context for the file
     *
     * Returns the created AccidentAttachments row (OData action return value).
     *
     * NOTE: After adding the `description` parameter to the CDS service action,
     * run `mvn clean install` (or `cds build`) to regenerate UploadAccidentFileContext
     * before this handler compiles — the generated getDescription() method only
     * exists after regeneration.
     */
    @On(event = "uploadAccidentFile")
    public void onUploadAccidentFile(UploadAccidentFileContext context) {

        // ── 1. Extract and validate parameters ───────────────────────────────
        String accidentId   = context.getAccidentId();   // accident_ID → accidentId
        String fileName     = context.getFileName();
        String mediaType    = context.getMediaType();
        String base64Content = context.getContent();
        String description  = context.getDescription();  // available after CDS regen

        if (isBlank(accidentId)) {
            throw new ServiceException(ErrorStatuses.BAD_REQUEST,
                    "accident_ID is required and cannot be blank.");
        }
        if (isBlank(fileName)) {
            throw new ServiceException(ErrorStatuses.BAD_REQUEST,
                    "fileName is required and cannot be blank.");
        }
        if (isBlank(base64Content)) {
            throw new ServiceException(ErrorStatuses.BAD_REQUEST,
                    "File content (base64) is required and cannot be blank.");
        }

        // Normalise mediaType — browser sometimes sends an empty string
        if (isBlank(mediaType)) {
            mediaType = "application/octet-stream";
        }

        // ── 2. Upload to Cloudinary ───────────────────────────────────────────
        Map<String, Object> cloudinaryResult;
        try {
            cloudinaryResult = cloudinaryService.upload(base64Content, fileName);
        } catch (IOException e) {
            log.error("Cloudinary upload failed for '{}' (accidentId={}): {}",
                    fileName, accidentId, e.getMessage(), e);
            throw new ServiceException(ErrorStatuses.SERVER_ERROR,
                    "File upload to Cloudinary failed: " + e.getMessage(), e);
        }

        String secureUrl = (String) cloudinaryResult.get("secure_url");
        String publicId  = (String) cloudinaryResult.get("public_id");
        Number fileSizeBytes = (Number) cloudinaryResult.get("bytes");

        log.info("Cloudinary upload success: file='{}', publicId='{}', url='{}'",
                fileName, publicId, secureUrl);

        // ── 3. Persist attachment metadata in HANA ────────────────────────────
        AccidentAttachments attachment = AccidentAttachments.create();
        attachment.setId(UUID.randomUUID().toString());
        attachment.setAccidentId(accidentId);           // FK to Accident
        attachment.setFileName(fileName);
        attachment.setMediaType(mediaType);
        attachment.setUrl(secureUrl);
        attachment.setPublicId(publicId);
        attachment.setFileSize(fileSizeBytes != null ? fileSizeBytes.longValue() : null);
        attachment.setDescription(description != null ? description.trim() : null);

        db.run(Insert.into(AccidentAttachments_.class).entry(attachment));

        log.info("AccidentAttachment saved: id='{}', accidentId='{}', file='{}'",
                attachment.getId(), accidentId, fileName);

        // ── 4. Return the created row ─────────────────────────────────────────
        context.setResult(attachment);
        context.setCompleted();
    }

    // ── deleteAccidentFile ────────────────────────────────────────────────────

    /**
     * Deletes an attachment permanently:
     *   1. Looks up the AccidentAttachments row to retrieve the Cloudinary publicId.
     *   2. Deletes the file from Cloudinary (tries image / raw / video resource types).
     *   3. Deletes the HANA row.
     *
     * If the row is not found in HANA, a 404 is returned to the client.
     * If the file is not found in Cloudinary (already deleted externally), the HANA
     * row is still cleaned up — CloudinaryService.delete() logs a warning but does
     * not throw in that case.
     */
    @On(event = "deleteAccidentFile")
    public void onDeleteAccidentFile(DeleteAccidentFileContext context) {

        // ── 1. Validate ───────────────────────────────────────────────────────
        String attachmentId = context.getAttachmentId();  // attachment_ID → attachmentId

        if (isBlank(attachmentId)) {
            throw new ServiceException(ErrorStatuses.BAD_REQUEST,
                    "attachment_ID is required and cannot be blank.");
        }

        // ── 2. Fetch the row ──────────────────────────────────────────────────
        var result = db.run(Select.from(AccidentAttachments_.class).byId(attachmentId));
        AccidentAttachments attachment = result.first(AccidentAttachments.class).orElse(null);

        if (attachment == null) {
            log.warn("Attachment not found for deletion: id='{}'", attachmentId);
            throw new ServiceException(ErrorStatuses.NOT_FOUND,
                    "Attachment with ID '" + attachmentId + "' was not found.");
        }

        String publicId = attachment.getPublicId();
        String fileName = attachment.getFileName();

        // ── 3. Delete from Cloudinary ─────────────────────────────────────────
        if (!isBlank(publicId)) {
            try {
                cloudinaryService.delete(publicId);
                log.info("Cloudinary deletion complete: publicId='{}'", publicId);
            } catch (IOException e) {
                // Surface Cloudinary errors to the client — the HANA row is NOT
                // removed if Cloudinary throws, to prevent a dangling metadata row.
                log.error("Cloudinary deletion failed for publicId='{}': {}", publicId, e.getMessage(), e);
                throw new ServiceException(ErrorStatuses.SERVER_ERROR,
                        "File deletion from Cloudinary failed: " + e.getMessage(), e);
            }
        } else {
            log.warn("No publicId on attachment '{}' (file='{}') — skipping Cloudinary deletion.",
                    attachmentId, fileName);
        }

        // ── 4. Delete from HANA ───────────────────────────────────────────────
        db.run(Delete.from(AccidentAttachments_.class).byId(attachmentId));

        log.info("AccidentAttachment deleted: id='{}', file='{}'", attachmentId, fileName);

        context.setCompleted();
    }

    // ── helpers ───────────────────────────────────────────────────────────────

    private static boolean isBlank(String s) {
        return s == null || s.isBlank();
    }
}