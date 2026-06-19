using {ec.masters as ams} from '../db/assets/asset-master';
using {API_COMPANYCODE_SRV as CO} from './external/API_COMPANYCODE_SRV';

service AssetMasterService {

  @odata.draft.enabled
  @Capabilities: {
    Insertable: true,
    Updateable: true,
    Deletable : true
  }
  // 1. Project AssetMaster without the auto-joining 'company' association
  entity AssetMaster as projection on ams.AssetMaster {
      *,  
      company_CompanyCode
  } excluding { 
      company
  };

  // 2. Expose the Remote S/4HANA Entity as a sepa  rate read-only entity
  @readonly
  entity AssetCompanies as projection on CO.A_CompanyCode;

  action UploadAssets(file: LargeBinary);

}
