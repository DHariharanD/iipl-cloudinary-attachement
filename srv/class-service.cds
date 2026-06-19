using {ec.masters as masters} from '../db/class/class';
using {CommonService as cm} from './common-service';

service ClassService @(requires: 'any') {

    entity Classes as
        projection on masters.Class {
            *,
            company : Association to cm.Companies
                          on company.CompanyCode = $projection.companyCode
        };

    entity Companies as projection on cm.Companies;
      action UploadClass(file: LargeBinary);
}

annotate ClassService.Classes with @odata.draft.enabled;