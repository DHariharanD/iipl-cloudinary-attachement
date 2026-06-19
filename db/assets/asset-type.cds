namespace ec.masters;

using {API_COMPANYCODE_SRV as CO} from '../../srv/external/API_COMPANYCODE_SRV';

using {
  cuid,
  managed
} from '@sap/cds/common';

entity AssetType : cuid, managed {
  name                : String(50) @mandatory;
  description         : String(200);
  company             : Association to CO.A_CompanyCode
                          on company.CompanyCode = company_CompanyCode;
  company_CompanyCode : String(4) @mandatory;
}
