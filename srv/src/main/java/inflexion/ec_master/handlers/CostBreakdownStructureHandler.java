package inflexion.ec_master.handlers;

import cds.gen.costbreakdownstructureservice.CostBreakdownStructureService_;
import cds.gen.costbreakdownstructureservice.UploadCostBreakdownStructureContext;

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
@ServiceName(CostBreakdownStructureService_.CDS_NAME)
public class CostBreakdownStructureHandler implements EventHandler {

    @Autowired
    PersistenceService db;

    @On(event = "uploadCostBreakdownStructure")
    public void uploadCostBreakdownStructure(UploadCostBreakdownStructureContext context) {

        try {

            byte[] fileBytes = context.getFile();
            String hierarchyId = context.getHierarchyId();

            Workbook workbook = new XSSFWorkbook(new ByteArrayInputStream(fileBytes));
            Sheet sheet = workbook.getSheetAt(0);

            DataFormatter formatter = new DataFormatter();

            Map<String, String> codeToIdMap = new HashMap<>();
            List<Map<String, Object>> allEntries = new ArrayList<>();

          
            for (Row row : sheet) {

                if (row.getRowNum() == 0)
                    continue;

                String code = formatter.formatCellValue(row.getCell(0)).trim();
                String name = formatter.formatCellValue(row.getCell(1)).trim();
                String descr = formatter.formatCellValue(row.getCell(2)).trim();
                String parentCode = formatter.formatCellValue(row.getCell(3)).trim();

                if (code == null || code.isEmpty())
                    continue;

              
                if (codeToIdMap.containsKey(code)) {
                    throw new RuntimeException("Duplicate code in Excel: " + code);
                }

                String uuid = UUID.randomUUID().toString();

                Map<String, Object> entry = new HashMap<>();
                entry.put("ID", uuid);
                entry.put("code", code);
                entry.put("name", name);
                entry.put("descr", descr);
                entry.put("cbshierarchy_ID", hierarchyId);

                // store parent temporarily
                entry.put("parentCode", parentCode);

                codeToIdMap.put(code, uuid);
                allEntries.add(entry);
            }

           
            for (Map<String, Object> entry : allEntries) {

                String parentCode = (String) entry.get("parentCode");

                if (parentCode != null && !parentCode.isEmpty()) {

                    String parentId = codeToIdMap.get(parentCode);

                    if (parentId != null) {
                        entry.put("parent_ID", parentId);
                    } else {
                        System.out.println(" Parent not found for: "
                                + entry.get("code") + " → " + parentCode);
                    }
                }

                entry.remove("parentCode");

                db.run(
                        com.sap.cds.ql.Insert.into("ec.masters.CostBreakdownStructure")
                                .entry(entry));
            }

            workbook.close();
            context.setCompleted();

        } catch (Exception e) {
            throw new RuntimeException("Excel Upload Failed: " + e.getMessage(), e);
        }
    }
}