using DesignationService as service from '../../srv/designations-service';
annotate service.Designations with @(
    UI.HeaderInfo                        : {
        TypeName      : 'Designation',
        TypeNamePlural: 'Designations',
        Title         : {
            $Type: 'UI.DataField',
            Value: name,
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: code,
        },
    },
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Code}',
                Value : code,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Name',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Description',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Hourly Rate',
                Value : hourlyRate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Company Code',
                Value : companyCode,
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
            Label : 'Code',
            Value : code,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Name',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : description,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Hourly Rate',
            Value : hourlyRate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Company Code',
            Value : companyCode,
        },
    ],
);

annotate service.Designations with {
    companyCode @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Companies',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : companyCode,
                    ValueListProperty : 'Company Code',
                },
            ],
            Label : 'Company code',
        },
        Common.ValueListWithFixedValues : true,
)};

