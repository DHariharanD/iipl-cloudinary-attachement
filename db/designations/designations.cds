namespace ec.masters;

using { cuid, managed } from '@sap/cds/common';

entity Designations : cuid, managed {
    key ID          : UUID @Core.Computed;

    code            : String(20)  @mandatory;
    name            : String(100) @mandatory;
    description     : String(500);
    hourlyRate      : Decimal(10,2);

    companyCode     : String(11) @mandatory;
}