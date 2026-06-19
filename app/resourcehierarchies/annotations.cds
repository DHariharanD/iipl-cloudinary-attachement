using ResourceServices as service from '../../srv/resource-type-service';

annotate service.ResourceCategories with @(
    Common.SideEffects          : {
        $Type           : 'Common.SideEffectsType',
        SourceProperties: [
            name,
            code
        ],
        TargetEntities  : [
            {
                $Type : 'Common.SideEffectsTargetEntityType',
                Target: 'parent'
            },
            {
                $Type : 'Common.SideEffectsTargetEntityType',
                Target: 'ResourceHierarchy'
            }
        ]
    },
    UI.LineItem #i18nCompanyCode: [],
);

annotate service.ResourceHierarchies with @(
    UI.SelectionFields               : [name, ],

    UI.LineItem                      : [
        {
            $Type: 'UI.DataField',
            Value: name,
            Label: 'Name',
        },
        // { $Type:'UI.DataField', Value:validFrom },
        // { $Type:'UI.DataField', Value:validTo },
        {
            $Type: 'UI.DataField',
            Value: descr,
            Label: '{i18n>Description}',
            @UI.Hidden
        },
        {
            $Type: 'UI.DataField',
            Value: note,
            Label: '{i18n>Note}',
            @UI.Hidden
        }
    ],

    UI.HeaderInfo                    : {
        TypeName      : '{i18n>ResourceHierarchy}',
        TypeNamePlural: '{i18n>ResourceHierarchies}',
        Title         : {
            $Type: 'UI.DataField',
            Value: Name
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: descr
        }
    },

    UI.Facets                        : [
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>Overview}',
            ID    : 'i18nOverview',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'General Information',
                    ID    : 'GeneralInformation',
                    Target: '@UI.FieldGroup#GeneralInformation'
                },
                // {
                //     $Type : 'UI.ReferenceFacet',
                //     Label : '{i18n>Timeframe}',
                //     ID    : 'i18nTimeframe',
                //     Target: '@UI.FieldGroup#i18nTimeframe'
                // }
            ]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>CompanyCodes}',
            ID    : 'i18nCompanyCodes',
            Target: 'resourceTypeCompany/@UI.LineItem#i18nCompanyCodes',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>ResourceCategories}',
            ID    : 'ResourceCategories',
            Target: 'Hierarchies/@UI.LineItem#ResourceCategories'
        },
    ],

    UI.FieldGroup #GeneralInformation: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: name,
                Label: 'Name'
            },
            {
                $Type: 'UI.DataField',
                Value: descr,
                Label: '{i18n>Description}'
            }
        ]
    },

    UI.FieldGroup #i18nTimeframe     : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: validTo
            },
            {
                $Type: 'UI.DataField',
                Value: note,
                Label: '{i18n>Note}'
            }
        ]
    }
);

annotate service.ResourceCategories with @(UI.LineItem #ResourceCategories: [
    {
        $Type: 'UI.DataField',
        Value: code,
        Label: '{i18n>Code}'
    },
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
        $Type: 'UI.DataField',
        Value: resourceType.name,
        Label: '{i18n>ResourceType}',
    },
      {
        $Type: 'UI.DataField',
        Value: resourceType_code,
        @UI.Hidden: true
    },
]);


annotate service.ResourceHierarchies with {
    ID @UI.Hidden;
};

annotate service.RtTypes with {
    name @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'RtTypes',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: name,
                ValueListProperty: 'code',
            }, ],
            Label         : 'Resource Type',
        },
        Common.ValueListWithFixedValues: true,
        Common.FieldControl            : #ReadOnly,
    )
};

annotate service.RtTypes with {
    code @(
        Common.Text                    : name,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate service.ResourceHierarchies with {
    name @Common.Label: 'Name'
};

annotate service.ResourceHierarchies with {
    descr @UI.MultiLineText: true
};

annotate service.ResourceHierarchies with {
    note @UI.MultiLineText: true
};

annotate service.ResourceMaterial with @(
    UI.Facets                        : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'General Information',
        ID    : 'GeneralInformation',
        Target: '@UI.FieldGroup#GeneralInformation',
    },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Prime Resource',
            ID : 'PrimeResource',
            Target : '@UI.FieldGroup#PrimeResource',
        }, ],
    UI.FieldGroup #GeneralInformation: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : productId,
                Label : 'Product Id',
            },
            {
                $Type: 'UI.DataField',
                Value: productName,
                Label: 'Product Name',
            },
            {
                $Type: 'UI.DataField',
                Value: isPrime,
                Label: 'Prime Resource',
            },
            {
                $Type : 'UI.DataField',
                Value : unitofMeasure,
                Label : 'Unit of Measure',
            },
        ],
    },
    UI.HeaderInfo                    : {
        Title         : {
            $Type: 'UI.DataField',
            Value: productName,
        },
        TypeName      : '',
        TypeNamePlural: '',
    },
    UI.FieldGroup #PrimeResource : {
        $Type : 'UI.FieldGroupType',
        @UI.Hidden : isPrime,
        Data : [
           
            {
                $Type : 'UI.DataField',
                Value : primeResource_ID,
                Label : 'Prime Resource',
                @UI.Hidden : isPrime,
            },
             {
                $Type : 'UI.DataField',
                Value : primeUnit,
                Label : 'Prime Unit',
                @UI.Hidden : isPrime,
            },
        ],
    },
);

