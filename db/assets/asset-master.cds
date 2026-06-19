namespace ec.masters;

using {API_COMPANYCODE_SRV as CO} from '../../srv/external/API_COMPANYCODE_SRV';

using {
    cuid,
    managed
} from '@sap/cds/common';

entity AssetMaster : cuid, managed {
    type                : String(50) @mandatory;
    asset               : String(50) @mandatory;
    technicalObject     : String(50);
    external            : Boolean;
    fuelManagement      : Boolean;
    description         : String(50);
    company             : Association to CO.A_CompanyCode
                              on company.CompanyCode = company_CompanyCode;
    company_CompanyCode : String(4) @mandatory;
}
