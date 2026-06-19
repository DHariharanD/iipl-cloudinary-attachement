package inflexion.ec_master.handlers;

import cds.gen.classservice.ClassService_;
import cds.gen.classservice.UploadClassContext;

import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.ByteArrayInputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@Component
@ServiceName(ClassService_.CDS_NAME)
public class ClassUploadHandler implements EventHandler {

    @Autowired
    PersistenceService db;

    @On(event = "UploadClass")
    public void uploadClass(UploadClassContext context) {

        try {

            byte[] fileBytes = context.getFile();
            ByteArrayInputStream inputStream = new ByteArrayInputStream(fileBytes);

            Workbook workbook = new XSSFWorkbook(inputStream);
            Sheet sheet = workbook.getSheetAt(0);

            DataFormatter formatter = new DataFormatter();

            for (Row row : sheet) {

                // Skip header row
                if (row.getRowNum() == 0)
                    continue;

                // Adjust columns based on your Excel structure
                String classCode = formatter.formatCellValue(row.getCell(0));
                String className = formatter.formatCellValue(row.getCell(1));
                String companyCode = formatter.formatCellValue(row.getCell(2));
                String description = formatter.formatCellValue(row.getCell(3));

                // Optional length validations
                if (classCode != null && classCode.length() > 40) {
                    classCode = classCode.substring(0, 40);
                }

                if (className != null && className.length() > 100) {
                    className = className.substring(0, 100);
                }

                if (description != null && description.length() > 1000) {
                    description = description.substring(0, 1000);
                }

                if (companyCode != null && companyCode.length() > 4) {
                    companyCode = companyCode.substring(0, 4);
                }

                Map<String, Object> entry = new HashMap<>();

                entry.put("ID", UUID.randomUUID().toString());
                entry.put("classCode", classCode);  
                entry.put("className", className);  
                entry.put("description", description);
                entry.put("companyCode", companyCode);

                db.run(
                        com.sap.cds.ql.Insert.into("ec.masters.Class")
                                .entry(entry));
            }

            workbook.close();
            context.setCompleted();

        } catch (Exception e) {
            throw new RuntimeException("Class Upload Failed: " + e.getMessage());
        }
    }
}