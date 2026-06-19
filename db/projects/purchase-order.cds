namespace ec.masters;

using {
    cuid,
    managed
} from '@sap/cds/common';
using {ec.masters as pa} from './enterprise-project';
using {ec.payment as ppa} from '../payment/procurement-payment-application';

entity PurchaseOrder : cuid, managed {
    PurchaseOrder           : String(200);
    Supplier                : String(200);
    company                 : String(200);
    status                  : String(30);
    PurchaseOrderDate       : Date;
    netOrderValue           : String(200);
    PurchaseOrderType       : String(200);
    Items                   : Composition of many PurchaseOrderItem
                                  on Items.parent = $self;
    Project                 : Association to pa.Projects;
    vendor                  : String(100); // Vendor
    paAmount                : Decimal(15, 2); // PA Amount
    invoice                 : String(100);
    paidAmount              : Decimal(15, 2);
    submittedDate           : Date;
    revision                : Integer;
    customerContractMapping : Boolean;
    ppApplication           : Association to ppa.ProcurementPaymentApplication

}

entity PurchaseOrderItem : cuid, managed {
    PurchaseOrder         : String(200);
    PurchaseOrderItems     : String(200);
    Product               : String(200);
    PurchasedQuantity     : String(200);
    NetValue              : String(200);
    SalesItemContract     : String(200);
    PurchaseOrderCategory : String(200);
    DocumentCurrency      : String(200);
    Material              : String(200);
    MaterialDescription   : String(200);
    parent                : Association to PurchaseOrder;
    wbs                   : Association to pa.ProjectPlanning;
    wbsboqItems           : Association to many pa.BillofQuantityItems
                                on wbsboqItems.wbsElement = wbs;
    paymentHistory        : Composition of many PaymentHistory
                                on paymentHistory.parent = $self;
    paymentCurrent        : Composition of many PaymentCurrent
                                on paymentCurrent.parent = $self;
}


entity PaymentHistory : cuid, managed {
    Item          : String(40);
    Product       : String(40);
    Quantity      : String(40);
    TotalNetValue : String(40);
    Pervious      : String(40);
    Current       : String(40);
    Total         : String(40);
    parent        : Association to PurchaseOrderItem;
}

entity PaymentCurrent : cuid, managed {
    Item          : String(40);
    Product       : String(40);
    Quantity      : String(40);
    TotalNetValue : String(40);
    Pervious      : String(40);
    Current       : String(40);
    Total         : String(40);
    parent        : Association to PurchaseOrderItem;
}
