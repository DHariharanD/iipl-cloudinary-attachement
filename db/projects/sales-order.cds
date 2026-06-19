namespace ec.masters;

using {
    cuid,
    managed
} from '@sap/cds/common';
using {ec.masters as pa} from './enterprise-project';
using {ec.masters.BillofQuantityItems} from '../billofquantities/bill-of-quantity';
entity SalesOrder : cuid, managed {
    SalesOrder            : String(200);
    Customer               :String(200);
    CustomerReference     :String(200);
    SalesOrderType        :String(200);
    PaymentTerms          :String(200);
    NetValue              :String(200);
    OverallStatus         :String(200);
    SoldToParty           : String(200);
    RequestedDeliveryDate : Date;
    BillingDocumentDate   : Date;
    TotalNetAmount        : String(200);
    TransactionCurrency   : String(200);
    Items                 : Composition of many SalesOrderItem
                                on Items.parent = $self;
    Project               : Association to pa.Projects;

}

entity SalesOrderItem : cuid, managed {
    SalesOrder               : String(200);
    SalesOrderItem           : String(200);           
    SalesOrderItemCategory   : String(200);
    SalesOrderItemText       : String(200);
    Product                  : String(200);
    ProductDescription       : String(200);
    RequestedQuantity        : String(200);
    ConfirmedQuanity         :String(200);
    RequestedQuantitySAPUnit : String(200);
    RequestedDeliveryDate    : Date;
    ConfirmedDeliveryDate    : Date;
    NetAmount                : String(200);
    transactioncurrency      : String(200);
    parent                   : Association to SalesOrder;
    wbs                      : Association to pa.ProjectPlanning;
    wbsboqItems              : Association to many BillofQuantityItems
                                   on wbsboqItems.wbsElement = wbs;
    paymentHistory           : Composition of many SalesPaymentHistory
                                   on paymentHistory.parent = $self;
    paymentCurrent           : Composition of many SalesPaymentCurrent
                                   on paymentCurrent.parent = $self;
}

entity SalesPaymentHistory : cuid, managed {
    Item          : String(40);
    Product       : String(40);
    Quantity      : String(40);
    TotalNetValue : String(40);
    Previous      : String(40);
    Current       : String(40);
    Total         : String(40);
    parent        : Association to SalesOrderItem;
}

entity SalesPaymentCurrent : cuid, managed {
    Item          : String(40);
    Product       : String(40);
    Quantity      : String(40);
    TotalNetValue : String(40);
    Previous      : String(40);
    Current       : String(40);
    Total         : String(40);
    parent        : Association to SalesOrderItem;
}
