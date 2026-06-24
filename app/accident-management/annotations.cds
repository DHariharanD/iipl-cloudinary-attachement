using AccidentService as service from '../../srv/accident-management-service';

annotate service.Accident with @(

    // GENERAL INFORMATION (Driver + Accident)
    UI.FieldGroup #GeneralInformation: {
        $Type: 'UI.FieldGroupType',
        Data: [
            { Value: driverName, Label: 'Driver Name' },
            { Value: driverLicenseNo, Label: 'Driver License No' },
            { Value: driverContact, Label: 'Driver Contact' },
            { Value: accidentDate, Label: 'Accident Date' },
            { Value: accidentTime, Label: 'Accident Time' },
            { Value: location, Label: 'Location' },
            { Value: description, Label: 'Description' },
            { Value: accidentType_code, Label: 'Accident Type' },
            { Value: severity_code, Label: 'Severity' },
            { Value: policeReportNo, Label: 'Police Report No' },
            { Value: policeStation, Label: 'Police Station' },
            { Value: isPoliceInformed, Label: 'Is Police Informed' },
            { Value: isInjury, Label: 'Is Injury' },
            { Value: injuryDetails, Label: 'Injury Details' },
            { Value: vehicleDamage, Label: 'Vehicle Damage' },
            { Value: thirdPartyDamage, Label: 'Third Party Damage' }
        ]
    },

    // VEHICLE INFORMATION
    UI.FieldGroup #VehicleInformation: {
        $Type: 'UI.FieldGroupType',
        Data: [
            {
                $Type : 'UI.DataField',
                Value : vehicleNo,
                Label : 'Vehicle',
            },
            { Value: SerialNo, Label: 'Serial No' },
            { Value: Chassis, Label: 'Chassis' },
            { Value: EngineNo, Label: 'Engine No' },
            {
                Value: Year, Label: 'Year'
            },
        ]
    },

    // INSURANCE INFORMATION
    UI.FieldGroup #InsuranceInformation: {
        $Type: 'UI.FieldGroupType',
        Data: [
            { Value: insuranceProvider, Label: 'Insurance Provider' },
            { Value: policyNumber, Label: 'Policy Number' },
            { Value: claimNumber, Label: 'Claim Number' },
            { Value: claimStatus_code, Label: 'Claim Status' },
            { Value: claimAmount, Label: 'Claim Amount' },
            { Value: approvedAmount, Label: 'Approved Amount' }
        ]
    },


    // VERTICAL SECTIONS
    UI.Facets: [
        {
            $Type : 'UI.CollectionFacet',
            ID    : 'GeneralSection',
            Label : 'General Information',
            Facets: [
                {
                    $Type  : 'UI.ReferenceFacet',
                    Target : '@UI.FieldGroup#GeneralInformation'
                }
            ]
        },
        {
            $Type : 'UI.CollectionFacet',
            ID    : 'VehicleSection',
            Label : 'Vehicle Information',
            Facets: [
                {
                    $Type  : 'UI.ReferenceFacet',
                    Target : '@UI.FieldGroup#VehicleInformation'
                }
            ]
        },
        {
            $Type : 'UI.CollectionFacet',
            ID    : 'InsuranceSection',
            Label : 'Insurance Information',
            Facets: [
                {
                    $Type  : 'UI.ReferenceFacet',
                    Target : '@UI.FieldGroup#InsuranceInformation'
                }
            ]
        },
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'AttachmentsSection',
            Label  : 'Attachments',
            Target : 'attachments/@UI.LineItem'
        }
        // ────────────────────────────────────────────────────────────────────
    ],


    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : vehicleNo,
            Label : 'Vehicle No',
        },
        { $Type: 'UI.DataField', Value: SerialNo, Label : 'Serial No' },
        { $Type: 'UI.DataField', Value: Chassis },
        { $Type: 'UI.DataField', Value: Year },
    ],

    UI.SelectionFields: [
        accidentDate,
        isInjury,
        isPoliceInformed
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : vehicleNo,
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : driverName,
        },
    },
);



