namespace ec.assets;

using {
    cuid,
    managed,
    sap.common.CodeList // ← import CodeList properly
} from '@sap/cds/common';

using {CommonService as cm} from '../../srv/common-service';
using {ec.vehicleManagement as make} from '../vehiclemanagement/asset-make';
using {ec.vehicleManagement as model} from '../vehiclemanagement/asset-model';
using {sap.attachments.Attachments} from 'com.sap.cds/cds-feature-attachments';
using {ec.masters as emp} from '../employeedetails/employee-details';
using {ec.masters as masters} from '../designations/designations';
using {S4FixedAsset as CO} from '../../srv/external/S4FixedAsset';

type AssetStatusKey    : String enum {
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

type AssetTypeKey      : String enum {
    MC = 'Machines';
    VH = 'Vehicles';
    SC = 'Scaffolding';
    FW = 'Form works';
}

entity AssetType : CodeList {
    key code : AssetTypeKey;
}

entity Assets : cuid, managed {
    companyCode       : String(11);
    company           : Association to cm.Companies
                            on company.CompanyCode = companyCode;
    code              : String(200);
    assetType         : Association to AssetType;
    assetCtegory      : String(256);
    resourceCode      : String(200);
    fixedAsset        : String(50);
    fixedAssetDesc    : String;
    location          : String(256);
    CBSCode           : String(256);
    standardHours     : String(200);
    assetStatus       : Association to AssetStatus;
    timeSheetRequired : Boolean;
    quantity          : Decimal(15, 2);
    uom               : String(15);
    Document          : Boolean;
    documents         : Composition of many AssetDoc
                            on documents.asset = $self;
    custodian         : Composition of one Custodian
                            on custodian.asset = $self;
    assetInfo         : Composition of one AssetInfo
                            on assetInfo.asset = $self;
    pricelist         : Composition of many Pricelist
                            on pricelist.asset = $self;
    attachments       : Composition of many Attachments;
}

entity AssetInfo : cuid, managed {
    asset          : Association to Assets;
    Make           : Association to make.AssetMake;
    Model          : Association to model.AssetModel;
    SerialNo       : String(100);
    Chassis        : String(100);
    EngineNo       : String(100);
    Year           : String(4);
    Capacity       : Decimal(10, 2);
    ExpectedMilage : Decimal(10, 2);
    RegNo          : String(50);
    Mileage        : Decimal(10, 2);
    fuelRequired   : Boolean;
}


entity AssetDoc : cuid, managed {
    vDocID        : String(25);
    documentID    : String(25);
    asset         : Association to Assets;
    docDefinition : Composition of many AssetDocDefinition
                        on docDefinition.assetDoc = $self;
}

entity AssetDocView as
    projection on AssetDoc {
        key ID,
            vDocID,
            documentID,
            asset,
            docDefinition.documentCode as documentCode,
            docDefinition.name         as documentName
    }

entity AssetDocDefinition : cuid, managed {
    documentCode          : String(25);
    name                  : String(50);
    description           : String(1111);
    validityRequired      : Boolean;
    isMandatory           : Boolean;
    attachment            : Association to AssetAttachmentType;
    isAttachmentMandatory : Boolean;
    assetDoc              : Association to AssetDoc;
}

entity AssetAttachmentType : CodeList {
    key code : AttachmentTypeKey;
}

type AttachmentTypeKey : String enum {
    SI = 'Single';
    ML = 'Multiple';
}

entity Custodian : cuid, managed {
    asset        : Association to Assets;
    employeeID   : String(50);
    employeeName : String(100);
    employee     : Association to emp.EmployeeDetails
                       on employee.ID = employeeID;
    designation  : String(100);

    fromDate     : Date;
    toDate       : Date;
}

entity Pricelist : cuid, managed {
    asset    : Association to Assets;

    type     : String(50);
    uom      : String(15);
    price    : Decimal(15, 2);
    currency : String(10);

    fromDate : Date;
    toDate   : Date;
}
