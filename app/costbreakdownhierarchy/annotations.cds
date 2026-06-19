using CostBreakdownStructureService as service from '../../srv/cbs-service';

annotate service.CostBreakDownHierarchies with @(
    UI.FieldGroup #GeneratedGroup        : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Valid From',
                Value: validFrom,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Valid To',
                Value: validTo,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Name',
                Value: name,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Description',
                Value: descr,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Note',
                Value: note,
            },
        ],
    },
    UI.Facets                            : [{
        $Type : 'UI.CollectionFacet',
        Label : '{i18n>Overview}',
        ID    : 'i18nOverview',
        Facets: [
            {
                $Type : 'UI.ReferenceFacet',
                Label : '{i18n>GeneralInformation}',
                ID    : 'i18nGeneralInformation',
                Target: '@UI.FieldGroup#i18nGeneralInformation',
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : '{i18n>CostBreakdownStructure}',
                ID    : 'CostBreakdownStructure',
                Target: 'cbHierarchies/@UI.LineItem#CostBreakdownStructure',
            },
        // {
        //     $Type : 'UI.ReferenceFacet',
        //     Label : '{i18n>Timeframe}',
        //     ID    : 'i18nTimeframe',
        //     Target: '@UI.FieldGroup#i18nTimeframe',
        // },
        ],
    },

    ],
    UI.LineItem                          : [
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Name}',
            Value: name,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Description}',
            Value: descr,
        },

    ],
    UI.SelectionFields                   : [
        name,
        descr,
    ],
    UI.FieldGroup #i18nGeneralInformation: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: company_CompanyCode,
                Label: 'Company',
            },
            {
                $Type: 'UI.DataField',
                Value: name,
                Label: '{i18n>Name}',
            },
            {
                $Type: 'UI.DataField',
                Value: descr,
                Label: '{i18n>Description}',
            },
            {
            $Type: 'UI.DataField',
            Label: 'Resource Name',
            Value: resourceName,
        },
        ],
    },
    // UI.FieldGroup #i18nTimeframe         : {
    //     $Type: 'UI.FieldGroupType',
    //     Data : [
    //         {
    //             $Type: 'UI.DataField',
    //             Value: validFrom,
    //             Label: '{i18n>ValidFrom}',
    //         },
    //         {
    //             $Type: 'UI.DataField',
    //             Value: validTo,
    //             Label: '{i18n>ValidTo}',
    //         },
    //         {
    //             $Type: 'UI.DataField',
    //             Value: note,
    //             Label: '{i18n>Note}',
    //         },
    //     ],
    // },
    UI.HeaderInfo                        : {
        TypeName      : '{i18n>CostBreakdownStructure}',
        TypeNamePlural: '{i18n>CostBreakdownStructure}',
        Description   : {
            $Type: 'UI.DataField',
            Value: descr,
        },
        Title         : {
            $Type: 'UI.DataField',
            Value: name,
        },
        TypeImageUrl  : 'sap-icon://combine',
    },
);

annotate service.CostBreakDownHierarchies with {
    resourceName @(
        Common.Label                   : 'Resource Name',
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'ResourceHierarchies',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: resourceName,
                ValueListProperty: 'name',
            }, ],
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.CostBreakDownHierarchies with {
    descr @(
        Common.Label    : '{i18n>Description}',
        UI.MultiLineText: true,
    )
};

annotate service.CostBreakdownStructure with @(
    UI.LineItem #CostBreakdownStructure: [
        {
            $Type: 'UI.DataField',
            Value: code,
            Label: '{i18n>Code}',
        },
        {
            $Type: 'UI.DataField',
            Value: name,
            Label: '{i18n>Name}',
        },
        {
            $Type: 'UI.DataField',
            Value: descr,
            Label: '{i18n>Description}',
        },

    ],
    UI.Facets                          : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General Information',
            ID    : 'GeneralInformation',
            Target: '@UI.FieldGroup#GeneralInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Productivity Code',
            ID    : 'ProductivityCode',
            Target: 'resourceMaterials/@UI.LineItem#ProductivityCode',
        },
    ],
    UI.FieldGroup #GeneralInformation  : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: name,
                Label: 'Name',
            },
            {
                $Type: 'UI.DataField',
                Value: code,
                Label: 'Code',
            },
            {
                $Type: 'UI.DataField',
                Value: descr,
                Label: 'Description',
            },
            // {
            //     $Type: 'UI.DataField',
            //     Value: resourceMaterials.unitofMeasure,
            //     Label: 'UOM',
            // },
            // {
            //     $Type: 'UI.DataField',
            //     Value: resourceMaterials.labRate,
            //     Label: 'Lab Rate',
            // },
            // {
            //     $Type: 'UI.DataField',
            //     Value: resourceMaterials.EqpRate,
            //     Label: 'Eqp Rate',
            // },
            // {
            //     $Type: 'UI.DataField',
            //     Value: resourceMaterials.outputQTY,
            //     Label: 'Output QTY',
            // },

        // {
        //     $Type : 'UI.DataField',
        //     Value : cbshierarchy.resourceHierarchies.cbsHierarchies_ID,
        //     Label : 'cbsHierarchies_ID',
        // },
        ],
    },
    UI.HeaderInfo                      : {
        Title         : {
            $Type: 'UI.DataField',
            Value: name,
        },
        TypeName      : '',
        TypeNamePlural: '',
    },
);

