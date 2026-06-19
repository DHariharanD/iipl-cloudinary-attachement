// using {ec.masters as rt} from './resource-types';
// using {ec.masters.CostBreakdownStructure} from '../cbs/cbs';
// using {API_COSTCNTRACTIVITYTYPE_CRUD_SRV as AC} from '../../srv/external/API_COSTCNTRACTIVITYTYPE_CRUD_SRV';
// using {
//     cuid,
//     managed,
//     sap.common.CodeList
// } from '@sap/cds/common';

// namespace ec.masters;

// entity ResourceHierarchies : cuid, managed {
//     name        : String(40);
//     descr       : String(1111);
//     note        : String(1111);
//     Hierarchies : Association to many ResourceCategories
//                       on Hierarchies.ResourceHierarchy = $self;
// }

// entity ResourceCategories @(Common: {SemanticKey: [ID]}) : cuid, managed {
//     name                   : String(40);
//     code                   : String(40);
//     descr                  : String(1111);
//     isDefaultBudgetHead    : Boolean;
//     isBudgetValidation     : Boolean;
//     // isGlAccount            : Boolean = RCResourceType.isGlAccount;
//     childType              : chidType;
//     parent                 : Association to ResourceCategories;
//     resourceType           : Association to RtTypes;
//     ResourceHierarchy      : Association to one ResourceHierarchies;

//     resourceMeterial       : Composition of many ResourceMaterial
//                                  on resourceMeterial.parent = $self;
//     resourceGlAccounts     : Composition of many ResourceGl
//                                  on resourceGlAccounts.parent = $self;
//     resourceAssets         : Composition of many ResourceAssets
//                                  on resourceAssets.parent = $self;
//     resourceWorkforce      : Composition of many ResourceWorkforce
//                                  on resourceWorkforce.parent = $self;

//     @Core.Computed: true
//     LimitedDescendantCount : Integer64;

//     @Core.Computed: true
//     DistanceFromRoot       : Integer64;

//     @Core.Computed: true
//     DrillState             : String;

//     @Core.Computed: true
//     Matched                : Boolean;

//     @Core.Computed: true
//     MatchedDescendantCount : Integer64;
// };

// entity ResourceMaterial : cuid, managed {
//     productId     : String(40);
//     productName   : String(1111) @mandatory;
//     descr         : String(1111);
//     productType   : String(40);
//     unitofMeasure : String(1111) @mandatory;
//     parent        : Association to one ResourceCategories;
//     cbsNode       : Association to one CostBreakdownStructure;
// };

// entity ResourceGl : cuid, managed {
//     GLNo   : String(10);
//     GLName : String(20);
//     parent : Association to one ResourceCategories
// };

// entity ResourceAssets : cuid, managed {
//     parent : Association to ResourceCategories;
//     // type   : String(50);
//     name   : String(20);
//     Asset  : String(20);
// }

// entity ResourceWorkforce : cuid, managed {
//     parent                   : Association to ResourceCategories;
//     WorkAssignmentExternalID : String(80);
//     ServiceCostLevel         : String(20);
// }

// entity Resources : cuid, managed {

//     RCRes                  : Association to one ResourceHierarchies;
//     RCCategory             : Association to one ResourceCategories;

//     // RCMat                  : Composition of many ResourceMaterial
//     //                              on RCMat.parent = $self;
//     // RCGL                   : Composition of many ResourceGl
//     //                              on RCGL.parent = $self;
//     resourceHierarchy_name : String(40);
//     resourceCategory_name  : String(40);
//     resourceType           : String(50);
//     typeOfResource_code    : String(10);
//     resAssets              : Association to AC.A_CostCenterActivityType;
//     RCResourceType_ID      : UUID @UI.Hidden: true;
// }

// type chidType      : String enum {
//     N = 'Node';
//     R = 'Resource Type';
// }

// entity NodeOptions {
//     key code : String(1);
//         name : String(50);
// }

// entity RtTypes : CodeList {
//     key code : resourceTypes;
// }

// type resourceTypes : String enum {
//     MT = 'Material';
//     AT = 'Asset';
//     MP = 'Manpower';
//     GL = 'GL Account';
//     SC = 'Subcontractor'
// }


using {ec.masters.CostBreakdownStructure} from '../cbs/cbs';
using {ec.masters.CostBreakDownHierarchies} from '../cbs/cbs';
using {API_GLACCOUNTINCHARTOFACCOUNTS_SRV as AC} from '../../srv/external/API_GLACCOUNTINCHARTOFACCOUNTS_SRV';
using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';
using {CommonService as cm} from '../../srv/common-service';

namespace ec.masters;

