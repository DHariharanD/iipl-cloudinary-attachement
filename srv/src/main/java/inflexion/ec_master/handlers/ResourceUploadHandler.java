package inflexion.ec_master.handlers;

import cds.gen.resourceservices.ResourceServices_;
import cds.gen.resourceservices.UploadResourceTypesContext;

import com.sap.cds.ql.Insert;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;

import org.slf4j.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.ByteArrayInputStream;
import java.util.*;

import org.apache.poi.ss.usermodel.*;

@Component
@ServiceName(ResourceServices_.CDS_NAME)
public class ResourceUploadHandler implements EventHandler {

    @Autowired
    PersistenceService db;

    private static final Logger log = LoggerFactory.getLogger(ResourceUploadHandler.class);

    private static final int BATCH_SIZE = 5000;

    @On(event = "uploadResourceTypes")
    public void uploadResourceTypes(UploadResourceTypesContext context) {

        try (Workbook workbook = WorkbookFactory.create(new ByteArrayInputStream(context.getFile()))) {

            DataFormatter f = new DataFormatter();

            Map<String, String> hierarchyMap = new HashMap<>();
            Map<String, String> categoryCodeMap = new HashMap<>();

            processHierarchy(workbook.getSheet("ResourceHierarchy"), f, hierarchyMap);
            processCompany(workbook.getSheet("CompanyCodes"), f, hierarchyMap);
            processCategories(workbook.getSheet("ResourceCategories"), f, hierarchyMap, categoryCodeMap);

            handleGL(workbook.getSheet("ResourceGL"), f, categoryCodeMap);
            handleMaterial(workbook.getSheet("ResourceMaterial"), f, categoryCodeMap);
            handleAssets(workbook.getSheet("ResourceAssets"), f, categoryCodeMap);
            handleWorkforce(workbook.getSheet("ResourceWorkforce"), f, categoryCodeMap);
            handleSubcontract(workbook.getSheet("ResourceSubcontract"), f, categoryCodeMap);

            context.setCompleted();

        } catch (Exception e) {
            log.error("Upload failed", e);
            throw new RuntimeException(e);
        }
    }

    // ===================== HIERARCHY =====================
    private void processHierarchy(Sheet sheet, DataFormatter f, Map<String, String> map) {

        List<Map<String, Object>> batch = new ArrayList<>();

        for (Row r : sheet) {
            if (r.getRowNum() == 0) continue;

            String key = f.formatCellValue(r.getCell(0)).trim();
            if (key.isEmpty()) continue;

            String uuid = UUID.randomUUID().toString();

            batch.add(Map.of(
                    "ID", uuid,
                    "name", f.formatCellValue(r.getCell(1)),
                    "descr", f.formatCellValue(r.getCell(2)),
                    "note", f.formatCellValue(r.getCell(3))
            ));

            map.put(key, uuid);

            if (batch.size() == BATCH_SIZE) {
                db.run(Insert.into("ec.masters.ResourceHierarchies").entries(batch));
                batch.clear();
            }
        }

        if (!batch.isEmpty()) {
            db.run(Insert.into("ec.masters.ResourceHierarchies").entries(batch));
        }
    }

    // ===================== COMPANY =====================
    private void processCompany(Sheet sheet, DataFormatter f, Map<String, String> hierarchyMap) {

        List<Map<String, Object>> batch = new ArrayList<>();

        for (Row r : sheet) {
            if (r.getRowNum() == 0) continue;

            String hId = hierarchyMap.get(f.formatCellValue(r.getCell(1)).trim());
            if (hId == null) continue;

            batch.add(Map.of(
                    "ID", UUID.randomUUID().toString(),
                    "companyCode", f.formatCellValue(r.getCell(2)),
                    "companyName", f.formatCellValue(r.getCell(3)),
                    "parent_ID", hId
            ));

            if (batch.size() == BATCH_SIZE) {
                db.run(Insert.into("ec.masters.ResourceTypeCompany").entries(batch));
                batch.clear();
            }
        }

        if (!batch.isEmpty()) {
            db.run(Insert.into("ec.masters.ResourceTypeCompany").entries(batch));
        }
    }

