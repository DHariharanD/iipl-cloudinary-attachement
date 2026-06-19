package inflexion.ec_master.handlers;

import com.sap.cds.ql.Insert;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;

import cds.gen.projectenterpriseservice.UploadEnterpriseProjectsContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.ByteArrayInputStream;
import java.util.*;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.usermodel.WorkbookFactory;

@Component
@ServiceName("ProjectEnterpriseService")
public class EnterpriseProjectUploadHandler implements EventHandler {

    @Autowired
    PersistenceService db;

    @On(event = "UploadEnterpriseProjects")
    public void uploadEnterpriseProjects(UploadEnterpriseProjectsContext context) {

        try {

            byte[] fileBytes = Base64.getDecoder().decode(context.getFile());
            Workbook workbook = WorkbookFactory.create(new ByteArrayInputStream(fileBytes));
            Sheet sheet = workbook.getSheetAt(0);
            DataFormatter formatter = new DataFormatter();

            String projectUUID = UUID.randomUUID().toString();
            String projectCode = null;
            String projectDesc = null;

            Map<String, String> wbsToIdMap = new HashMap<>();
            List<Map<String, Object>> allRecords = new ArrayList<>();

            for (Row row : sheet) {
                if (row.getRowNum() == 0)
                    continue;

                String wbs = formatter.formatCellValue(row.getCell(0)).trim();
                String name = formatter.formatCellValue(row.getCell(1)).trim();

                if (wbs == null || wbs.isBlank())
                    continue;

                projectCode = wbs;
                projectDesc = name;
                break;
            }

            Map<String, Object> project = new HashMap<>();
            project.put("ID", projectUUID);
            project.put("project", projectCode);
            project.put("projectDescription", projectDesc);
            project.put("companyCode", "1300");

            db.run(
                    Insert.into("ec.masters.Projects")
                            .entry(project));

            for (Row row : sheet) {

                if (row.getRowNum() == 0)
                    continue;

                String wbsCode = formatter.formatCellValue(row.getCell(0)).trim();
                String name = formatter.formatCellValue(row.getCell(1)).trim();

                if (wbsCode == null || wbsCode.isBlank())
                    continue;

                if (name != null && name.length() > 40) {
                    name = name.substring(0, 40);
                }

                String currentId = UUID.randomUUID().toString();

                String parentWbs = getParentWbs(wbsCode);
                String parentId = parentWbs != null ? wbsToIdMap.get(parentWbs) : null;

                Map<String, Object> planning = new HashMap<>();

                planning.put("ID", currentId);
                planning.put("projectElementDescription", name);
                planning.put("projectId", wbsCode);

                Map<String, Object> projectRef = new HashMap<>();
                projectRef.put("ID", projectUUID);
                planning.put("plshierarchy", projectRef);

                if (parentId != null) {
                    Map<String, Object> parentRef = new HashMap<>();
                    parentRef.put("ID", parentId);
                    planning.put("parent", parentRef);
                }

                wbsToIdMap.put(wbsCode, currentId);
                allRecords.add(planning);
            }

            if (!allRecords.isEmpty()) {
                db.run(
                        Insert.into("ec.masters.ProjectPlanning")
                                .entries(allRecords));
            }

            workbook.close();

            context.setResult(" Upload successful: " + allRecords.size() + " records");
            context.setCompleted();

        } catch (Exception e) {
            throw new RuntimeException(" Upload Failed: " + e.getMessage(), e);
        }
    }

    private String getParentWbs(String wbs) {
        if (wbs == null || !wbs.contains(".")) {
            return null;
        }
        return wbs.substring(0, wbs.lastIndexOf("."));
    }
}