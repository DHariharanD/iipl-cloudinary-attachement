using PaymentApplication as service from '../../srv/Procurement-payment-applicayion';
using from '../../db/billofquantities/boqcontract';

annotate service.procurementPayment with @(
    UI.SelectionFields            : [
        company,
        project_ID,
        certificateNumber,
    ],
    UI.LineItem                   : [
        {
            $Type: 'UI.DataField',
            Value: applicationNo,
            Label: 'Application No',
        },
        {
            $Type: 'UI.DataField',
            Value: company,
            Label: 'Company',
        },
        {
            $Type: 'UI.DataField',
            Value: project_ID,
            Label: 'Project',
        },
    ],
    UI.HeaderInfo                 : {
        TypeName      : 'Procurement Payment Application',
        TypeNamePlural: 'Procurement Payment Applications',
        Title         : {
            $Type: 'UI.DataField',
            Value: project_ID,
        },
    },
    UI.Facets                     : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Overview',
            ID    : 'Overview',
            Target: '@UI.FieldGroup#Overview',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Supplier Details',
            ID    : 'SupplierDetails',
            Target: '@UI.FieldGroup#SupplierDetails',
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
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Contract Items',
            ID    : 'ContractItems',
            Target: 'contractItems/@UI.LineItem#ContractItems',
        },
    ],
    UI.FieldGroup #Overview       : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: company,
                Label: 'Company',
            },
            {
                $Type: 'UI.DataField',
                Value: contractNo_ID,
                Label: 'Contract',
            },
        ],
    },
    UI.FieldGroup #SupplierDetails: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: startDate,
                Label: 'Start Date',
            },
            {
                $Type: 'UI.DataField',
                Value: dueDate,
                Label: 'Due Date',
            },
            {
                $Type: 'UI.DataField',
                Value: paStart,
                Label: 'PA Start',
            },
            {
                $Type: 'UI.DataField',
                Value: paEnd,
                Label: 'PA End',
            },
            {
                $Type: 'UI.DataField',
                Value: orderNumber,
                Label: 'Order Number',
            },
            {
                $Type: 'UI.DataField',
                Value: orderType,
                Label: 'Order Type',
            },
            {
                $Type: 'UI.DataField',
                Value: Supplier,
                Label: 'Supplier',
            },
            {
                $Type: 'UI.DataField',
                Value: retention,
                Label: 'Retention',
            },
            {
                $Type: 'UI.DataField',
                Value: status,
                Label: 'Overall Status',
            },
            {
                $Type: 'UI.DataField',
                Value: revisedContractAmount,
                Label: 'Revised Contract Amount',
            },
        ],
    },
    UI.FieldGroup #BOQ            : {
        $Type: 'UI.FieldGroupType',
        Data : [{
            $Type: 'UI.DataField',
            Value: contractNo_ID,
            Label: 'Contract',
        }],
    },
);

annotate service.procurementPayment with {
    contractNo @(
        Common.Text                    : contractNo.agreementName,
        Common.Text.@UI.TextArrangement: #TextOnly
    )
};

annotate service.procurementPayment with @(Common.SideEffects: {
    SourceProperties: ['contractNo_ID'],
    TargetEntities  : ['contractItems']
});

