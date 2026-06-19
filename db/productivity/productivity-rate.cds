namespace ec.productivityrate;

using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';

using {CommonService as cm} from '../../srv/common-service';
using {ec.masters as cbs} from '../cbs/cbs';


entity ProductivityRate : cuid, managed {
    company             : Association to cm.Companies @mandatory;
    resourceType        : Association to ResourceType @mandatory;
    resourceCode        : String(100)                 @mandatory;
    resourceDescription : String(255)                 @mandatory;
    activityFreeText    : String(255);
    linkedCbsActivity   : String(100)                 @mandatory;
    linkedCBS           : Association to cbs.CostBreakdownStructure;
    status              : Association to Status default 'Active';
    productivities      : Composition of many Productivity
                              on productivities.parent = $self;

    datesApplicability  : Composition of many DatesApplicability
                              on datesApplicability.parent = $self;
}

entity Productivity : cuid, managed {
    parent       : Association to ProductivityRate;
    cbsRresource:  Association to cbs.CBSResourceMaterial;
    productivity : String(100);
   outputUOM : Association to OutputUOM;
    outputHour   : Decimal(10, 2) default '1';
    output       : Decimal(10, 2);
}

entity DatesApplicability : cuid, managed {
    parent        : Association to ProductivityRate;
    effectiveFrom : Date @mandatory;
    effectiveTo   : Date;
    applicability : Association to Applicability;
    notes         : String(500);
}

entity ResourceType : CodeList {
    key code : ResourceTypeText;
}

entity Status : CodeList {
    key code : StatusText;
}

entity Applicability : CodeList {
    key code : ApplicabilityText;
}
entity OutputUOM : CodeList {
    key code : String(20);
}

type ResourceTypeText  : String enum {
    MANPOWER = 'Manpower';
    EQUIPMENT = 'Asset';
}

type StatusText        : String enum {
    ACTIVE = 'A';
    DRAFT = 'D';
    SUPERSEDED = 'S';
}

type ApplicabilityText : String enum {
    GLOBAL = 'GL';
    REGION_GULF = 'RG';
    PROJECT_ONLY = 'PO';
    PROJECT_FAMILY = 'PF';
}
