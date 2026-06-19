namespace ec.masters;

using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';

// Enums
type UOMKey               : String enum {
    M3 = 'M3';
    M2 = 'M2';
    MTR = 'MTR';
    KG = 'KG';
    TON = 'TON';
    NOS = 'NOS';
    SET = 'SET';
    FIX = 'FIX';
    FLR = 'FLR';
    BAG = 'BAG';
    L = 'L';
}


type ApplicabilityKey     : String enum {
    GLOBAL = 'Global (all projects)';
    GULF = 'Region — Gulf';
    PROJECT = 'Project P-2024-014 only';
}

type NormTypeKey          : String enum {
    PLANNING = 'Planning';
    FINALIZED = 'Finalized';
}

type StatusKey            : String enum {
    ACTIVE = 'Active';
    INACTIVE = 'Inactive';
    DRAFT = 'Draft';
}

entity ConsumptionRate : cuid, managed {
    // Identification
    company_CompanyCode : String(4)  @mandatory;
    materialId          : String(60) @mandatory;
    productId           : String(40);
    // productName   : String(1111) @mandatory;
    productType         : String(40);
    materialDescription : String(200);
    resourceCode        : String(60);
    materialClass       : Association to MaterialClassKey;
    linkedCBS           : String(20);
    activity            : String(300);
    // Theoretical Net (with wastage)
    outputUOM           : UOMKey;
    theoretical         : Decimal(15, 4) default 1.0000;
    consUOM             : UOMKey;
    wastagePercent      : Decimal(5, 2) default 0.00;
    netRate             : Decimal(15, 4);
    varianceThreshold   : Decimal(5, 2) default 5.00;
    mosCap              : Decimal(5, 2) default 80.00;
    // Effective dates & applicability
    effectiveFrom       : Date;
    effectiveTo         : Date;
    applicability       : ApplicabilityKey default #GLOBAL;
    notes               : String(1000);
    // Admin
    normType            : NormTypeKey default #PLANNING;
    status              : StatusKey default #ACTIVE;
}



type MaterialClassKeyText : String enum {
    CON = 'Concrete';
    RFT = 'Reinforcement';
    FMW = 'Formwork';
    BLK = 'Blockwork';
    PLS = 'Plaster & finishes';
    TLG = 'Tiling';
    PNT = 'Paint';
    MEP_PLB = 'MEP — Plumbing';
    MEP_ELC = 'MEP — Electrical';
    MEP_HVC = 'MEP — HVAC';
    JNR = 'Joinery / Hardware';
    CSM = 'Consumables';
}

entity MaterialClassKey : CodeList {
    key code : MaterialClassKeyText;
}