annotate service.ResourceMaterial with {
    primeResource @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'ResourceMaterial',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: primeResource_ID,
                    ValueListProperty: 'productName',
                },
                {
                    $Type            : 'Common.ValueListParameterIn',
                    ValueListProperty: 'parent_ID',
                    LocalDataProperty: parent_ID,
                },
                {
                    $Type            : 'Common.ValueListParameterIn',
                    ValueListProperty: 'isPrime',
                    LocalDataProperty: isPrime,
                    Constant         : true
                },
                {
                    $Type            : 'Common.ValueListParameterOut',
                    ValueListProperty: 'unitofMeasure',
                    LocalDataProperty: primeUnit,
                    UI.Hidden        : true
                },
            ],
            Label         : 'Prime Resources',
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.ResourceTypeCompany with @(
    UI.LineItem #i18nCompanyCodes: [
        {
            $Type: 'UI.DataField',
            Value: companyCode,
            Label: 'Company Code',
        },
        {
            $Type: 'UI.DataField',
            Value: companyName,
            Label: 'Company Name',
        },
    ],
    UI.CreateHidden              : true,

);

annotate service.ResourceAssets with @(
    UI.Facets                        : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'General Information',
        ID    : 'GeneralInformation',
        Target: '@UI.FieldGroup#GeneralInformation',
    }, ],
    UI.FieldGroup #GeneralInformation: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: Asset,
                Label: 'Asset',
            },
            {
                $Type: 'UI.DataField',
                Value: assetCategory,
                Label: 'Asset Category',
            },
            {
                $Type: 'UI.DataField',
                Value: billingUnit,
                Label: 'Billing Unit',
            },
            {
                $Type: 'UI.DataField',
                Value: budgetHead,
                Label: 'Budget Head',
            },
            {
                $Type: 'UI.DataField',
                Value: group,
                Label: 'Group',
            },
            {
                $Type: 'UI.DataField',
                Value: itemUnit,
                Label: 'Item Unit',
            },
            {
                $Type: 'UI.DataField',
                Value: name,
                Label: 'Name',
            },
            {
                $Type: 'UI.DataField',
                Value: refCat,
                Label: 'Ref Cat',
            },
            {
                $Type: 'UI.DataField',
                Value: subCount,
                Label: 'Sub Count',
            },
            {
                $Type: 'UI.DataField',
                Value: tsUnit,
                Label: 'T.S Unit',
            },
            {
                $Type: 'UI.DataField',
                Value: vat,
                Label: 'VAT',
            },
        ],
    },
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : Asset,
        },
        TypeName : '',
        TypeNamePlural : '',
    },
);
annotate service.ResourceSubcontract with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General Information',
            ID : 'GeneralInformation',
            Target : '@UI.FieldGroup#GeneralInformation',
        },
    ],
    UI.FieldGroup #GeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : refCategory,
                Label : 'Ref Category',
            },
            {
                $Type : 'UI.DataField',
                Value : subcontractId,
                Label : 'Sub Contract Id',
            },
            {
                $Type : 'UI.DataField',
                Value : subcontractName,
                Label : 'Sub Contract Name',
            },
            {
                $Type : 'UI.DataField',
                Value : subcontractType,
                Label : 'Sub Contract Type',
            },
            {
                $Type : 'UI.DataField',
                Value : unitOfMeasure,
                Label : 'UOM',
            },
            {
                $Type : 'UI.DataField',
                Value : vat,
                Label : 'VAT',
            },
        ],
    },
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : subcontractName,
        },
        TypeName : '',
        TypeNamePlural : '',
    },
);

annotate service.ResourceWorkforce with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General Information',
            ID : 'GeneralInformation',
            Target : '@UI.FieldGroup#GeneralInformation',
        },
    ],
    UI.FieldGroup #GeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : ServiceCostLevel,
                Label : 'Service Cost Level',
            },
            {
                $Type : 'UI.DataField',
                Value : billingUni,
                Label : 'Billing Unit',
            },
            {
                $Type : 'UI.DataField',
                Value : itemUnit,
                Label : 'Item Unit',
            },
            {
                $Type : 'UI.DataField',
                Value : labourCategory,
                Label : 'Labour Category',
            },
            {
                $Type : 'UI.DataField',
                Value : rate,
                Label : 'Rate',
            },
            {
                $Type : 'UI.DataField',
                Value : refCategory,
                Label : 'Ref Category',
            },
            {
                $Type : 'UI.DataField',
                Value : tsUnit,
                Label : 'T.S Unit',
            },
            {
                $Type : 'UI.DataField',
                Value : vat,
                Label : 'VAT',
            },
        ],
    },
      UI.HeaderInfo                    : {
        Title         : {
            $Type: 'UI.DataField',
            Value: ServiceCostLevel,
        },
        TypeName      : '',
        TypeNamePlural: '',
    },
);

annotate service.ResourceTypeCompany with {
    companyCode @Core.Immutable;
    companyName @Core.Immutable;

};

annotate service.ResourceMaterial with {
    primeUnit        @Core.Immutable;

}
annotate service.ResourceHierarchies with {
    cbsHierarchies @Common.Label : 'CBS Hierarchy';
};

annotate service.ResourceCategories with {
    
    code  @Common.Label : 'Code';

    name  @Common.Label : 'Name';

    descr @Common.Label : 'Description';
};