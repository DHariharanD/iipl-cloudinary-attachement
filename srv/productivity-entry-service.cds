// productivity-entry-service.cds
using {ec.masters as pv} from '../db/productivity/ProductivityEntry';
using {CommonService as cm} from './common-service';
using {ec.masters as ep} from '../db/projects/enterprise-project';
using {ec.masters as cbsRes} from '../db';
using {ec.masters as wbsMap} from '../db/projects/project-primavera-wbs-mapping';

// productivity-entry-service.cds
service ProductivityEntryService {

    @odata.draft.enabled
    entity DailyProductivityVoucher     as projection on pv.DailyProductivityVoucher;

    entity DailyProductivityVoucherItem as projection on pv.DailyProductivityVoucherItem;
    entity company                      as projection on cm.Companies;

    entity Projects                     as
        select from ep.Projects {
            ID,
            project,
            projectDescription,
            companyCode,
            projectStartDate,
            projectEndDate,
            projectCurrency,
            status,
        };

    @readonly
    entity Wbs                          as
        select from ep.ProjectPlanning {
            ID,
            projectElementDescription as primaverawbsCode,
            projectElementDescription as primaverawbs,
            plshierarchy.ID           as project_ID,
        };

    @readonly
    entity CostBreakdownStructure       as
        select from cbsRes.CostBreakdownStructure {
            *,
            parent,
            parent.code as parentCode,
            cbshierarchy
        };

    @readonly
    entity CBSResourceMaterial          as
        select from cbsRes.CBSResourceMaterial {
            ID,
            productId,
            productName,
            productType,
            unitofMeasure,
            cbsNode,
            cbsNode.code as cbsNodeCode,
            cbsNode.name as cbsNodeName,
        };
}
