namespace ec.accidentManagement;

using { ec.assets as ass } from '../assets/assets';
using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';


entity Accident : cuid, managed {

    vehicle          : Association to ass.Assets;
    vehicleNo        : String(50) not null;
    SerialNo         : String(100);
    Chassis          : String(100);
    EngineNo         : String(100);
    Year             : Integer;

    driverName       : String(100);
    driverLicenseNo  : String(50);
    driverContact    : String(20);

    accidentDate     : Date;
    accidentTime     : Time;
    location         : String(255);
    description      : String(1000);
    accidentType     : Association to AccidentType;
    severity         : Association to Severity;

    policeReportNo   : String(50);
    policeStation    : String(100);
    isPoliceInformed : Boolean;

    isInjury         : Boolean;
    injuryDetails    : String(500);

    vehicleDamage    : String(1000);
    thirdPartyDamage : String(1000);

    insuranceProvider : String(100);
    policyNumber      : String(100);
    claimNumber       : String(100);
    claimStatus       : Association to ClaimStatus;
    claimAmount       : Decimal(15,2);
    approvedAmount    : Decimal(15,2);

    attachments : Association to many AccidentAttachments on attachments.accident = $self;
}


entity AccidentAttachments : cuid, managed {
    accident   : Association to Accident;
    fileName   : String(255);
    mediaType  : String(100);
    url        : String(500);
    fileSize   : Integer64;
    publicId   : String(500);      // Cloudinary public_id 
    description  : String(500);
}


entity AccidentType : CodeList {
    key code : AccidentTypeText;
}

type AccidentTypeText : String enum {
    Minor       = 'MIN';
    Major       = 'MAJ';
    Collision   = 'COL';
    Fire        = 'FIR';
    Theft       = 'THF';
};


entity Severity : CodeList {
    key code : SeverityText;
}

type SeverityText : String enum {
    Low    = 'LOW';
    Medium = 'MED';
    High   = 'HIG';
};


entity ClaimStatus : CodeList {
    key code : ClaimStatusText;
}

type ClaimStatusText : String enum {
    Initiated = 'INI';
    UnderReview = 'REV';
    Approved = 'APR';
    Rejected = 'REJ';
    Closed   = 'CLO';
};