package inflexion.ec_master.handlers;

import cds.gen.consumptionrateservice.ConsumptionRateService_;
import cds.gen.consumptionrateservice.ProductDescriptions_;
import cds.gen.consumptionrateservice.Products_;
import cds.gen.consumptionrateservice.ProductsVH_;
import cds.gen.consumptionrateservice.ProductUnitsOfMeasures_;
import cds.gen.consumptionrateservice.ProductValuationLedgerAccount_;

import com.sap.cds.Result;
import com.sap.cds.ql.Select;
import com.sap.cds.ql.cqn.CqnSelect;
import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
@ServiceName(ConsumptionRateService_.CDS_NAME)
public class ConsumptionRateProductHandler implements EventHandler {

    @Autowired
    @Qualifier("CE_PRODUCT_0002")
    private CqnService ceProduct;

    @On(entity = Products_.CDS_NAME)
    public void onReadProducts(CdsReadEventContext ctx) {
        ctx.setResult(ceProduct.run(ctx.getCqn()));
        ctx.setCompleted();
    }

    @On(entity = ProductDescriptions_.CDS_NAME)
    public void onReadProductDescriptions(CdsReadEventContext ctx) {
        ctx.setResult(ceProduct.run(ctx.getCqn()));
        ctx.setCompleted();
    }

    @On(entity = ProductUnitsOfMeasures_.CDS_NAME)
    public void onReadProductUnitsOfMeasures(CdsReadEventContext ctx) {
        ctx.setResult(ceProduct.run(ctx.getCqn()));
        ctx.setCompleted();
    }

    @On(entity = ProductValuationLedgerAccount_.CDS_NAME)
    public void onReadProductValuation(CdsReadEventContext ctx) {
        ctx.setResult(ceProduct.run(ctx.getCqn()));
        ctx.setCompleted();
    }

    @On(entity = ProductsVH_.CDS_NAME)
    public void onReadProductsVH(CdsReadEventContext ctx) {

        // Fetch Products from S4
        CqnSelect productsQuery = Select.from(Products_.CDS_NAME)
                .columns("Product", "ProductType", "BaseUnit");
        Result productsResult = ceProduct.run(productsQuery);

        // Fetch English descriptions from S4
        CqnSelect descQuery = Select.from(ProductDescriptions_.CDS_NAME)
                .columns("Product", "ProductDescription")
                .where(d -> d.get("Language").eq("EN"));
        Result descResult = ceProduct.run(descQuery);

        // Build description map
        Map<String, String> descMap = new HashMap<>();
        for (Map<String, Object> row : descResult) {
            String prod = String.valueOf(row.get("Product"));
            String desc = String.valueOf(row.getOrDefault("ProductDescription", ""));
            descMap.put(prod, desc);
        }

        // Join and build result as plain maps
        List<Map<String, Object>> result = new ArrayList<>();
        for (Map<String, Object> row : productsResult) {
            String productId = String.valueOf(row.get("Product"));
            Map<String, Object> vh = new HashMap<>();
            vh.put("Product", productId);
            vh.put("ProductType", row.getOrDefault("ProductType", ""));
            vh.put("BaseUnit", row.getOrDefault("BaseUnit", ""));
            vh.put("ProductDescription", descMap.getOrDefault(productId, ""));
            result.add(vh);
        }

        ctx.setResult(result);
        ctx.setCompleted();
    }
}