package inflexion.ec_master.external;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;

import cds.gen.assetservice.AssetService;
import cds.gen.assetservice.AssetService_;
import cds.gen.assetservice.Fixedassetec_;

@Component
@ServiceName(AssetService_.CDS_NAME)
public class FixedAssetControlHandler implements EventHandler {
    @Autowired
    @Qualifier("S4FixedAsset")
    CqnService remoteActivity;

    @On(event = CqnService.EVENT_READ, entity = Fixedassetec_.CDS_NAME)
    public void getactivities(CdsReadEventContext context) {

        System.out.println("Fetching Assets from external system...");

        context.setResult(
                remoteActivity.run(context.getCqn()));
    }
}
