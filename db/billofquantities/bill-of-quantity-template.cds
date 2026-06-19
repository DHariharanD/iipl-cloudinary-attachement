using {
    cuid,
    managed,
    temporal
} from '@sap/cds/common';
using {API_COMPANYCODE_SRV as CO} from '../../srv/external/API_COMPANYCODE_SRV';

namespace ec.masters;

entity BillofQuantityTemplates : cuid, managed {
    name                : String(40) @mandatory;
    descr               : String(1111);
    Hierarchies         : Composition of many BillofQuantityTemplateDetails
                              on Hierarchies.boqHierarchy = $self;
    company             : Association to CO.A_CompanyCode
                              on company.CompanyCode = company_CompanyCode;
    company_CompanyCode : String(4) @mandatory;
}

entity BillofQuantityTemplateDetails @(Common: {SemanticKey: [ID]}) : cuid, managed {
    item              : String(40); 
    description       : String(1111);
    unitOfMeasurement : String(10); 
    quantity          : Decimal(15, 7);
    // parent            : Association to BillofQuantityTemplateDetails;
    boqHierarchy      : Association to one BillofQuantityTemplates;
};
