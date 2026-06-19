using TAVouchersService as service from '../../srv/hr-tavouchers-service';
using from '../../db/hrportal/ta-vouchers';
using from '../../db/cbs/cbs';


annotate service.TAVouchers with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: company_CompanyCode,
                Label: 'Company Code',
            },
            {
                $Type: 'UI.DataField',
                Value: project_ID,
                Label: 'Project',
            },
            {
                $Type: 'UI.DataField',
                Value: vrNo,
                Label: 'Vr.No',
            },
            {
                $Type: 'UI.DataField',
                Value: vrDate,
                Label: 'Vr.Date',
            },
            {
                $Type: 'UI.DataField',
                Value: location,
                Label: 'Location',
            },
            {
                $Type: 'UI.DataField',
                Value: supervisor,
                Label: 'Supervisor',
            },
        ],
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Detail',
            ID    : 'Detail',
            Target: 'details/@UI.LineItem#Detail',
        },
    ],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Value: company_CompanyCode,
            Label: 'Company Code',
        },
        {
            $Type: 'UI.DataField',
            Value: vrNo,
            Label: 'Vr.No',
        },
        {
            $Type: 'UI.DataField',
            Value: vrDate,
            Label: 'Vr.Date',
        },
    ],
    UI.HeaderInfo                : {
        Title         : {
            $Type: 'UI.DataField',
            Value: project_ID,
        },
        TypeName      : 'Timesheet',
        TypeNamePlural: 'Timesheets',
        Description   : {
            $Type: 'UI.DataField',
            Value: company_CompanyCode,
        },
    },
);

annotate service.TADetails with @(
    UI.LineItem #Detail    : [
        {
            $Type: 'UI.DataField',
            Value: srNo,
            Label: 'Sr.No',
        },
        // {
        //     $Type : 'UI.DataField',
        //     Value : empCode,
        //     Label : 'Emp Code',
        // },
        {
            $Type: 'UI.DataField',
            Value: employeeName,
            Label: 'Employee Name',
        },
    ],
    UI.Facets              : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'OverView',
        ID    : 'OverView',
        Target: '@UI.FieldGroup#OverView',
    }, ],
    UI.FieldGroup #OverView: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: wbs_ID,
                Label: 'Wbs',
            },
            {
                $Type: 'UI.DataField',
                Value: costCode_ID,
                Label: 'Cost Code',
            },
            // {
            //     $Type : 'UI.DataField',
            //     Value : costCodeName,
            //     Label : 'CostCode Name',
            // },
            {
                $Type: 'UI.DataField',
                Value: productivityCode,
                Label: 'Productivity Code',
            },
            // {
            //     $Type : 'UI.DataField',
            //     Value : productivityName,
            //     Label : 'Productivity Name',
            // },
            // {
            //     $Type : 'UI.DataField',
            //     Value : empCode,
            //     Label : 'Emp Code',
            // },
            {
                $Type: 'UI.DataField',
                Value: employeeName,
                Label: 'Employee Name',
            },
            {
                $Type: 'UI.DataField',
                Value: oldCode,
                Label: 'Old Code',
            },
            {
                $Type: 'UI.DataField',
                Value: workingAs,
                Label: 'Working As',
            },
            {
                $Type: 'UI.DataField',
                Value: shift,
                Label: 'Shift',
            },
            {
                $Type: 'UI.DataField',
                Value: shiftInTime,
                Label: 'Shift In Time',
            },
            {
                $Type: 'UI.DataField',
                Value: inTime,
                Label: 'In Time',
            },
            {
                $Type: 'UI.DataField',
                Value: outTime,
                Label: 'Out Time',
            },
            {
                $Type: 'UI.DataField',
                Value: actualHours,
                Label: 'Actual Hours',
            },
            {
                $Type: 'UI.DataField',
                Value: workHours,
                Label: 'Work Hours',
            },
            {
                $Type: 'UI.DataField',
                Value: punchOTHours,
                Label: 'Punch OT Hours',
            },
            {
                $Type: 'UI.DataField',
                Value: stdHours,
                Label: 'Std Hours',
            },
            {
                $Type: 'UI.DataField',
                Value: gang,
                Label: 'Gang',
            },
            {
                $Type: 'UI.DataField',
                Value: outputQty,
                Label: 'Output Qty',
            },
            {
                $Type: 'UI.DataField',
                Value: earnedOT,
                Label: 'Earned OT',
            },
            {
                $Type: 'UI.DataField',
                Value: cotHours,
                Label: 'Cot Hours',
            },
            {
                $Type: 'UI.DataField',
                Value: holidayHours,
                Label: 'Holiday Hours',
            },
            {
                $Type: 'UI.DataField',
                Value: unit,
                Label: 'Unit',
            },
            {
                $Type: 'UI.DataField',
                Value: empRate,
                Label: 'Emp Rate',
            },
            {
                $Type: 'UI.DataField',
                Value: toBeAchieved,
                Label: 'To Be Achieved',
            },
        ],
    },
    UI.HeaderInfo          : {
        Title         : {
            $Type: 'UI.DataField',
            Value: costCode_ID,
        },
        TypeName      : '',
        TypeNamePlural: '',
        Description   : {
            $Type: 'UI.DataField',
            Value: productivityName,
        },
    },
);

