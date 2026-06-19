namespace ec.masters;

using { cuid, managed } from '@sap/cds/common';

entity Commodity : cuid, managed {
    commodityCode   : String(20)  @mandatory;
    commodityName   : String(100) @mandatory;
    companyCode : String(11)  @mandatory;
    description : String(500);
}