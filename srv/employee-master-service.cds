using {ec.masters as emp} from '../db/employee/employee-master';
using {API_COMPANYCODE_SRV as CO} from './external/API_COMPANYCODE_SRV';


service EmployeeMasterService @(requires: 'any') {
    @odata.draft.enabled
    @Capabilities.Insertable: true
    @Capabilities.Updateable: true
    @Capabilities.Deletable : true

    entity EmployeeMaster  as
        projection on emp.EmployeeMaster {
            *,
            company_CompanyCode
        }
        excluding {
            company
        };

    entity EmployeeAddress as projection on emp.EmployeeAddress;

    @readonly
    entity Companies       as projection on CO.A_CompanyCode;
}
// annotate EmployeeMasterService.EmployeeMaster with @odata.draft.enabled;
