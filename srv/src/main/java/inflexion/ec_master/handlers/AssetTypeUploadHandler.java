package inflexion.ec_master.handlers;

import cds.gen.assettypeservice.AssetTypeService_;
import cds.gen.assettypeservice.UploadAssetTypesContext;

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
@ServiceName(AssetTypeService_.CDS_NAME)
public class AssetTypeUploadHandler implements EventHandler {

    @Autowired
    PersistenceService db;

    @On(event = "UploadAssetTypes")
    public void uploadAssetTypes(UploadAssetTypesContext context) {

        try {

            byte[] fileBytes = context.getFile();
            ByteArrayInputStream inputStream = new ByteArrayInputStream(fileBytes);

            Workbook workbook = new XSSFWorkbook(inputStream);
            Sheet sheet = workbook.getSheetAt(0);

            DataFormatter formatter = new DataFormatter();

            for (Row row : sheet) {

                if (row.getRowNum() == 0)
                    continue;

                String name = formatter.formatCellValue(row.getCell(1));
                String description = formatter.formatCellValue(row.getCell(2));
                String companyCode = formatter.formatCellValue(row.getCell(3));

                if (name != null && name.length() > 40) {
                    name = name.substring(0, 40);
                }

                if (companyCode != null && companyCode.length() > 4) {
                    companyCode = companyCode.substring(0, 4);
                }

                Map<String, Object> entry = new HashMap<>();

                entry.put("ID", UUID.randomUUID().toString());
                entry.put("name", name);
                entry.put("description", description);
                entry.put("company_CompanyCode", companyCode);

                db.run(
                        com.sap.cds.ql.Insert.into("ec.masters.AssetType")
                                .entry(entry));
            }

            workbook.close();
            context.setCompleted();

        } catch (Exception e) {
            throw new RuntimeException("Excel Upload Failed: " + e.getMessage());
        }
    }
}