using {ec.masters as res} from '../db/projects/project-primavera-wbs-mapping';
using {CommonService as cm} from './common-service';
using {ec.masters as ep} from '../db/projects/enterprise-project';
using {ec.masters as wbs} from '../db/projects/enterprise-project';
using {ec.masters as prima} from '../db/projects/project-primavera-mapping';

service ProjectPrimaveraWBSService {

  //   @odata.draft.enabled
  //   @Capabilities.Insertable: true
  //   @Capabilities.Updateable: true
  //   @Capabilities.Deletable : true
  entity PrimaveraProjects as projection on res.PrimaveraProjects;
  @Aggregation.RecursiveHierarchy #PrimaveraWBS: {
        NodeProperty            : ID,
        ParentNavigationProperty: parent
    }
    @Hierarchy.RecursiveHierarchy #PrimaveraWBS  : {
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
  entity PrimaveraWBS        as projection on res.PrimaveraWBS;
  entity PrimaveraWBSMapping as projection on res.PrimaveraWBSMapping;
  entity company             as projection on cm.Companies;
  entity Projects            as projection on ep.Projects;
  entity Wbs                 as projection on wbs.ProjectPlanning;
  entity ProjectPrimaveraMapping as projection on prima.ProjectPrimaveraMapping;

action UploadWbsProject(file : LargeBinary);
}

annotate ProjectPrimaveraWBSService.PrimaveraProjects with @odata.draft.enabled;
//annotate ProjectPrimaveraWBSService.PrimaveraWBSMapping with @odata.draft.enabled;
