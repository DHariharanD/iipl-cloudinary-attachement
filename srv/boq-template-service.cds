using {ec.masters as res} from '../db/billofquantities/bill-of-quantity-template';
using {API_COMPANYCODE_SRV as CO} from './external/API_COMPANYCODE_SRV';

service BillofQuantityTemplateService {
  entity BillofQuantityTemplates       as
    projection on res.BillofQuantityTemplates {
      *,
      company_CompanyCode
    }
    excluding {
      company
    };

  @readonly
  entity Companies                     as projection on CO.A_CompanyCode;

  entity BillofQuantityTemplateDetails as projection on res.BillofQuantityTemplateDetails;
}

annotate BillofQuantityTemplateService.BillofQuantityTemplates with @odata.draft.enabled;
// annotate BillofQuantityTemplateService.BillofQuantityTemplateDetails with @odata.draft.enabled;
