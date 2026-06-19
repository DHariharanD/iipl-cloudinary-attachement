using FamilyService as service from '../../srv/family-service';

annotate service.Families with @(
     UI.HeaderInfo: {
        TypeName      : 'Family',
        TypeNamePlural: 'Families',
    },
    UI.SelectionFields: [
        familyCode,
        familyName,
        companyCode,
    ],
    UI.LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: familyCode,
            Label: 'Family Code',
        },
        {
            $Type: 'UI.DataField',
            Value: familyName,
            Label: 'Family Name',
        },
        {
            $Type: 'UI.DataField',
            Value: companyCode,
            Label: 'Company Code',
        },
        {
            $Type: 'UI.DataField',
            Value: description,
            Label: 'Description',
        },
    ],
);

annotate service.Families with {
    familyCode  @Common.Label: 'Family Code';
    familyName  @Common.Label: 'Family Name';
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

annotate service.Companies with {
    CompanyCode @Common.Text: CompanyCodeName
};
