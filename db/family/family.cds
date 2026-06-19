namespace ec.masters;

using { cuid, managed } from '@sap/cds/common';

entity Family : cuid, managed {
    familyCode       : String(20) @mandatory;
    familyName       : String(100); 
    companyCode     : String(11)  @mandatory;
    description     : String(500); 
}