using ProductivityRateService as service from '../../srv/productivity-rate-service';

annotate service.ProductivityRates with @(
    UI.FieldGroup #GeneratedGroup             : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Company Code',
                Value: company_CompanyCode,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Resource Type',
                Value: resourceType_code,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Resource Description',
                Value: resourceDescription,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Resource Code',
                Value: resourceCode,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Activity Free Text',
                Value: activityFreeText,
            },
            {
                $Type: 'UI.DataField',
                Label: 'LinkedCbs Activity',
                Value: linkedCbsActivity,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Status',
                Value: status_code,
            },
        ],
    },
    UI.Facets                                 : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'Identification',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Productivity',
            ID    : 'Productivity',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Productivity',
                    ID    : 'Productivity1',
                    Target: '@UI.FieldGroup#Productivity',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Resource',
                    ID    : 'Resource',
                    Target: 'productivities/@UI.LineItem#Resource',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Effective dates & applicability',
            ID    : 'Effectivedatesapplicability',
            Target: '@UI.FieldGroup#Effectivedatesapplicability',
        },
    ],
    UI.LineItem                               : [
        {
            $Type: 'UI.DataField',
            Label: 'Company Code',
            Value: company_CompanyCode,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Resource Code',
            Value: resourceCode,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Resource Description',
            Value: resourceDescription,
        },

    ],
    UI.FieldGroup #Productivity               : {
        $Type: 'UI.FieldGroupType',
        Data : [
             {
                $Type : 'UI.DataField',
                Value : productivities.outputUOM_code,
                Label : 'Output UOM',
            },            
            {
                $Type: 'UI.DataField',
                Value: productivities.outputHour,
                Label: 'Output Hour',
            },
            {
                $Type: 'UI.DataField',
                Value: productivities.output,
                Label: 'Output',
            },
           
        ],
    },
    UI.FieldGroup #Effectivedatesapplicability: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: datesApplicability.effectiveFrom,
                Label: 'Effective From',
            },
            {
                $Type: 'UI.DataField',
                Value: datesApplicability.effectiveTo,
                Label: 'Effective To',
            },
            {
                $Type: 'UI.DataField',
                Value: datesApplicability.applicability_code,
                Label: 'Applicability',
            },
            {
                $Type: 'UI.DataField',
                Value: datesApplicability.notes,
                Label: 'Notes',
            },
        ],
    },
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : linkedCbsActivity,
        },
        TypeName : 'Productivity-Rate',
        TypeNamePlural : 'Productivity-Rate',
        Description : {
            $Type : 'UI.DataField',
            Value : company_CompanyCode,
        },
    },
);

annotate service.ProductivityRates with {
    company @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'company',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: company_CompanyCode,
                ValueListProperty: 'CompanyCode',
            },
            {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'CompanyCodeName',
                },],
        },
        Common.ValueListWithFixedValues: false,
    )
};

annotate service.Productivity with @(UI.LineItem #Resource: [
    {
        $Type : 'UI.DataField',
        Value : cbsRresource_ID,
        Label : 'Product Name',
    },
 ]);

annotate service.DatesApplicability with {
    notes @UI.MultiLineText: true
};

annotate service.ProductivityRates with {
    resourceType @Common.ValueListWithFixedValues: true
};

annotate service.ProductivityRates with {
    status @Common.ValueListWithFixedValues: true
};

annotate service.DatesApplicability with {
    applicability @Common.ValueListWithFixedValues: true
};

annotate service.ProductivityRates with {
    linkedCbsActivity @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Cbs',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: linkedCbsActivity,
                ValueListProperty: 'name',
            },
                {
                    $Type : 'Common.ValueListParameterIn',
                    ValueListProperty : 'resourceMaterials/productType',
                    LocalDataProperty : resourceType_code,
                },
                {
                    $Type : 'Common.ValueListParameterOut',
                    ValueListProperty : 'resourceMaterials/productName',
                    LocalDataProperty : productivities.productivity,
                }, ],
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.Cbs with {
    name @Common.Text: descr
};
// annotate service.Productivity with @(Common.SideEffects: {
//     SourceProperties: ['linkedCbsActivity'],
//     TargetProperties: ['productivities']
// });
// annotate service.ProductivityRates with @(Common.SideEffects #ProductivityUpdate: {
//     SourceProperties: [linkedCbsActivity],
//     TargetEntities  : [productivities] 
//     // Using TargetEntities is more robust when updating child items in a table
// });
annotate service.ProductivityRates with @(Common.SideEffects: {
    SourceProperties: [linkedCBS],
    TargetEntities  : [productivities] 
});
annotate service.Productivity with {
    outputUOM @(
        Common.ValueListWithFixedValues : true,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'OutputUOM',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : outputUOM_code,
                    ValueListProperty : 'name',
                },
            ],
        },
    )
};

annotate service.ProductivityRates with {
    linkedCBS @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Cbs',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : linkedCBS_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterIn',
                    ValueListProperty : 'resourceMaterials/productType',
                    LocalDataProperty : resourceType_code,
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

annotate service.Cbs with {
    ID @(
        Common.Text : name,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate service.Productivity with {
    cbsRresource @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'CbsResourceMaterial',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : cbsRresource_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterIn',
                    ValueListProperty : 'cbsNode/name',
                    LocalDataProperty : parent.linkedCbsActivity,
                },
            ],
        },
        Common.ValueListWithFixedValues : false,
        Common.Text : cbsRresource.productName,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate service.CbsResourceMaterial with {
    ID @(
        Common.Text : productName,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

