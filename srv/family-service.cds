using {ec.masters as masters} from '../db/family/family';
using {CommonService as cm} from './common-service';

service FamilyService @(requires: 'any') {

    entity Families as
        projection on masters.Family {
            *,
            company : Association to cm.Companies
                          on company.CompanyCode = $projection.companyCode
        };

    entity Companies as projection on cm.Companies;
}

annotate FamilyService.Families with @odata.draft.enabled;