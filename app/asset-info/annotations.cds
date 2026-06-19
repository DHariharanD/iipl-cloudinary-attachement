using AssetInfoService as service from '../../srv/asset-info-service';
using from '../../db/assets/asset-info';

annotate service.AssetInfo with @(
    UI.HeaderInfo                    : {
        TypeName      : 'Asset Info',
        TypeNamePlural: 'Asset Infos',
        Title         : {
            $Type: 'UI.DataField',
            Value: AssetID.code,
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: AssetID.assetType,
        },
    },

    UI.LineItem                      : [
        {
            $Type: 'UI.DataField',
            Value: AssetID.code,
            Label: 'Asset'
        },
        {
            $Type: 'UI.DataField',
            Value: Make.assetName,
            Label: 'Make'
        },
        {
            $Type: 'UI.DataField',
            Value: Model.modelModel,
            Label: 'Model'
        },
        {
            $Type: 'UI.DataField',
            Value: SerialNo,
            Label: 'Serial No'
        },
        {
            $Type: 'UI.DataField',
            Value: Chassis,
            Label: 'Chassis'
        },
        {
            $Type: 'UI.DataField',
            Value: EngineNo,
            Label: 'Engine No'
        },
        {
            $Type: 'UI.DataField',
            Value: Year,
            Label: 'Year'
        },
        {
            $Type: 'UI.DataField',
            Value: Capacity,
            Label: 'Capacity'
        },
        {
            $Type: 'UI.DataField',
            Value: ExpectedMilage,
            Label: 'Expected Milage'
        },
        {
            $Type: 'UI.DataField',
            Value: RegNo,
            Label: 'Reg No'
        },
        {
            $Type: 'UI.DataField',
            Value: Mileage,
            Label: 'Mileage'
        }
    ],

    UI.Facets                        : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General Information',
            ID    : 'GeneralInformation',
            Target: '@UI.FieldGroup#GeneralInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Documents Upload',
            ID    : 'DocumentsUpload',
            Target: '@UI.FieldGroup#DocumentsUpload',
        },
        {
            $Type     : 'UI.ReferenceFacet',
            Label     : 'Document Details',
            ID        : 'DocumentDetails',
            Target    : 'isDocument/@UI.LineItem#DocumentDetails',
            @UI.Hidden: {$edmJson: {$Not: {$Path: 'Document'}}},
        },
    ],

    UI.FieldGroup #GeneralInformation: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: AssetID_ID,
                Label: 'Asset'
            },
            {
                $Type: 'UI.DataField',
                Value: Make_ID,
                Label: 'Asset Make'
            },
            {
                $Type: 'UI.DataField',
                Value: Model_ID,
                Label: 'Asset Model'
            },
            {
                $Type: 'UI.DataField',
                Value: SerialNo,
                Label: 'Serial No'
            },
            {
                $Type: 'UI.DataField',
                Value: Chassis,
                Label: 'Chassis'
            },
            {
                $Type: 'UI.DataField',
                Value: EngineNo,
                Label: 'Engine No'
            },
            {
                $Type: 'UI.DataField',
                Value: Year,
                Label: 'Year'
            },
            {
                $Type: 'UI.DataField',
                Value: ExpectedMilage,
                Label: 'Expected Milage'
            },
            {
                $Type: 'UI.DataField',
                Value: RegNo,
                Label: 'Reg No'
            },
            {
                $Type: 'UI.DataField',
                Value: Mileage,
                Label: 'Mileage'
            },
        ],
    },

    UI.FieldGroup #DocumentsUpload   : {
        $Type: 'UI.FieldGroupType',
        Data : [{
            $Type: 'UI.DataField',
            Value: Document,
            Label: 'Document'
        }],
    },
);


//  Asset
annotate service.AssetInfo with {
    AssetID @(
        Common.Label          : 'Asset',
        Common.Text           : AssetID.code,
        Common.TextArrangement: #TextOnly,
        Common.ValueList      : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Assets',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: AssetID_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'code',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'assetType',
                },
            ],
        },
    );
};

// Asset Make
annotate service.AssetInfo with {
    Make @(
        Common.Label          : 'Asset Make',
        Common.Text           : Make.assetName,
        Common.TextArrangement: #TextOnly,
        Common.ValueList      : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'AssetMake',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: Make_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'assetCode',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'assetName',
                },
            ],
        },
    );
};

// Asset Model
annotate service.AssetInfo with {
    Model @(
        Common.Label          : 'Asset Model',
        Common.Text           : Model.modelModel,
        Common.TextArrangement: #TextOnly,
        Common.ValueList      : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'AssetModel',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: Model_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'modelModel',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'modelMake',
                }
            ]
        }
    );
};


annotate service.Assets with {
    ID @UI.Hidden: true;
};

annotate service.AssetMake with {
    ID @UI.Hidden: true;
};

annotate service.AssetModel with {
    ID @UI.Hidden: true;
};


annotate service.AssetInfo with {
    AssetID_ID @Common.Text           : AssetID.code;
    AssetID_ID @Common.TextArrangement: #TextOnly;

    Make_ID    @Common.Text           : Make.assetName;
    Make_ID    @Common.TextArrangement: #TextOnly;

};

annotate service.AssetInfo with {
    Model @(
        Common.Text           : Model.modelModel,
        Common.TextArrangement: #TextOnly
    );
};

annotate service.AssetInfo with {
    Model @UI.TextArrangement: #TextOnly;
};
annotate service.AssetInfo with {
    Model @Common.ValueListWithFixedValues: false;
};