using CustomerPaymentService as service from '../../srv/customer-payment-application';
using from '../../db/payment/customer-payment-application';


annotate service.Customer with @(
    UI.SelectionFields               : [
        company,
        project_ID,
        certificateNumber,
    ],
    UI.LineItem                      : [
        {
            $Type: 'UI.DataField',
            Value: applicationID,
            Label: 'Application ID',
        },
        {
            $Type: 'UI.DataField',
            Value: company,
        },
        {
            $Type: 'UI.DataField',
            Value: project_ID,
        },
    ],
    UI.HeaderInfo                    : {
        TypeName      : '{i18n>CustomerPaymentApplication}',
        TypeNamePlural: 'Customer Payment Application',
        Title         : {
            $Type: 'UI.DataField',
            Value: project_ID,
        },
    },
    UI.Facets                        : [
        // {
        //     $Type : 'UI.ReferenceFacet',
        //     Label : 'Basic Details',
        //     ID    : 'i18nBasicDetails',
        //     Target: '@UI.FieldGroup#i18nBasicDetails',
        // },
        // {
        //     $Type : 'UI.ReferenceFacet',
        //     Label : 'Sales Order Items',
        //     ID    : 'SalesOrderItems',
        //     Target: 'salesOrderItems/@UI.LineItem#SalesOrderItems',
        // },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Application Details',
            ID    : 'ApplicationDetails',
            Target: '@UI.FieldGroup#ApplicationDetails',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Customer Details',
            ID : 'Customer',
            Target : '@UI.FieldGroup#Customer',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Previous',
            ID    : 'Previous',
            Target: 'previousTable/@UI.LineItem#Previous',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Current Period',
            ID    : 'CurrentPeriod',
            Target: 'CurrentPeriodTable/@UI.LineItem#CurrentPeriod',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Cumulative',
            ID    : 'Cumulative',
            Target: 'CumulativeTable/@UI.LineItem#Cumulative',
        },
        // {
        //     $Type : 'UI.ReferenceFacet',
        //     Label : 'Contract',
        //     ID    : 'BOQ',
        //     Target: '@UI.FieldGroup#BOQ',
        // },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Boq Items',
            ID : 'BoqItems',
            Target : 'boqItems/@UI.LineItem#BoqItems1',
        },
        
    ],
    // UI.FieldGroup #i18nBasicDetails  : {
    //     $Type: 'UI.FieldGroupType',
    //     Data : [
    //         {
    //             $Type: 'UI.DataField',
    //             Value: company,
    //             Label: 'Company',
    //         },
    //         {
    //             $Type: 'UI.DataField',
    //             Value: project_ID,
    //             Label: 'Project',
    //         },
    //         {
    //             $Type: 'UI.DataField',
    //             Value: boq_ID,
    //             Label: 'BOQ',
    //         },
    //         {
    //             $Type: 'UI.DataField',
    //             Value: salesOrder_ID,
    //             Label: 'Sales Order',
    //         },
    //     ],
    // },
    UI.FieldGroup #ApplicationDetails: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: vrNumber,
                Label: 'Vr.Number',
            },
            {
                $Type: 'UI.DataField',
                Value: uptoDate,
                Label: 'Upto Date',
            },
            {
                $Type: 'UI.DataField',
                Value: project_ID,
            },
             {
                $Type : 'UI.DataField',
                Value : boq_ID,
                Label: 'BOQ',
            },
            {
                $Type: 'UI.DataField',
                Value: certificateNumber,
                Label: 'Certificate Number',
            },
            {
                $Type: 'UI.DataField',
                Value: revisionDate,
                Label: 'Revision Date',
            },
            {
                $Type: 'UI.DataField',
                Value: submittedDate,
                Label: 'Submitted Date',
            },
            {
                $Type: 'UI.DataField',
                Value: expectedDate,
                Label: 'Expected Date',
            },
            {
                $Type: 'UI.DataField',
                Value: certifiedDate,
                Label: 'Certified Date',
            },
            {
                $Type: 'UI.DataField',
                Value: certificatePayment,
                Label: 'Certificate Payment',
            },
            {
                $Type: 'UI.DataField',
                Value: currency,
                Label: 'Currency',
            },
            {
                $Type: 'UI.DataField',
                Value: claimNumber,
                Label: 'ClaimNumber',
            },
        ],
    },
    UI.FieldGroup #Customer : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : startDate,
                Label : 'Start Date',
            },
            {
                $Type : 'UI.DataField',
                Value : dueDate,
                Label : 'Due Date',
            },
            {
                $Type : 'UI.DataField',
                Value : paStart,
                Label : 'PA Start',
            },
            {
                $Type : 'UI.DataField',
                Value : paEnd,
                Label : 'PA End',
            },
            {
                $Type : 'UI.DataField',
                Value : orderNumber,
                Label : 'Order Number',
            },
            {
                $Type : 'UI.DataField',
                Value : orderType,
                Label : 'Order Type',
            },
            {
                $Type : 'UI.DataField',
                Value : customer,
                Label : 'Customer',
            },
            {
                $Type : 'UI.DataField',
                Value : retention,
                Label : 'Retention',
            },
            {
                $Type : 'UI.DataField',
                Value : overallStatus,
                Label : 'Overall Status',
            },
            {
                $Type : 'UI.DataField',
                Value : contractAmount,
                Label : 'Contract Amount',
            },
        ],
    },
);

