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

import cds.gen.resourceservices.ProductDescriptions_;
import cds.gen.resourceservices.ResourceServices_;

@Component
@ServiceName(ResourceServices_.CDS_NAME)
public class ProductDescriptionHandler implements EventHandler{
    
 @Autowired
    @Qualifier("CE_PRODUCT_0002")
    CqnService remoteProduct;

    @On(event = CqnService.EVENT_READ, entity = ProductDescriptions_.CDS_NAME)
    public void getProductDescriptions(CdsReadEventContext context) {

        System.out.println("Fetching ProductDescriptions (Language = EN) from external system...");

      CqnSelect originalQuery = context.getCqn();

        // 2. Create a modified query that adds the Language filter
        // This ensures "Language = 'EN'" is sent to S/4HANA
        CqnSelect modifiedQuery = Select.from(originalQuery.ref())
            .columns(originalQuery.columns())
            .where(b -> b.get(ProductDescriptions_.LANGUAGE).eq("EN"));

        // 3. Execute the modified query against the remote system
        context.setResult(remoteProduct.run(modifiedQuery));
    }
}
