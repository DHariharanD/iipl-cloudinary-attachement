package inflexion.ec_master.external;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.sap.cds.ql.Select;
import com.sap.cds.ql.cqn.CqnSelect;
import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import cds.gen.resourceservices.GlAccounts_;
import cds.gen.resourceservices.ResourceServices_;

@Component
@ServiceName(ResourceServices_.CDS_NAME)
public class GlAccountHandler implements EventHandler{
    
    @Autowired
    @Qualifier("API_GLACCOUNTINCHARTOFACCOUNTS_SRV")
    CqnService remotegl;
 
    @On(event = CqnService.EVENT_READ,entity = GlAccounts_.CDS_NAME)
    public void getGlAccounts(CdsReadEventContext context) {

        System.out.println("GL Account fetching started....................");
        CqnSelect originalQuery = context.getCqn();

        CqnSelect modifiedQuery = Select.from(originalQuery.ref())
                .columns(originalQuery.columns())
                .where(b -> b.get(GlAccounts_.LANGUAGE).eq("EN"));

        context.setResult(remotegl.run(modifiedQuery));
    }
}