entity ResourceHierarchies : cuid, managed {
        // Redefining ID to String (text) keeps cuid's auto-gen but fixes Postgres array mismatch
    key ID                  : UUID @Core.Computed;
        name                : String(40);
        descr               : String(1111);
        note                : String(1111);
        Hierarchies         : Composition of many ResourceCategories
                                  on Hierarchies.ResourceHierarchy = $self;
        resourceTypeCompany : Composition of many ResourceTypeCompany
                                  on resourceTypeCompany.parent = $self @ma;
        cbsHierarchies      : Association to one CostBreakDownHierarchies;
}

entity ResourceCategories @(Common: {SemanticKey: [ID]}) : cuid, managed {
    key ID                     : String; // Fixes "column 19 has type character varying(36)[]"
        name                   : String(40);
        code                   : String(40);
        descr                  : String(1111);
        isDefaultBudgetHead    : Boolean;
        isBudgetValidation     : Boolean;
        childType              : chidType;
        parent                 : Association to ResourceCategories;
        resourceType           : Association to RtTypes;
        ResourceHierarchy      : Association to one ResourceHierarchies;

        resourceMeterial       : Composition of many ResourceMaterial
                                     on resourceMeterial.parent = $self;
        resourceGlAccounts     : Composition of many ResourceGl
                                     on resourceGlAccounts.parent = $self;
        resourceAssets         : Composition of many ResourceAssets
                                     on resourceAssets.parent = $self;
        resourceWorkforce      : Composition of many ResourceWorkforce
                                     on resourceWorkforce.parent = $self;
        resourceSubcontract    : Composition of many ResourceSubcontract
                                     on resourceSubcontract.parent = $self;


        @Core.Computed: true
        LimitedDescendantCount : Integer64;

        @Core.Computed: true
        DistanceFromRoot       : Integer64;

        @Core.Computed: true
        DrillState             : String;

        @Core.Computed: true
        Matched                : Boolean;

        @Core.Computed: true
        MatchedDescendantCount : Integer64;
};

// Apply the same ID redefinition to all related child entities
entity ResourceMaterial : cuid, managed {
    //  key ID            : String;
    productId     : String(40);
    productName   : String(1111) @mandatory;
    descr         : String(1111);
    productType   : String(40);
    unitofMeasure : String(1111) @mandatory;
    isPrime       : Boolean default false;
    primeResource : Association to ResourceMaterial;
    primeUnit     : String(100);
    unitFactor    : Decimal(15, 7);
    parent        : Association to one ResourceCategories;
    cbsNode       : Association to one CostBreakdownStructure;
};

entity ResourceGl : cuid, managed {
    GLNo   : String(10);
    GLName : String(50);
    parent : Association to one ResourceCategories
};

entity ResourceAssets : cuid, managed {
    //  key ID            : String;
    parent        : Association to ResourceCategories;
    name          : String(20);
    Asset         : String(20);
    //for details page
    itemUnit      : String(20);
    rate          : Decimal(15, 2);
    tsUnit        : String(11);
    group         : String(11);
    refCat        : String(11);
    subCount      : Integer;
    assetCategory : String(20);
    budgetHead    : String(30);
    billingUnit   : String(11);
    vat           : Integer;
}

entity ResourceWorkforce : cuid, managed {
    //  key ID                       : String;
    parent         : Association to ResourceCategories;
    name           : String(100);
    description    : String(500);
    //for details page
    itemUnit       : String(20);
    rate           : Decimal(15, 2);
    tsUnit         : String(11);
    labourCategory : String(36);
    billingUni     : String(11);
    refCategory    : String(20);
    vat            : Integer
};

entity ResourceSubcontract : cuid, managed {
    //  key ID              : String;
    subcontractId   : String(40)  @mandatory;
    subcontractName : String(255) @mandatory;
    description     : String(1111);
    subcontractType : String(40);
    unitOfMeasure   : String(40)  @mandatory;
    parent          : Association to one ResourceCategories;
    //for details page
    refCategory     : String(11);
    vat             : Integer;
};

entity ResourceTypeCompany : cuid, managed {
    //  key ID          : String;
    parent      : Association to one ResourceHierarchies;
    companyCode : String(11);
    companyName : String(111);
    company     : Association to cm.Companies
                      on company.CompanyCode = companyCode;
};

entity Resources : cuid, managed {
    //   key ID                     : String;
    RCRes                  : Association to one ResourceHierarchies;
    RCCategory             : Association to one ResourceCategories;
    resourceHierarchy_name : String(40);
    resourceCategory_name  : String(40);
    resourceType           : String(50);
    typeOfResource_code    : String(10);
    resAssets              : Association to AC.A_GLAccountText;
    RCResourceType_ID      : UUID @UI.Hidden: true;
}

type chidType      : String enum {
    N = 'Node';
    R = 'Resource Type';
}

entity NodeOptions {
    key code : String(1);
        name : String(50);
}

entity RtTypes : CodeList {
    key code : resourceTypes;
}

type resourceTypes : String enum {
    MT = 'Material';
    AT = 'Asset';
    MP = 'Manpower';
    GL = 'GL Account';
    SC = 'Subcontractor'
}
