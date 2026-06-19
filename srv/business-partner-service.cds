using {API_BUSINESS_PARTNER as bp} from './external/API_BUSINESS_PARTNER';

service BusinessPartnerServices {
    entity BusinessPartners as projection on bp.A_BusinessPartner;
}
