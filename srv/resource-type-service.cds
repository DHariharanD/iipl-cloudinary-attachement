using {ec.masters as masters} from '../db';
using {PRODUCTTYPE_0001 as pt} from './external/PRODUCTTYPE_0001';
using {API_GLACCOUNTINCHARTOFACCOUNTS_SRV as gl} from './external/API_GLACCOUNTINCHARTOFACCOUNTS_SRV';
using {CE_PRODUCT_0002 as prod} from './external/CE_PRODUCT_0002';
using {YY1_TECHNICAL_OBJECT_CDS_0001 as at} from './external/YY1_TECHNICAL_OBJECT_CDS_0001';
using {YY1_WORKFORCE_SERVICE_LINE_CDS_0001 as wf} from './external/YY1_WORKFORCE_SERVICE_LINE_CDS_0001';
using {API_COSTCNTRACTIVITYTYPE_CRUD_SRV as AC} from './external/API_COSTCNTRACTIVITYTYPE_CRUD_SRV';
using {CommonService as cm} from './common-service';
using {ec.masters as emp} from '../db/employeedetails/employee-details';


service ResourceServices {

  // entity ResourceTypes          as projection on masters.ResourceTypes;
  entity ProductService         as projection on pt.ProductType;

  // entity RTAssets               as projection on masters.RTAssets;

  // entity RTWorkforce            as projection on masters.RTWorkforce;

  entity ProductTypeService     as projection on pt.ProductTypeText
                                   where
                                     Language = 'EN';

  // entity GLAccountService    as projection on gl.A_GLAccountText
  //                               where
  //                                 Language = 'EN';

  // entity RTProductTypes         as
  //   projection on masters.RTProductTypes {
  //     *,
  //     ProductTypeText : Association to pt.ProductTypeText
  //                         on  ProductTypeText.ProductType = prodType
  //                         and ProductTypeText.Language    = 'EN',
  //     productTypeName : String(40)
  //   };

  // entity ProductsWithText    as
  //   select from prod.Product as P
  //   left join prod.ProductDescription as D
  //     on  D.Product  = P.Product
  //     and D.Language = 'EN'
  //   {
  //     key P.Product,
  //         P.ProductType,
  //         D.ProductDescription as productName
  //   };

  entity Products               as projection on prod.Product;
  entity ProductDescriptions    as projection on prod.ProductDescription;
  entity ProductUnitsOfMeasures as projection on prod.ProductUnitOfMeasure;
  entity ProductValuationLedgerAccount as projection on prod.ProductValuationLedgerAccount;

  entity Activities             as projection on AC.A_CostCenterActivityTypeText;

  entity GlAccounts             as projection on gl.A_GLAccountText;

  entity company                as projection on cm.Companies;

  entity ResourceTypeCompany    as projection on masters.ResourceTypeCompany;

  entity CBHierarchy            as projection on masters.CostBreakDownHierarchies;

  // entity RTGlAccounts        as
  //   projection on masters.RTGlAccounts {
  //     *,
  //     GLAccount     : Association to gl.A_GLAccountText
  //                       on  GLAccount.GLAccount = glAccount
  //                       and GLAccount.Language  = 'EN',
  //     glAccountName : String(20) @Core.Computed
  //   };


  entity Assets                 as projection on at.YY1_Technical_Object;

  entity ManPower               as projection on wf.YY1_Workforce_service_line;


  // entity Type                   as projection on masters.type;
  entity RtTypes                as projection on masters.RtTypes;

  // entity AssetResources      as
  //   projection on AC.A_CostCenterActivityType {
  //     *,
  //     to_Text
  //   };

  // entity AssetResourcesText  as
  //   projection on AC.A_CostCenterActivityTypeText {
  //     *,
  //     to_CostCenterActivityType
  //   };


  action uploadResourceTypes(file: LargeBinary);
  entity NodeOptions            as projection on masters.NodeOptions;

  entity ResourceHierarchies    as
    projection on masters.ResourceHierarchies {
      *,
      resourceTypeCompany
    }

  entity ResourceMaterial       as projection on masters.ResourceMaterial;
  entity EmployeeDetails as projection on emp.Designations;

  entity Resources              as
    projection on masters.Resources {
      *,
      resourceType,
      RCResourceType_ID,
    }


  @Aggregation.RecursiveHierarchy #ResourceCategories: {
    NodeProperty            : ID,
    ParentNavigationProperty: parent
  }

  @Hierarchy.RecursiveHierarchy #ResourceCategories  : {
    ExternalKey           : ID,
    LimitedDescendantCount: LimitedDescendantCount,
    DistanceFromRoot      : DistanceFromRoot,
    DrillState            : DrillState,
    Matched               : Matched,
    MatchedDescendantCount: MatchedDescendantCount
  }
  @Capabilities.FilterRestrictions                   : {NonFilterableProperties: [
    LimitedDescendantCount,
    DistanceFromRoot,
    DrillState,
    Matched,
    MatchedDescendantCount
  ]}
  @Capabilities.SortRestrictions                     : {NonSortableProperties: [
    LimitedDescendantCount,
    DistanceFromRoot,
    DrillState,
    Matched,
    MatchedDescendantCount
  ]}


  @cds.redirection.target
  entity ResourceCategories     as projection on masters.ResourceCategories
    actions {
      action addNode(Type: String,
                     parentId: UUID,
                     ResourceHierarchy_ID: UUID,
                     name: String(100),
                     description: String(1111),
                     resourceName: String(100),
                     resourceDescription: String(1000),
                     rtCode: String(10)) returns ResourceCategories;
    }

  action uploadResourceCategories(file: LargeBinary,hierarchyId: UUID);

}

// annotate ResourceServices.ResourceTypes with @odata.draft.enabled;

annotate ResourceServices.ResourceHierarchies with @odata.draft.enabled;

annotate ResourceServices.Resources with @odata.draft.enabled;
