using {ec.masters as masters} from '../db/group/group';
using {CommonService as cm} from './common-service';

service GroupService @(requires: 'any') {

    @odata.draft.enabled
    @Capabilities.Insertable: true
    @Capabilities.Updateable: true
    @Capabilities.Deletable : true
    entity Groups    as
        projection on masters.Group {
            *,
            company : Association to cm.Companies
                          on company.CompanyCode = $projection.companyCode
        };

    entity Companies as projection on cm.Companies;
}
