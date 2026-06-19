package inflexion.ec_master.handlers;

import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;

import cds.gen.projectprimaverawbsservice.ProjectPrimaveraWBSService_;
import cds.gen.projectprimaverawbsservice.UploadWbsProjectContext;

import com.sap.cds.ql.Select;
import com.sap.cds.ql.Insert;
import com.sap.cds.ql.cqn.CqnSelect;
import com.sap.cds.Result;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.ByteArrayInputStream;
import java.util.*;

import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@Component
@ServiceName(ProjectPrimaveraWBSService_.CDS_NAME)
public class WbsProjectUploadHandler implements EventHandler {

    @Autowired
    PersistenceService db;

    @On(event = "UploadWbsProject")
    public void uploadWbsProject(UploadWbsProjectContext context) {
        try {
            byte[] fileBytes = context.getFile();
            ByteArrayInputStream inputStream = new ByteArrayInputStream(fileBytes);

            Workbook workbook = new XSSFWorkbook(inputStream);
            Sheet sheet = workbook.getSheetAt(0);
            DataFormatter formatter = new DataFormatter();


            Map<String, String> projectIdByCode = new HashMap<>();
            Map<String, String> wbsIdByCode = new HashMap<>();
            for (org.apache.poi.ss.usermodel.Row row : sheet) {
                if (row.getRowNum() == 0)
                    continue;

                String projectCode = trim(formatter.formatCellValue(row.getCell(0)), 40);
                String projectName = trim(formatter.formatCellValue(row.getCell(1)), 150);
                String wbsCode = trim(formatter.formatCellValue(row.getCell(2)), 40);
                String wbsName = trim(formatter.formatCellValue(row.getCell(3)), 40);
                String parentWbsCode = formatter.formatCellValue(row.getCell(4));
                String company = trim(formatter.formatCellValue(row.getCell(5)), 40);
                String primaveraID = trim(formatter.formatCellValue(row.getCell(6)), 50);
                String primaveraName = trim(formatter.formatCellValue(row.getCell(7)), 150);
                String boq = trim(formatter.formatCellValue(row.getCell(8)), 40);
                String cbs = trim(formatter.formatCellValue(row.getCell(9)), 40);
                String amount = trim(formatter.formatCellValue(row.getCell(10)), 111);

                if (projectCode == null || projectCode.isBlank())
                    continue;
                if (!projectIdByCode.containsKey(projectCode)) {
                    CqnSelect selectProject = Select.from("ec.masters.PrimaveraProjects")
                            .where(p -> p.get("primaveraProjectCode").eq(projectCode));
                    Optional<com.sap.cds.Row> existing = db.run(selectProject).first();

                    if (existing.isPresent()) {
                        projectIdByCode.put(projectCode, (String) existing.get().get("ID"));
                    } else {
                        String projectId = UUID.randomUUID().toString();
                        Map<String, Object> project = new HashMap<>();
                        project.put("ID", projectId);
                        project.put("primaveraProjectCode", projectCode);
                        project.put("primaveraProjectName", projectName);
                        db.run(Insert.into("ec.masters.PrimaveraProjects").entry(project));
                        projectIdByCode.put(projectCode, projectId);
                    }
                }

                String projectId = projectIdByCode.get(projectCode);
                if (wbsCode != null && !wbsCode.isBlank() && !wbsIdByCode.containsKey(wbsCode)) {

                    String wbsId = UUID.randomUUID().toString();
                    Map<String, Object> wbs = new HashMap<>();
                    wbs.put("ID", wbsId);
                    wbs.put("primaverawbs", wbsName);
                    wbs.put("primaverawbsCode", wbsCode);
                    wbs.put("pjHierarchies_ID", projectId);

                    if (parentWbsCode != null && !parentWbsCode.isBlank()) {
                        String parentId = wbsIdByCode.get(parentWbsCode);
                        if (parentId != null) {
                            wbs.put("parent_ID", parentId);
                        }
                    }

                    db.run(Insert.into("ec.masters.PrimaveraWBS").entry(wbs));
                    wbsIdByCode.put(wbsCode, wbsId);
                }
                if (wbsCode != null && !wbsCode.isBlank()) {
                    String wbsId = wbsIdByCode.get(wbsCode);

                    Map<String, Object> mapping = new HashMap<>();
                    mapping.put("ID", UUID.randomUUID().toString());
                    mapping.put("company", company);
                    mapping.put("primavearID", primaveraID);
                    mapping.put("primaveraName", primaveraName);
                    mapping.put("boq", boq);
                    mapping.put("cbs", cbs);
                    mapping.put("amount", amount);
                    if (wbsId != null) {
                        mapping.put("prWbshierarchy_ID", wbsId);
                    }

                    db.run(Insert.into("ec.masters.PrimaveraWBSMapping").entry(mapping));
                }
            }

            workbook.close();
            context.setCompleted();

        } catch (Exception e) {
            throw new RuntimeException("WBS Upload Failed: " + e.getMessage(), e);
        }
    }

    private String trim(String value, int maxLen) {
        if (value == null || value.isBlank())
            return null;
        return value.length() > maxLen ? value.substring(0, maxLen) : value;
    }
}