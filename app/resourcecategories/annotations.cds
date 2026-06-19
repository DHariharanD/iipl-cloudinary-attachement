using ResourceServices as service from '../../srv/resource-type-service';

annotate service.ResourceCategories with @(

    UI.LineItem                    : [
        {
            $Type: 'UI.DataField',
            Value: name,
            Label: '{i18n>Name}',
        },
        {
            $Type: 'UI.DataField',
            Value: descr,
            Label: '{i18n>Descriptions}',
        }
    ],

    /* >>> SINGLE FACETS BLOCK (Overview + Details + Products + GL Accounts) <<< */
    UI.Facets                      : [
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>Overview}',
            ID    : 'i18nOverview',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>GeneralInformation}',
                    ID    : 'ResourceCategory',
                    Target: '@UI.FieldGroup#ResourceCategory'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>Details}',
                    ID    : 'i18nDetails',
                    Target: '@UI.FieldGroup#i18nDetails',
                }
            ],
        },

        /* Products Table Tab */
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Products',
            ID    : 'Products',
            Target: 'resourceMeterial/@UI.LineItem#Products1',

        },

        /* ===== GL Accounts Table ===== */
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'GL Accounts',
            ID    : 'GLAccounts',
            Target: 'resourceGlAccounts/@UI.LineItem#GLAccounts1',

        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Assets',
            ID    : 'Assets',
            Target: 'resourceAssets/@UI.LineItem#Assets',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Work Force',
            ID    : 'WorkForce',
            Target: 'resourceWorkforce/@UI.LineItem#WorkForce',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Sub Contract',
            ID    : 'SubContract',
            Target: 'resourceSubcontract/@UI.LineItem#SubContract',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>CompanyCode}',
            ID    : 'i18nCompanyCode',
            Target: 'resourceTypeCompany/@UI.LineItem#i18nCompanyCode',
        },
    ],

    UI.FieldGroup #ResourceCategory: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: name,
                Label: '{i18n>Name}'
            },
            {
                $Type: 'UI.DataField',
                Value: descr,
                Label: '{i18n>Description}'
            },
            {
                $Type     : 'UI.DataField',
                Value     : resourceType.code,
                @UI.Hidden: true
            },
            {
                $Type     : 'UI.DataField',
                Value     : resourceType.name,
                @UI.Hidden: true
            }
        ],
    },

    UI.HeaderInfo                  : {
        TypeName      : '{i18n>ResourceCategory}',
        TypeNamePlural: '{i18n>ResourceCategories}',
        Title         : {
            $Type: 'UI.DataField',
            Value: name
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: descr
        },
    },

    UI.FieldGroup #i18nDetails     : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: isDefaultBudgetHead,
                Label: '{i18n>DefaultBudgetHead}'
            },
            {
                $Type: 'UI.DataField',
                Value: isBudgetValidation,
                Label: 'Budget Validation'
            },
        // { $Type:'UI.DataField', Value:childType,          Label:'{i18n>Type}' },
        ],
    }
);

/* Value Help */
annotate service.ResourceCategories with {
    RCResourceType @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'ResourceTypes',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: RCResourceType_ID,
                ValueListProperty: 'ID',
            }],
        },
        Common.ValueListWithFixedValues: true,
        Common.Text                    : RCResourceType.resourceType,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

/* Text on ID of ResourceType */
annotate service.ResourceTypes with {
    ID @(
        Common.Text                    : resourceType,
        Common.Text.@UI.TextArrangement: #TextOnly
    )
};

/* ReadOnly + Multiline fields */
// annotate service.ResourceCategories with {
//     name  @Common.FieldControl: #ReadOnly;
//     descr @Common.FieldControl: #ReadOnly;
//     code  @Common.FieldControl: #ReadOnly;
//     descr @UI.MultiLineText   : true;
// };

/* Products table definition */
annotate service.ResourceMaterial with @(
    UI.LineItem #Products1: [
        {
            $Type: 'UI.DataField',
            Value: productId,
            Label: 'Product ID',
        },
        {
            $Type: 'UI.DataField',
            Value: productName,
            Label: 'Product Name',
        },
        {
            $Type: 'UI.DataField',
            Value: productType,
            Label: 'Product Type',
        },
        {
            $Type: 'UI.DataField',
            Value: unitofMeasure,
            Label: 'Unit of Measure'
        },

    ],
    UI.CreateHidden       : true,
);

/* GL Accounts table definition */
annotate service.ResourceGl with @(
    UI.LineItem #GLAccounts1: [
        {
            $Type: 'UI.DataField',
            Value: GLNo,
            Label: 'GL No'
        },
        {
            $Type: 'UI.DataField',
            Value: GLName,
            Label: 'GL Name'
        }
    ],
    UI.CreateHidden         : true,
);

annotate service.ResourceAssets with @(
    UI.LineItem #Assets   : [
        {
            $Type: 'UI.DataField',
            Value: parent.resourceAssets.Asset,
            Label: 'Asset',
        },
        {
            $Type: 'UI.DataField',
            Value: parent.resourceAssets.name,
            Label: 'Name',
        },
    ],
    UI.LineItem #WorkForce: [],
    UI.CreateHidden       : true,

);

annotate service.ResourceWorkforce with @(
    UI.LineItem #WorkForce: [
        {
            $Type: 'UI.DataField',
            Value: parent.resourceWorkforce.name,
            Label: 'name',
        },
        {
            $Type: 'UI.DataField',
            Value: parent.resourceWorkforce.description,
            Label: 'description',
        },
    ],
    UI.CreateHidden       : true,

);

annotate service.ResourceSubcontract with @(
    UI.LineItem #SubContract: [
        {
            $Type: 'UI.DataField',
            Value: subcontractId,
            Label: 'Sub ContractId',
        },
        {
            $Type: 'UI.DataField',
            Value: subcontractName,
            Label: 'Sub Contract Name',
        },
        {
            $Type: 'UI.DataField',
            Value: subcontractType,
            Label: 'Sub Contract Type',
        },
    ],
    UI.CreateHidden         : true,
);

annotate service.ResourceTypeCompany with @(UI.LineItem #i18nCompanyCode: [
    {
        $Type: 'UI.DataField',
        Value: company.CompanyCode,
        Label: '{i18n>CompanyCode}',
    },
    {
        $Type: 'UI.DataField',
        Value: company.CompanyCodeName,
        Label: 'Company Code Name',
    },
]);


