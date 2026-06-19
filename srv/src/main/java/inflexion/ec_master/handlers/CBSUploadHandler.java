package inflexion.ec_master.handlers;

import cds.gen.costbreakdownstructureservice.*;
import com.sap.cds.ql.Insert;
import com.sap.cds.services.handler.*;
import com.sap.cds.services.handler.annotations.*;
import com.sap.cds.services.persistence.PersistenceService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.ByteArrayInputStream;
import java.util.*;

@Component
@ServiceName(CostBreakdownStructureService_.CDS_NAME)
public class CBSUploadHandler implements EventHandler {

    @Autowired
    PersistenceService db;

    @On(event = "uploadCBSBulk")
    public void uploadCBS(UploadCBSBulkContext context) {

        try {

            Workbook workbook = new XSSFWorkbook(new ByteArrayInputStream(context.getFile()));
            DataFormatter f = new DataFormatter();

            Sheet sheet1 = workbook.getSheetAt(0);
            Sheet sheet2 = workbook.getSheetAt(1);

            String cbsHierarchyId = "a1f5c7e2-9b34-4c9a-8f2a-3b6d7c9e0a11";

            Map<String, String> level0Map = new HashMap<>();
            Map<String, String> level1Map = new HashMap<>();
            Map<String, String> level2Map = new HashMap<>();

            List<Map<String, Object>> nodes = new ArrayList<>();
            List<Map<String, Object>> materials = new ArrayList<>();

           
            for (Row r : sheet2) {

                if (r.getRowNum() == 0)
                    continue;

                String code = f.formatCellValue(r.getCell(0)).trim();
                String name = f.formatCellValue(r.getCell(1)).trim();

                if (code.length() == 4) {

                    String id = UUID.randomUUID().toString();

                    Map<String, Object> node = new HashMap<>();
                    node.put("ID", id);
                    node.put("code", code);
                    node.put("name", name);
                    node.put("cbshierarchy_ID", cbsHierarchyId);

                    nodes.add(node);
                    level0Map.put(code, id);

                    //System.out.println("✅ LEVEL0: " + code);
                }
            }

            
            for (Row r : sheet1) {

                if (r.getRowNum() == 0)
                    continue;

                String col0 = f.formatCellValue(r.getCell(0)).trim();
                String code = f.formatCellValue(r.getCell(1)).trim();
                String name = f.formatCellValue(r.getCell(2)).trim();

                if (code.isEmpty())
                    continue;

                //System.out.println("\n➡️ Processing Row: CODE=" + code + " | COL0=" + col0);


                if (code.length() == 8) {

                    String parentKey = code.substring(0, 4);
                    String parentId = level0Map.get(parentKey);

                    //System.out.println("LEVEL1 → parentKey=" + parentKey + " parentId=" + parentId);

                    String id = UUID.randomUUID().toString();

                    Map<String, Object> node = new HashMap<>();
                    node.put("ID", id);
                    node.put("code", code);
                    node.put("name", name);
                    node.put("cbshierarchy_ID", cbsHierarchyId);

                    if (parentId != null) {
                        node.put("parent_ID", parentId);
                    } else {
                        //System.out.println("❌ LEVEL1 parent missing for: " + code);
                    }

                    nodes.add(node);
                    level1Map.put(code, id);
                }

               
                else if (code.length() == 10) {

                    String parentKey = code.substring(0, 8);
                    String parentId = level1Map.get(parentKey);

                    //System.out.println("LEVEL2 → parentKey=" + parentKey + " parentId=" + parentId);

                    String id = UUID.randomUUID().toString();

                    Map<String, Object> node = new HashMap<>();
                    node.put("ID", id);
                    node.put("code", code);
                    node.put("name", name);
                    node.put("cbshierarchy_ID", cbsHierarchyId);

                    if (parentId != null) {
                        node.put("parent_ID", parentId);
                    } else {
                        //System.out.println("❌ LEVEL2 parent missing for: " + code);
                    }

                    nodes.add(node);
                    level2Map.put(code, id);
                }

              
                else {

                    if (code != null && code.trim().startsWith("30")) {

                        //System.out.println("🔍 RESOURCE FOUND → " + code + " | PARENT CBS: " + col0);

                        String parentId = level2Map.get(col0);

                        if (parentId == null) {
                            //System.out.println("❌ RESOURCE parent NOT FOUND → " + col0);
                            continue;
                        }

                        //System.out.println("✅ RESOURCE INSERTING → parentId=" + parentId);

                        Map<String, Object> mat = new HashMap<>();
                        mat.put("ID", UUID.randomUUID().toString());
                        mat.put("cbsNode_ID", parentId);
                        mat.put("productId", code.trim());
                        mat.put("productName", name);

                        materials.add(mat);
                    }
                }
            }

            
            // System.out.println("\n TOTAL CBS NODES: " + nodes.size());
            // System.out.println(" TOTAL MATERIALS: " + materials.size());

           
            db.run(Insert.into("ec.masters.CostBreakdownStructure").entries(nodes));
            db.run(Insert.into("ec.masters.CBSResourceMaterial").entries(materials));

            workbook.close();
            context.setCompleted();

        } catch (Exception e) {
            throw new RuntimeException("CBS Upload Failed: " + e.getMessage(), e);
        }
    }
}