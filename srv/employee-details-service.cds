using {ec.masters as emp} from '../db/employeedetails/employee-details';
using {ec.masters as masters} from '../db/designations/designations';
using {API_COMPANYCODE_SRV as CO} from './external/API_COMPANYCODE_SRV';

service EmployeeDetailsService @(requires: 'any') {

    @odata.draft.enabled
    @Capabilities.Insertable: true
    @Capabilities.Updateable: true
    @Capabilities.Deletable : true
    entity EmployeeDetails       as
        projection on emp.EmployeeDetails {
            *,

            designation.name        as designation_name
        };

    entity EmployeeAddressDetail as projection on emp.EmployeeAddressDetail;

    @readonly
    entity Companies             as
        projection on CO.A_CompanyCode {
            CompanyCode,
            CompanyCodeName
        };

    @readonly
    entity Designations          as
        projection on masters.Designations {
            key ID,
                code,
                name
        };
}
