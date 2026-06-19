using ProductivityEntryService as service from '../../srv/productivity-entry-service';

annotate service.DailyProductivityVoucher with @(

    UI.HeaderInfo             : {
        TypeName      : 'Productivity',
        TypeNamePlural: 'Productivity',
        Title         : {
            $Type: 'UI.DataField',
            Value: project.projectDescription,
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: vrNo,
        },
    },

    UI.SelectionFields        : [
        companyCode,
        project_ID,
        status,
    ],

    UI.LineItem               : [
        {
            $Type                : 'UI.DataField',
            Value                : voucherItems.chargehand,
            Label                : 'Chargehand',
            ![@HTML5.CssDefaults]: {width: '10rem'},
        },
        {
            $Type                : 'UI.DataField',
            Value                : voucherItems.chargehandName,
            Label                : 'Chargehand Name',
            ![@HTML5.CssDefaults]: {width: '14rem'},
        },
        {
            $Type                : 'UI.DataField',
            Value                : voucherItems.productivityCode,
            Label                : 'Productivity Code',
            ![@HTML5.CssDefaults]: {width: '12rem'},
        },
        // {
        //     $Type                : 'UI.DataField',
        //     Value                : voucherItems.productivityName,
        //     Label                : 'Productivity Name',
        //     ![@HTML5.CssDefaults]: {width: '14rem'},
        // },
        {
            $Type                : 'UI.DataField',
            Value                : voucherItems.wbs,
            Label                : 'WBS',
            ![@HTML5.CssDefaults]: {width: '10rem'},
        },
        {
            $Type                : 'UI.DataField',
            Value                : voucherItems.unit,
            Label                : 'Unit',
            ![@HTML5.CssDefaults]: {width: '6rem'},
        },
        {
            $Type                : 'UI.DataField',
            Value                : voucherItems.gang,
            Label                : 'Gang',
            ![@HTML5.CssDefaults]: {width: '6rem'},
        },
        {
            $Type                : 'UI.DataField',
            Value                : voucherItems.outputAchieved,
            Label                : 'Output Achieved',
            ![@HTML5.CssDefaults]: {width: '10rem'},
        },
        {
            $Type                : 'UI.DataField',
            Value                : voucherItems.locationCode,
            Label                : 'Location Code',
            ![@HTML5.CssDefaults]: {width: '10rem'},
        },
        {
            $Type                : 'UI.DataField',
            Value                : voucherItems.costCode,
            Label                : 'Cost Code',
            ![@HTML5.CssDefaults]: {width: '10rem'},
        },
        // {
        //     $Type                : 'UI.DataField',
        //     Value                : voucherItems.costCodeName,
        //     Label                : 'Cost Code Name',
        //     ![@HTML5.CssDefaults]: {width: '12rem'},
        // },
    ],

    UI.Facets                 : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneralInfo',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneralInfo',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Productivity',
            ID    : 'Productivity',
            Target: 'voucherItems/@UI.LineItem#Productivity',
        },
    ],

    UI.FieldGroup #GeneralInfo: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Company',
                Value: companyCode,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Project',
                Value: project_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Vr No',
                Value: vrNo,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Vr Date',
                Value: vrDate,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Status',
                Value: status,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Location',
                Value: location,
            },
        ],
    },
);

//  Company value help
annotate service.DailyProductivityVoucher with {
    companyCode @(
        Common.Label                   : 'Company',
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'company',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: companyCode,
                    ValueListProperty: 'CompanyCode',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'CompanyCodeName',
                },
            ],
            Label         : 'Select Company',
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.company with {
    CompanyCode @Common.Text: CompanyCodeName
};

//  Project value help — filtered by companyCode
annotate service.DailyProductivityVoucher with {
    project @(
        Common.Label                   : 'Project',
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
                    LocalDataProperty: companyCode,
                    ValueListProperty: 'companyCode',
                },
            ],
            Label         : 'Select Project',
        },
    )
};

annotate service.Projects with {
    ID @UI.Hidden;
};

