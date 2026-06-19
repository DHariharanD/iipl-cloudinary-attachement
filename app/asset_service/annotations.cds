using ResourceServices as service from '../../srv/resource-type-service';
using from '../../srv/asset-service';

annotate AssetService.Asset with @(
    UI.SelectionFields                  : [
        companyCode,
        code,
        assetCtegory,
        assetStatus_code,
    ],
    UI.LineItem                         : [
        {
            $Type: 'UI.DataField',
            Value: companyCode,
        },
        {
            $Type: 'UI.DataField',
            Value: code,
        },
        {
            $Type: 'UI.DataField',
            Value: assetType_code,
            Label: '{i18n>AssetType}',
        },
        {
            $Type: 'UI.DataField',
            Value: assetCtegory,
        },
        {
            $Type: 'UI.DataField',
            Value: assetStatus_code,
        },
    ],
    UI.Facets                           : [
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>Assets}',
            ID    : 'i18nAssets',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>BasicInformation}',
                    ID    : 'i18nBasicInformation',
                    Target: '@UI.FieldGroup#i18nBasicInformation',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>AdditionalDetails}',
                    ID    : 'i18nAdditionalDetails',
                    Target: '@UI.FieldGroup#i18nAdditionalDetails',
                },
            ],
        },
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>AssetInfo}',
            ID    : 'i18nAssetInfo',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>BasicInfo}',
                    ID    : 'i18nBasicInfo',
                    Target: '@UI.FieldGroup#i18nBasicInfo',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>OtherDetails}',
                    ID    : 'i18nOtherDetails',
                    Target: '@UI.FieldGroup#i18nOtherDetails',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Custodian}',
            ID    : 'i18nCustodian',
            Target: '@UI.FieldGroup#i18nCustodian',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Price List',
            ID    : 'PriceList',
            Target: 'pricelist/@UI.LineItem#PriceList',
        },
    ],
    UI.FieldGroup #i18nAsset            : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: companyCode,
            },
            {
                $Type: 'UI.DataField',
                Value: code,
            },
            {
                $Type: 'UI.DataField',
                Value: assetType_code,
                Label: '{i18n>AssetType}',
            },
            {
                $Type: 'UI.DataField',
                Value: assetCtegory,
            },
            {
                $Type: 'UI.DataField',
                Value: CBSCode,
                Label: '{i18n>CbsCode}',
            },
            {
                $Type: 'UI.DataField',
                Value: resourceCode,
                Label: '{i18n>ResourceCode}',
            },
        ],
    },
    UI.FieldGroup #i18nAssets           : {
        $Type: 'UI.FieldGroupType',
        Data : [],
    },
    UI.FieldGroup #i18nBasicInformation : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: companyCode,
            },
            {
                $Type: 'UI.DataField',
                Value: code,
            },
            {
                $Type: 'UI.DataField',
                Value: assetType_code,
                Label: '{i18n>AssetType}',
            },
            {
                $Type: 'UI.DataField',
                Value: assetCtegory,
            },
            {
                $Type: 'UI.DataField',
                Value: assetStatus_code,
            },
            {
                $Type: 'UI.DataField',
                Value: resourceCode,
                Label: '{i18n>ResourceCode}',
            },
            {
                $Type: 'UI.DataField',
                Value: CBSCode,
                Label: '{i18n>CbsCode}',
            },
            {
                $Type: 'UI.DataField',
                Value: fixedAsset,
                Label: '{i18n>FixedAsset}',
            },
        ],
    },
    UI.FieldGroup #i18nAdditionalDetails: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: location,
                Label: '{i18n>Location}',
            },
            {
                $Type: 'UI.DataField',
                Value: standardHours,
                Label: '{i18n>StandardHours}',
            },
            {
                $Type: 'UI.DataField',
                Value: timeSheetRequired,
                Label: '{i18n>TimeSheetRequired}',
            },
            {
                $Type: 'UI.DataField',
                Value: quantity,
                Label: '{i18n>Quantity}',
            },
            {
                $Type: 'UI.DataField',
                Value: uom,
                Label: '{i18n>UnitOfMeasure1}',
            },
        ],
    },
    UI.FieldGroup #i18nAssetInfo        : {
        $Type: 'UI.FieldGroupType',
        Data : [],
    },
    UI.FieldGroup #i18nBasicInfo        : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: assetInfo.Make_ID,
                Label: '{i18n>AssetMake}',
            },
            {
                $Type: 'UI.DataField',
                Value: assetInfo.Model_ID,
                Label: '{i18n>AssetModel}',
            },

            {
                $Type: 'UI.DataField',
                Value: assetInfo.SerialNo,
                Label: '{i18n>SerialNo}',
            },
            {
                $Type: 'UI.DataField',
                Value: assetInfo.Chassis,
                Label: 'Chassis',
            },
            {
                $Type: 'UI.DataField',
                Value: assetInfo.EngineNo,
                Label: '{i18n>EngineNo}',
            },
        ],
    },
    UI.FieldGroup #i18nOtherDetails     : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: assetInfo.Capacity,
                Label: 'Capacity',
            },
            {
                $Type: 'UI.DataField',
                Value: assetInfo.Mileage,
                Label: 'Mileage',
            },
            {
                $Type: 'UI.DataField',
                Value: assetInfo.ExpectedMilage,
                Label: '{i18n>ExpectedMilage}',
            },
            {
                $Type: 'UI.DataField',
                Value: assetInfo.RegNo,
                Label: '{i18n>RegNo}',
            },
            {
                $Type: 'UI.DataField',
                Value: assetInfo.Year,
                Label: 'Year',
            },
        ],
    },
    UI.FieldGroup #i18nCustodian        : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: custodian.employeeName,
                Label: '{i18n>Employee}',
            },
            {
                $Type: 'UI.DataField',
                Value: custodian.designation,
                Label: '{i18n>Designation}',
            },
            {
                $Type: 'UI.DataField',
                Value: custodian.fromDate,
                Label: '{i18n>FromDate}',
            },
            {
                $Type: 'UI.DataField',
                Value: custodian.toDate,
                Label: '{i18n>ToDate}',
            },
        ],
    },
    UI.HeaderInfo                       : {
        TypeName      : 'Assets',
        TypeNamePlural: '{i18n>Assets}',
        Title         : {
            $Type: 'UI.DataField',
            Value: code,
        },
    },
);


