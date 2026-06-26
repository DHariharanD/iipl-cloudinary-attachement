package inflexion.ec_master.external;

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
public class CloudinaryService
{

    private static final Logger log = LoggerFactory.getLogger(CloudinaryService.class);

    private final Cloudinary cloudinary;

    public CloudinaryService(
            @Value("${cloudinary.cloud-name}") String cloudName,
            @Value("${cloudinary.api-key}")    String apiKey,
            @Value("${cloudinary.api-secret}") String apiSecret)
    {
        this.cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", cloudName,
                "api_key",    apiKey,
                "api_secret", apiSecret,
                "secure",     true
        ));

        log.info("CloudinaryService initialised for cloud: {}", cloudName);
    }

    // ── upload ───────────────────────────────────────────────────────────────
    /**
     * Uploads a file to Cloudinary under accident-attachments/<vehicleNo>/<uuid>-<name-without-ext>
     *
     * resource_type is now determined explicitly from the mediaType parameter
     * instead of using "auto". Cloudinary classifies PDFs as "image" when using
     * auto-detection, which results in /image/upload/ URLs that require signed
     * delivery (401 for unsigned access). By forcing "raw" for all non-image,
     * non-video MIME types, PDFs and documents are stored under /raw/upload/
     * and are publicly accessible without signing.
     *
     * @param base64Content  Raw base64 string (no data URI prefix)
     * @param originalName   Original file name
     * @param vehicleNo      Vehicle number — used as subfolder name in Cloudinary
     * @param mediaType      MIME type of the file — used to pick resource_type
     * @return Cloudinary response map
     */
    public Map<String, Object> upload(String base64Content, String originalName,
                                      String vehicleNo, String mediaType)
            throws IOException
    {

        byte[] fileBytes = Base64.getDecoder().decode(base64Content);

        // Sanitise vehicleNo for use as a folder name
        String sanitisedVehicleNo = sanitiseName(vehicleNo != null ? vehicleNo : "unknown");

        // Full path: accident-attachments/<vehicleNo>/<uuid>-<name-without-ext>
        String publicId = "accident-attachments/"
                + sanitisedVehicleNo
                + "/"
                + UUID.randomUUID()
                + "-"
                + stripExtension(sanitiseName(originalName));

        // Determine Cloudinary resource_type explicitly from MIME type.
        // Using "auto" causes Cloudinary to classify PDFs as "image", resulting
        // in /image/upload/ URLs that require signed delivery on most plans.
        String resourceType = resolveResourceType(mediaType);

        log.info("Uploading to Cloudinary: publicId={}, resourceType={}, size={} bytes",
                publicId, resourceType, fileBytes.length);

        @SuppressWarnings("unchecked")
        Map<String, Object> result = (Map<String, Object>) cloudinary.uploader().upload(
                fileBytes,
                ObjectUtils.asMap(
                "public_id",     publicId,
                "asset_folder",  "accident-attachments/" + sanitisedVehicleNo,
                "resource_type", resourceType,
                "tags",          "accident-management"
                ));

        log.info("Cloudinary upload successful: url={}", result.get("secure_url"));
        return result;
    }

    // ── delete ───────────────────────────────────────────────────────────────
    /**
     * Tries image/raw/video in order until one succeeds.
     */
    public void delete(String publicId) throws IOException
    {

        log.info("Deleting from Cloudinary: publicId={}", publicId);

        String[] resourceTypes = { "image", "raw", "video" };

        for (String resourceType : resourceTypes)
        {
            @SuppressWarnings("unchecked")
            Map<String, Object> result = (Map<String, Object>) cloudinary.uploader()
                    .destroy(publicId,
                             ObjectUtils.asMap("resource_type", resourceType));

            String outcome = (String) result.get("result");
            if ("ok".equals(outcome))
            {
                log.info("Deleted from Cloudinary [resourceType={}]: {}", resourceType, publicId);
                return;
            }
        }

        log.warn("File not found in Cloudinary (already deleted?): publicId={}", publicId);
    }

    // ── helpers ──────────────────────────────────────────────────────────────

    /**
     * Maps a MIME type to a Cloudinary resource_type string.
     * - image/*         → "image"
     * - video/* / audio/* → "video"
     * - everything else → "raw"  (PDFs, Word, Excel, text, etc.)
     */
    private String resolveResourceType(String mediaType)
    {
        if (mediaType == null || mediaType.isBlank())
        {
            return "raw";
        }
        String lower = mediaType.toLowerCase();
        if (lower.startsWith("image/"))
        {
            return "image";
        }
        if (lower.startsWith("video/") || lower.startsWith("audio/"))
        {
            return "video";
        }
        return "raw";
    }

    private String sanitiseName(String name)
    {
        if (name == null || name.isBlank()) return "file";
        return name.replaceAll("[^a-zA-Z0-9._-]", "_");
    }

    private String stripExtension(String name)
    {
        int dot = name.lastIndexOf('.');
        return dot > 0 ? name.substring(0, dot) : name;
    }
}