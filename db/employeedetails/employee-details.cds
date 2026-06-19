namespace ec.masters;

using {API_COMPANYCODE_SRV as CO} from '../../srv/external/API_COMPANYCODE_SRV';
using {ec.masters as masters} from '../designations/designations'; 
using {
    cuid,
    managed
} from '@sap/cds/common';

entity EmployeeDetails : cuid, managed {
    firstName           : String(50);
    lastName            : String(50) @mandatory;
    gender              : String(50);
    dateOfBirth         : Date;
    designation_code    : String(20)  @mandatory:false;
    addresses           : Composition of many EmployeeAddressDetail
                              on addresses.parent = $self;
   designation : Association to masters.Designations
    on designation.code = designation_code;
}

entity EmployeeAddressDetail : cuid, managed {
    streetName   : String(50);
    region       : String(50);
    country      : String(50);
    postalCode   : String(50);
    phoneNumber  : String(50);
    EmailAddress : String(50);
    parent       : Association to EmployeeDetails;
}

entity Designation : cuid, managed {
    key ID : UUID;
    code   : String(20);
    name   : String(100);
}