annotate AssetService.Asset with {
    assetCtegory @Common.Label: '{i18n>AssetCategory}'
};

annotate AssetService.Asset with {
    assetStatus @(
        Common.Label                   : '{i18n>AssetStatus}',
        Common.ValueListWithFixedValues: true,
        Common.Text                    : assetStatus.name,
        Common.Text.@UI.TextArrangement: #TextOnly,
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'AssetStatus',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: assetStatus_code,
                    ValueListProperty: 'code',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name',
                },
            ],
        },
    );
};

annotate AssetService.Asset with {
    code @Common.Label: '{i18n>Code}'
};

annotate AssetService.Asset with {
    companyCode @(
        Common.Label                   : '{i18n>CompanyCode}',
        Common.ValueListWithFixedValues: false,
        Common.Text                    : company.CompanyCodeName,
        Common.Text.@UI.TextArrangement: #TextLast,
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Companies',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: companyCode,
                    ValueListProperty: 'CompanyCode',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'CompanyCodeName',
                },
            ],
            Label         : 'Company Code',
        },
    );
};

annotate AssetService.Pricelist with @(UI.LineItem #PriceList: [
    {
        $Type: 'UI.DataField',
        Value: asset.pricelist.type,
        Label: '{i18n>Type}',
    },
    {
        $Type: 'UI.DataField',
        Value: asset.pricelist.uom,
        Label: '{i18n>Uom}',
    },
    {
        $Type: 'UI.DataField',
        Value: asset.pricelist.price,
        Label: '{i18n>Price}',
    },
    {
        $Type: 'UI.DataField',
        Value: asset.pricelist.fromDate,
        Label: '{i18n>FromDate}',
    },
    {
        $Type: 'UI.DataField',
        Value: asset.pricelist.toDate,
        Label: '{i18n>ToDate}',
    },
    {
        $Type: 'UI.DataField',
        Value: asset.pricelist.currency,
        Label: '{i18n>Currency}',
    },
]);

annotate AssetService.Asset with {
    assetType @(
        Common.Label                   : '{i18n>AssetType}',
        Common.ValueListWithFixedValues: false,
        Common.Text                    : assetType.name,
        Common.Text.@UI.TextArrangement: #TextOnly,
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'AssetType',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: assetType_code,
                    ValueListProperty: 'code',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name',
                },
            ],
        },
    );
};

annotate AssetService.Custodian with {
    employeeName @(
        Common.Label    : '{i18n>Employee}',
        Common.ValueList: {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'EmployeeDetails',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: employeeID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: employeeName,
                    ValueListProperty: 'fullName',
                },
            ],
            Label         : 'Select Employee',
        },
    );
    employeeID   @UI.Hidden: true;
    designation  @(
        Common.Label       : '{i18n>Designation}',
        Common.FieldControl: #Optional,
    );
};

annotate AssetService.EmployeeDetails with {
    ID @UI.Hidden: true;
};

// annotate AssetService.Custodian with {
//     designation @(
//         Common.Label       : '{i18n>Designation}',
//         Core.Computed      : false,
//         Common.FieldControl: #Optional,
//     );
// };
annotate AssetService.AssetInfo with {
    Make  @(
        Common.Label                   : '{i18n>AssetMake}',
        Common.ValueListWithFixedValues: false,
        Common.Text                    : Make.assetName,
        Common.Text.@UI.TextArrangement: #TextOnly,
        Common.ValueList               : {
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

    Model @(
        Common.Label                   : '{i18n>AssetModel}',
        Common.ValueListWithFixedValues: false,
        Common.Text                    : Model.modelMake,
        Common.Text.@UI.TextArrangement: #TextOnly,
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

// For AssetMake entity
annotate AssetService.AssetMake with {
    ID @UI.Hidden: true;
};

// For AssetModel entity
annotate AssetService.AssetModel with {
    ID @UI.Hidden: true;
};

annotate AssetService.fixedassetec with @(

    UI.SelectionFields: [
        FixedAsset,
        CompanyCode
    ],

    UI.LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: FixedAsset,
            Label: 'Asset Number'
        },
        {
            $Type: 'UI.DataField',
            Value: CompanyCode,
            Label: 'Company Code'
        },
        {
            $Type: 'UI.DataField',
            Value: FixedAssetClass,
            Label: 'Asset Class'
        },
        {
            $Type: 'UI.DataField',
            Value: FixedAssetDescription,
            Label: 'Description'
        }
    ],
);

annotate AssetService.Asset with {
    fixedAsset @(
        Common.Label                   : '{i18n>FixedAsset}',
        Common.Text                    : fixedAssetDesc,
        Common.Text.@UI.TextArrangement: #TextLast,

        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'fixedassetec',

            Parameters    : [

                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: fixedAsset,
                    ValueListProperty: 'MasterFixedAsset'
                },

                // {
                //     $Type            : 'Common.ValueListParameterDisplayOnly',
                //     ValueListProperty: 'FixedAsset'
                // },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'FixedAssetDescription'
                }
            ]
        }
    );
};
