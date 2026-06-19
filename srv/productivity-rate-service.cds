using {ec.productivityrate as pr} from '../db/productivity/productivity-rate';
using {CommonService as cm} from './common-service';
using {ec.masters as cbs} from '../db/cbs/cbs';

service ProductivityRateService {

    entity ProductivityRates  as projection on pr.ProductivityRate;
    entity Productivity       as projection on pr.Productivity;
    entity DatesApplicability as projection on pr.DatesApplicability;
    entity company            as projection on cm.Companies;
   entity Cbs as projection on cbs.CostBreakdownStructure;
   entity CbsResourceMaterial as projection on cbs.CBSResourceMaterial; 
}
annotate ProductivityRateService.ProductivityRates with @odata.draft.enabled;