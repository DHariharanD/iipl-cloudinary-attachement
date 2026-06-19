package inflexion.ec_master.external;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;

import cds.gen.assetmasterservice.AssetMasterService_;
import cds.gen.assettypeservice.AssetTypeService_;
import cds.gen.billofquantityservice.BillofQuantityService_;
import cds.gen.billofquantitytemplateservice.BillofQuantityTemplateService_;
import cds.gen.classservice.ClassService;
import cds.gen.commonservice.CommonService_;
import cds.gen.consumptionrateservice.ConsumptionRateService;
import cds.gen.costbreakdownstructureservice.CostBreakdownStructureService_;
import cds.gen.customerpaymentservice.CustomerPaymentService_;
import cds.gen.designationservice.DesignationService_;
import cds.gen.paymentapplication.PaymentApplication_;
import cds.gen.productivityentryservice.ProductivityEntryService;
import cds.gen.projectbudgetservice.ProjectBudgetService_;
import cds.gen.projectenterpriseservice.ProjectEnterpriseService_;
import cds.gen.requestresource.RequestResource_;
import cds.gen.resourceservices.ResourceServices_;
import cds.gen.vehiclemanagementservice.VehicleManagementService;
import cds.gen.groupservice.GroupService_;
import cds.gen.employeedetailsservice.EmployeeDetailsService_;
import cds.gen.projectprimaveraservice.ProjectPrimaveraService_;
import cds.gen.familyservice.FamilyService_;
import cds.gen.classservice.ClassService_;
import cds.gen.commodityservice.CommodityService_;
import cds.gen.vehiclemanagementservice.VehicleManagementService_;
import cds.gen.assetrequestservice.AssetRequestService_;
import cds.gen.productivityentryservice.ProductivityEntryService_;
import cds.gen.productivityrateservice.ProductivityRateService;
import cds.gen.productivityrateservice.ProductivityRateService_;
import cds.gen.tavouchersservice.TAVouchersService_;
// import cds.gen.assetservice.AssetService;
import cds.gen.assetservice.AssetService_;
import cds.gen.assettimesheetdailyservice.AssetTimeSheetDailyService_;
import cds.gen.consumptionrateservice.ConsumptionRateService_;

@Component
@ServiceName({
        CommonService_.CDS_NAME, ResourceServices_.CDS_NAME, RequestResource_.CDS_NAME,
        CostBreakdownStructureService_.CDS_NAME, AssetTypeService_.CDS_NAME, AssetMasterService_.CDS_NAME,
        BillofQuantityService_.CDS_NAME, BillofQuantityTemplateService_.CDS_NAME, ProjectBudgetService_.CDS_NAME,
        ProjectPrimaveraService_.CDS_NAME, CustomerPaymentService_.CDS_NAME, PaymentApplication_.CDS_NAME,
        EmployeeDetailsService_.CDS_NAME, DesignationService_.CDS_NAME, GroupService_.CDS_NAME, FamilyService_.CDS_NAME,
        ClassService_.CDS_NAME, CommodityService_.CDS_NAME, ProjectEnterpriseService_.CDS_NAME,
        VehicleManagementService_.CDS_NAME, AssetRequestService_.CDS_NAME, ProductivityEntryService_.CDS_NAME,
        AssetService_.CDS_NAME, TAVouchersService_.CDS_NAME, AssetTimeSheetDailyService_.CDS_NAME,
        ConsumptionRateService_.CDS_NAME,ProductivityRateService_.CDS_NAME
})

public class CompanyCodeHandler implements EventHandler {

    @Autowired
    @Qualifier("API_COMPANYCODE_SRV")
    private CqnService remote;

    @On(event = CqnService.EVENT_READ)
    public void onRead(CdsReadEventContext context) {

        String entityName = context.getTarget().getName();

        // Forward only company-related entities
        if (entityName.endsWith("Companies")
                || entityName.endsWith("company")
                || entityName.endsWith("Requestcompany")
                || entityName.endsWith("AssetCompanies")
                || entityName.endsWith("AssetNewService.Companies")) {

            System.out.println("Forwarding to S4 for entity: " + entityName);

            context.setResult(remote.run(context.getCqn()));
        }
    }
}