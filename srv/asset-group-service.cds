using {ec.masters as res} from '../db/assets/asset-group';

service AssetGroupService {

     entity AssetCategory as projection on res.AssetCategory;

    @Aggregation.RecursiveHierarchy #AssetGroup: {
        NodeProperty            : ID,
        ParentNavigationProperty: parent
    }
    @Hierarchy.RecursiveHierarchy #AssetGroup  : {
        ExternalKey           : ID,
        LimitedDescendantCount: LimitedDescendantCount,
        DistanceFromRoot      : DistanceFromRoot,
        DrillState            : DrillState
    }
    @Capabilities.FilterRestrictions: {NonFilterableProperties: [
        LimitedDescendantCount,
        DistanceFromRoot,
        DrillState
    ]}
    @Capabilities.SortRestrictions  : {NonSortableProperties: [
        LimitedDescendantCount,
        DistanceFromRoot,
        DrillState
    ]}

    entity AssetGroup as projection on res.AssetGroup;
}
