using ResourceServices as service from '../../srv/resource-type-service';
using from '../../srv/project-budget-service';
using from '../../db/projects/project-budget';
using from '../../db/billofquantities/bill-of-quantity';


annotate ProjectBudgetService.ProjectBudget with @(Common.SideEffects: {
    SourceProperties: [boq_ID],
    TargetEntities  : [WbsItems]
});

annotate ProjectBudgetService.ProjectBudget with @(
    UI.SelectionFields                    : [
        project_ID,
        vrNo,
    ],
    UI.LineItem                           : [
        {
            $Type: 'UI.DataField',
            Value: project_ID,
        },
        {
            $Type: 'UI.DataField',
            Value: vrNo,
        },
    ],
    UI.Facets                             : [
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>Overview}',
            ID    : 'i18nOverview',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>ProjectDetails}',
                    ID    : 'i18nGeneralInformation',
                    Target: '@UI.FieldGroup#i18nGeneralInformation',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>GeneralInformation}',
                    ID    : 'i18nGeneralInformation1',
                    Target: '@UI.FieldGroup#i18nGeneralInformation1',
                },
            ],
        },
        // {
        //     $Type : 'UI.ReferenceFacet',
        //     Label : 'WBS List',                             ////for demo purpose
        //     ID : 'WBSList',
        //     Target : 'WbsItems/@UI.LineItem#WBSList',
        // },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'WBS Items',
            ID : 'WBSItems',
            Target : 'WbsItems/@UI.LineItem#WBSItems',
        },
    ],
    UI.FieldGroup #i18nGeneralInformation : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: company,
                Label: '{i18n>CompanyCode}',
            },
            {
                $Type: 'UI.DataField',
                Value: project_ID,
                Label: '{i18n>Project}',
            },
            {
                $Type: 'UI.DataField',
                Value: boq_ID,
                Label: 'BOQ',
            },
            {
                $Type: 'UI.DataField',
                Value: vrNo,
                Label: '{i18n>VrNo1}',
            },
        ],
    },
    UI.FieldGroup #i18nGeneralInformation1: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: type_Code,
                Label: '{i18n>Type}',
            },
            {
                $Type: 'UI.DataField',
                Value: refCode,
                Label: 'Reference Code',
            },
            {
                $Type: 'UI.DataField',
                Value: revision,
                Label: '{i18n>Revision}',
            },
            {
                $Type: 'UI.DataField',
                Value: description,
                Label: '{i18n>Description}',
            },
        ],
    },
    UI.HeaderInfo                         : {
        TypeName      : 'Project Budget',
        TypeNamePlural: '{i18n>ProjectDetails}',
        Title         : {
            $Type: 'UI.DataField',
            Value: project_ID,
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: vrNo,
        },
    },
);

//  Project value help
annotate ProjectBudgetService.ProjectBudget with {
    project @(
        Common.Label                   : '{i18n>Project}',
        Common.Text                    : project.projectDescription,
        Common.Text.@UI.TextArrangement: #TextOnly,
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Projects',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: project_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'projectDescription',
                },
                {
                    $Type            : 'Common.ValueListParameterIn',
                    ValueListProperty: 'companyCode',
                    LocalDataProperty: company,
                },
            ],
        },
    )
};

annotate ProjectBudgetService.ProjectBudget with {
    vrNo        @Common.Label    : '{i18n>VrNo1}';
    description @UI.MultiLineText: true;
};

// Company value help
annotate ProjectBudgetService.ProjectBudget with {
    company @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'company',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: company,
                ValueListProperty: 'CompanyCode',
            }],
            Label         : '{i18n>SelectCompanyCode}',
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate ProjectBudgetService.company with {
    CompanyCode @Common.Text: CompanyCodeName
};

