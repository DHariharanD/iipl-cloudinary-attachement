using CommodityService as service from '../../srv/commodity-service';

annotate service.Commodities with @(
         UI.HeaderInfo: {
        TypeName      : 'Commodity',
        TypeNamePlural: 'Commodites',
    },
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'commodityCode',
                Value : commodityCode,
            },
            {
                $Type : 'UI.DataField',
                Label : 'commodityName',
                Value : commodityName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'companyCode',
                Value : companyCode,
            },
            {
                $Type : 'UI.DataField',
                Label : 'description',
                Value : description,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>CommodityCode}',
            Value : commodityCode,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>CommodityName}',
            Value : commodityName,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>CompanyCode}',
            Value : companyCode,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Description}',
            Value : description,
        },
    ],
    UI.SelectionFields : [
        commodityCode,
        commodityName,
        companyCode,
    ],
);

annotate service.Commodities with {
    commodityCode @Common.Label : '{i18n>CommodityCode}'
};

annotate service.Commodities with {
    commodityName @Common.Label : '{i18n>CommodityName}'
};



annotate service.Commodities with {
    classCode   @Common.Label: 'Class Code';
    className   @Common.Label: 'Class Name';
    description @Common.Label: 'Description';
    companyCode @(
        Common.Label                   : 'Company Code',
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
        Common.ValueListWithFixedValues: true,
        Common.Text                    : company.CompanyCodeName,
        Common.Text.@UI.TextArrangement: #TextLast,
    );
};

annotate service.Commodities with {
    CompanyCode @Common.Text: CompanyCodeName
};