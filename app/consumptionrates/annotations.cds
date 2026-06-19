using ConsumptionRateService as service from '../../srv/consumption-rates-service';

annotate service.ConsumptionRates with @(
    UI.FieldGroup #GeneratedGroup                 : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Company',
                Value: company_CompanyCode,
            },

            {
                $Type: 'UI.DataField',
                Label: '{i18n>Material}',
                Value: materialId,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Linked CBS',
                Value: linkedCBS,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Material Description',
                Value: materialDescription,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Material Class',
                Value: materialClass_code,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Activity',
                Value: activity,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Output UOM',
                Value: outputUOM,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Theoretical',
                Value: theoretical,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Cons UOM',
                Value: consUOM,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Wastage %',
                Value: wastagePercent,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Net Rate',
                Value: netRate,
            },

            {
                $Type: 'UI.DataField',
                Label: 'Notes',
                Value: notes,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Product Type',
                Value: productType,
            },

        ],
    },
    UI.Facets                                     : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'Identification',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Theoretical Net ',
            ID    : 'i18nTheoretical',
            Target: '@UI.FieldGroup#i18nTheoretical',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>EffectiveDatesApplicability}',
            ID    : 'i18nEffectiveDatesApplicability',
            Target: '@UI.FieldGroup#i18nEffectiveDatesApplicability',
        },
    ],
    UI.LineItem                                   : [
        {
            $Type: 'UI.DataField',
            Label: 'Company',
            Value: company_CompanyCode,
        },
        {
            $Type: 'UI.DataField',
            Value: linkedCBS,
            Label: 'Linked CBS',
        },
        {
            $Type: 'UI.DataField',
            Label: 'Material Description',
            Value: materialDescription,
        },
        // {
        //     $Type: 'UI.DataField',
        //     Label: 'Resource Code',
        //     Value: resourceCode,
        // },
        {
            $Type: 'UI.DataField',
            Value: activity,
            Label: 'Activity',
        },

        {
            $Type: 'UI.DataField',
            Value: outputUOM,
            Label: 'Output UOM',
        },
        {
            $Type: 'UI.DataField',
            Value: theoretical,
            Label: 'Theoretical',
        },
        {
            $Type: 'UI.DataField',
            Value: consUOM,
            Label: 'Cons UOM',
        },
        {
            $Type: 'UI.DataField',
            Value: wastagePercent,
            Label: 'Wastage %',
        },
        {
            $Type: 'UI.DataField',
            Value: netRate,
            Label: 'Net Rate',
        },
        {
            $Type: 'UI.DataField',
            Value: notes,
            Label: 'Notes',
        },
    ],
    UI.SelectionFields                            : [
        linkedCBS,
        status,
    ],
    UI.HeaderInfo                                 : {
        Title         : {
            $Type: 'UI.DataField',
            Value: materialDescription,
        },
        TypeName      : '',
        TypeNamePlural: '',
        Description   : {
            $Type: 'UI.DataField',
            Value: materialDescription,
        },
    },
    UI.FieldGroup #i18nTheoretical                : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: outputUOM,
                Label: '{i18n>OutputUom}',
            },
            {
                $Type: 'UI.DataField',
                Value: theoretical,
                Label: '{i18n>Theoretical}',
            },
            {
                $Type: 'UI.DataField',
                Value: consUOM,
                Label: '{i18n>ConsUom}',
            },
            {
                $Type: 'UI.DataField',
                Value: wastagePercent,
                Label: '{i18n>Wastage}',
            },
            {
                $Type: 'UI.DataField',
                Value: netRate,
                Label: '{i18n>NetRate}',
            },
            {
                $Type: 'UI.DataField',
                Value: varianceThreshold,
                Label: 'Variance Threshold',
            },
            {
                $Type: 'UI.DataField',
                Value: mosCap,
                Label: 'Mos Cap',
            },
        ],
    },
    UI.FieldGroup #i18nEffectiveDatesApplicability: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: effectiveFrom,
                Label: '{i18n>EffectiveFrom}',
            },
            {
                $Type: 'UI.DataField',
                Value: effectiveTo,
                Label: '{i18n>EffectiveTo}',
            },
            {
                $Type: 'UI.DataField',
                Value: applicability,
                Label: 'Applicability',
            },
            {
                $Type: 'UI.DataField',
                Value: notes,
                Label: 'Notes',
            },
        ],
    },
);

annotate service.ConsumptionRates with {
    linkedCBS @Common.Label: 'linkedCBS'
};

annotate service.ConsumptionRates with {
    status @Common.Label: 'status'
};

annotate service.ConsumptionRates with {
    company_CompanyCode @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Companies',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: company_CompanyCode,
                ValueListProperty: 'CompanyCode'
            }],
            Label         : '{i18n>SelectCompanyCode}'
        },
        Common.ValueListWithFixedValues: true
    );

};

annotate service.Companies with {
    CompanyCode @Common.Text: CompanyCodeName
};
annotate service.ConsumptionRates with {
    materialClass @Common.ValueListWithFixedValues: true
};
annotate service.MaterialClassKey with {
    code @Common.Text                    : name
         @Common.Text.@UI.TextArrangement: #TextOnly
};
annotate service.ConsumptionRates with {
    materialId @Common.Label: 'Material';
};

annotate service.ConsumptionRates with {
    materialId @(
        Common.Text                    : materialDescription,
        Common.Text.@UI.TextArrangement: #TextOnly,
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'CBS_Materials',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: materialId,
                    ValueListProperty: 'productId',
                },
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: materialDescription,
                    ValueListProperty: 'productName',
                },
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: productType,
                    ValueListProperty: 'productType',
                },
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: consUOM,
                    ValueListProperty: 'unitofMeasure',
                },
                {
                    $Type            : 'Common.ValueListParameterIn',
                    LocalDataProperty: linkedCBS,
                    ValueListProperty: 'cbsName',
                },
            ],
        },
        Common.ValueListWithFixedValues: false
    );
};

annotate service.ConsumptionRates with @(Common.SideEffects #MaterialRefresh: {
    SourceProperties: [linkedCBS],
    TargetProperties: [materialId]
});

annotate service.ConsumptionRates with {
    linkedCBS @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'CBS_CostBreakdownStructure',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: linkedCBS,
                    ValueListProperty: 'name',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'descr',
                },
            ],
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.CBS_CostBreakdownStructure with {
    name @Common.Text                    : descr
         @Common.Text.@UI.TextArrangement: #TextFirst
};
