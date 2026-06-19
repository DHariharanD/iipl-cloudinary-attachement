using {ec.masters as masters} from '../db/commodity/commodity';
using {CommonService as cm} from './common-service';

service CommodityService @(requires: 'any') {

    entity Commodities as
        projection on masters.Commodity {
            *,
            company : Association to cm.Companies
                          on company.CompanyCode = $projection.companyCode
        };

    entity Companies as projection on cm.Companies;
    action UploadCommodity (file:LargeBinary)
}

annotate CommodityService.Commodities with @odata.draft.enabled;