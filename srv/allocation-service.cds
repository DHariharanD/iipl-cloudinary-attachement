using {ec.allocationmanagement as am} from '../db/allocations/allocations';
using {ec.masters as ep} from '../db/projects/enterprise-project';
using {ec.masters as cbs} from '../db/cbs/cbs';
using {ec.masters as bq} from '../db/billofquantities/bill-of-quantity';

service AllocationService {

    @odata.draft.enabled
    entity Allocations as projection on am.Allocations;


    //for valuehelp
    entity Projects as
        select from ep.Projects {
            key ID,
            project,
            projectDescription,
            companyCode,
            projectStartDate,
            projectEndDate,
            projectCurrency,
            status,
        };


    entity Wbs  as
        select from ep.ProjectPlanning {
            key ID,
            projectElementDescription,
            plshierarchy.ID as project_ID,
        };

    entity BoqItem  as 
        select from bq.BillofQuantityItems {
            key ID,
            item,
            description,
            unitOfMeasurement,
            quantity,
            actualQuantity,
            actualAmount,
            budgetQuantity,
            budgetAmount,
            wbsElement.ID as wbs_ID,
        };


    entity CostBreakdownStructure       as
        select from cbs.CostBreakdownStructure {
            key ID,
            code,
            name,
            descr,
            parent.code as parentCode,
            boqitem.ID as boqitem_ID,
        };

    action uploadAllocation(file : LargeBinary);
}