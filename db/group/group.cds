namespace ec.masters;

using { cuid, managed } from '@sap/cds/common';

entity Group : cuid, managed {
    groupCode       : String(20)  @mandatory;
    groupName       : String(100) @mandatory;
    description     : String(500);
    costOfSales     : String(20);   
    salesAc         : String(20);  
    companyCode     : String(11)  @mandatory;
}