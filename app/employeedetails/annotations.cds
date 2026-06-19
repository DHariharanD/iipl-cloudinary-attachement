using EmployeeDetailsService as service from '../../srv/employee-details-service';

annotate service.EmployeeDetails with @(

    UI.SelectionFields           : [
        company_CompanyCode,
        firstName,
        lastName,
        gender,
    ],

    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Label: '{i18n>CompanyCode}',
            Value: company_CompanyCode,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>FirstName}',
            Value: firstName,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>LastName}',
            Value: lastName,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Gender}',
            Value: gender,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>DateOfBirth}',
            Value: dateOfBirth,
        },
        // ── Designation column in list ──
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Designation}',
            Value: designation_code,
        },
    ],

    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: '{i18n>CompanyCode}',
                Value: company_CompanyCode,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>FirstName}',
                Value: firstName,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>LastName}',
                Value: lastName,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Gender}',
                Value: gender,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>DateOfBirth}',
                Value: dateOfBirth,
            },
            // ── Designation field in form ──
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Designation}',
                Value: designation_code,
            },
        ],
    },

    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Address}',
            ID    : 'i18nAddress',
            Target: 'addresses/@UI.LineItem#AddressTable',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>ContactInformation}',
            ID    : 'i18nContactInformation',
            Target: 'addresses/@UI.LineItem#i18nContactInformation',
        },
    ],

    UI.HeaderInfo                : {
        TypeName      : '',
        TypeNamePlural: '',
        Description   : {
            $Type: 'UI.DataField',
            Value: firstName,
        },
        TypeImageUrl  : 'sap-icon://account',
    },
);

// ─── Company Code value help ───────────────────────────────────────────────────

annotate service.EmployeeDetails with {
    company_CompanyCode @(
        Common.Label                   : '{i18n>CompanyCode}',
        Common.Text                    : company_CompanyCodeName,
        Common.TextArrangement         : #TextFirst,
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Companies',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: company_CompanyCode,
                    ValueListProperty: 'CompanyCode',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'CompanyCodeName',
                },
            ],
            Label         : 'Select Company Code',
        },
        Common.ValueListWithFixedValues: true,
    );
};

// ─── Designation value help — two-column dialog (code + name) ─────────────────

annotate service.EmployeeDetails with {
    designation_code @(
        Common.Label          : '{i18n>Designation}',
        Common.Text           : designation_name,  
        Common.TextArrangement: #TextFirst,
        Common.ValueList      : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Designations',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: designation_code,
                    ValueListProperty: 'code',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name',
                },
            ],
            Label         : 'Select Designation',
        }
    );
    designation_code @Common.FieldControl: #Optional;
};

// ─── CompanyCode text display in Companies dropdown ───────────────────────────

annotate service.Companies with {
    CompanyCode @(
        Common.Text           : CompanyCodeName,
        Common.TextArrangement: #TextFirst,
    );
};

// ─── Other field labels ────────────────────────────────────────────────────────

annotate service.EmployeeDetails with {
    firstName        @Common.Label: '{i18n>FirstName}';
    lastName         @Common.Label: '{i18n>LastName}';
    gender           @Common.Label: '{i18n>Gender}';
    dateOfBirth      @Common.Label: '{i18n>DateOfBirth}';
    designation_code @Common.Label: '{i18n>Designation}';
};

// ─── Address Table ─────────────────────────────────────────────────────────────

annotate service.EmployeeAddressDetail with @(

    UI.LineItem #AddressTable          : [
        {
            $Type: 'UI.DataField',
            Value: parent.addresses.streetName,
            Label: '{i18n>StreetName}',
        },
        {
            $Type: 'UI.DataField',
            Value: parent.addresses.region,
            Label: '{i18n>Region}',
        },
        {
            $Type: 'UI.DataField',
            Value: parent.addresses.country,
            Label: '{i18n>Country1}',
        },
        {
            $Type: 'UI.DataField',
            Value: parent.addresses.postalCode,
            Label: '{i18n>PostalCode}',
        },
    ],

    UI.Facets                          : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'AddressDetailsFacet',
            Label : '{i18n>AddressDetails}',
            Target: '@UI.FieldGroup#AddressDetails',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'ContactDetailsFacet',
            Label : '{i18n>ContactDetails}',
            Target: '@UI.FieldGroup#ContactDetails',
        },
    ],

    UI.HeaderFacets                    : [],

    UI.FieldGroup #i18nEmployeeDetails : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: parent.firstName,
            },
            {
                $Type: 'UI.DataField',
                Value: parent.lastName,
            },
        ],
    },

    UI.HeaderInfo                      : {
        TypeName      : '',
        TypeNamePlural: '',
        Description   : {
            $Type: 'UI.DataField',
            Value: parent.firstName,
        },
    },

    UI.LineItem #i18nContactInformation: [
        {
            $Type: 'UI.DataField',
            Value: parent.addresses.phoneNumber,
            Label: '{i18n>PhoneNumber}',
        },
        {
            $Type: 'UI.DataField',
            Value: parent.addresses.EmailAddress,
            Label: '{i18n>EmailAddress}',
        },
    ],
);