// Company value help
annotate service.procurementPayment with {
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

// Project value help
annotate service.procurementPayment with {
    project @(
        Common.Label                   : '{i18n>Project}',
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'projects',
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

annotate service.procurementPayment with {
    contractNo @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'BOQContract',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: contractNo_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'agreementName',
                },
            ],
        },
        Common.ValueListWithFixedValues: true,
        Common.Text                    : contractNo.agreementVrNo,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate service.procurementPayment with {
    contractNo @ObjectModel.text.association: 'contractNo'
};

annotate service.BOQContract with {
    ID @(
        Common.Text                    : agreementVrNo,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

// Previous tab columns
annotate service.ProcurementPrevious with @(UI.LineItem #Previous: [
    {
        $Type: 'UI.DataField',
        Value: workDone,
        Label: 'Work Done'
    },
    {
        $Type: 'UI.DataField',
        Value: Material,
        Label: 'Material'
    },
    {
        $Type: 'UI.DataField',
        Value: totalDue,
        Label: 'Total Due For Payment'
    },
    {
        $Type: 'UI.DataField',
        Value: retention,
        Label: 'Retention'
    },
    {
        $Type: 'UI.DataField',
        Value: retentionMaterial,
        Label: 'Retention Material'
    },
    {
        $Type: 'UI.DataField',
        Value: advPayRecoveryMaterial,
        Label: 'AdvPay Recovery Material'
    },
    {
        $Type: 'UI.DataField',
        Value: otherDeduction,
        Label: 'Other Deduction'
    },
    {
        $Type: 'UI.DataField',
        Value: netPaymentDue,
        Label: 'Net Payment Due'
    },
    {
        $Type: 'UI.DataField',
        Value: claimAmount,
        Label: 'Claim Amount'
    },
    {
        $Type: 'UI.DataField',
        Value: advanceAmount,
        Label: 'Advance Amount'
    },
    {
        $Type: 'UI.DataField',
        Value: advPayRecovery,
        Label: 'Adv Pay Recovery'
    },
    {
        $Type: 'UI.DataField',
        Value: retentionRelease,
        Label: 'Retention Release'
    },
]);

// Current Period tab columns
annotate service.ProcurementCurrentPeriod with @(UI.LineItem #CurrentPeriod: [
    {
        $Type: 'UI.DataField',
        Value: workDone,
        Label: 'Work Done'
    },
    {
        $Type: 'UI.DataField',
        Value: Material,
        Label: 'Material'
    },
    {
        $Type: 'UI.DataField',
        Value: totalDue,
        Label: 'Total Due For Payment'
    },
    {
        $Type: 'UI.DataField',
        Value: retention,
        Label: 'Retention'
    },
    {
        $Type: 'UI.DataField',
        Value: retentionMaterial,
        Label: 'Retention Material'
    },
    {
        $Type: 'UI.DataField',
        Value: advPayRecoveryMaterial,
        Label: 'AdvPay Recovery Material'
    },
    {
        $Type: 'UI.DataField',
        Value: otherDeduction,
        Label: 'Other Deduction'
    },
    {
        $Type: 'UI.DataField',
        Value: netPaymentDue,
        Label: 'Net Payment Due'
    },
    {
        $Type: 'UI.DataField',
        Value: claimAmount,
        Label: 'Claim Amount'
    },
    {
        $Type: 'UI.DataField',
        Value: advanceAmount,
        Label: 'Advance Amount'
    },
    {
        $Type: 'UI.DataField',
        Value: advPayRecovery,
        Label: 'Adv Pay Recovery'
    },
    {
        $Type: 'UI.DataField',
        Value: retentionRelease,
        Label: 'Retention Release'
    },
]);

// Cumulative tab columns
annotate service.ProcurementCumulative with @(UI.LineItem #Cumulative: [
    {
        $Type: 'UI.DataField',
        Value: workDone,
        Label: 'Work Done'
    },
    {
        $Type: 'UI.DataField',
        Value: Material,
        Label: 'Material'
    },
    {
        $Type: 'UI.DataField',
        Value: totalDue,
        Label: 'Total Due For Payment'
    },
    {
        $Type: 'UI.DataField',
        Value: retention,
        Label: 'Retention'
    },
    {
        $Type: 'UI.DataField',
        Value: retentionMaterial,
        Label: 'Retention Material'
    },
    {
        $Type: 'UI.DataField',
        Value: advPayRecoveryMaterial,
        Label: 'AdvPay Recovery Material'
    },
    {
        $Type: 'UI.DataField',
        Value: otherDeduction,
        Label: 'Other Deduction'
    },
    {
        $Type: 'UI.DataField',
        Value: netPaymentDue,
        Label: 'Net Payment Due'
    },
    {
        $Type: 'UI.DataField',
        Value: claimAmount,
        Label: 'Claim Amount'
    },
    {
        $Type: 'UI.DataField',
        Value: advanceAmount,
        Label: 'Advance Amount'
    },
    {
        $Type: 'UI.DataField',
        Value: advPayRecovery,
        Label: 'Adv Pay Recovery'
    },
    {
        $Type: 'UI.DataField',
        Value: retentionRelease,
        Label: 'Retention Release'
    },
]);

// Contract Items tab columns
annotate service.ContractItems with @(UI.LineItem #ContractItems: [
    {
        $Type                : 'UI.DataField',
        Value                : resource,
        Label                : '{i18n>Resource}',
        ![@HTML5.CssDefaults]: {width: '10rem'}
    },
    {
        $Type                : 'UI.DataField',
        Value                : resourceName,
        Label                : 'Resource Name',
        ![@HTML5.CssDefaults]: {width: '12rem'}
    },
    {
        $Type                : 'UI.DataField',
        Value                : costCode,
        Label                : 'Cost Code',
        ![@HTML5.CssDefaults]: {width: '8rem'}
    },
    {
        $Type                : 'UI.DataField',
        Value                : costCodeDescription,
        Label                : 'Cost Code Description',
        ![@HTML5.CssDefaults]: {width: '12rem'}
    },
    {
        $Type                : 'UI.DataField',
        Value                : wbs,
        Label                : '{i18n>Wbs}',
        ![@HTML5.CssDefaults]: {width: '8rem'}
    },
    {
        $Type                : 'UI.DataField',
        Value                : unit,
        Label                : '{i18n>Unit}',
        ![@HTML5.CssDefaults]: {width: '5rem'}
    },
    {
        $Type                : 'UI.DataField',
        Value                : quantity,
        Label                : 'Quantity',
        ![@HTML5.CssDefaults]: {width: '8rem'}
    },
    {
        $Type                : 'UI.DataField',
        Value                : rate,
        Label                : '{i18n>Rate}',
        ![@HTML5.CssDefaults]: {width: '7rem'}
    },
    {
        $Type                : 'UI.DataField',
        Value                : discountPercent,
        Label                : 'Discount %',
        ![@HTML5.CssDefaults]: {width: '8rem'}
    },
    {
        $Type                : 'UI.DataField',
        Value                : discountedRate,
        Label                : 'Discounted Rate',
        ![@HTML5.CssDefaults]: {width: '9rem'}
    },
    {
        $Type                : 'UI.DataField',
        Value                : amount,
        Label                : '{i18n>Amount}',
        ![@HTML5.CssDefaults]: {width: '8rem'}
    },
    {
        $Type                : 'UI.DataField',
        Value                : vatRate,
        Label                : 'Vat Rate',
        ![@HTML5.CssDefaults]: {width: '6rem'}
    },
]);
