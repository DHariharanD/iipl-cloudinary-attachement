package inflexion.ec_master.handlers;

import cds.gen.billofquantityservice.BillofQuantityService_;
import cds.gen.billofquantityservice.UploadBoqContext;

import com.sap.cds.ql.Insert;
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
@ServiceName(BillofQuantityService_.CDS_NAME)
public class BoqUploadHandler implements EventHandler {

    @Autowired
    PersistenceService db;

    @On(event = "UploadBoq")
    public void uploadBoq(UploadBoqContext context) {

        try {

            Workbook workbook = new XSSFWorkbook(new ByteArrayInputStream(context.getFile()));
            // Sheet sheet = workbook.getSheetAt(0);
            Sheet sheet = workbook.getSheet("BoQ (PS not incl)");
            if (sheet == null) {
                throw new RuntimeException("Sheet not found!");
            }
            DataFormatter f = new DataFormatter();

            String headerId = UUID.randomUUID().toString();

            String vrNo = null;
            String projectName = null;
            String companyCode = "1300"; // default
            String boqType = "ORG"; // default

            String lastItemNo = null;

            List<Map<String, Object>> items = new ArrayList<>();

            // ================= READ EXCEL =================
            for (Row row : sheet) {

                if (row.getRowNum() == 0)
                    continue;

                String jobNo = f.formatCellValue(row.getCell(1));
                String billStr = f.formatCellValue(row.getCell(2));
                String section = f.formatCellValue(row.getCell(3));
                String pageStr = f.formatCellValue(row.getCell(4));
                String revStr = f.formatCellValue(row.getCell(5));
                String itemNo = f.formatCellValue(row.getCell(6));
                String boqNo = f.formatCellValue(row.getCell(7));

                String narration = f.formatCellValue(row.getCell(8)); // optional
                String description = f.formatCellValue(row.getCell(9));
                String unit = f.formatCellValue(row.getCell(10));
                String qtyStr = f.formatCellValue(row.getCell(11));
                String priceStr = f.formatCellValue(row.getCell(12));

                // ================= HEADER =================
                if (vrNo == null && jobNo != null && !jobNo.isBlank()) {
                    vrNo = jobNo;
                    projectName = jobNo;
                }

                // ================= HANDLE MERGED ITEM =================
                if (itemNo != null && !itemNo.isBlank()) {
                    lastItemNo = itemNo;
                } else {
                    itemNo = lastItemNo;
                }

                if (itemNo == null || itemNo.isBlank())
                    continue;

                // ================= PARSE NUMBERS =================
                Integer bill = null;
                Integer page = null;
                Integer rev = null;
                Double qty = 0.0;
                Double price = 0.0;

                try {
                    if (!billStr.isBlank())
                        bill = Integer.parseInt(billStr);
                } catch (Exception e) {
                }
                try {
                    if (!pageStr.isBlank())
                        page = Integer.parseInt(pageStr);
                } catch (Exception e) {
                }
                try {
                    if (!revStr.isBlank())
                        rev = Integer.parseInt(revStr);
                } catch (Exception e) {
                }
                try {
                    if (!qtyStr.isBlank())
                        qty = Double.parseDouble(qtyStr);
                } catch (Exception e) {
                }
                try {
                    if (!priceStr.isBlank())
                        price = Double.parseDouble(priceStr);
                } catch (Exception e) {
                }

              
                Map<String, Object> item = new HashMap<>();

                item.put("ID", UUID.randomUUID().toString());
                item.put("item", itemNo);
                item.put("description", description);
                item.put("unitOfMeasurement", unit);
                item.put("quantity", qty);
                item.put("unitPrice", price);

                item.put("section", section);
                item.put("page", page);
                item.put("revision", rev);
                item.put("bill", bill);
                if (boqNo != null && boqNo.length() > 10) {
                    boqNo = boqNo.substring(0, 10);
                }
                item.put("boqNo", boqNo);

                // 🔗 LINK HEADER
                item.put("bqitemsHierarchy_ID", headerId);

                items.add(item);
            }

            // ================= INSERT HEADER =================
            Map<String, Object> header = new HashMap<>();
            header.put("ID", headerId);
            header.put("vrNo", vrNo);
            header.put("projectName", projectName);
            header.put("company_CompanyCode", companyCode);
            header.put("boqType_code", boqType);

            db.run(
                    Insert.into("ec.masters.BillofQuantityHeader")
                            .entry(header));

            // ================= INSERT ITEMS =================
            for (Map<String, Object> item : items) {
                db.run(
                        Insert.into("ec.masters.BillofQuantityItems")
                                .entry(item));
            }

            System.out.println("TOTAL ITEMS INSERTED: " + items.size());

            workbook.close();
            context.setCompleted();

        } catch (Exception e) {
            throw new RuntimeException("BOQ Upload Failed: " + e.getMessage(), e);
        }
    }
}