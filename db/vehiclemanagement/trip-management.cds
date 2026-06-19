namespace ec.tripmanagement;

using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';
using {ec.assets as assets} from '../assets/assets';

entity Trips : cuid, managed {

    tripName    : String(100);
    tripType    : Association to tripType;
    status      : Association to tripStatus;
    startDate   : Date;
    endDate     : Date;
    route       : String(255);

    VehicleInfo : Composition of many VehicleInformation
                      on VehicleInfo.vehickeInfo = $self;

    RouteInfo   : Composition of many Route
                      on RouteInfo.route = $self;

    FuelExpInfo : Composition of many FuelExp
                      on FuelExpInfo.fuelExp = $self;

    stops       : Composition of many AdditionalInfo
                      on stops.additionalInfo = $self;

    attachments : Composition of many TripAttachments
                      on attachments.attachment = $self;
}

entity VehicleInformation : cuid, managed {
    vehickeInfo   : Association to Trips;
    vehicle       : Association to one assets.Assets ;
    vehicleNumber : String(30);
    vehicleType   : String(50);
    driverName    : String(100);
    driverContact : String(20);
    licenseNumber : String(50);
}

entity Route : cuid, managed {
    route               : Association to Trips;
    sourceLocation      : String(150);
    destinationLocation : String(150);
    departureTime       : Timestamp;
    expectedArrival     : Timestamp;
}

entity FuelExp : cuid, managed {
    fuelExp         : Association to Trips;
    fuelIssued      : Decimal(15, 2);
    fuelConsumed    : Decimal(15, 2);
    fuelCost        : Decimal(15, 2);
    tollCharges     : Decimal(15, 2);
    driverAllowance : Decimal(15, 2);
    otherExpenses   : Decimal(15, 2);
}


entity AdditionalInfo : cuid, managed {
    additionalInfo : Association to Trips;
    currentStatus  : String(30);
    delayReason    : String(255);
    remarks        : String(1000);
}

entity TripAttachments : cuid, managed {
    attachment : Association to Trips;
    fileName   : String(255);
    mediaType  : String(100);
    url        : String(500);
}

entity tripType : CodeList {
    key code : TripType;
}

entity tripStatus : CodeList {
    key code : TripStatus;
}

type TripType   : String enum {
    Delivery = 'DEL';
    Pickup = 'PIC';
};

type TripStatus : String enum {
    Planned = 'PLN';
    Running = 'RUN';
    Completed = 'CMP';
};
