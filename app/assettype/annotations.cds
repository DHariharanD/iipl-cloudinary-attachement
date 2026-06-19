using AssetTypeService as service from '../../srv/asset-type-service';
using API_COMPANYCODE_SRV as CO from '../../srv/external/API_COMPANYCODE_SRV';

annotate service.AssetTypes with @(
    UI.SelectionFields : [
        name,
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Value : description,
            Label : '{i18n>Description}',
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>GeneralInformation}',
            ID : 'i18nGeneralInformation',
            Target : '@UI.FieldGroup#i18nGeneralInformation',
        },
    ],
    UI.FieldGroup #i18nGeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Value : description,
                Label : '{i18n>Description}',
            },
            {
                $Type : 'UI.DataField',
                Value : company_CompanyCode,
                Label : '{i18n>CompanyCode}',
            },
        ],
    },
    UI.HeaderInfo : {
        TypeName : 'Asset Type',
        TypeNamePlural : 'Asset Type',
        Description : {
            $Type : 'UI.DataField',
            Value : description,
        },
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
        TypeImageUrl : 'sap-icon://eam-work-order',
    },
);

annotate service.AssetTypes with {
    name @Common.Label : '{i18n>Name}'
};

annotate service.AssetTypes with {
    company @(
        Common.Text : company.CompanyCodeName,
        UI.TextArrangement : #TextOnly,

        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Companies',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : company_CompanyCode,
                    ValueListProperty : 'CompanyCode'
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'CompanyCodeName'
                }
            ],
            Label : 'Company'
        },

        Common.ValueListWithFixedValues : true
    );
};

annotate service.AssetTypes with {
    description @UI.MultiLineText : true
};

annotate service.AssetTypes with {
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

