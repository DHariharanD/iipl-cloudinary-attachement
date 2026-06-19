package inflexion.ec_master.handlers;

import java.io.IOException;
import java.util.Base64;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

@Service
public class CloudinaryService {

    private static final Logger log = LoggerFactory.getLogger(CloudinaryService.class);

    private final Cloudinary cloudinary;

    // ── Constructor ──────────────────────────────────────────────────────────
    // Spring injects the three values from application.yaml / VCAP_SERVICES.
    public CloudinaryService(
            @Value("${cloudinary.cloud-name}") String cloudName,
            @Value("${cloudinary.api-key}")    String apiKey,
            @Value("${cloudinary.api-secret}") String apiSecret) {

        this.cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", cloudName,
                "api_key",    apiKey,
                "api_secret", apiSecret,
                "secure",     true       // always use HTTPS URLs
        ));

        log.info("CloudinaryService initialised for cloud: {}", cloudName);
    }

    // ── upload ───────────────────────────────────────────────────────────────
    /**
     * Uploads a file to Cloudinary.
     *
     * @param base64Content  Raw base64 string (no "data:...;base64," prefix —
     *                       the UI extension controller strips that before
     *                       sending the action parameter).
     * @param originalName   Original file name, used to build a readable
     *                       public_id in Cloudinary (e.g. "report.pdf").
     * @return Cloudinary response map containing at minimum:
     *         "secure_url"    — HTTPS CDN URL to store in HANA
     *         "public_id"     — identifier needed for future deletion
     *         "bytes"         — file size in bytes
     *         "resource_type" — "image" / "video" / "raw"
     * @throws IOException if the Cloudinary API call fails
     */
    public Map<String, Object> upload(String base64Content, String originalName)
            throws IOException {

        // Decode base64 → raw bytes
        byte[] fileBytes = Base64.getDecoder().decode(base64Content);

        // Build a unique, human-readable public_id so files are organised
        // inside a folder called "accident-attachments/" in Cloudinary.
        // Example: "accident-attachments/a3f2c1d0-report.pdf"
        String publicId = "accident-attachments/"
                + UUID.randomUUID()
                + "-"
                + sanitiseName(originalName);

        log.info("Uploading file to Cloudinary: publicId={}, size={} bytes",
                publicId, fileBytes.length);

        @SuppressWarnings("unchecked")
        Map<String, Object> result = (Map<String, Object>) cloudinary.uploader().upload(
                fileBytes,
                ObjectUtils.asMap(
                        "public_id",     publicId,
                        // "auto" lets Cloudinary detect whether the file is
                        // an image, video, or raw (pdf, docx, xlsx, txt …)
                        "resource_type", "auto",
                        // Keep the original file name as a tag for easy search
                        "tags",          "accident-management"
                ));

        log.info("Cloudinary upload successful: url={}", result.get("secure_url"));
        return result;
    }

    // ── delete ───────────────────────────────────────────────────────────────
    /**
     * Permanently deletes a file from Cloudinary using its public_id.
     *
     * Cloudinary requires the resource_type to be specified for non-image
     * files (e.g. PDFs are "raw", videos are "video").  We try all three
     * types so the caller doesn't need to track resource_type separately.
     *
     * @param publicId the Cloudinary public_id stored in AccidentAttachments
     * @throws IOException if all deletion attempts fail
     */
    public void delete(String publicId) throws IOException {

        log.info("Deleting file from Cloudinary: publicId={}", publicId);

        // Try image first (most common for photos), then raw (pdf/docx/xlsx),
        // then video.  Cloudinary returns "ok" on success, "not found" if the
        // type doesn't match — we only throw if ALL three return non-ok.
        String[] resourceTypes = { "image", "raw", "video" };

        for (String resourceType : resourceTypes) {
            @SuppressWarnings("unchecked")
            Map<String, Object> result = (Map<String, Object>) cloudinary.uploader()
                    .destroy(publicId,
                             ObjectUtils.asMap("resource_type", resourceType));

            String outcome = (String) result.get("result");
            if ("ok".equals(outcome)) {
                log.info("Deleted from Cloudinary [resourceType={}]: {}", resourceType, publicId);
                return;
            }
        }

        // If we get here the file wasn't found in Cloudinary — log a warning
        // but do NOT throw, so the HANA row is still cleaned up.
        log.warn("File not found in Cloudinary (already deleted?): publicId={}", publicId);
    }

    // ── helpers ──────────────────────────────────────────────────────────────

    /**
     * Strips characters that are invalid in a Cloudinary public_id
     * (spaces, slashes other than the folder separator, etc.).
     */
    private String sanitiseName(String name) {
        if (name == null || name.isBlank()) return "file";
        // Replace spaces and special chars with underscores
        return name.replaceAll("[^a-zA-Z0-9._-]", "_");
    }
}
