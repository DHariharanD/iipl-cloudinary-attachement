using AssetInfoService as service from '../../srv/asset-info-service';
using from '../../db/assets/asset-info';


annotate service.HiredAssets with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: AssetID,
                Label: 'Asset',
            },
            {
                $Type: 'UI.DataField',
                Label: 'Code',
                Value: code,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Asset Type',
                Value: assetType,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Asset Ctegory',
                Value: assetCtegory,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Resource Code',
                Value: resourceCode,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Fixed Asset',
                Value: fixedAsset,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Location',
                Value: location,
            },
            {
                $Type: 'UI.DataField',
                Label: 'CBS Code',
                Value: CBSCode,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Standard Hours',
                Value: standardHours,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Asset Status',
                Value: assetStatus_code,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Time Sheet Required',
                Value: timeSheetRequired,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Quantity',
                Value: quantity,
            },
            {
                $Type: 'UI.DataField',
                Label: 'UOM',
                Value: uom,
            },
        ],
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Hired Asset Info',
            ID : 'HiredAssetInfo',
            Target : '@UI.FieldGroup#HiredAssetInfo',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Custodian Details',
            ID : 'Custodian',
            Target : '@UI.FieldGroup#Custodian',
        },
        // {
        //     $Type : 'UI.ReferenceFacet',
        //     Label : 'Hired Asset Info',
        //     ID    : 'HiredAssetInfo',
        //     Target: '@UI.FieldGroup#HiredAssetInfo',
        // },
        // {
        //     $Type : 'UI.ReferenceFacet',
        //     Label : 'Custodian',
        //     ID    : 'Custodian',
        //     Target: '@UI.FieldGroup#Custodian',
        // },
    ],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Value: AssetID,
            Label: 'Asset',
        },
        {
            $Type: 'UI.DataField',
            Label: 'Code',
            Value: code,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Asset Type',
            Value: assetType,
        },

    ],
   
    UI.FieldGroup #HiredAssetInfo : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: child.AssetID,
                Label: 'Asset',
            },
            {
                $Type: 'UI.DataField',
                Value: child.Make_ID,
                Label: 'Make',
            },
            {
                $Type: 'UI.DataField',
                Value: child.Model_ID,
                Label: 'Model',
            },
            {
                $Type: 'UI.DataField',
                Value: child.SerialNo,
                Label: 'SerialNo',
            },
            {
                $Type: 'UI.DataField',
                Value: child.Chassis,
                Label: 'Chassis',
            },
            {
                $Type: 'UI.DataField',
                Value: child.EngineNo,
                Label: 'EngineNo',
            },
            {
                $Type: 'UI.DataField',
                Value: child.Year,
                Label: 'Year',
            },
            {
                $Type: 'UI.DataField',
                Value: child.Capacity,
                Label: 'Capacity',
            },
            {
                $Type: 'UI.DataField',
                Value: child.ExpectedMilage,
                Label: 'ExpectedMilage',
            },
            {
                $Type: 'UI.DataField',
                Value: child.RegNo,
                Label: 'RegNo',
            },
            {
                $Type: 'UI.DataField',
                Value: child.Mileage,
                Label: 'Mileage',
            },
        ],
    },
    UI.FieldGroup #Custodian : {
        $Type : 'UI.FieldGroupType',
        Data : [
           {
                $Type: 'UI.DataField',
                Value: childCustodian.employeeID,
                Label: 'Employee',
            },
            {
                $Type: 'UI.DataField',
                Value: childCustodian.designation,
                Label: 'Designation',
            },
            {
                $Type: 'UI.DataField',
                Value: childCustodian.isfrom,
                Label: 'From',
            },
            {
                $Type: 'UI.DataField',
                Value: childCustodian.to,
                Label: 'To',
            },
        ],
    },
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : assetType,
        },
        TypeName : 'Hired Asset',
        TypeNamePlural : 'Hired Assets',
        Description : {
            $Type : 'UI.DataField',
            Value : code,
        },
    },
);
annotate service.HiredAssets with {
    assetType @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'AssetTypes',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : assetType,
                    ValueListProperty : 'name',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

annotate service.HiredAssetInfo with {
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

annotate service.AssetMake with {
    ID @(
        Common.Text : assetName,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate service.HiredAssetInfo with {
   Model @(
        Common.Label                   : 'Asset Model',
        Common.Text                    : Model.modelModel,
        Common.TextArrangement         : #TextOnly,
        Common.ValueListWithFixedValues: false,
        Common.ValueList               : {
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
                },
            ],
        },
    );
};

annotate service.AssetModel with {
    ID @(
        Common.Text : modelModel,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate service.HiredAssetInfo with {
    AssetID @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Assets',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : AssetID_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

annotate service.Assets with {
    ID @(
        Common.Text : assetType,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate service.HiredAssets with {
    AssetID @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Assets',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : AssetID_ID,
                    ValueListProperty : 'ID',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

