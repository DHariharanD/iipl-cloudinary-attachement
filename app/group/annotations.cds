using GroupService as service from '../../srv/group-service';

annotate service.Groups with @(
    UI.HeaderInfo                        : {
        TypeName      : 'Group',
        TypeNamePlural: 'Groups',
        Title         : {
            $Type: 'UI.DataField',
            Value: groupName,
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: groupCode,
        },
    },
    UI.SelectionFields                   : [
        groupCode,
        groupName,
        companyCode,
    ],
    UI.LineItem                          : [
        {
            $Type: 'UI.DataField',
            Value: groupCode,
              Label: 'Group Code',
        },
        {
            $Type: 'UI.DataField',
            Value: groupName,
             Label: 'Group Name',
        },
        {
            $Type: 'UI.DataField',
            Value: costOfSales,
            Label: 'Cost Of Sales',
        },
        {
            $Type: 'UI.DataField',
            Value: salesAc,
            Label: 'Sales Account',
        },
        {
            $Type: 'UI.DataField',
            Value: companyCode,
             Label: 'Company Code'
        },
    ],
    UI.Facets                            : [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>GeneralInformation}',
        ID    : 'i18nGeneralInformation',
        Target: '@UI.FieldGroup#i18nGeneralInformation',
    }, ],
    UI.FieldGroup #i18nGeneralInformation: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: groupCode,
                Label : '{i18n>GroupCode}',
            },
            {
                $Type: 'UI.DataField',
                Value: groupName,
                Label : '{i18n>GroupName}',
            },
            {
                $Type: 'UI.DataField',
                Value: costOfSales,
                Label: '{i18n>CostOfSales}',
            },
            {
                $Type: 'UI.DataField',
                Value: salesAc,
                Label: '{i18n>Salesac}',
            },
            {
                $Type: 'UI.DataField',
                Value: companyCode,
                Label: 'Company Code',
            },
            {
                $Type: 'UI.DataField',
                Value: description,
                Label: '{i18n>Description}',
            },
        ],
    },

);

annotate GroupService.Groups with {
    groupCode @Common.Label: '{i18n>GroupCode}'
};

annotate GroupService.Groups with {
    groupName @Common.Label: '{i18n>GroupName}'
};

annotate GroupService.Companies with {
    CompanyCode @Common.Text: CompanyCodeName
};

annotate GroupService.Groups with {
    companyCode @(
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
        Common.Label                   : 'Company Code',
        Common.Text                    : company.CompanyCodeName,
        Common.Text.@UI.TextArrangement: #TextLast,
    )
};
