using {ec.masters as res} from '../db/projects/enterprise-project';
using {API_COMPANYCODE_SRV as CO} from './external/API_COMPANYCODE_SRV';
using {ec.masters as sa} from '../db/projects/sales-order';
using {ec.masters as pu} from '../db/projects/purchase-order';
using {ec.masters as boq} from '../db/billofquantities/bill-of-quantity';

service ProjectEnterpriseService {
    @odata.draft.enabled
    @Capabilities.Insertable: true
    @Capabilities.Updateable: true
    @Capabilities.Deletable : true
    entity Projects             as
        projection on res.Projects {
            *,
            SalesOrders,
            PurchaseOrders,
            companyCode
        }

    @Aggregation.RecursiveHierarchy #ProjectPlanning: {
        NodeProperty            : ID,
        ParentNavigationProperty: parent
    }
    @Hierarchy.RecursiveHierarchy #ProjectPlanning  : {
        ExternalKey           : ID,
        LimitedDescendantCount: LimitedDescendantCount,
        DistanceFromRoot      : DistanceFromRoot,
        DrillState            : DrillState,
        Matched               : Matched,
        MatchedDescendantCount: MatchedDescendantCount
    }
    @Capabilities.FilterRestrictions                : {NonFilterableProperties: [
        LimitedDescendantCount,
        DistanceFromRoot,
        DrillState,
        Matched,
        MatchedDescendantCount
    ]}
    @Capabilities.SortRestrictions                  : {NonSortableProperties: [
        LimitedDescendantCount,
        DistanceFromRoot,
        DrillState,
        Matched,
        MatchedDescendantCount
    ]}
    entity ProjectPlanning      as projection on res.ProjectPlanning;

    @readonly
    entity BillofQuantityHeader as projection on boq.BillofQuantityHeader;

    @readonly
    entity BillofQuantityItem   as projection on boq.BillofQuantityItems;

    @readonly
    entity Companies            as projection on CO.A_CompanyCode;

    action UploadEnterpriseProjects(file: String) returns String;
}
