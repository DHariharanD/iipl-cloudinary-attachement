//  using {
//      cuid,
//      managed,
//      temporal
//  } from '@sap/cds/common';
//  using { ec.masters.ResourceMaterial }
//    from '../resources/resource-categories';
//    using { ec.masters.BillofQuantityItems}
//    from '../billofquantities/bill-of-quantity';
//  namespace ec.masters;
//  entity CostBreakDownHierarchies : cuid, managed {
//      name          : String(40);
//      descr         : String(1111);
//      note          : String(1111);
//      cbHierarchies : Association to many CostBreakdownStructure
//          on cbHierarchies.cbshierarchy = $self;
//  }
//  entity CostBreakdownStructure  @(Common: {SemanticKey: [ID]}) : cuid, managed {
//      code         : String(40);
//      name         : String(255);
//      descr        : String(1000);
//      parent       : Association to CostBreakdownStructure;
//      children : Association to many CostBreakdownStructure
//                    on children.parent = $self;
//      cbshierarchy : Association to one CostBreakDownHierarchies;
//       resourceMaterials : Composition of many CBSResourceMaterial
//          on resourceMaterials.cbsNode = $self;
//      boqitem : Association to BillofQuantityItems;
//      @Core.Computed: true
//      LimitedDescendantCount : Integer64;
//      @Core.Computed: true
//      DistanceFromRoot       : Integer64;
//      @Core.Computed: true
//      DrillState             : String;
//      @Core.Computed: true
//      Matched                : Boolean;
//      @Core.Computed: true
//      MatchedDescendantCount : Integer64;
//  }
//  entity CBSResourceMaterial : cuid, managed {
//      productId     : String(40);
//      productName   : String(1111);
//      productType   : String(40);
//      unitofMeasure : String(10);
//      quantity      : String(10) default '1';
//      cbsNode       : Association to one CostBreakdownStructure;
//      resourceMat   : Association to one ResourceMaterial;
//  }
//  entity NodeTypeOptions  {
//      key code : String(1);
//      name     : String(50);
//  }

using {
    cuid,
    managed,
    temporal
} from '@sap/cds/common';
using {ec.masters.ResourceMaterial} from '../resources/resource-categories';
using {ec.masters.ResourceHierarchies} from '../resources/resource-categories';
using {ec.masters.BillofQuantityItems} from '../billofquantities/bill-of-quantity';
using {CommonService as cm} from '../../srv/common-service';


namespace ec.masters;

entity CostBreakDownHierarchies : cuid, managed {
    key ID                  : UUID; // Redefinition to fix Postgres array type mismatch
        name                : String(40);
        resourceName        : String(225);
        descr               : String(1111);
        note                : String(1111);
        company             : Association to cm.Companies @mandatory;

        cbHierarchies       : Composition of many CostBreakdownStructure
                                  on cbHierarchies.cbshierarchy = $self;
        cbsTypeCompany      : Composition of many CbsTypeCompany
                                  on cbsTypeCompany.parent = $self;
        resourceHierarchies : Association to one ResourceHierarchies
                                  on resourceHierarchies.cbsHierarchies = $self
}

entity CostBreakdownStructure @(Common: {SemanticKey: [ID]}) : cuid, managed {
    key ID                     : String; // Fixes: "column has type character varying(36)[] in non-recursive term"
        code                   : String(40);
        name                   : String(255);
        descr                  : String(1000);

        parent                 : Association to CostBreakdownStructure;
        children               : Association to many CostBreakdownStructure
                                     on children.parent = $self;
        cbshierarchy           : Association to one CostBreakDownHierarchies;

        resourceMaterials      : Composition of many CBSResourceMaterial
                                     on resourceMaterials.cbsNode = $self;

        boqitem                : Association to BillofQuantityItems;

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

        @Core.Computed: true
        LimitedRank            : Integer64;
}

entity CBSResourceMaterial : cuid, managed {
    key ID            : String; // Redefinition for consistency across keys
        productId     : String(40);
        productName   : String(1111);
        productType   : String(40);
        unitofMeasure : String(10);
        quantity      : Integer;
        outputQTY     : Decimal(15, 2);
        labRate       : Decimal(15, 2);
        EqpRate       : Decimal(15, 2);
        rate          : Decimal(15, 2);
        // @Analytics.Measure: true
        // @DefaultAggregation: #Sum
        amount        : Decimal(15, 2);
        isOT          : Boolean;
        cbsNode       : Association to one CostBreakdownStructure;
        resourceMat   : Association to one ResourceMaterial;
}

entity CbsTypeCompany : cuid, managed {
    key ID          : String;
        parent      : Association to one CostBreakDownHierarchies;
        companyCode : String(11);
        companyName : String(111);
        company     : Association to cm.Companies
                          on company.CompanyCode = companyCode;
};

entity NodeTypeOptions {
    key code : String(1);
        name : String(50);
}