    // ===================== CATEGORIES =====================
    private void processCategories(Sheet sheet, DataFormatter f,
                                   Map<String, String> hierarchyMap,
                                   Map<String, String> codeMap) {

        List<Map<String, Object>> batch = new ArrayList<>();
        List<Map<String, Object>> pendingParent = new ArrayList<>();

        for (Row r : sheet) {
            if (r.getRowNum() == 0) continue;

            String hierarchyId = hierarchyMap.get(f.formatCellValue(r.getCell(1)).trim());
            if (hierarchyId == null) continue;

            String code = f.formatCellValue(r.getCell(4)).trim();
            String parentCode = f.formatCellValue(r.getCell(6)).trim();

            String uuid = UUID.randomUUID().toString();

            Map<String, Object> entry = new HashMap<>();
            entry.put("ID", uuid);
            entry.put("name", trim(f.formatCellValue(r.getCell(2)), 40));
            entry.put("code", code);
            entry.put("descr", f.formatCellValue(r.getCell(3)));
            entry.put("ResourceHierarchy_ID", hierarchyId);
            entry.put("resourceType_code", f.formatCellValue(r.getCell(5)));

            codeMap.put(code, uuid);

            if (parentCode != null && !parentCode.isEmpty()) {
                entry.put("parentCode", parentCode);
                pendingParent.add(entry);
            } else {
                batch.add(entry);
            }

            if (batch.size() == BATCH_SIZE) {
                db.run(Insert.into("ec.masters.ResourceCategories").entries(batch));
                batch.clear();
            }
        }

        if (!batch.isEmpty()) {
            db.run(Insert.into("ec.masters.ResourceCategories").entries(batch));
        }

        // Resolve parents
        batch.clear();
        for (Map<String, Object> e : pendingParent) {
            String parentCode = (String) e.get("parentCode");
            String parentId = codeMap.get(parentCode);

            if (parentId != null) {
                e.put("parent_ID", parentId);
            }
            e.remove("parentCode");

            batch.add(e);

            if (batch.size() == BATCH_SIZE) {
                db.run(Insert.into("ec.masters.ResourceCategories").entries(batch));
                batch.clear();
            }
        }

        if (!batch.isEmpty()) {
            db.run(Insert.into("ec.masters.ResourceCategories").entries(batch));
        }
    }

    // ===================== GENERIC HANDLER =====================
    private void processChild(Sheet sheet, DataFormatter f, Map<String, String> codeMap,
                              String table, ChildMapper mapper) {

        List<Map<String, Object>> batch = new ArrayList<>();

        for (Row r : sheet) {
            if (r.getRowNum() == 0) continue;

            String code = f.formatCellValue(r.getCell(1)).trim();
            String parentId = codeMap.get(code);

            if (parentId == null) {
                log.error("Invalid code: " + code);
                continue;
            }

            Map<String, Object> entry = mapper.map(r, f, parentId);
            batch.add(entry);

            if (batch.size() == BATCH_SIZE) {
                db.run(Insert.into(table).entries(batch));
                batch.clear();
            }
        }

        if (!batch.isEmpty()) {
            db.run(Insert.into(table).entries(batch));
        }
    }

    // ===================== CHILD TABLES =====================
    private void handleGL(Sheet s, DataFormatter f, Map<String, String> map) {
        processChild(s, f, map, "ec.masters.ResourceGl",
                (r, df, parentId) -> Map.of(
                        "ID", UUID.randomUUID().toString(),
                        "parent_ID", parentId,
                        "GLNo", df.formatCellValue(r.getCell(2)),
                        "GLName", df.formatCellValue(r.getCell(3))
                ));
    }

    private void handleMaterial(Sheet s, DataFormatter f, Map<String, String> map) {
        processChild(s, f, map, "ec.masters.ResourceMaterial",
                (r, df, parentId) -> Map.of(
                        "ID", UUID.randomUUID().toString(),
                        "parent_ID", parentId,
                        "productId", df.formatCellValue(r.getCell(2)),
                        "productName", df.formatCellValue(r.getCell(3)),
                        "productType", df.formatCellValue(r.getCell(4)),
                        "unitofMeasure", df.formatCellValue(r.getCell(5))
                ));
    }

    private void handleAssets(Sheet s, DataFormatter f, Map<String, String> map) {
        processChild(s, f, map, "ec.masters.ResourceAssets",
                (r, df, parentId) -> Map.of(
                        "ID", UUID.randomUUID().toString(),
                        "parent_ID", parentId,
                        "name", trim(df.formatCellValue(r.getCell(2)), 20),
                        "Asset", df.formatCellValue(r.getCell(3)),
                        "itemUnit", df.formatCellValue(r.getCell(4))
                ));
    }

    private void handleWorkforce(Sheet s, DataFormatter f, Map<String, String> map) {
        processChild(s, f, map, "ec.masters.ResourceWorkforce",
                (r, df, parentId) -> Map.of(
                        "ID", UUID.randomUUID().toString(),
                        "parent_ID", parentId,
                        "name", df.formatCellValue(r.getCell(2)),
                        "description", trim(df.formatCellValue(r.getCell(3)), 20)
                ));
    }

    private void handleSubcontract(Sheet s, DataFormatter f, Map<String, String> map) {
        processChild(s, f, map, "ec.masters.ResourceSubcontract",
                (r, df, parentId) -> Map.of(
                        "ID", UUID.randomUUID().toString(),
                        "parent_ID", parentId,
                        "subcontractId", df.formatCellValue(r.getCell(2)),
                        "subcontractName", df.formatCellValue(r.getCell(3)),
                        "unitOfMeasure", df.formatCellValue(r.getCell(6))
                ));
    }

    // ===================== UTIL =====================
    private String trim(String val, int max) {
        return val != null && val.length() > max ? val.substring(0, max) : val;
    }

    interface ChildMapper {
        Map<String, Object> map(Row r, DataFormatter f, String parentId);
    }
}