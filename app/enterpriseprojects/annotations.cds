using ProjectEnterpriseService as service from '../../srv/enterprise-project-service';
using from '../../db/projects/sales-order';
using from '../../db/projects/purchase-order';


annotate service.Projects with @(
    UI.SelectionFields                   : [
        project,
        projectDescription,
    ],
    UI.LineItem                          : [
        {
            $Type: 'UI.DataField',
            Value: project,
            Label: 'Project'
        },
        {
            $Type: 'UI.DataField',
            Value: projectDescription,
            Label: 'Project Description'
        },
        {
            $Type: 'UI.DataField',
            Value: projectStartDate,
            Label: 'Project Start Date',
        },
        {
            $Type: 'UI.DataField',
            Value: projectEndDate,
            Label: 'Project End Date',
        },
        {
            $Type: 'UI.DataField',
            Value: projectCurrency,
            Label: 'Project Currency',
        },
    ],
    UI.Facets                            : [
        {
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
                    Label : '{i18n>ProjectDetails}',
                    ID    : 'i18nProjectDetails',
                    Target: '@UI.FieldGroup#i18nProjectDetails',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'WBS Elements',
            ID    : 'WBSElements',
            Target: 'pjHierarchies/@UI.LineItem#WBSElements',
        },

        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Bill of Quantities',
            ID    : 'BOQFacet',
            Target: 'BOQs/@UI.LineItem#BOQs',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Sales Order',
            ID    : 'SalesOrder',
            Target: 'SalesOrders/@UI.LineItem#SalesOrder',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>PurchaseOrder}',
            ID    : 'i18nPurchaseOrder',
            Target: 'PurchaseOrders/@UI.LineItem#i18nPurchaseOrder',
        },
        // --- ADDED ATTACHMENTS TAB START ---
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Attachments}',
            ID    : 'AttachmentsFacet',
            Target: 'attachments/@UI.LineItem',
        },

    // --- ADDED ATTACHMENTS TAB END ---
    ],
    UI.FieldGroup #i18nGeneralInformation: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: project,
                Label: 'Project'
            },
            {
                $Type: 'UI.DataField',
                Value: projectDescription,
                Label: 'Project Description'
            },
            {
                $Type: 'UI.DataField',
                Value: projectStartDate,
                Label: 'Project Start Date'
            },
            {
                $Type: 'UI.DataField',
                Value: projectEndDate,
                Label: 'Project End Date'
            },
            {
                $Type: 'UI.DataField',
                Value: projectCurrency,
                Label: 'Project Currency'
            },
        ],
    },
    UI.FieldGroup #i18nProjectDetails    : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: advance,
                Label: '{i18n>Advance}'
            },
            {
                $Type: 'UI.DataField',
                Value: advancePaymentGuarantee,
                Label: '{i18n>AdvancePaymentGuarantee}'
            },
            {
                $Type: 'UI.DataField',
                Value: awardedDate,
                Label: '{i18n>AwardedDate}'
            },
            {
                $Type: 'UI.DataField',
                Value: defectLiability,
                Label: '{i18n>DefectLiability}'
            },
            {
                $Type: 'UI.DataField',
                Value: performanceSecurity,
                Label: '{i18n>PerformanceSecurity}'
            },
            {
                $Type: 'UI.DataField',
                Value: retention,
                Label: '{i18n>Retention}'
            },
            {
                $Type: 'UI.DataField',
                Value: status,
                Label: '{i18n>Status}'
            },
            {
                $Type: 'UI.DataField',
                Value: companyCode,
                Label: '{i18n>CompanyCode}',
            },
            {
                $Type: 'UI.DataField',
                Value: projectManager,
                Label: '{i18n>ProjectManager}',
            },
        ],
    },

    UI.HeaderInfo                        : {
        TypeName      : 'Enterprise Projects',
        TypeNamePlural: '{i18n>EnterpriseProjects}',
        Title         : {
            $Type: 'UI.DataField',
            Value: projectDescription
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: project
        },
        TypeImageUrl  : 'sap-icon://project-definition-triangle',
    },
);

