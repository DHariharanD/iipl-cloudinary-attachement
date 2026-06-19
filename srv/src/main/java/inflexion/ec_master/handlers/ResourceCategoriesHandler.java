package inflexion.ec_master.handlers;

import cds.gen.resourceservices.ResourceServices_;
import cds.gen.resourceservices.UploadResourceCategoriesContext;

import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.ByteArrayInputStream;
import java.util.*;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@Component
@ServiceName(ResourceServices_.CDS_NAME)
public class ResourceCategoriesHandler implements EventHandler {

    @Autowired
    PersistenceService db;

    @On(event = "uploadResourceCategories")
    public void uploadResourceCategories(UploadResourceCategoriesContext context) {

        try {

            byte[] fileBytes = context.getFile();
            ByteArrayInputStream inputStream = new ByteArrayInputStream(fileBytes);

            Workbook workbook = new XSSFWorkbook(inputStream);
            Sheet sheet = workbook.getSheetAt(0);

            String hierarchyId = context.getHierarchyId();
            DataFormatter formatter = new DataFormatter();

            // ✅ Resource Type Mapping (FIXED lowercase)
            Map<String, String> resourceTypeMap = new HashMap<>();
            resourceTypeMap.put("material", "MT");
            resourceTypeMap.put("asset", "AT");
            resourceTypeMap.put("manpower", "MP");
            resourceTypeMap.put("labour", "MP");
            resourceTypeMap.put("gl account", "GL");
            resourceTypeMap.put("subcontractor", "SC"); // FIXED

            Map<String, String> codeToIdMap = new HashMap<>();
            List<Map<String, Object>> allEntries = new ArrayList<>();

            // ==============================
            // STEP 1: READ & PREPARE DATA
            // ==============================
            for (Row row : sheet) {

                if (row.getRowNum() == 0)
                    continue;

                String code = formatter.formatCellValue(row.getCell(0)).trim();
                String name = formatter.formatCellValue(row.getCell(1)).trim();
                String description = formatter.formatCellValue(row.getCell(2)).trim();
                String resourceTypeText = formatter.formatCellValue(row.getCell(3)).trim();
                String parentCode = formatter.formatCellValue(row.getCell(4)).trim();

                if (code == null || code.isEmpty())
                    continue;

                // ✅ Length validation
                if (code.length() > 40) {
                    code = code.substring(0, 40);
                }

                if (description != null && description.length() > 1000) {
                    description = description.substring(0, 1000);
                }

                // ✅ Duplicate check
                if (codeToIdMap.containsKey(code)) {
                    throw new RuntimeException("Duplicate code found in Excel: " + code);
                }

                // ==============================
                // ✅ Resource Type (NO EXCEPTION)
                // ==============================
                String resourceTypeCode = null;

                if (resourceTypeText != null && !resourceTypeText.isEmpty()) {

                    String typeLower = resourceTypeText.toLowerCase().trim();

                    if (resourceTypeMap.containsKey(typeLower)) {
                        resourceTypeCode = resourceTypeMap.get(typeLower);
                    } else {
                        // ⚠️ Unknown → just log, don't fail
                        System.out.println("⚠️ Unknown Resource Type: " + resourceTypeText + " (Code: " + code + ")");
                        resourceTypeCode = null;
                    }
                }

                String uuid = UUID.randomUUID().toString();

                Map<String, Object> entry = new HashMap<>();
                entry.put("ID", uuid);
                entry.put("code", code);
                entry.put("name", name);
                entry.put("descr", description);
                entry.put("ResourceHierarchy_ID", hierarchyId);

                // only set if present
                if (resourceTypeCode != null) {
                    entry.put("resourceType_code", resourceTypeCode);
                }

                // store parent temporarily
                entry.put("parentCode", parentCode);

                codeToIdMap.put(code, uuid);
                allEntries.add(entry);
            }

            // ==============================
            // STEP 2: RESOLVE PARENT + INSERT
            // ==============================
            for (Map<String, Object> entry : allEntries) {

                String parentCode = (String) entry.get("parentCode");

                if (parentCode != null && !parentCode.isEmpty()) {

                    String parentId = codeToIdMap.get(parentCode);

                    if (parentId != null) {
                        entry.put("parent_ID", parentId);
                    } else {
                        // ⚠️ Parent not found → skip (NO exception)
                        System.out.println("⚠️ Parent not found for Code: "
                                + entry.get("code") + " → Parent Code: " + parentCode);
                    }
                }

                entry.remove("parentCode");

                db.run(
                        com.sap.cds.ql.Insert.into("ec.masters.ResourceCategories")
                                .entry(entry));
            }

            workbook.close();
            context.setCompleted();

        } catch (Exception e) {
            throw new RuntimeException("Excel Upload Failed: " + e.getMessage(), e);
        }
    }
}