package inflexion.ec_master.external;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
 
import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import cds.gen.businesspartnerservices.BusinessPartnerServices_;
import cds.gen.businesspartnerservices.BusinessPartners_;

@Component
@ServiceName(BusinessPartnerServices_.CDS_NAME)
public class BusinessPartnerHandler implements EventHandler{
     @Autowired
    @Qualifier("API_BUSINESS_PARTNER")
    CqnService remoteBp;
 
    @On(event = CqnService.EVENT_READ,entity = BusinessPartners_.CDS_NAME)
    public void getBusinessPartner(CdsReadEventContext context) {
        System.out.println("Business Parner fetching started....................");
        context.setResult(remoteBp.run(context.getCqn()));
    }
}
