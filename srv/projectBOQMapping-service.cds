using {ec.masters as res} from '../db/projectboq/projectBOQMapping';

service ProjectBOQMappingService {

    entity Projects              as projection on res.Projects;

    entity BillofQuantityHeader  as projection on res.BillofQuantityHeader;

    @cds.redirection.target
    entity ProjectPlanning       as projection on res.ProjectPlanning;

    /* WBS for tree / value help (filtered via $filter) */
    entity ProjectWBS            as projection on res.ProjectPlanning;

    /* Header */
    entity ProjectBOQMapping     as projection on res.ProjectBOQMapping;

    annotate ProjectBOQMappingService.ProjectPlanning with
    @Aggregation.RecursiveHierarchy #ProjectPlanningHierarchy: {
        NodeProperty            : ID,
        ParentNavigationProperty: parent
    };

    annotate ProjectBOQMappingService.ProjectPlanning with
    @Hierarchy.RecursiveHierarchy #ProjectPlanningHierarchy: {
        ExternalKey           : ID,
        LimitedDescendantCount: LimitedDescendantCount,
        DistanceFromRoot      : DistanceFromRoot,
        DrillState            : DrillState,
        Matched               : Matched,
        MatchedDescendantCount: MatchedDescendantCount
    };

    annotate ProjectBOQMappingService.WbsBillOfQuantities with
    @Aggregation.RecursiveHierarchy #WBSBOQHierarchy: {
        NodeProperty            : ID,
        ParentNavigationProperty: parent
    };

    annotate ProjectBOQMappingService.WbsBillOfQuantities with
    @Hierarchy.RecursiveHierarchy #WBSBOQHierarchy: {
        ExternalKey           : ID,
        LimitedDescendantCount: LimitedDescendantCount,
        DistanceFromRoot      : DistanceFromRoot,
        DrillState            : DrillState,
        Matched               : Matched,
        MatchedDescendantCount: MatchedDescendantCount
    };

    /* Items (table rows) */
    entity ProjectBOQMappingItem as projection on res.ProjectBOQMappingItem;
}

annotate ProjectBOQMappingService.ProjectBOQMapping with @odata.draft.enabled;