annotate service.Customer with {
    project @(
        Common.Label                   : '{i18n>Project}',
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
        Common.ValueListWithFixedValues: false,
        Common.Text                    : project.projectDescription,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate service.Customer with {
    ID @UI.Hidden;
};

annotate service.Companies with {
    CompanyCode @Common.Text: CompanyCodeName
};

annotate service.Customer with {
    company @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Companies',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: company,
                ValueListProperty: 'CompanyCode',
            }],
            Label         : 'Company Code',
        },
        Common.ValueListWithFixedValues: true,
        Common.Label                   : '{i18n>Company}',
    )
};

annotate service.Customer with {
    boq @(
        Common.Label                   : 'BOQ',
        Common.Text                    : boq.vrNo,
        Common.Text.@UI.TextArrangement: #TextOnly,

        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Boq',

            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: boq_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'vrNo'
                },
                {
                    $Type            : 'Common.ValueListParameterIn',
                    LocalDataProperty: project_ID,
                    ValueListProperty: 'project_ID'
                },
            ]
        }
    );
};

annotate service.Boq with {
    vrNo @Common.Label: 'BOQ';
};

annotate service.Projects with {
    ID @(
        Common.Text                    : projectDescription,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate service.Customer with {
    salesOrder @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'SalesOrders',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: salesOrder_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterIn',
                    LocalDataProperty: project_ID,
                    ValueListProperty: 'Project_ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'SalesOrder',
                },
            ],
        },
        Common.ValueListWithFixedValues: false,
        Common.Text                    : salesOrder.SalesOrder,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate service.SalesOrders with {
    ID @UI.Hidden;
};

annotate service.Boq with {
    ID @UI.Hidden;
};

// annotate service.Customer with @(Common.SideEffects #SalesOrderChanged: {
//     SourceProperties: [salesOrder_ID],
//     TargetEntities  : [salesOrderItems],
// });