//  Productivity item line item table
annotate service.DailyProductivityVoucherItem with @(UI.LineItem #Productivity: [
    {
        $Type                : 'UI.DataField',
        Value                : chargehand,
        Label                : 'Chargehand',
        ![@HTML5.CssDefaults]: {width: '9rem'},
    },
    {
        $Type                : 'UI.DataField',
        Value                : chargehandName,
        Label                : 'Chargehand Name',
        ![@HTML5.CssDefaults]: {width: '12rem'},
    },
    {
        $Type                : 'UI.DataField',
        Value                : wbs,
        Label                : 'WBS',
        ![@HTML5.CssDefaults]: {width: '10rem'},
    },
    {
        $Type                : 'UI.DataField',
        Value                : locationCode,
        Label                : 'Location Code',
        ![@HTML5.CssDefaults]: {width: '9rem'},
    },
    {
        $Type                : 'UI.DataField',
        Value                : costCode,
        Label                : 'Cost Code',
        ![@HTML5.CssDefaults]: {width: '9rem'},
    },
    // {
    //     $Type                : 'UI.DataField',
    //     Value                : costCodeName,
    //     Label                : 'Cost Code Name',
    //     ![@HTML5.CssDefaults]: {width: '12rem'},
    // },
    {
        $Type                : 'UI.DataField',
        Value                : productivityCode,
        Label                : 'Productivity Code',
        ![@HTML5.CssDefaults]: {width: '10rem'},
    },
    // {
    //     $Type                : 'UI.DataField',
    //     Value                : productivityName,
    //     Label                : 'Productivity Name',
    //     ![@HTML5.CssDefaults]: {width: '12rem'},
    // },
    {
        $Type                : 'UI.DataField',
        Value                : unit,
        Label                : 'Unit',
        ![@HTML5.CssDefaults]: {width: '6rem'},
    },
    {
        $Type                : 'UI.DataField',
        Value                : gang,
        Label                : 'Gang',
        ![@HTML5.CssDefaults]: {width: '6rem'},
    },
    {
        $Type                : 'UI.DataField',
        Value                : outputAchieved,
        Label                : 'Output Achieved',
        ![@HTML5.CssDefaults]: {width: '9rem'},
    },
]);

//WBS Code Based on Selected Project
annotate service.DailyProductivityVoucherItem with {
    wbs @(
        Common.Label    : 'WBS',
        Common.ValueList: {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Wbs',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: wbs,
                    ValueListProperty: 'primaverawbsCode',
                    ![@UI.Hidden]    : true,
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'primaverawbs',
                    ![@Common.Label] : 'WBS Element',
                },
                {
                    $Type            : 'Common.ValueListParameterIn',
                    LocalDataProperty: voucher.project_ID,
                    ValueListProperty: 'project_ID',
                },
            ],
            Label         : 'Select WBS',
        },
    )
};

annotate service.Wbs with {
    primaverawbsCode @UI.Hidden;
    primaverawbs     @Common.Label: 'WBS Element';
};

// Cost Code value help
annotate service.DailyProductivityVoucherItem with {
    costCode @(
        Common.Label    : 'Cost Code',
        Common.ValueList: {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'CostBreakdownStructure',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: costCode,
                    ValueListProperty: 'code',
                },
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: costCodeName,
                    ValueListProperty: 'name',
                },
                // {
                //     $Type            : 'Common.ValueListParameterDisplayOnly',
                //     ValueListProperty: 'descr',
                // },
            ],
            Label         : 'Select Cost Code',
        },
    )
};

// Productivity Code filtered by selected costCode
annotate service.DailyProductivityVoucherItem with {
    productivityCode @(
        Common.Label    : 'Productivity Code',
        Common.ValueList: {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'CBSResourceMaterial',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: productivityCode,
                    ValueListProperty: 'productName',
                },
                // {
                //     $Type            : 'Common.ValueListParameterInOut',
                //     LocalDataProperty: productivityName,
                //     ValueListProperty: 'productName',
                // },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'productType',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'unitofMeasure',
                },
                {
                    $Type            : 'Common.ValueListParameterIn',
                    LocalDataProperty: costCode,
                    ValueListProperty: 'cbsNodeCode',
                },
            ],
            Label         : 'Select Productivity Code',
        },
    )
};
annotate service.DailyProductivityVoucherItem with {
    costCode         @Common.Text: costCodeName  @UI.TextArrangement: #TextOnly;
    // productivityCode @Common.Text: productivityName @UI.TextArrangement: #TextOnly;
};