//  BOQ value help filtered by project
annotate ProjectBudgetService.ProjectBudget with {
    boq @(
        Common.Label                   : 'BOQ',
        Common.Text                    : boq.vrNo,
        Common.Text.@UI.TextArrangement: #TextOnly,
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'BillofQuantityHeader',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: boq_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterIn',
                    LocalDataProperty: project_ID,
                    ValueListProperty: 'project_ID',
                },
                {
                    $Type : 'Common.ValueListParameterOut',
                    ValueListProperty : 'vrNo',
                    LocalDataProperty : vrNo,
                },
            ],
        },
        Common.ValueListWithFixedValues: false,
    )
};

annotate ProjectBudgetService.BillofQuantityHeader with {
    ID @(
        Common.Text                    : vrNo,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate ProjectBudgetService.BillofQuantityItems with @(
    UI.LineItem #WBSList : [
        {
            $Type : 'UI.DataField',
            Value : wbsElement.projectElementDescription,
            Label : 'WBS Element',
        },
        {
            $Type : 'UI.DataField',
            Value : description,
            Label : 'Description',
        },
        {
            $Type : 'UI.DataField',
            Value : quantity,
            Label : 'Quantity',
        },
        {
            $Type : 'UI.DataField',
            Value : boqcbs.descr,
            Label : 'CBS',
        },
      
        {
            $Type : 'UI.DataField',
            Value : boqResource.descr,
            Label : 'Resource',
        },
        {
            $Type : 'UI.DataField',
            Value : unitPrice,
            Label : 'Unit Price',
        },
        {
            $Type : 'UI.DataField',
            Value : actualQuantity,
            Label : 'Actual Quantity',
        },
        {
            $Type : 'UI.DataField',
            Value : actualAmount,
            Label : 'Actual Amount',
        },
        {
            $Type : 'UI.DataField',
            Value : budgetQuantity,
            Label : 'Budget Quantity',
        },
        {
            $Type : 'UI.DataField',
            Value : budgetAmount,
            Label : 'Budget Amount',
        },
    ],
    UI.LineItem #WBSList1 : [
    ],
);


annotate ProjectBudgetService.Wbs with {
    projectElementDescription @Common.FieldControl : #ReadOnly
};

annotate ProjectBudgetService.BillofQuantityItems with {
    quantity @Common.FieldControl : #ReadOnly
};

annotate ProjectBudgetService.BoqCbs with {
    descr @Common.FieldControl : #ReadOnly
};

annotate ProjectBudgetService.BoqResource with {
    descr @Common.FieldControl : #ReadOnly
};

annotate ProjectBudgetService.ProjectBudget with {
    type @Common.ValueListWithFixedValues : true
};

annotate ProjectBudgetService.BudgetType with {
    Code @Common.Text : name
};

annotate ProjectBudgetService.ProjectBudgetResources with @(
    UI.LineItem #WBSItems : [
        {
            $Type : 'UI.DataField',
            Value : wbsElement,
            Label : 'Wbs Element',
        },
        {
            $Type : 'UI.DataField',
            Value : description,
            Label : 'Description',
        },
        {
            $Type : 'UI.DataField',
            Value : UOM,
            Label : 'UOM',
        },
        {
            $Type : 'UI.DataField',
            Value : quantity,
            Label : 'Quantity',
        },
        {
            $Type : 'UI.DataField',
            Value : cbs,
            Label : 'CBS',
        },
        {
            $Type : 'UI.DataField',
            Value : resource,
            Label : 'Resource',
        },
        {
            $Type : 'UI.DataField',
            Value : unitPrice,
            Label : 'Unit Price',
        },
        {
            $Type : 'UI.DataField',
            Value : budgetQuantity,
            Label : 'Budget Quantity',
        },
        {
            $Type : 'UI.DataField',
            Value : budgetAmount,
            Label : 'Budget Amount',
        },
        {
            $Type : 'UI.DataField',
            Value : actualQuantity,
            Label : 'Actual Quantity',
        },
        {
            $Type : 'UI.DataField',
            Value : actualAmount,
            Label : 'Actual Amount',
        },
    ]
);

