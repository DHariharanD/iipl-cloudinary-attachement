using {ec.tavouchers as voucher} from '../db/hrportal/ta-vouchers';
using {CommonService as cm} from './common-service';
using {ec.masters as cbs} from '../db/cbs/cbs';
using {ec.masters as pa} from '../db/projects/enterprise-project';
using {ec.masters as bo} from '../db/billofquantities/bill-of-quantity';
using {ec.masters as em} from '../db/employeedetails/employee-details';


service TAVouchersService {
    entity TAVouchers as projection on voucher.vouchers;
    entity company    as projection on cm.Companies;
    entity CBS as projection on cbs.CostBreakDownHierarchies;
    entity CostBreakDown as projection on cbs.CostBreakdownStructure;
    entity CBSResourceMaterial as projection on cbs.CBSResourceMaterial;
    entity Projects as projection on pa.Projects;
    entity Boq as projection  on bo.BillofQuantityHeader;
    entity wbs as projection on pa.ProjectPlanning;
    entity Employeedetails as projection on em.EmployeeDetails;
}
annotate TAVouchersService.TAVouchers with @odata.draft.enabled; 