// annotate service.SalesOrderItems with @(
//     UI.LineItem #SalesOrderItems: [
//         {
//             $Type: 'UI.DataField',
//             Value: SalesOrderItem,
//             Label: 'Item'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: SalesOrderItemText,
//             Label: 'Description'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: Product,
//             Label: 'Product'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: ProductDescription,
//             Label: 'Product Description'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: RequestedQuantity,
//             Label: 'Quantity'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: RequestedQuantitySAPUnit,
//             Label: 'Unit'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: NetAmount,
//             Label: 'Net Amount'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: transactioncurrency,
//             Label: 'Currency'
//         },
//     ],
//     UI.HeaderInfo               : {
//         Title         : {
//             $Type: 'UI.DataField',
//             Value: SalesOrder
//         },
//         TypeName      : '',
//         TypeNamePlural: '',
//         Description   : {
//             $Type: 'UI.DataField',
//             Value: SalesOrderItemCategory
//         },
//     },
//     UI.Facets                   : [
//         {
//             $Type : 'UI.ReferenceFacet',
//             Label : 'Header',
//             ID    : 'SOIHeader',
//             Target: '@UI.FieldGroup#SOIHeader',
//         },
//         {
//             $Type : 'UI.ReferenceFacet',
//             Label : 'BOQ Items',
//             ID    : 'SOIBOQItems',
//             Target: 'wbsboqItems/@UI.LineItem#SOIBOQItems',
//         },
//         {
//             $Type : 'UI.ReferenceFacet',
//             Label : 'Previous',
//             ID    : 'SOIPrevious',
//             Target: 'paymentHistory/@UI.LineItem#SOIPrevious',
//         },
//         {
//             $Type : 'UI.ReferenceFacet',
//             Label : 'Current Period',
//             ID    : 'SOICurrent',
//             Target: 'paymentCurrent/@UI.LineItem#SOICurrent',
//         },
//     ],
//     UI.FieldGroup #SOIHeader    : {
//         $Type: 'UI.FieldGroupType',
//         Data : [
//             {
//                 $Type: 'UI.DataField',
//                 Value: SalesOrder,
//                 Label: 'Sales Order'
//             },
//             {
//                 $Type: 'UI.DataField',
//                 Value: SalesOrderItem,
//                 Label: 'Item'
//             },
//             {
//                 $Type: 'UI.DataField',
//                 Value: SalesOrderItemCategory,
//                 Label: 'Category'
//             },
//             {
//                 $Type: 'UI.DataField',
//                 Value: SalesOrderItemText,
//                 Label: 'Description'
//             },
//             {
//                 $Type: 'UI.DataField',
//                 Value: Product,
//                 Label: 'Product'
//             },
//             {
//                 $Type: 'UI.DataField',
//                 Value: ProductDescription,
//                 Label: 'Product Description'
//             },
//             {
//                 $Type: 'UI.DataField',
//                 Value: RequestedQuantity,
//                 Label: 'Requested Qty'
//             },
//             {
//                 $Type: 'UI.DataField',
//                 Value: RequestedQuantitySAPUnit,
//                 Label: 'Unit'
//             },
//             {
//                 $Type: 'UI.DataField',
//                 Value: RequestedDeliveryDate,
//                 Label: 'Requested Delivery'
//             },
//             {
//                 $Type: 'UI.DataField',
//                 Value: ConfirmedDeliveryDate,
//                 Label: 'Confirmed Delivery'
//             },
//             {
//                 $Type: 'UI.DataField',
//                 Value: NetAmount,
//                 Label: 'Net Amount'
//             },
//             {
//                 $Type: 'UI.DataField',
//                 Value: transactioncurrency,
//                 Label: 'Currency'
//             },
//         ],
//     },
// );

// annotate service.SalesOrderItems with {
//     SalesOrder               @Common.FieldControl: #ReadOnly;
//     SalesOrderItemCategory   @Common.FieldControl: #ReadOnly;
//     SalesOrderItem           @Common.FieldControl: #ReadOnly;
//     SalesOrderItemText       @Common.FieldControl: #ReadOnly;
//     Product                  @Common.FieldControl: #ReadOnly;
//     ProductDescription       @Common.FieldControl: #ReadOnly;
//     RequestedQuantity        @Common.FieldControl: #ReadOnly;
//     RequestedQuantitySAPUnit @Common.FieldControl: #ReadOnly;
//     RequestedDeliveryDate    @Common.FieldControl: #ReadOnly;
//     ConfirmedDeliveryDate    @Common.FieldControl: #ReadOnly;
//     NetAmount                @Common.FieldControl: #ReadOnly;
//     transactioncurrency      @Common.FieldControl: #ReadOnly;
// };

 annotate service.BillofQuantityItems with @(
//     UI.LineItem #SOIBOQItems: [
//         {
//             $Type: 'UI.DataField',
//             Value: boqNo,
//             Label: 'BOQ No'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: budgetAmount,
//             Label: 'Budget Amount'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: budgetQuantity,
//             Label: 'Budget Quantity'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: actualQuantity,
//             Label: 'Actual Quantity'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: actualAmount,
//             Label: 'Actual Amount'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: advance,
//             Label: 'Advance'
//         },
//     ],
//     UI.HeaderInfo           : {
//         TypeName      : '',
//         TypeNamePlural: '',
//     },
//     UI.Facets               : [{
//         $Type : 'UI.ReferenceFacet',
//         Label : 'Add Payment',
//         ID    : 'SOIAddPayment',
//         Target: 'addPayments/@UI.LineItem#SOIAddPayment',
//     }, ],
    UI.LineItem #BoqItems   : [
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
    ],
    UI.LineItem #BoqItems1 : [
        {
            $Type : 'UI.DataField',
            Value : item,
            Label : 'item',
        },
        {
            $Type : 'UI.DataField',
            Value : description,
            Label : 'description',
        },
    ],
);

