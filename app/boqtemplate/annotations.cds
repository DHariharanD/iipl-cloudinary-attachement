using BillofQuantityTemplateService as service from '../../srv/boq-template-service';
annotate service.BillofQuantityTemplates with @(
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
            Value : descr,
            Label : '{i18n>Description}',
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
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Details}',
            ID : 'i18nDetails',
            Target : 'Hierarchies/@UI.LineItem#i18nDetails',
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
                Value : descr,
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
        TypeName : 'BOQ Template',
        TypeNamePlural : '{i18n>BoqTemplate}',
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : descr,
        },
        TypeImageUrl : 'sap-icon://travel-expense-report',
    },
);

annotate service.BillofQuantityTemplates with {
    name @Common.Label : '{i18n>Name}'
};

annotate service.BillofQuantityTemplates with {
    descr @(
        Common.Label : 'descr',
        UI.MultiLineText : true,
    )
};

annotate service.BillofQuantityTemplates with {
    ID @UI.Hidden;
};

annotate service.BillofQuantityTemplateDetails with @(
    UI.LineItem #i18nDetails : [
        {
            $Type : 'UI.DataField',
            Value : item,
            Label : '{i18n>Item}',
        },
        {
            $Type : 'UI.DataField',
            Value : description,
            Label : '{i18n>Description}',
        },
        {
            $Type : 'UI.DataField',
            Value : unitOfMeasurement,
            Label : '{i18n>UnitOfMeasurement}',
        },
        {
            $Type : 'UI.DataField',
            Value : quantity,
            Label : '{i18n>Quantity}',
        },
    ]
);

annotate service.BillofQuantityTemplates with {
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

annotate service.BillofQuantityTemplates with {
    company_CompanyCode @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Companies',
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

annotate service.Companies with {
    CompanyCode @Common.Text : CompanyCodeName
};

