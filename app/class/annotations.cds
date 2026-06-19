using ClassService as service from '../../srv/class-service';

annotate service.Classes with @(
     UI.HeaderInfo: {
        TypeName      : 'Class',
        TypeNamePlural: 'Classes',
    },
    UI.SelectionFields: [
        classCode,
        className,
        companyCode,
    ],
    UI.LineItem: [
        {
            $Type: 'UI.DataField',
            Value: classCode,
            Label: 'Class Code',
        },
        {
            $Type: 'UI.DataField',
            Value: className,
            Label: 'Class Name',
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

annotate service.Classes with {
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

annotate service.Companies with {
    CompanyCode @Common.Text: CompanyCodeName
};