annotate service.BillofQuantityItems with {
    boqNo          @Common.FieldControl: #ReadOnly;
    actualQuantity @Common.FieldControl: #ReadOnly;
    actualAmount   @Common.FieldControl: #ReadOnly;
    advance        @Common.FieldControl: #ReadOnly;
    budgetQuantity @Common.FieldControl: #ReadOnly;
    budgetAmount   @Common.FieldControl: #ReadOnly;
};

// annotate service.addPayments with @(UI.LineItem #SOIAddPayment: [
//     {
//         $Type: 'UI.DataField',
//         Value: srNo,
//         Label: 'Sr'
//     },
//     {
//         $Type: 'UI.DataField',
//         Value: itemDecr,
//         Label: 'Item Description'
//     },
//     {
//         $Type: 'UI.DataField',
//         Value: unit,
//         Label: 'Unit'
//     },
//     {
//         $Type: 'UI.DataField',
//         Value: q1,
//         Label: '01'
//     },
//     {
//         $Type: 'UI.DataField',
//         Value: q2,
//         Label: '02'
//     },
//     {
//         $Type: 'UI.DataField',
//         Value: q3,
//         Label: '03'
//     },
//     {
//         $Type: 'UI.DataField',
//         Value: q4,
//         Label: '04'
//     },
//     {
//         $Type: 'UI.DataField',
//         Value: q5,
//         Label: '05'
//     },
// ], );

// annotate service.SalesPaymentHistory with @(UI.LineItem #SOIPrevious: [
//     {
//         $Type: 'UI.DataField',
//         Value: Item,
//         Label: 'Item'
//     },
//     {
//         $Type: 'UI.DataField',
//         Value: Product,
//         Label: 'Product'
//     },
//     {
//         $Type: 'UI.DataField',
//         Value: Quantity,
//         Label: 'Quantity'
//     },
//     {
//         $Type: 'UI.DataField',
//         Value: Total,
//         Label: 'Total'
//     },
//     {
//         $Type: 'UI.DataField',
//         Value: TotalNetValue,
//         Label: 'Total Net Value'
//     },
// ], );

// annotate service.SalesPaymentCurrent with @(UI.LineItem #SOICurrent: [
//     {
//         $Type: 'UI.DataField',
//         Value: Item,
//         Label: 'Item'
//     },
//     {
//         $Type: 'UI.DataField',
//         Value: Product,
//         Label: 'Product'
//     },
//     {
//         $Type: 'UI.DataField',
//         Value: Quantity,
//         Label: 'Quantity'
//     },
//     {
//         $Type: 'UI.DataField',
//         Value: Total,
//         Label: 'Total'
//     },
//     {
//         $Type: 'UI.DataField',
//         Value: TotalNetValue,
//         Label: 'Total Net Value'
//     },
// ], );

