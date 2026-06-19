package inflexion.ec_master.external;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.sap.cds.Result;
import com.sap.cds.ResultBuilder;
import com.sap.cds.Row;
import com.sap.cds.ql.Select;
import com.sap.cds.ql.cqn.CqnSelect;
import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;

import cds.gen.workforceservices.WorkforceServices_;
import cds.gen.workforceservices.Workforces_;

@Component
@ServiceName(WorkforceServices_.CDS_NAME)
public class WorkForceHandler implements EventHandler {

    @Autowired
    @Qualifier("YY1_WORKFORCE_CDS")
    CqnService remotewf;
 
    @On(event = CqnService.EVENT_READ,entity = Workforces_.CDS_NAME)
    // public void getWorkForce(CdsReadEventContext context) {
    //     System.out.println("Workforce fetching started....................");
    //     CqnSelect originalQuery = context.getCqn();

    // // Create a modified query that adds the Language filter
    // // This ensures "Language = 'EN'" is sent to S/4HANA
    // CqnSelect modifiedQuery = Select.from(originalQuery.ref())
    //         .columns(originalQuery.columns())
    //         .where(b -> b.get(Workforces_.LANGUAGE).eq("EN"));

    // // Execute the modified query against the remote system
    // context.setResult(remotewf.run(modifiedQuery));
    // // context.setResult(remotewf.run(context.getCqn()));
    // }
public void getWorkForce(CdsReadEventContext context) {
 System.out.println("Workforce fetching started....................");
    
    // 1. Define the modifiedQuery (The missing symbol)
    CqnSelect originalQuery = context.getCqn();
    CqnSelect modifiedQuery = Select.from(originalQuery.ref())
            .columns(originalQuery.columns())
            .where(b -> b.get(Workforces_.LANGUAGE).eq("EN")).limit(2);

    // 2. Execute against remote system
    Result remoteResult = remotewf.run(modifiedQuery);

    // 3. Get the list of rows
    List<Row> rows = remoteResult.list();

    // 4. Determine the count safely for the UI
    long count;
    try {
        count = remoteResult.inlineCount();
        // If the remote result has no count, it might return 0 or -1 depending on version
        if (count <= 0) {
            count = rows.size();
        }
    } catch (Exception e) {
        count = rows.size(); // Ultimate fallback
    }

    // 5. Build the final result with the mandatory inlineCount
    context.setResult(ResultBuilder.selectedRows(rows)
            .inlineCount(count)
            .result());
}
}