annotate service.TAVouchers with {
    company @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'company',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: company_CompanyCode,
                ValueListProperty: 'CompanyCode',
            }, ],
            Label         : 'Select Company',
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.company with {
    CompanyCode @Common.Text: CompanyCodeName
};

annotate service.TAVouchers with {
    project @(
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
                    $Type            : 'Common.ValueListParameterIn',
                    ValueListProperty: 'companyCode',
                    LocalDataProperty: company_CompanyCode,
                },
            ],
        },
        Common.ValueListWithFixedValues: false,
        Common.Text                    : project.projectDescription,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate service.Projects with {
    ID @(
        Common.Text                    : projectDescription,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate service.TADetails with {
    wbs @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'wbs',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: wbs_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterIn',
                    ValueListProperty: 'plshierarchy_ID',
                    LocalDataProperty: parent.project_ID,
                },
            ],
        },
        Common.ValueListWithFixedValues: false,
        Common.Text                    : wbs.projectElementDescription,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate service.wbs with {
    ID @(
        Common.Text                    : projectElementDescription,
        Common.Text.@UI.TextArrangement: #TextOnly,
    );
    ID @Common.Label: 'WBS';
};

annotate service.TADetails with {
    productivityCode @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'CBSResourceMaterial',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: productivityCode,
                    ValueListProperty: 'productName',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'productId',
                },
                {
                    $Type            : 'Common.ValueListParameterIn',
                    ValueListProperty: 'cbsNode_ID',
                    LocalDataProperty: costCode_ID,
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'productType',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'unitofMeasure',
                },
            ],
        },
        Common.ValueListWithFixedValues: false,
    )
};

annotate service.CostBreakDown with {
    cbshierarchy @(
        Common.Text                    : code,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate service.CostBreakDown with {
    ID   @Common.Label: 'Name';
    code @Common.Label: 'Code';
};
// annotate service.CBSResourceMaterial with {

// };
annotate service.CBSResourceMaterial with {
    ID            @(
        Common.Text                    : productId,
        Common.Text.@UI.TextArrangement: #TextOnly,
    );
    productId     @Common.Label: 'Product Id';
    productType   @Common.Label: 'Product Type';
    unitofMeasure @Common.Label: 'UOM';
};

annotate service.TADetails with {
    employeeName @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Employeedetails',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: employeeName,
                ValueListProperty: 'firstName',
            }, ],
            Label         : 'Select Employee',
        },
        Common.ValueListWithFixedValues: false,
    )
};

// annotate service.TADetails with {
//     productivityName @Common.FieldControl : #ReadOnly
// };

// annotate service.TADetails with {
//     costCodeName @Common.FieldControl : #ReadOnly
// };

annotate service.TADetails with {
    costCode @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'CostBreakDown',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: costCode_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'code',
                },
            ],
        },
        Common.ValueListWithFixedValues: false,
        Common.Text                    : costCode.code,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate service.CostBreakDown with {
    ID @(
        Common.Text                    : name,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate service.CBSResourceMaterial with {
    productId @(
        Common.Text                    : productName,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};
