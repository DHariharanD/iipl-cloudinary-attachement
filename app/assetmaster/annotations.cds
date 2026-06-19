using AssetMasterService as service from '../../srv/asset-master-service';
annotate service.AssetMaster with @(
    UI.SelectionFields : [
        asset,
        type,
        external,
        description,
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : type,
        },
        {
            $Type : 'UI.DataField',
            Value : asset,
        },
        {
            $Type : 'UI.DataField',
            Value : description,
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>Overview}',
            ID : 'i18nOverview',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>GeneralInformation}',
                    ID : 'i18nGeneralInformation',
                    Target : '@UI.FieldGroup#i18nGeneralInformation',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>AssetRequirements}',
                    ID : 'i18nAssetRequirements',
                    Target : '@UI.FieldGroup#i18nAssetRequirements',
                },
            ],
        },
    ],
    UI.FieldGroup #i18nGeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : type,
            },
            {
                $Type : 'UI.DataField',
                Value : asset,
            },
            {
                $Type : 'UI.DataField',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Value : company_CompanyCode,
                Label : '{i18n>CompanyCode}',
            },
        ],
    },
    UI.FieldGroup #i18nAssetRequirements : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : external,
            },
            {
                $Type : 'UI.DataField',
                Value : fuelManagement,
                Label : 'Fuel Management',
            },
        ],
    },
    UI.HeaderInfo : {
        TypeName : '{i18n>AssetMaster}',
        TypeNamePlural : 'Asset master',
        Title : {
            $Type : 'UI.DataField',
            Value : type,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : asset,
        },
        TypeImageUrl : 'sap-icon://master-task-triangle',
    },
);

annotate service.AssetMaster with {
    asset @Common.Label : '{i18n>Asset}'
};

annotate service.AssetMaster with {
    type @Common.Label : '{i18n>Type}'
};

annotate service.AssetMaster with {
    external @Common.Label : '{i18n>External}'
};

annotate service.AssetMaster with {
    description @(
        Common.Label : '{i18n>Description}',
        UI.MultiLineText : true,
    )
};

annotate service.AssetMaster with {
    company_CompanyCode @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'AssetCompanies',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : company_CompanyCode,
                    ValueListProperty : 'CompanyCode',
                },
            ],
            Label : 'Select Company Code',
        },
        Common.ValueListWithFixedValues : true,
)};

annotate service.AssetCompanies with {
    CompanyCode @Common.Text : CompanyCodeName
};

