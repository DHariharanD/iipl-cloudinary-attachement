using {ec.masters as res} from '../db/assets/asset-type';
using {API_COMPANYCODE_SRV as CO} from './external/API_COMPANYCODE_SRV';


service AssetTypeService @(requires: 'any') {
  @odata.draft.enabled
  @Capabilities.Insertable: true
  @Capabilities.Updateable: true
  @Capabilities.Deletable : true
  entity AssetTypes as projection on res.AssetType{
    *,
    company_CompanyCode
  }excluding { 
      company
  };

  @readonly
  entity AssetCompanies as projection on CO.A_CompanyCode;
  action UploadAssetTypes(file : LargeBinary);
}

// annotate AssetTypeService.AssetTypes with @odata.draft.enabled;
