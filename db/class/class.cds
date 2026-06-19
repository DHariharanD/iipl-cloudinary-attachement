namespace ec.masters;

using { cuid, managed } from '@sap/cds/common';

entity Class : cuid, managed {
    classCode   : String(20)  @mandatory;
    className   : String(100) @mandatory;
    companyCode : String(11)  @mandatory;
    description : String(500);
}