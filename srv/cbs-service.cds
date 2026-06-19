using {ec.masters as masters} from '../db';
using {CommonService as cm} from './common-service';


service CostBreakdownStructureService {

    // entity Type                     as projection on masters.type;

    entity CostBreakDownHierarchies as projection on masters.CostBreakDownHierarchies;

    @Aggregation.RecursiveHierarchy #CostBreakdownStructure: {
        NodeProperty            : ID,
        ParentNavigationProperty: parent
    }
    @Hierarchy.RecursiveHierarchy #CostBreakdownStructure  : {
        ExternalKey           : ID,
        LimitedDescendantCount: LimitedDescendantCount,
        DistanceFromRoot      : DistanceFromRoot,
        DrillState            : DrillState,
        Matched               : Matched,
        MatchedDescendantCount: MatchedDescendantCount
    }
    @Capabilities.FilterRestrictions                       : {NonFilterableProperties: [
        LimitedDescendantCount,
        DistanceFromRoot,
        DrillState,
        Matched,
        MatchedDescendantCount
    ]}
    @Capabilities.SortRestrictions                         : {NonSortableProperties: [
        LimitedDescendantCount,
        DistanceFromRoot,
        DrillState,
        Matched,
        MatchedDescendantCount
    ]}
    entity CostBreakdownStructure   as projection on masters.CostBreakdownStructure
        // actions {
        //     action addNode(Type: String(10),
        //                    Products: array of UUID,
        //                    Name: String(30),
        //                    Code: String(30),
        //                    descr: String(30)) 
        //                    returns CostBreakdownStructure;

            

        // }
        ;
        action uploadCostBreakdownStructure(file: LargeBinary, hierarchyId: UUID);
         action uploadCBSBulk(file: LargeBinary, hierarchyId: UUID);

    @readonly
    entity NodeTypeOptions          as projection on masters.NodeTypeOptions;

    @readonly
    entity ResourceCategories       as projection on masters.ResourceCategories;

    entity ResourceMaterial         as projection on masters.ResourceMaterial;
 
    entity CBSResourceMaterial      as projection on masters.CBSResourceMaterial;
    entity ResourceSubcontract         as projection on masters.ResourceSubcontract;
    entity ResourceWorkforce         as projection on masters.ResourceWorkforce;
    entity ResourceAssets         as projection on masters.ResourceAssets;
    entity ResourceGl         as projection on masters.ResourceGl;
    entity company                  as projection on cm.Companies;
    entity CbsTypeCompany           as projection on masters.CbsTypeCompany;
    entity ResourceHierarchies      as projection on masters.ResourceHierarchies;
    entity ResourceTypeCompany      as projection on masters.ResourceTypeCompany;
}

annotate CostBreakdownStructureService.CostBreakDownHierarchies with @odata.draft.enabled;