annotate service.Projects with {
    projectDescription @Common.Label: '{i18n>ProjectDescription}'
};

annotate service.Projects with {
    project @Common.Label: '{i18n>Project}'
};

annotate service.ProjectPlanning with @(
    UI.LineItem #WBSElements     : [
        {
            $Type: 'UI.DataField',
            Value: projectElementDescription,
            Label: '{i18n>ProjectElementDescription}'
        },
        {
            $Type: 'UI.DataField',
            Value: plannedStartDate,
            Label: '{i18n>PlannedStartDate}'
        },
        {
            $Type: 'UI.DataField',
            Value: plannedEndDate,
            Label: '{i18n>PlannedEndDate}'
        },
        {
            $Type: 'UI.DataField',
            Value: costCenter,
            Label: '{i18n>CostCenter}'
        },
        {
            $Type: 'UI.DataField',
            Value: profitCenter,
            Label: '{i18n>ProfitCenter}'
        },
    ],
    UI.Facets                    : [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>WbsDetails}',
        ID    : 'i18nWbsDetails',
        Target: '@UI.FieldGroup#i18nWbsDetails'
    }, ],
    UI.FieldGroup #i18nWbsDetails: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: projectId,
                Label: '{i18n>ProjectId1}'
            },
            {
                $Type: 'UI.DataField',
                Value: projectElementDescription,
                Label: '{i18n>ProjectElementDescription2}'
            },
            {
                $Type: 'UI.DataField',
                Value: processingStatus,
                Label: '{i18n>ProcessingStatus}'
            },
            {
                $Type: 'UI.DataField',
                Value: plannedStartDate,
                Label: '{i18n>PlannedStartDate}'
            },
            {
                $Type: 'UI.DataField',
                Value: plannedEndDate,
                Label: '{i18n>PlannedEndDate}'
            },
            {
                $Type: 'UI.DataField',
                Value: profitCenter,
                Label: '{i18n>ProfitCenter}'
            },
            {
                $Type: 'UI.DataField',
                Value: costCenter,
                Label: '{i18n>CostCenter}'
            },
        ],
    },
    UI.HeaderInfo                : {
        Title         : {
            $Type: 'UI.DataField',
            Value: projectElementDescription
        },
        TypeName      : '',
        TypeNamePlural: '',
    },
);


annotate service.SalesOrder with @(
    UI.LineItem #SalesOrder             : [
        {
            $Type: 'UI.DataField',
            Value: SalesOrder,
            Label: '{i18n>SalesOrder}',
        },
        {
            $Type: 'UI.DataField',
            Value: Customer,
            Label: '{i18n>Customer}',
        },
        {
            $Type: 'UI.DataField',
            Value: CustomerReference,
            Label: '{i18n>CustomerReference}',
        },
        {
            $Type: 'UI.DataField',
            Value: SalesOrderType,
            Label: '{i18n>SalesOrderType}',
        },
        {
            $Type: 'UI.DataField',
            Value: OverallStatus,
            Label: '{i18n>OverallStatus}',
        },
        {
            $Type: 'UI.DataField',
            Value: PaymentTerms,
            Label: '{i18n>PaymentTerms}',
        },
        {
            $Type: 'UI.DataField',
            Value: NetValue,
            Label: '{i18n>NetValue}',
        },
    ],
    UI.Facets                           : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>SalesOrderDetails}',
            ID    : 'i18nSalesOrderDetails',
            Target: '@UI.FieldGroup#i18nSalesOrderDetails',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>SalesOrderItems}',
            ID    : 'i18nSalesOrderItems',
            Target: 'Items/@UI.LineItem#i18nSalesOrderItems',
        },
    ],
    UI.HeaderInfo                       : {
        TypeName      : 'Sales Order Item',
        TypeNamePlural: '{i18n>SalesOrderItem}',
        Title         : {
            $Type: 'UI.DataField',
            Value: SalesOrder,
        },
    },
    UI.FieldGroup #i18nSalesOrderDetails: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: SalesOrder,
                Label: '{i18n>SalesOrder}',
            },
            {
                $Type: 'UI.DataField',
                Value: Customer,
                Label: 'Customer',
            },
            {
                $Type: 'UI.DataField',
                Value: CustomerReference,
                Label: '{i18n>CustomerReference}',
            },
            {
                $Type: 'UI.DataField',
                Value: SalesOrderType,
                Label: '{i18n>SalesOrderType}',
            },
            {
                $Type: 'UI.DataField',
                Value: TotalNetAmount,
                Label: '{i18n>TotalNetAmount}',
            },
        ],
    },
);

