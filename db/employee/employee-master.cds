namespace ec.masters;

using {API_COMPANYCODE_SRV as CO} from '../../srv/external/API_COMPANYCODE_SRV';

using {
    cuid,
    managed
} from '@sap/cds/common';

entity EmployeeMaster : cuid, managed {
    businessPartner         : String(50);
    firstName               : String(50);
    lastName                : String(50) @mandatory;
    businessPartnerCategory : String(50);
    businessPartnerGrouping : String(50);
    gender                  : String(50);
    dateOfBirth             : Date;
    addresses               : Composition of many EmployeeAddress
                                  on addresses.parent = $self
                                         @mandatory;
    company                 : Association to CO.A_CompanyCode
                                  on company.CompanyCode = company_CompanyCode;
    company_CompanyCode     : String(4) @mandatory;
}

entity EmployeeAddress : cuid, managed {
    streetName   : String(50);
    region       : String(50);
    country      : String(50);
    postalCode   : String(50);
    phoneNumber  : String(50);
    EmailAddress : String(50);
    parent       : Association to EmployeeMaster;
}
