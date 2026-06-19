using { my.assettimesheetdaily as at} from '../db/assets/asset-time-sheet-daily';
using {ec.masters as ep} from '../db/projects/enterprise-project';
using {ec.masters as cbsRes} from '../db';
using { ec.masters as ed } from '../db/employeedetails/employee-details';
using {CommonService as cm} from './common-service';

service AssetTimeSheetDailyService {

    @odata.draft.enabled
    entity TimeSheetHeader as projection on at.TimeSheetHeader;

    entity AssetTimeSheets as projection on at.AssetTimeSheetDaily;

    @readonly
    entity EmployeeDetails as projection on ed.EmployeeDetails {
        ID,
        firstName,
        lastName,
        (firstName || ' ' || lastName) as fullName : String
    };

    @readonly
    entity Companies as projection on cm.Companies;

    entity ProjectsVH as
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
    entity Wbs                   as
        select from ep.ProjectPlanning {
            ID,
            projectElementDescription as assetWbs,
            plshierarchy.ID as project_ID,
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
