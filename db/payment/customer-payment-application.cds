namespace ec.masters;

using {
  cuid,
  managed
} from '@sap/cds/common';

using {ec.masters as pa} from '../projects/enterprise-project';
using {
  ec.masters.BillofQuantityHeader,
  ec.masters.BillofQuantityItems
} from '../billofquantities/bill-of-quantity';
using {ec.masters as so} from '../projects/sales-order';
using {ec.assetinfo as subCount} from '../billofquantities/boqcontract';


entity Customer : cuid, managed {
  company               : String(40);
  applicationID         : String(40);
  vrNumber              : Integer;
  currency              : String(3);
  uptoDate              : Date;
  projectCode           : String(20);
  projectDescription    : String(255);
  claimNumber           : Integer;
  certificateNumber     : Integer;
  revisionNumber        : Integer;
  status                : String(20);
  revisionDate          : Date;
  submittedDate         : Date;
  expectedDate          : Date;
  certifiedDate         : Date;
  certificatePayment    : Integer;
// Summary details
  startDate             : Date;
  dueDate               : Date;
  paStart               : Date;
  paEnd                 : Date;
  orderNumber           : String(20);
  orderType             : String(50);
  customer              : String(100);
  retention             : Decimal(5, 2);
  overallStatus         : String(30);
  contractAmount : Decimal(15, 2);

  // contractNo         : Association to subCount.BOQContract;
  // contractItems      : Association to many subCount.ContractItems
  //                        on contractItems.assetInfo = contractNo;

  project               : Association to pa.Projects @mandatory;
  boq                   : Association to BillofQuantityHeader;
  boqItems              : Association to many BillofQuantityItems
                            on boqItems.bqitemsHierarchy = boq;

  salesOrder            : Association to so.SalesOrder;
  salesOrderItems       : Association to many so.SalesOrderItem
                            on salesOrderItems.parent.ID = salesOrder.ID;
  payments              : Composition of many Payment
                            on payments.customer = $self;

  previousTable         : Composition of many Previous
                            on previousTable.customerPrevious = $self;
  CurrentPeriodTable    : Composition of many CurrentPeriod
                            on CurrentPeriodTable.customerCurrentPeriod = $self;
  CumulativeTable       : Composition of many Cumulative
                            on CumulativeTable.customerCumulative = $self;
}


entity Payment : cuid, managed {
  customer       : Association to Customer;
  wbsElement     : Association to pa.ProjectPlanning;
  salesOrderItem : Association to so.SalesOrderItem;
}

// entity ContractSummary {
//     startDate                 : Date;
//     dueDate                   : Date;
//     paStart                   : Date;
//     paEnd                     : Date;
//     orderNumber               : String(20);
//     orderType                 : String(50);
//     supplier                  : String(100);
//     retention                 : Decimal(5,2);
//     overallStatus             : String(30);
//     revisedContractAmount     : Decimal(15,2);
// }

entity Previous : cuid, managed {

  workDone               : Decimal(15, 2);
  meterial               : Decimal(15, 2);
  totalDue               : Decimal(15, 2);
  advPayRecovery         : Decimal(15, 2);
  retention              : Decimal(15, 2);
  retentionMaterial      : Decimal(15, 2);
  advPayRecoveryMaterial : Decimal(15, 2);
  otherDeduction         : Decimal(15, 2);

  netPaymentDue          : Decimal(15, 2);

  claimAmount            : Decimal(15, 2);
  advanceAmount          : Decimal(15, 2);
  retentionRelease       : Decimal(15, 2);

  customerPrevious       : Association to Customer;
}

entity CurrentPeriod : cuid, managed {

  workDone               : Decimal(15, 2);
  meterial               : Decimal(15, 2);
  totalDue               : Decimal(15, 2);
  advPayRecovery         : Decimal(15, 2);
  retention              : Decimal(15, 2);
  retentionMaterial      : Decimal(15, 2);
  advPayRecoveryMaterial : Decimal(15, 2);
  otherDeduction         : Decimal(15, 2);

  netPaymentDue          : Decimal(15, 2);

  claimAmount            : Decimal(15, 2);
  advanceAmount          : Decimal(15, 2);
  retentionRelease       : Decimal(15, 2);

  customerCurrentPeriod  : Association to Customer;
}

entity Cumulative : cuid, managed {

  workDone               : Decimal(15, 2);
  meterial               : Decimal(15, 2);
  totalDue               : Decimal(15, 2);
  advPayRecovery         : Decimal(15, 2);
  retention              : Decimal(15, 2);
  retentionMaterial      : Decimal(15, 2);
  advPayRecoveryMaterial : Decimal(15, 2);
  otherDeduction         : Decimal(15, 2);

  netPaymentDue          : Decimal(15, 2);

  claimAmount            : Decimal(15, 2);
  advanceAmount          : Decimal(15, 2);
  retentionRelease       : Decimal(15, 2);

  customerCumulative     : Association to Customer;
}
