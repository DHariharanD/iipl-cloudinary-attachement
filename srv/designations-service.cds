using { ec.masters as masters } from '../db/designations/designations';
using { CommonService as cm } from './common-service';

service DesignationService {

    entity Designations as projection on masters.Designations {
        *,
        company : Association to cm.Companies
                    on company.CompanyCode = companyCode
    };

    entity Companies as projection on cm.Companies;
}

annotate DesignationService.Designations with @odata.draft.enabled;