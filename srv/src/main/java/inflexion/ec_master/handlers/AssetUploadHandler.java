package inflexion.ec_master.handlers;

import cds.gen.assetmasterservice.AssetMasterService_;
import cds.gen.assetmasterservice.UploadAssetsContext;

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
@ServiceName(AssetMasterService_.CDS_NAME)
public class AssetUploadHandler implements EventHandler {

    @Autowired
    PersistenceService db;

    @On(event = "UploadAssets")
    public void uploadAssets(UploadAssetsContext context) {

        try {

            byte[] fileBytes = context.getFile();
            ByteArrayInputStream inputStream = new ByteArrayInputStream(fileBytes);

            Workbook workbook = new XSSFWorkbook(inputStream);
            Sheet sheet = workbook.getSheetAt(0);

            DataFormatter formatter = new DataFormatter();

            for (Row row : sheet) {

                if (row.getRowNum() == 0)
                    continue;
                String type = formatter.formatCellValue(row.getCell(0));
                String assetCode = formatter.formatCellValue(row.getCell(1));
                String description = formatter.formatCellValue(row.getCell(2));
                String companyCode = formatter.formatCellValue(row.getCell(3));

                if (assetCode != null && assetCode.length() > 40) {
                    assetCode = assetCode.substring(0, 40);
                }

                if (description != null && description.length() > 1000) {
                    description = description.substring(0, 1000);
                }

                if (companyCode != null && companyCode.length() > 4) {
                    companyCode = companyCode.substring(0, 4);
                }

                Map<String, Object> entry = new HashMap<>();

                entry.put("ID", UUID.randomUUID().toString());
                entry.put("type", type);
                entry.put("asset", assetCode);
                entry.put("description", description);
                entry.put("company_CompanyCode", companyCode);

                db.run(
                        com.sap.cds.ql.Insert.into("ec.masters.AssetMaster")
                                .entry(entry));
            }

            workbook.close();
            context.setCompleted();

        } catch (Exception e) {
            throw new RuntimeException("Excel Upload Failed: " + e.getMessage());
        }
    }
}