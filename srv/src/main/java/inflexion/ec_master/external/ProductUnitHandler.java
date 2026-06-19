package inflexion.ec_master.external;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
 
import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import cds.gen.resourceservices.ProductUnitsOfMeasures_;
import cds.gen.resourceservices.ResourceServices_;

@Component
@ServiceName(ResourceServices_.CDS_NAME)
public class ProductUnitHandler implements EventHandler{
      @Autowired
    @Qualifier("CE_PRODUCT_0002")
    CqnService remoteProduct;

    @On(event = CqnService.EVENT_READ, entity = ProductUnitsOfMeasures_.CDS_NAME)
    public void getProducts(CdsReadEventContext context) {

        System.out.println("Fetching Products from external system...");

        context.setResult(
            remoteProduct.run(context.getCqn())
        );
    }
}