annotate service.SalesOrderItem with @(
    UI.LineItem #i18nSalesOrderItems   : [
        {
            $Type: 'UI.DataField',
            Value: SalesOrderItem,
            Label: '{i18n>SalesOrderItem}',
        },
        {
            $Type: 'UI.DataField',
            Value: Product,
            Label: 'Product',
        },
        {
            $Type: 'UI.DataField',
            Value: RequestedQuantity,
            Label: '{i18n>RequestedQuantity}',
        },
        {
            $Type: 'UI.DataField',
            Value: ConfirmedQuanity,
            Label: '{i18n>ConfirmedQuanity}',
        },
        {
            $Type: 'UI.DataField',
            Value: NetAmount,
            Label: '{i18n>NetAmount}',
        },
    ],
    UI.LineItem #i18nPurchaseOrder     : [],
    UI.LineItem #i18nPurchaseOrderItems: [],
);

annotate service.PurchaseOrder with @(
    UI.LineItem #PurchaseOrder           : [
        {
            $Type: 'UI.DataField',
            Value: PurchaseOrder,
            Label: '{i18n>PurchaseOrder}',
        },
        {
            $Type: 'UI.DataField',
            Value: PurchaseOrderType,
            Label: '{i18n>PurchaseOrderType}',
        },
        {
            $Type: 'UI.DataField',
            Value: Supplier,
            Label: '{i18n>Supplier}',
        },
    ],
    UI.LineItem #i18nPurchaseOrder       : [
        {
            $Type: 'UI.DataField',
            Value: PurchaseOrder,
            Label: '{i18n>PurchaseOrder}',
        },
        {
            $Type: 'UI.DataField',
            Value: Supplier,
            Label: 'Supplier',
        },
        {
            $Type: 'UI.DataField',
            Value: company,
            Label: 'Company',
        },
        {
            $Type: 'UI.DataField',
            Value: PurchaseOrderDate,
            Label: '{i18n>PurchaseOrderDate}',
        },
        {
            $Type: 'UI.DataField',
            Value: netOrderValue,
            Label: '{i18n>NetOrderValue}',
        },
        {
            $Type: 'UI.DataField',
            Value: status,
            Label: '{i18n>Status}',
        },
    ],
    UI.Facets                            : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>PurchaseOrderItems}',
            ID    : 'i18nPurchaseOrderItems',
            Target: '@UI.FieldGroup#i18nPurchaseOrderItems',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>PurchaseOrder}',
            ID    : 'i18nPurchaseOrder',
            Target: 'Items/@UI.LineItem#i18nPurchaseOrder',
        },
    ],
    UI.HeaderInfo                        : {
        TypeName      : 'Purchase Order Items',
        TypeNamePlural: 'Purchase Order Items',
        Title         : {
            $Type: 'UI.DataField',
            Value: PurchaseOrder,
        },
    },
    UI.FieldGroup #i18nPurchaseOrderItems: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: PurchaseOrder,
                Label: '{i18n>PurchaseOrder}',
            },
            {
                $Type: 'UI.DataField',
                Value: PurchaseOrderDate,
                Label: '{i18n>PurchaseOrderDate}',
            },
            {
                $Type: 'UI.DataField',
                Value: Supplier,
                Label: 'Supplier',
            },
            {
                $Type: 'UI.DataField',
                Value: company,
                Label: '{i18n>Company}',
            },
            {
                $Type: 'UI.DataField',
                Value: netOrderValue,
                Label: '{i18n>NetOrderValue}',
            },
        ],
    },
);

