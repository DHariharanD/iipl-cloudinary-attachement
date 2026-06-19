namespace ec.fuelmanagement;

using {ec.assets as ass} from '../assets/assets';
using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';

using {CommonService as cm} from '../../srv/common-service';


entity FuelRequest : cuid, managed {
    vehicle         : Association to ass.Assets;
    driver          : String(20);
    status          : String(20);
    indents         :Composition of many FuelIndent on indents.parent=$self;
    SerialNo       : String(100);
    Chassis        : String(100);
    EngineNo       : String(100);
    Year           : Integer;
    Capacity       : Decimal(10, 2);
    ExpectedMilage : Decimal(10, 2);
    RegNo          : String(50);
    Mileage        : Decimal(10, 2);
    fuelRequired: Boolean;
}


entity FuelIndent : cuid, managed {
    indentNo         : String(20);
    fuelType         : Association to FuelType;
    requestedQty     : Decimal(10, 2);
    issuedQty        : Decimal(10, 2);
    requestedBy      : String(100);
    approvedBy       : String(100);
    rejectedBy       : String(100);
    rejectionComment : String(500);
    requestedTime    : Timestamp;
    approvedTime     : Timestamp;
    companyCode      : String(11);
    odometerReading : Decimal(10, 2);
    uom             : String(20);
    parent : Association to FuelRequest;
}
entity FuelType : CodeList{
    Key code: FuelTypeText;
}
type FuelTypeText : String enum {
    Petrol = 'PE';
    Diesel = 'DE'
}

 