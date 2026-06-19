namespace ec.payment;

using {
    cuid,
    managed
} from '@sap/cds/common';
using {ec.masters as pj} from '../projects/enterprise-project';
using {ec.masters as po} from '../projects/purchase-order';
using {ec.masters as ep} from '../projects/enterprise-project';
using {ec.assetinfo as subCount} from '../billofquantities/boqcontract';

entity ProcurementPaymentApplication : cuid, managed {

    applicationNo         : String(50);
    originalPAAmount      : Decimal(15, 2);
    updatedPAAmount       : Decimal(15, 2);
    invoice               : String(100);
    project               : Association to ep.Projects;
    wbs                   : Association to pj.ProjectPlanning;
    customer              : String(100);
    company               : String(50);
    dueDate               : Date;
    submittedDate         : Date;
    status                : String(30);
    manage                : String(50);
    Supplier              : String(50);
    startDate             : Date;
    endDate               : Date;

    // Certificate / Claim fields (mirroring Customer)
    vrNumber              : Integer;
    currency              : String(3);
    claimNumber           : Integer;
    certificateNumber     : Integer;
    revisionNumber        : Integer;
    revisionDate          : Date;
    expectedDate          : Date;
    certifiedDate         : Date;
    certificatePayment    : Integer;

    contractNo            : Association to subCount.BOQContract;
    contractItems         : Association to many subCount.ContractItems
                                on contractItems.assetInfo = $self.contractNo;
    ppaPurchaseOrder      : Association to po.PurchaseOrder;

    // Summary tables — same structure as Customer
    previousTable         : Composition of many ProcurementPrevious
                                on previousTable.procurementPrevious = $self;
    CurrentPeriodTable    : Composition of many ProcurementCurrentPeriod
                                on CurrentPeriodTable.procurementCurrentPeriod = $self;
    CumulativeTable       : Composition of many ProcurementCumulative
                                on CumulativeTable.procurementCumulative = $self;

    paStart               : Date;
    paEnd                 : Date;
    orderNumber           : String(20);
    orderType             : String(50);
    retention             : Decimal(5, 2);
    revisedContractAmount : Decimal(15, 2);
}

entity ProcurementPrevious : cuid, managed {
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
    procurementPrevious    : Association to ProcurementPaymentApplication;
}

entity ProcurementCurrentPeriod : cuid, managed {
    workDone                 : Decimal(15, 2);
    meterial                 : Decimal(15, 2);
    totalDue                 : Decimal(15, 2);
    advPayRecovery           : Decimal(15, 2);
    retention                : Decimal(15, 2);
    retentionMaterial        : Decimal(15, 2);
    advPayRecoveryMaterial   : Decimal(15, 2);
    otherDeduction           : Decimal(15, 2);
    netPaymentDue            : Decimal(15, 2);
    claimAmount              : Decimal(15, 2);
    advanceAmount            : Decimal(15, 2);
    retentionRelease         : Decimal(15, 2);
    procurementCurrentPeriod : Association to ProcurementPaymentApplication;
}

entity ProcurementCumulative : cuid, managed {
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
    procurementCumulative  : Association to ProcurementPaymentApplication;
}

entity CreateProject : cuid, managed {
    ppaCompany : String(40);
    ppaProject : Association to pj.Projects;
    ppaWbs     : Association to pj.ProjectPlanning;
    ppaMap     : Association to ProcurementPaymentApplication;
}

entity createApplication : cuid, managed {
    itemDescription : String(40);
    Unit            : String(40);
    QA1             : String(40);
    QA2             : String(40);
    QA3             : String(40);
}
