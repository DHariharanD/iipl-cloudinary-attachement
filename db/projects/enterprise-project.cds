// using {
//     cuid,
//     managed,
//     temporal
// } from '@sap/cds/common';
// using {ec.masters as sa} from './sales-order';
// using {ec.masters as pu} from './purchase-order';

// namespace ec.masters;

// using {ec.masters as boq} from '../billofquantities/bill-of-quantity';
// using {sap.attachments.Attachments} from 'com.sap.cds/cds-feature-attachments';
// using {API_COMPANYCODE_SRV as CO} from '../../srv/external/API_COMPANYCODE_SRV';

// entity Projects : cuid, managed {
//     project                 : String(40);
//     projectDescription      : String(1111);
//     projectStartDate        : Date;
//     projectEndDate          : Date;
//     projectCurrency         : String(1111);
//     awardedDate             : Date;
//     status                  : String(30);
//     advance                 : Decimal(15, 2);
//     retention               : Decimal(15, 2);
//     defectLiability         : Integer;
//     performanceSecurity     : Decimal(15, 2);
//     advancePaymentGuarantee : Decimal(15, 2);
//     company                 : Association to CO.A_CompanyCode
//                                   on company.CompanyCode = company_CompanyCode;
//     company_CompanyCode     : String(4);
//     pjHierarchies           : Composition of many ProjectPlanning
//                                   on pjHierarchies.plshierarchy = $self;
//     SalesOrders             : Composition of many sa.SalesOrder
//                                   on SalesOrders.Project = $self;
//     PurchaseOrders          : Composition of many pu.PurchaseOrder
//                                   on PurchaseOrders.Project = $self;
//     attachments             : Composition of many Attachments;
// }

// entity ProjectPlanning @(Common: {SemanticKey: [ID]}) : cuid, managed {

//     projectElementDescription : String(40);
//     plannedStartDate          : Date;
//     plannedEndDate            : Date;
//     projectId                 : String(40);
//     processingStatus          : String(40);
//     costCenter                : String(111);
//     profitCenter              : String(111);
//     parent                    : Association to ProjectPlanning;
//     plshierarchy              : Association to one Projects;
//     WbsBoq                    : Composition of many WbsBillOfQuantities
//                                     on WbsBoq.projectPlanning = $self;

//     @Core.Computed: true
//     LimitedDescendantCount    : Integer64;

//     @Core.Computed: true
//     DistanceFromRoot          : Integer64;

//     @Core.Computed: true
//     DrillState                : String;

//     @Core.Computed: true
//     Matched                   : Boolean;

//     @Core.Computed: true
//     MatchedDescendantCount    : Integer64;
// }

// entity WbsBillOfQuantities : cuid, managed {
//     projectPlanning        : Association to one ProjectPlanning;
//     boqResources           : Composition of many BoqResources
//                                  on boqResources.parent = $self;
//     item                   : String(40);
//     description            : String(1111);
//     unitOfMeasurement      : String(10);
//     quantity               : String(20);
//     bill                   : Integer;
//     section                : String(10);
//     page                   : Integer;
//     revision               : Integer;
//     retention              : Decimal(15, 7);
//     advance                : Decimal(15, 7);
//     parent                 : Association to WbsBillOfQuantities;

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
// }

// entity BoqResources : cuid, managed {
//     productId     : String(40);
//     productName   : String(1111);
//     descr         : String(1111);
//     unitofMeasure : String(1111);
//     parent        : Association to one WbsBillOfQuantities;
//     type          : String(20) default 'Resources'
// }

using {
    cuid,
    managed,
    temporal
} from '@sap/cds/common';
using {ec.masters as sa} from './sales-order';
using {ec.masters as pu} from './purchase-order';

namespace ec.masters;

using {ec.masters as boq} from '../billofquantities/bill-of-quantity';
using {sap.attachments.Attachments} from 'com.sap.cds/cds-feature-attachments';
using {API_COMPANYCODE_SRV as CO} from '../../srv/external/API_COMPANYCODE_SRV';

entity Projects : cuid, managed {
    key ID                      : UUID      @Core.Computed; // Fixes Postgres recursive type mismatch
        project                 : String(40);
        projectDescription      : String(1111);
        projectStartDate        : Date;
        projectEndDate          : Date;
        projectCurrency         : String(1111);
        projectManager          : String(500);
        awardedDate             : Date;
        status                  : String(30);
        advance                 : Decimal(15, 2);
        retention               : Decimal(15, 2);
        defectLiability         : Integer;
        performanceSecurity     : Decimal(15, 2);
        advancePaymentGuarantee : Decimal(15, 2);

        // Lowercase to match Postgres physical column naming
        company                 : Association to CO.A_CompanyCode
                                      on company.CompanyCode = companyCode;
        companyCode             : String(4) @mandatory;

        pjHierarchies           : Composition of many ProjectPlanning
                                      on pjHierarchies.plshierarchy = $self;
        SalesOrders             : Composition of many sa.SalesOrder
                                      on SalesOrders.Project = $self;
        PurchaseOrders          : Composition of many pu.PurchaseOrder
                                      on PurchaseOrders.Project = $self;
        attachments             : Composition of many Attachments;
         BOQs                    : Association to many boq.BillofQuantityHeader
                                      on BOQs.project = $self;
}

entity ProjectPlanning @(Common: {SemanticKey: [ID]}) : cuid, managed {
   key ID                     : String; 
        projectElementDescription : String(40);
        plannedStartDate          : Date;
        plannedEndDate            : Date;
        projectId                 : String(40);
        processingStatus          : String(40);
        costCenter                : String(111);
        profitCenter              : String(111);
        parent                    : Association to ProjectPlanning;
        plshierarchy              : Association to one Projects;
        WbsBoq                    : Composition of many WbsBillOfQuantities
                                        on WbsBoq.projectPlanning = $self;

        @Core.Computed: true
        LimitedDescendantCount    : Integer64;

        @Core.Computed: true
        DistanceFromRoot          : Integer64;

        @Core.Computed: true
        DrillState                : String;

        @Core.Computed: true
        Matched                   : Boolean;

        @Core.Computed: true
        MatchedDescendantCount    : Integer64;
}

entity WbsBillOfQuantities : cuid, managed {
    key ID                     : String; // Fixes Postgres recursive type mismatch
        projectPlanning        : Association to one ProjectPlanning;
        boqResources           : Composition of many BoqResources
                                     on boqResources.parent = $self;
        item                   : String(40);
        description            : String(1111);
        unitOfMeasurement      : String(10);
        quantity               : String(20);
        bill                   : Integer;
        section                : String(10);
        page                   : Integer;
        revision               : Integer;
        retention              : Decimal(15, 7);
        advance                : Decimal(15, 7);
        parent                 : Association to WbsBillOfQuantities;

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
}

entity BoqResources : cuid, managed {
    key ID            : String; // Consistency across the model
        productId     : String(40);
        productName   : String(1111);
        descr         : String(1111);
        unitofMeasure : String(1111);
        parent        : Association to one WbsBillOfQuantities;
        type          : String(20) default 'Resources'
}
