// using {
//     cuid,
//     managed
// } from '@sap/cds/common';
// using {API_COMPANYCODE_SRV as CO} from '../../srv/external/API_COMPANYCODE_SRV';

// namespace ec.masters;

// entity wbs : cuid, managed {
//     Project            : String(40);
//     ProjectDescription : String(1111);
//     ProjectStartDate   : Date;
//     ProjectEndDate     : Date;
//     ProjectCurrency    : String(1111);
//     wbspjHierarchies   : Association to many wbsElement
//                              on wbspjHierarchies.wbshierarchy = $self;
// }

// entity wbsElement @(Common: {SemanticKey: [ID]}) : cuid, managed {

//     name                   : String(100);
//     wbsId                  : String(100);
//     processingStatus       : String(100);
//     plannedStart           : Date;
//     plannedFinish          : Date;
//     responsiableCostCenter : String(100);
//     profitCenter           : String(100);
//     parent                 : Association to wbsElement;
//     wbshierarchy           : Association to one wbs;
//     company                : Association to CO.A_CompanyCode
//                                  on company.CompanyCode = company_CompanyCode;
//     company_CompanyCode    : String(4);

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

// // code         : String(40);
// // name         : String(255);
// // descr        : String(1000);
// // parent       : Association to wbsElement;
// // cbshierarchy : Association to one wbs;

// // @Core.Computed: true
// // LimitedDescendantCount : Integer64;

// // @Core.Computed: true
// // DistanceFromRoot       : Integer64;

// // @Core.Computed: true
// // DrillState             : String;

// // @Core.Computed: true
// // Matched                : Boolean;

// // @Core.Computed: true
// // MatchedDescendantCount : Integer64;
// }

using {
    cuid,
    managed
} from '@sap/cds/common';
using {API_COMPANYCODE_SRV as CO} from '../../srv/external/API_COMPANYCODE_SRV';

namespace ec.masters;

entity wbs : cuid, managed {
    key ID             : String; // Redefinition for PostgreSQL hierarchy support
    Project            : String(40);
    ProjectDescription : String(1111);
    ProjectStartDate   : Date;
    ProjectEndDate     : Date;
    ProjectCurrency    : String(1111);
    wbspjHierarchies   : Association to many wbsElement
                             on wbspjHierarchies.wbshierarchy = $self;
}

entity wbsElement @(Common: {SemanticKey: [ID]}) : cuid, managed {
    key ID                 : String; // Redefinition for PostgreSQL hierarchy support
    name                   : String(100);
    wbsId                  : String(100);
    processingStatus       : String(100);
    plannedStart           : Date;
    plannedFinish          : Date;
    responsiableCostCenter : String(100);
    profitCenter           : String(100);
    parent                 : Association to wbsElement;
    wbshierarchy           : Association to one wbs;
    
    // Lowercase naming to match PostgreSQL physical column behavior
    company                : Association to CO.A_CompanyCode
                                 on company.CompanyCode = company_CompanyCode;
    company_CompanyCode    : String(4) @mandatory;

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



