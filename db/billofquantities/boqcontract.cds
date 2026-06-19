namespace ec.assetinfo;

using {
    cuid,
    sap.common.CodeList,
    managed
} from '@sap/cds/common';
using {ec.masters.Customer} from '../payment/customer-payment-application';


entity BOQContract : cuid, managed {
    vrNo            : String(50);
    vrDate          : Date;
    type            : Association to ContractType;
    project         : String(100);
    projectDesc     : String(255);
    subJob          : String(100);
    subJobDesc      : String(255);
    subContractType : String(100);
    startSrNo       : String(50);
    requestNo       : String(50);
    agreementVrNo   : String(50);
    agreementName   : String(255);
    items           : Composition of many ContractItems
                          on items.assetInfo = $self;
}

entity ContractItems : cuid, managed {
    assetInfo           : Association to BOQContract;
    resource            : String(50);
    resourceName        : String(255);
    costCode            : String(50);
    costCodeDescription : String(255);
    wbs                 : String(100);
    unit                : String(20);
    quantity            : Decimal(15, 2);
    rate                : Decimal(15, 2);
    discountPercent     : Decimal(5, 2);
    discountedRate      : Decimal(15, 2);
    amount              : Decimal(15, 2);
    vatRate             : Decimal(5, 2);
    itemCode            : String(50);
    budgetRemarks       : String(500);
    customerPayment : Association to Customer;
}

entity ContractType : CodeList {
    key code : ContractTypeCode;
}

type ContractTypeCode : String enum {
    Contract = 'Contract';
    Direct = 'Direct';
    Hired = 'Hired';
}

