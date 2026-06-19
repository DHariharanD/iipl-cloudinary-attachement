using EmployeeMasterService as service from '../../srv/employee-master-service';
annotate service.EmployeeMaster with @(
    UI.SelectionFields : [
        businessPartner,
        firstName,
        lastName,
        businessPartnerCategory,
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : businessPartner,
        },
        {
            $Type : 'UI.DataField',
            Value : firstName,
        },
        {
            $Type : 'UI.DataField',
            Value : lastName,
        },
        {
            $Type : 'UI.DataField',
            Value : businessPartnerCategory,
        },
    ],
    UI.HeaderInfo : {
        TypeName : '{i18n>Employees}',
        TypeNamePlural : '{i18n>Employees}',
        Title : {
            $Type : 'UI.DataField',
            Value : firstName,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : businessPartner,
        },
        TypeImageUrl : 'sap-icon://employee',
    },
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
                    Label : '{i18n>BusinessPartnerType}',
                    ID : 'i18nBusinessPartnerType',
                    Target : '@UI.FieldGroup#i18nBusinessPartnerType',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Address',
                    ID : 'Address',
                    Target : 'addresses/@UI.LineItem#Address',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Contact Information',
                    ID : 'ContactInformation',
                    Target : 'addresses/@UI.LineItem#ContactInformation',
                },
            ],
        },
    ],
    UI.FieldGroup #i18nGeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : businessPartner,
            },
            {
                $Type : 'UI.DataField',
                Value : firstName,
            },
            {
                $Type : 'UI.DataField',
                Value : lastName,
            },
            {
                $Type : 'UI.DataField',
                Value : company_CompanyCode,
                Label : '{i18n>CompanyCode}',
            },
        ],
    },
    UI.FieldGroup #i18nBusinessPartnerType : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : businessPartnerCategory,
            },
            {
                $Type : 'UI.DataField',
                Value : businessPartnerGrouping,
                Label : '{i18n>BusinessPartnerGrouping}',
            },
            {
                $Type : 'UI.DataField',
                Value : gender,
                Label : '{i18n>Gender}',
            },
            {
                $Type : 'UI.DataField',
                Value : dateOfBirth,
                Label : '{i18n>DateOfBirth}',
            },
        ],
    },
);

annotate service.EmployeeMaster with {
    businessPartner @(
        Common.Label : '{i18n>BusinessPartner}',
        Common.FieldControl : #ReadOnly,
    )
};

annotate service.EmployeeMaster with {
    firstName @Common.Label : '{i18n>FirstName}'
};

annotate service.EmployeeMaster with {
    lastName @Common.Label : '{i18n>LastName}'
};

annotate service.EmployeeMaster with {
    businessPartnerCategory @Common.Label : '{i18n>BusinessPartnerCategory}'
};

annotate service.EmployeeAddress with @(
    UI.LineItem #Address : [
        {
            $Type : 'UI.DataField',
            Value : streetName,
            Label : '{i18n>StreetName}',
        },
        {
            $Type : 'UI.DataField',
            Value : region,
            Label : '{i18n>Region}',
        },
        {
            $Type : 'UI.DataField',
            Value : country,
            Label : '{i18n>Country1}',
        },
        {
            $Type : 'UI.DataField',
            Value : postalCode,
            Label : '{i18n>PostalCode}',
        },
    ],
    UI.LineItem #ContactInformation : [
        {
            $Type : 'UI.DataField',
            Value : EmailAddress,
            Label : '{i18n>EmailAddress}',
        },
        {
            $Type : 'UI.DataField',
            Value : phoneNumber,
            Label : '{i18n>PhoneNumber}',
        },
    ],
);

annotate service.EmployeeMaster with {
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

annotate service.EmployeeMaster with {
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

