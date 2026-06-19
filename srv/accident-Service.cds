using { ec.accidentManagement as am } from '../db/vehiclemanagement/accident-management';
using { ec.assets as assets } from '../db/assets/assets';

service AccidentService {

    entity Accident as projection on am.Accident;

    entity AccidentAttachments as projection on am.AccidentAttachments;

    entity AccidentType as projection on am.AccidentType;
    entity Severity as projection on am.Severity;
    entity ClaimStatus as projection on am.ClaimStatus;

    entity Assets as projection on assets.Assets;

    action uploadAccidentFile(
        accident_ID : UUID,            // parent Accident record
        fileName    : String(255),     // original file name
        mediaType   : String(100),     // MIME type          e.g. "application/pdf"
        content     : LargeString   
    ) returns AccidentAttachments;

    action deleteAccidentFile(
        attachment_ID : UUID           // AccidentAttachments.ID to remove
    );
}


annotate AccidentService.Accident with @odata.draft.enabled;