annotate service.Previous with @(UI.LineItem #Previous: [
    {
        $Type: 'UI.DataField',
        Value: workDone,
        Label: 'Work Done',
    },
    {
        $Type: 'UI.DataField',
        Value: Material,
        Label: 'Material',
    },
    {
        $Type: 'UI.DataField',
        Value: totalDue,
        Label: 'Total Due For Payment',
    },
    {
        $Type: 'UI.DataField',
        Value: retention,
        Label: 'Retention',
    },
    {
        $Type: 'UI.DataField',
        Value: retentionMaterial,
        Label: 'Retention Material',
    },
    {
        $Type: 'UI.DataField',
        Value: advPayRecoveryMaterial,
        Label: 'AdvPay Recovery Material',
    },
    {
        $Type: 'UI.DataField',
        Value: otherDeduction,
        Label: 'Other Deduction',
    },
    {
        $Type: 'UI.DataField',
        Value: netPaymentDue,
        Label: 'Net Payment Due',
    },
    {
        $Type: 'UI.DataField',
        Value: claimAmount,
        Label: 'Claim Amount',
    },
    {
        $Type: 'UI.DataField',
        Value: advanceAmount,
        Label: 'Advance Amount',
    },
    {
        $Type: 'UI.DataField',
        Value: advPayRecovery,
        Label: 'Adv Pay Recovery',
    },
    {
        $Type: 'UI.DataField',
        Value: retentionRelease,
        Label: 'Retention Release',
    },
]);

annotate service.CurrentPeriod with @(UI.LineItem #CurrentPeriod: [
    {
        $Type: 'UI.DataField',
        Value: workDone,
        Label: 'Work Done',
    },
    {
        $Type: 'UI.DataField',
        Value: Material,
        Label: 'Material',
    },
    {
        $Type: 'UI.DataField',
        Value: totalDue,
        Label: 'Total Due For Payment',
    },
    {
        $Type: 'UI.DataField',
        Value: retention,
        Label: 'Retention',
    },
    {
        $Type: 'UI.DataField',
        Value: retentionMaterial,
        Label: 'Retention Material',
    },
    {
        $Type: 'UI.DataField',
        Value: advPayRecoveryMaterial,
        Label: 'AdvPay Recovery Material',
    },
    {
        $Type: 'UI.DataField',
        Value: otherDeduction,
        Label: 'Other Deduction',
    },
    {
        $Type: 'UI.DataField',
        Value: netPaymentDue,
        Label: 'Net Payment Due',
    },
    {
        $Type: 'UI.DataField',
        Value: claimAmount,
        Label: 'Claim Amount',
    },
    {
        $Type: 'UI.DataField',
        Value: advanceAmount,
        Label: 'Advance Amount',
    },
    {
        $Type: 'UI.DataField',
        Value: advPayRecovery,
        Label: 'Adv Pay Recovery',
    },
    {
        $Type: 'UI.DataField',
        Value: retentionRelease,
        Label: 'Retention Release',
    },
]);

annotate service.Cumulative with @(UI.LineItem #Cumulative: [
    {
        $Type: 'UI.DataField',
        Value: workDone,
        Label: 'Work Done',
    },
    {
        $Type: 'UI.DataField',
        Value: Material,
        Label: 'Material',
    },
    {
        $Type: 'UI.DataField',
        Value: totalDue,
        Label: 'Total Due For Payment',
    },
    {
        $Type: 'UI.DataField',
        Value: retention,
        Label: 'Retention',
    },
    {
        $Type: 'UI.DataField',
        Value: retentionMaterial,
        Label: 'Retention Material',
    },
    {
        $Type: 'UI.DataField',
        Value: advPayRecoveryMaterial,
        Label: 'AdvPay Recovery Material',
    },
    {
        $Type: 'UI.DataField',
        Value: otherDeduction,
        Label: 'Other Deduction',
    },
    {
        $Type: 'UI.DataField',
        Value: netPaymentDue,
        Label: 'Net Payment Due',
    },
    {
        $Type: 'UI.DataField',
        Value: claimAmount,
        Label: 'Claim Amount',
    },
    {
        $Type: 'UI.DataField',
        Value: advanceAmount,
        Label: 'Advance Amount',
    },
    {
        $Type: 'UI.DataField',
        Value: advPayRecovery,
        Label: 'Adv Pay Recovery',
    },
    {
        $Type: 'UI.DataField',
        Value: retentionRelease,
        Label: 'Retention Release',
    },
]);

