using {ec.masters as res} from '../db/projects/wbs';
using {API_COMPANYCODE_SRV as CO} from './external/API_COMPANYCODE_SRV';


service WbsService {

    entity wbs        as projection on res.wbs;

    @Aggregation.RecursiveHierarchy #wbsElement: {
        NodeProperty            : ID,
        ParentNavigationProperty: parent
    }
    @Hierarchy.RecursiveHierarchy #wbsElement  : {
        ExternalKey           : ID,
        LimitedDescendantCount: LimitedDescendantCount,
        DistanceFromRoot      : DistanceFromRoot,
        DrillState            : DrillState,
        Matched               : Matched,
        MatchedDescendantCount: MatchedDescendantCount
    }
    @Capabilities.FilterRestrictions           : {NonFilterableProperties: [
        LimitedDescendantCount,
        DistanceFromRoot,
        DrillState,
        Matched,
        MatchedDescendantCount
    ]}
    @Capabilities.SortRestrictions             : {NonSortableProperties: [
        LimitedDescendantCount,
        DistanceFromRoot,
        DrillState,
        Matched,
        MatchedDescendantCount
    ]}

    entity wbsElement as
        projection on res.wbsElement {
            *,
            company_CompanyCode
        }
        excluding {
            company
        };

    @readonly
    entity Companies  as projection on CO.A_CompanyCode;
}

annotate WbsService.wbs with @odata.draft.enabled;
annotate WbsService.wbsElement with @odata.draft.enabled;
