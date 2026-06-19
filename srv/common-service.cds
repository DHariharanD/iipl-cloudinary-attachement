using {API_COMPANYCODE_SRV as CO} from './external/API_COMPANYCODE_SRV';

service CommonService {
    @readonly
    entity Companies as projection on CO.A_CompanyCode;
}
