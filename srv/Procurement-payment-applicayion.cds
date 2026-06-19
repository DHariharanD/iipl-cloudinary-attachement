using {ec.payment as ppa} from '../db/payment/procurement-payment-application';
using {CommonService as cm} from './common-service';
using {ec.masters as ep} from '../db/projects/enterprise-project';
using {ec.masters as wbs} from '../db/projects/enterprise-project';
using {ec.masters as po} from '../db/projects/purchase-order';
using {ec.assetinfo as subCont} from '../db/billofquantities/boqcontract';

service PaymentApplication {
    @odata.draft.enabled
    entity procurementPayment  as projection on ppa.ProcurementPaymentApplication {
        *,
        contractNo,
        contractItems : redirected to ContractItems
    };

    entity Companies           as projection on cm.Companies;
    entity Wbs                 as projection on wbs.ProjectPlanning;
    entity purchseOrders       as projection on po.PurchaseOrder;
    entity projects            as projection on ep.Projects;
    entity createApplication   as projection on ppa.createApplication;

    // Summary tables
    entity ProcurementPrevious      as projection on ppa.ProcurementPrevious;
    entity ProcurementCurrentPeriod as projection on ppa.ProcurementCurrentPeriod;
    entity ProcurementCumulative    as projection on ppa.ProcurementCumulative;

    // Contract (same as Customer)
    entity BOQContract         as projection on subCont.BOQContract;
    entity ContractItems       as projection on subCont.ContractItems;
}