annotate service.Customer with {
    certificateNumber @Common.Label: 'certificateNumber'
};

// annotate service.Customer with @(Common.SideEffects #BoqChanged: {
//     SourceProperties: [boq_ID],
//     TargetEntities  : [BoqItems]
// });
annotate service.Customer with @Common.SideEffects : {
    SourceProperties : ['boq_ID'],
    TargetProperties : ['BoqItems']
};

// annotate service.Customer with @Common.SideEffects : {
//     $Type : 'Common.SideEffectsType',
//     SourceProperties : [contractNo_ID],
//     TargetEntities   : [contractItems]
// };
// annotate service.Customer with {
//     contractNo @(
//         Common.ValueList : {
//             $Type : 'Common.ValueListType',
//             CollectionPath : 'BOQContract',
//             Parameters : [
//                 {
//                     $Type : 'Common.ValueListParameterInOut',
//                     LocalDataProperty : contractNo_ID,
//                     ValueListProperty : 'ID',
//                 },
//                 {
//                     $Type : 'Common.ValueListParameterDisplayOnly',
//                     ValueListProperty : 'agreementName',
//                 },
//             ],
//         },
//         Common.ValueListWithFixedValues : true,
//         Common.Text : contractNo.agreementVrNo,
//         Common.Text.@UI.TextArrangement : #TextOnly,
// )};

// annotate service.BOQContract with {
//     ID @(
//         Common.Text : agreementVrNo,
//         Common.Text.@UI.TextArrangement : #TextOnly,
// )};

// annotate service.ContractItems with @(
//     UI.LineItem #ContractItems : [
//         {
//         $Type                : 'UI.DataField',
//         Value                : resource,
//         Label                : '{i18n>Resource}',
//         ![@HTML5.CssDefaults]: {width: '10rem'},
//     },
//     {
//         $Type                : 'UI.DataField',
//         Value                : resourceName,
//         Label                : 'Resource Name',
//         ![@HTML5.CssDefaults]: {width: '12rem'},
//     },
//     {
//         $Type                : 'UI.DataField',
//         Value                : costCode,
//         Label                : 'Cost Code',
//         ![@HTML5.CssDefaults]: {width: '8rem'},
//     },
//     {
//         $Type                : 'UI.DataField',
//         Value                : costCodeDescription,
//         Label                : 'Cost Code Description',
//         ![@HTML5.CssDefaults]: {width: '12rem'},
//     },
//     {
//         $Type                : 'UI.DataField',
//         Value                : wbs,
//         Label                : '{i18n>Wbs}',
//         ![@HTML5.CssDefaults]: {width: '8rem'},
//     },
//     {
//         $Type                : 'UI.DataField',
//         Value                : unit,
//         Label                : '{i18n>Unit}',
//         ![@HTML5.CssDefaults]: {width: '5rem'},
//     },
//     {
//         $Type                : 'UI.DataField',
//         Value                : quantity,
//         Label                : '{i18n>Quantity1}',
//         ![@HTML5.CssDefaults]: {width: '8rem'},
//     },
//     {
//         $Type                : 'UI.DataField',
//         Value                : rate,
//         Label                : '{i18n>Rate}',
//         ![@HTML5.CssDefaults]: {width: '7rem'},
//     },
//     {
//         $Type                : 'UI.DataField',
//         Value                : discountPercent,
//         Label                : 'Discount %',
//         ![@HTML5.CssDefaults]: {width: '8rem'},
//     },
//     {
//         $Type                : 'UI.DataField',
//         Value                : discountedRate,
//         Label                : 'Discounted Rate',
//         ![@HTML5.CssDefaults]: {width: '9rem'},
//     },
//     {
//         $Type                : 'UI.DataField',
//         Value                : amount,
//         Label                : '{i18n>Amount}',
//         ![@HTML5.CssDefaults]: {width: '8rem'},
//     },
//     {
//         $Type                : 'UI.DataField',
//         Value                : vatRate,
//         Label                : 'Vat Rate',
//         ![@HTML5.CssDefaults]: {width: '6rem'},
//     },
//     ]
// );

