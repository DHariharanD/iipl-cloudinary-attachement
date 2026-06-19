namespace ec.hiredInfo;

using {
    cuid,
    sap.common.CodeList,
    managed
} from '@sap/cds/common';
using {ec.assets as asset} from './assets';
using {CommonService as cm} from '../../srv/common-service';
using {ec.vehicleManagement as make} from '../vehiclemanagement/asset-make';
using {ec.vehicleManagement as model} from '../vehiclemanagement/asset-model';
using {ec.masters as empDetails} from '../employeedetails/employee-details';

// entity AssetInfo : cuid, managed {
//     AssetID        : Association to asset.Assets; // Link to Asset (can later be association)
//     Make           : Association to make.AssetMake;
//     Model          : Association to model.AssetModel;
//     SerialNo       : String(100);
//     Chassis        : String(100);
//     EngineNo       : String(100);
//     Year           : Integer;
//     Capacity       : Decimal(10, 2);
//     ExpectedMilage : Decimal(10, 2);
//     RegNo          : String(50);
//     Mileage        : Decimal(10, 2);
//     Document       : Boolean;
//     isDocument     : Composition of many AssetDocument
//                          on isDocument.assetInfo = $self;

// }
type AssetStatusKey : String enum {
    WK = 'Working';
    UR = 'Under Repair';
    SC = 'Scrap';
    RS = 'Reserved';
    LS = 'Lost/Stolen';
    DN = 'Donated';
    SD = 'Sold';
    WO = 'Write OFF';
    IC = 'Insurance Claim';
    IT = 'In Transit/Disposed';
}

entity AssetStatus : CodeList {
    key code : AssetStatusKey;
}

entity HiredAssets : cuid, managed {
    // companyCode       : String(11);
    // company           : Association to cm.Companies
    //                         on company.CompanyCode = companyCode;
    AssetID           : String(100);
    code              : String(200);
    assetType         : String(100);
    assetCtegory      : String(256);
    resourceCode      : String(200);
    fixedAsset        : String(256);
    location          : String(256);
    CBSCode           : String(256);
    standardHours     : String(200);
    assetStatus       : Association to AssetStatus;
    timeSheetRequired : Boolean;
    quantity          : Decimal(15, 2);
    uom               : String(15);
    child             : Composition of many HiredAssetInfo on child.parent =$self;
    childCustodian    : Composition of many Custodian on childCustodian.parent =$self

// isDocument     : Composition of many AssetDocument
//         on isDocument.hiredAssets = $self;
}

entity HiredAssetInfo : cuid, managed {
    AssetID        : String(320); // Link to Asset (can later be association)
    Make           : Association to make.AssetMake;
    Model          : Association to model.AssetModel;
    SerialNo       : String(100);
    Chassis        : String(100);
    EngineNo       : String(100);
    Year           : Integer;
    Capacity       : Decimal(10, 2);
    ExpectedMilage : Decimal(10, 2);
    RegNo          : String(50);
    Mileage        : Decimal(10, 2);
    parent         : Association to HiredAssets;
//  Document       : Boolean;
}

entity Custodian : cuid, managed {
   // custodianID : String(100);
    assetID     :  Association to asset.Assets;
    employeeID  : String(100);
    isfrom      : Date;
    to          : Date;
    designation : String(100);
    parent         : Association to HiredAssets;
}


// entity AssetDocument : cuid, managed {
//     vDocID        : String(25);
//     documentID    : String(25);
//     hiredAssets     : Association to HiredAssets;
//     docDefinition : Composition of many DocumentDefinition
//                         on docDefinition.assetDoc = $self;
// }

// entity DocumentDefinition : cuid, managed {
//     documentCode          : String(25);
//     name                  : String(50);
//     description           : String(1111);
//     validityRequired      : Boolean;
//     isMandatory           : Boolean;
//     attachment            : Association to AttachmentType;
//     isAttachmentMandatory : Boolean;
//     assetDoc              : Association to AssetDocument;
// }

// entity AttachmentType : CodeList {
//     key code : AttachmentTypeKey;
// }

// type AttachmentTypeKey : String enum {
//     SI = 'Single';
//     ML = 'Multiple';
// }

 