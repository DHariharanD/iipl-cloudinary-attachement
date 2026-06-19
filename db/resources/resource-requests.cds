namespace ec.masters;

using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';
using {
    ec.masters.BillofQuantityHeader,
    ec.masters.BillofQuantityItems
} from '../billofquantities/bill-of-quantity';
using {ec.masters as ep} from '../projects/enterprise-project';

using {ec.masters.CostBreakdownStructure} from '../cbs/cbs';

entity RequestResource : cuid, managed {
    // COMMON FIELDS
    requestId              : String(30);
    name                   : String(255);
    company                : String(100);
    project                : Association to ep.Projects;
    requestType            : Association to RequestType;
    priority               : Association to PriorityType;
    notes                  : LargeString;
    approvedBy             : String(255);
    raisedBy               : String(255);
    boq                    : Association to BillofQuantityHeader;

    // MATERIAL REQUEST (MT)
    workFront              : String(255);
    needBy                 : Date;
    needByFrom             : Date;
    needByTo               : Date;
    storageLocation        : String(100);
    storageType            : String(100);
    uom                    : String(10);
    lineCount              : Integer;
    materialCount          : Integer;
    wbsCount               : Integer;
    cbsCount               : Integer;

    // EQUIPMENT REQUEST (AT)
    mobWindowFrom          : Date;
    mobWindowTo            : Date;
    demobWindowFrom        : Date;
    demobWindowTo          : Date;
    demobRemarks           : String(500);
    defaultShiftPattern    : String(100);
    custodian              : String(255);
    equipmentLineCount     : Integer;
    equipmentInstanceCount : Integer;
    equipmentWbsCount      : Integer;

    // MANPOWER REQUEST (MP)
    startWindowFrom        : Date;
    startWindowTo          : Date;
    endWindowFrom          : Date;
    endWindowTo            : Date;
    reportingTo            : String(255);
    manpowerShiftPattern   : String(100);
    manpowerLineCount      : Integer;
    manpowerHeadCount      : Integer;
    manpowerCrewCount      : Integer;
    manpowerWbsCount       : Integer;

    // SUBCONTRACTOR REQUEST (SC)
    tradePackage           : String(255);
    wbsCode                : String(255);
    cbsCode                : String(255);
    periodFrom             : Date;
    periodTo               : Date;
    indicativeValue        : Decimal(15,2);
    currency               : String(10);
    contractsOwner         : String(255);
    routing                : String(255);
    sapServicePrTarget     : String(255);

    // CHILD ENTITIES
    requestBoqItems        : Composition of many RequestBoqItems
                                on requestBoqItems.parent = $self;

    requestCbs             : Composition of many RequestCbs
                                on requestCbs.parent = $self;

    requestCbsResource     : Composition of many RequestCbsResource
                                on requestCbsResource.parent = $self;
}

entity RequestBoqItems : cuid, managed {
    parent              : Association to one RequestResource;
    item                : String(40);
    description         : String(1111);
    unitOfMeasurement   : String(10);
    quantity            : Decimal(15, 7);
    bill                : Integer;
    section             : String(10);
    page                : Integer;
    revision            : Integer;
    retention           : Decimal(15, 7);
    advance             : Decimal(15, 7);
    peformanceBond      : Decimal(15, 7);
    bankGuarantee       : Decimal(15, 7);
    sumBack             : Boolean;
    boqNo               : String(10);
    pcRate              : Boolean;
    nonClient           : Boolean;
    excludeActiveBudget : Boolean;
    boqItem_ID          : UUID;
}

entity RequestCbs : cuid, managed {
    boqCbs_ID : UUID;
    code      : String(40);
    name      : String(255);
    descr     : String(1000);
    parent    : Association to RequestResource;
}

entity RequestCbsResource : cuid, managed {
    code              : String(40);
    name              : String(255);
    descr             : String(1000);
    parent            : Association to RequestResource;
    requestedQuantity : Integer;
    availableQuantity:Integer;
}

entity PriorityType : CodeList {
    key code : PriorityTypeText;
}

type PriorityTypeText : String enum {
    NORMAL  = 'NORMAL';
    HIGH    = 'HIGH';
    URGENCY = 'URGENCY';
}
entity RequestType :CodeList{
    Key code : RequestTypeText;
}

type RequestTypeText : String enum {
    MT = 'Material';
    AT = 'Asset';
    MP = 'Manpower';
    GL = 'GL Account';
    SC = 'Subcontractor'
}