annotate service.PurchaseOrderItem with @(UI.LineItem #i18nPurchaseOrder: [
    {
        $Type: 'UI.DataField',
        Value: PurchaseOrderItems,
        Label: '{i18n>PurchaseOrderItems}',
    },
    {
        $Type: 'UI.DataField',
        Value: Product,
        Label: 'Product',
    },
    {
        $Type: 'UI.DataField',
        Value: PurchasedQuantity,
        Label: '{i18n>PurchasedQuantity}',
    },
    {
        $Type: 'UI.DataField',
        Value: SalesItemContract,
        Label: '{i18n>SalesItemContract}',
    },
]);

annotate service.Projects with {
    company_CompanyCode @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Companies',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: company_CompanyCode,
                ValueListProperty: 'CompanyCode',
            }, ],
            Label         : 'Select Company Code',
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.Companies with {
    CompanyCode @Common.Text: CompanyCodeName
};

annotate service.Projects with {
    companyCode @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Companies',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: companyCode,
                ValueListProperty: 'CompanyCode',
            }, ],
            Label         : 'Add Company Code',
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.BillofQuantityHeader with @(

    UI.LineItem #BOQs        : [
        {
            $Type: 'UI.DataField',
            Value: vrNo,
            Label: 'VR No',
        },
        {
            $Type: 'UI.DataField',
            Value: boqType.code,
            Label: 'BOQ Type',
        },
        {
            $Type: 'UI.DataField',
            Value: projectName,
            Label: 'Project Name',
        },
        {
            $Type: 'UI.DataField',
            Value: startSrNo,
            Label: 'Start Sr No',
        },
    ],

    UI.Facets                : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General Information',
            ID    : 'BOQGenInfo',
            Target: '@UI.FieldGroup#BOQGenInfo',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'BOQ Items',
            ID    : 'BOQItemsList',
            Target: 'bqHeaderHierarchies/@UI.LineItem#BOQItemsInProject',
        },
    ],

    UI.FieldGroup #BOQGenInfo: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: vrNo,
                Label: 'VR No',
            },
            {
                $Type: 'UI.DataField',
                Value:  boqType.code,
                Label: 'BOQ Type',
            },
            {
                $Type: 'UI.DataField',
                Value: projectName,
                Label: 'Project Name',
            },
            {
                $Type: 'UI.DataField',
                Value: startSrNo,
                Label: 'Start Sr No',
            },
            {
                $Type: 'UI.DataField',
                Value: company_CompanyCode,
                Label: 'Company Code',
            },
            {
                $Type: 'UI.DataField',
                Value: description,
                Label: 'Description',
            },
            {
                $Type: 'UI.DataField',
                Value: quantity,
                Label: 'Quantity',
            },
        ],
    },

    UI.HeaderInfo            : {
        TypeName      : 'Bill of Quantity',
        TypeNamePlural: 'Bill of Quantities',
        Title         : {
            $Type: 'UI.DataField',
            Value: vrNo
        },
        Description   : {
            $Type: 'UI.DataField',
            Value:  boqType.code
        },
    },
);

annotate service.BillofQuantityItem with @(UI.LineItem #BOQItemsInProject: [
    {
        $Type: 'UI.DataField',
        Value: item,
        Label: 'Item',
    },
    {
        $Type: 'UI.DataField',
        Value: description,
        Label: 'Description',
    },
    {
        $Type: 'UI.DataField',
        Value: unitOfMeasurement,
        Label: 'Unit Of Measurement',
    },
    {
        $Type: 'UI.DataField',
        Value: quantity,
        Label: 'Quantity',
    },
    {
        $Type: 'UI.DataField',
        Value: wbsElement_ID,
        Label: 'WBS Element',
    },
], );
