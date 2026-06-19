package inflexion.ec_master.handlers;

import com.sap.cds.Row;
import com.sap.cds.ql.Insert;
import com.sap.cds.ql.cqn.CqnSelect;
import com.sap.cds.services.EventContext;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.ByteArrayInputStream;
import java.util.*;

@Component
@ServiceName("AllocationService")
public class AllocationUploadHandler implements EventHandler {

    @Autowired
    private PersistenceService db;

    @On(event = "uploadAllocation")
    public void onUploadAllocation(EventContext context) {

        try {
            // Get file parameter
            Object fileParam = context.get("file");

            byte[] fileBytes = null;

            if (fileParam instanceof byte[]) {
                fileBytes = (byte[]) fileParam;
            } else if (fileParam instanceof String) {
                fileBytes = Base64.getDecoder().decode((String) fileParam);
            }

            if (fileBytes == null || fileBytes.length == 0) {
                throw new RuntimeException("File is required");
            }

            int recordCount = 0;
            List<String> errors = new ArrayList<>();

            try (
                Workbook workbook = new XSSFWorkbook(new ByteArrayInputStream(fileBytes))
            ) {
                Sheet sheet = workbook.getSheet("Allocations");

                if (sheet == null) {
                    throw new RuntimeException("Sheet 'Allocations' not found");
                }

                for (int rowIndex = 1;rowIndex <= sheet.getLastRowNum();rowIndex++) {

                    org.apache.poi.ss.usermodel.Row poiRow = sheet.getRow(rowIndex);

                    if (poiRow == null) {
                        continue;
                    }

                    String projectDescription = getCellValue(poiRow, 0);
                    String projectElementDescription = getCellValue(poiRow, 1);
                    String boqDescription = getCellValue(poiRow, 2);
                    String cbsName = getCellValue(poiRow, 3);
                    String floorZoneReference = getCellValue(poiRow, 4);
                    String notes = getCellValue(poiRow, 5);

                    // Skip empty row
                    if (projectDescription == null || projectDescription.isBlank()) {
                        continue;
                    }

                    // Lookup IDs
                    String projectId = getIdByField("ec.masters.Projects","projectDescription",projectDescription);
                    String wbsId = getIdByField("ec.masters.ProjectPlanning","projectElementDescription",projectElementDescription);
                    String boqId = getIdByField("ec.masters.BillofQuantityItems","description",boqDescription);
                    String cbsId = getIdByField("ec.masters.CostBreakdownStructure","name",cbsName);

                    // Validation
                    if (projectId == null || wbsId == null || boqId == null || cbsId == null) {

                        StringBuilder error = new StringBuilder("Row " + (rowIndex + 1) + ": ");

                        if (projectId == null) {
                            error.append("Project not found; ");
                        }
                        if (wbsId == null) {
                            error.append("WBS not found; ");
                        }
                        if (boqId == null) {
                            error.append("BOQ not found; ");
                        }
                        if (cbsId == null) {
                            error.append("CBS not found");
                        }

                        errors.add(error.toString());

                        continue;
                    }

                    Map<String, Object> allocation = new HashMap<>();

                    allocation.put("project_ID",projectId);
                    allocation.put("wbs_ID",wbsId);
                    allocation.put("boqItem_ID",boqId);
                    allocation.put("cbs_ID",cbsId);
                    allocation.put("floorZoneReference",floorZoneReference);
                    allocation.put("notes",notes);

                    try {
                        db.run(
                            Insert.into("ec.allocationmanagement.Allocations")
                                        .entries(Collections.singletonList(allocation)));

                        recordCount++;
                    } catch (Exception e) {
                        errors.add("Row " + (rowIndex + 1) + ": " + e.getMessage());
                    }
                }
            }

            Map<String, Object> result = new HashMap<>();

            result.put("message","Upload completed");
            result.put("recordsProcessed",recordCount);
            result.put("errors",errors);

            context.setCompleted();

        } catch (Exception e) {
            throw new RuntimeException("Upload failed: " + e.getMessage(), e);
        }
    }

    private String getIdByField(String entityName,String fieldName,String fieldValue) {

        try {
            CqnSelect query = com.sap.cds.ql.Select
                                .from(entityName)
                                .where(
                                        c -> c.get(fieldName)
                                                .eq(fieldValue)
                                );

            List<Row> results = db.run(query).list();

            if (results == null || results.isEmpty()) {
                return null;
            }

            Row row = results.get(0);

            Object id = row.get("ID");

            return id != null ? id.toString() : null;

        } catch (Exception e) {

            System.err.println("Lookup Error: " + entityName + " -> " + e.getMessage());
            return null;
        }
    }

    private String getCellValue(org.apache.poi.ss.usermodel.Row row, int cellIndex) {

        Cell cell = row.getCell(cellIndex);

        if (cell == null) {
            return "";
        }

        try {
            return switch ( cell.getCellType() ) {

                case STRING ->
                        cell.getStringCellValue().trim();

                case NUMERIC -> {

                    double num =
                            cell.getNumericCellValue();

                    yield (num == (int) num) ? String.valueOf((int) num) : String.valueOf(num);
                }

                case BOOLEAN ->
                        String.valueOf(cell.getBooleanCellValue());

                default -> "";
            };

        } catch (Exception e) {
            return "";
        }
    }
}