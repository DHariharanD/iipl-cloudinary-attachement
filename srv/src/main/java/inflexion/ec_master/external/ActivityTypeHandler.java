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
import cds.gen.resourceservices.ResourceServices_;
import cds.gen.resourceservices.Activities_;

@Component
@ServiceName(ResourceServices_.CDS_NAME)
public class ActivityTypeHandler implements EventHandler {

    @Autowired
    @Qualifier("API_COSTCNTRACTIVITYTYPE_CRUD_SRV")
    CqnService remoteActivityType;

    @On(event = CqnService.EVENT_READ, entity = Activities_.CDS_NAME)
  public void getActivityTypes(CdsReadEventContext context) {
    System.out.println("Fetching Activity Types (Language = EN) from external system...");
    CqnSelect originalQuery = context.getCqn();
    CqnSelect modifiedQuery = Select.from(originalQuery.ref())
            .columns(originalQuery.columns())
            .where(b -> b.get(Activities_.LANGUAGE).eq("EN"));
    context.setResult(remoteActivityType.run(modifiedQuery));
}
}