// AccidentType
annotate service.Accident with {
    accidentType @(
        Common.ValueList: {
            $Type: 'Common.ValueListType',
            CollectionPath: 'AccidentType',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: accidentType_code,
                    ValueListProperty: 'code'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        },
        Common.ValueListWithFixedValues: true,

    )
};

// Severity
annotate service.Accident with {
    severity @(
        Common.ValueList: {
            $Type: 'Common.ValueListType',
            CollectionPath: 'Severity',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: severity_code,
                    ValueListProperty: 'code'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        },
        Common.ValueListWithFixedValues: true
    )
};

// ClaimStatus
annotate service.Accident with {
    claimStatus @(
        Common.ValueList: {
            $Type: 'Common.ValueListType',
            CollectionPath: 'ClaimStatus',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: claimStatus_code,
                    ValueListProperty: 'code'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        },
        Common.ValueListWithFixedValues: true
    )
};


annotate service.Accident with {
    vehicleNo @(
        Common.ValueList: {
            $Type: 'Common.ValueListType',
            CollectionPath: 'Assets',
            Parameters: [

                // Only one column + mapping
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: vehicleNo,
                    ValueListProperty: 'assetCtegory'
                },

                {
                    $Type: 'Common.ValueListParameterConstant',
                    ValueListProperty: 'assetType_code',
                    Constant: 'VH'
                }
            ]
        }
    )
};


// Hide technical fields in value help
annotate service.Accident with {
    accidentType @(
        Common.Text : accidentType.name,
        Common.Text.@UI.TextArrangement : #TextOnly
    );

    severity @(
        Common.Text : severity.name,
        Common.Text.@UI.TextArrangement : #TextOnly
    );

    claimStatus @(
        Common.Text : claimStatus.name,
        Common.Text.@UI.TextArrangement : #TextOnly
    );
};


// Hide code in valuehelp inside and show only description
annotate service.ClaimStatus with {
    code @UI.Hidden;
};

annotate service.Severity with {
    code @UI.Hidden;
};

annotate service.AccidentType with {
    code @UI.Hidden;
};



annotate service.Assets with {
    ID @(
        Common.Text : assetCtegory,
        Common.Text.@UI.TextArrangement : #TextOnly
    )
};

annotate service.Accident with {
    vehicleNo @mandatory;
};

annotate service.Assets with {
    assetCtegory @Common.Label: 'ID';
};


// ── AccidentAttachments table columns ─────────────────────────────────────────
// description is listed second so users immediately see context alongside the
// clickable file name. fileSize and mediaType are secondary technical detail.
annotate service.AccidentAttachments with @(

    UI.LineItem: [
        {
            // Clickable file name → opens the Cloudinary URL in a new tab
            $Type : 'UI.DataFieldWithUrl',
            Value : fileName,
            Url   : url,
            Label : 'File Name'
        },
        {
            $Type : 'UI.DataField',
            Value : description,
            Label : 'Description'
        },
        {
            $Type : 'UI.DataField',
            Value : mediaType,
            Label : 'Type'
        },
        {
            $Type : 'UI.DataField',
            Value : fileSize,
            Label : 'Size (bytes)'
        },
        {
            $Type : 'UI.DataField',
            Value : createdAt,
            Label : 'Uploaded On'
        },
        {
            $Type : 'UI.DataField',
            Value : createdBy,
            Label : 'Uploaded By'
        }
    ]
);

// Disable default Fiori Elements CRUD on the attachments table —
// uploads and deletes are handled exclusively via the custom toolbar actions.
annotate service.AccidentAttachments with @(
    Capabilities.InsertRestrictions: { Insertable: false },
    Capabilities.DeleteRestrictions: { Deletable: false },
    Capabilities.UpdateRestrictions: { Updatable: false }
);

// Hide technical/internal fields — never shown as editable columns.
annotate service.AccidentAttachments with {
    publicId    @UI.Hidden;   // Cloudinary internal ID
    url         @UI.Hidden;   // used only as Url target in DataFieldWithUrl
};
