using {ec.masters as res} from '../db/payment/customer-payment-application';
using {CommonService as cm} from './common-service';
using {ec.masters as ep} from '../db/projects/enterprise-project';
using {ec.masters as boq} from '../db/billofquantities/bill-of-quantity';
using {ec.masters as so} from '../db/projects/sales-order';
using {ec.assetinfo as subCont} from '../db/billofquantities/boqcontract';


service CustomerPaymentService {
    @odata.draft.enabled
    entity Customer            as
        projection on res.Customer {
            *,
            salesOrder      : redirected to SalesOrders,
            salesOrderItems : redirected to SalesOrderItems,
            boqItems        : redirected to BillofQuantityItems
        };

    entity Payment             as projection on res.Payment;
    entity Companies           as projection on cm.Companies;
    entity Projects            as projection on ep.Projects;
    entity Wbs                 as projection on ep.ProjectPlanning;
    entity Boq                 as projection on boq.BillofQuantityHeader;

    entity SalesOrders         as
        projection on so.SalesOrder {
            *,
            Items : redirected to SalesOrderItems
        };

    entity SalesOrderItems     as
        projection on so.SalesOrderItem {
            *,
            wbsboqItems : redirected to BillofQuantityItems
        };

    entity BillofQuantityItems as projection on boq.BillofQuantityItems;
    entity addPayments         as projection on boq.addPayments;
    entity SalesPaymentHistory as projection on so.SalesPaymentHistory;
    entity SalesPaymentCurrent as projection on so.SalesPaymentCurrent;
    entity BOQContract         as projection on subCont.BOQContract;
    entity ContractItems       as projection on subCont.ContractItems;
}