annotate service.ResourceCategories with {
    ID
    @Common.Text           : name
    @Common.TextArrangement: #TextOnly;
};

annotate service.CostBreakdownStructure actions {
    addNode(
    @Common.Label                   : 'Type'
    @ParameterDefaultValue          : 'Node'
    @Common.ValueListWithFixedValues: true
    @Common.ValueList               : {
        CollectionPath: 'NodeTypeOptions',
        Parameters    : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: Type,
            ValueListProperty: 'name'
        }]
    }
    Type,

    @UI.Hidden                      : {$edmJson: {$Ne: [
        {$Path: 'Type'},
        'Product'
    ]}}

    @Common.Label                   : 'Products'

    @Common.ValueList               : {
        CollectionPath: 'ResourceMaterial',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: Products,
                ValueListProperty: 'ID'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'productName'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'unitofMeasure'
            }
        ]
    }
    Products,

    )
}

annotate service.CostBreakDownHierarchies with {
    note @UI.MultiLineText: true
};

annotate service.CBSResourceMaterial with @(
    UI.LineItem #ProductivityCode: [
        {
            $Type: 'UI.DataField',
            Value: productId,
            Label: 'Resource Id',
        },
        {
            $Type: 'UI.DataField',
            Value: productName,
            Label: 'Resource Name'
        },
        {
            $Type: 'UI.DataField',
            Value: productType,
            Label: 'Resource Type'
        },
        {
            $Type: 'UI.DataField',
            Value: quantity,
            Label: 'Qty'
        },
        {
            $Type: 'UI.DataField',
            Value: rate,
            Label: 'Rate'
        },
        {
            $Type: 'UI.DataField',
            Value: amount,
            Label: 'Amount'
        },
        {
            $Type        : 'UI.DataField',
            Value        : isOT,
            Label        : 'OT Justification',
            ![@UI.Hidden]: {$edmJson: {$If: [
                {$Or: [
                    {$Eq: [
                        {$Path: 'productType'},
                        'Manpower'
                    ]},
                    {$Eq: [
                        {$Path: 'productType'},
                        'Asset'
                    ]}
                ]},
                false,
                true
            ]}}
        },
        {
            $Type : 'UI.DataField',
            Value : unitofMeasure,
            Label : 'unitofMeasure',
        },
        {
            $Type : 'UI.DataField',
            Value : labRate,
            Label : 'labRate',
        },
        {
            $Type : 'UI.DataField',
            Value : EqpRate,
            Label : 'EqpRate',
        },
        {
            $Type : 'UI.DataField',
            Value : outputQTY,
            Label : 'outputQTY',
        },
    ],
    UI.CreateHidden              : true
);

annotate service.CbsTypeCompany with @(
    UI.LineItem #CompanyCodes: [
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
    UI.CreateHidden          : true
);

annotate service.ResourceHierarchies with {
    name @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'ResourceHierarchies',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: name,
                ValueListProperty: 'name',
            }, ],
            Label         : 'Resource Hierarchies',
        },
        Common.ValueListWithFixedValues: true,
    )
};

// annotate CostBreakdownStructureService.CostBreakDownHierarchies with {
//     resourceHierarchies @(
//         Common.ValueList : {
//             $Type : 'Common.ValueListType',
//             CollectionPath : 'ResourceHierarchies',
//             Parameters : [
//                 {
//                     $Type : 'Common.ValueListParameterOut',
//                     LocalDataProperty : resourceHierarchies_ID,
//                     ValueListProperty : 'ID',
//                 },
//                 // This parameter triggers the UI to send the company code to the backend
//                 {
//                     $Type : 'Common.ValueListParameterIn',
//                     LocalDataProperty : cbsTypeCompany.companyCode,
//                     ValueListProperty : 'ID' // We will intercept this in Java
//                 },
//                 {
//                     $Type : 'Common.ValueListParameterDisplayOnly',
//                     ValueListProperty : 'name',
//                 },
//             ],
//         }
//     );
// }

annotate service.ResourceHierarchies with {
    cbsHierarchies @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'ResourceTypeCompany',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: cbsHierarchies_ID,
                    ValueListProperty: 'companyCode',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'parent/name',
                    LocalDataProperty: name,
                },
            //              {
            //                     $Type : 'Common.ValueListParameterIn',
            //                     LocalDataProperty : cbsTypeCompany.companyCode,
            //                     ValueListProperty : 'ID' // We will intercept this in Java
            //              },
            ],
        },
        Common.ValueListWithFixedValues: true,
        Common.Text                    : name,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate service.CostBreakDownHierarchies with {
    ID @(
        Common.Text                    : name,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate service.CostBreakDownHierarchies with {
    company @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'company',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: company_CompanyCode,
                ValueListProperty: 'CompanyCode',
            }, ],
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.company with {
    CompanyCode @(
        Common.Text                    : CompanyCodeName,
        Common.Text.@UI.TextArrangement: #TextFirst,
    // Common.Text.@UI.TextArrangement : #TextOnly,
    )
};

annotate service.CostBreakDownHierarchies with {
    ID @UI.Hidden
};

annotate service.CostBreakDownHierarchies with {
    company @Common.Label: 'Company Code'
}

annotate service.CostBreakdownStructure with {
    code @Common.Label :'Code';
    name @Common.Label :'Name';
    descr @Common.Label :'Description';
}
