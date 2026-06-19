using AssetTimeSheetDailyService as service from '../../srv/asset-time-sheet-daily-service';
annotate service.TimeSheetHeader with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Company Code',
                Value : companyCode,
            },
            {
                $Type : 'UI.DataField',
                Value : project_ID,
                Label : 'Project',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Asset TimeSheet',
            ID : 'AssetTImeSheetDaily',
            Target : 'timeSheets/@UI.LineItem#AssetTImeSheetDaily',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Company Code',
            Value : companyCode,
        },
        {
            $Type : 'UI.DataField',
            Value : project_ID,
        },
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : companyCode,
        },
        TypeName : '',
        TypeNamePlural : '',
    },
);

annotate service.AssetTimeSheets with @(
    UI.LineItem #AssetTImeSheetDaily : [
        {
            $Type : 'UI.DataField',
            Value : assetId,
            Label : 'Asset',
        },
        {
            $Type : 'UI.DataField',
            Value : assetName,
            Label : 'Asset Name',
        },
        {
            $Type : 'UI.DataField',
            Value : employee.fullName,
            Label : 'Employee Name',
        },
    ],
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
                Value : wbs,
                Label : 'WBS',
            },
            {
                $Type : 'UI.DataField',
                Value : costCode,
                Label : 'Cost Code',
            },
            {
                $Type : 'UI.DataField',
                Value : prodCode,
                Label : 'Prod Code',
            },
            {
                $Type : 'UI.DataField',
                Value : prodUnit,
                Label : 'Prod Unit',
            },
            {
                $Type : 'UI.DataField',
                Value : assetId,
                Label : 'Asset',
            },
            {
                $Type : 'UI.DataField',
                Value : assetName,
                Label : 'Asset Name',
            },
            {
                $Type : 'UI.DataField',
                Value : aHrs,
                Label : 'A Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : actualHours,
                Label : 'Actual Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : assetNormalHours,
                Label : 'Asset Normal Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : assetTotalBillingHrs,
                Label : 'Asset Total Billing Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : bHrs,
                Label : 'B Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : billingUnit,
                Label : 'Billing Unit',
            },
            {
                $Type : 'UI.DataField',
                Value : breakdownHours,
                Label : 'Breakdown Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : refNo,
                Label : 'Ref No',
            },
            {
                $Type : 'UI.DataField',
                Value : employee_ID,
                Label : 'Employee',
            },
            {
                $Type : 'UI.DataField',
                Value : empBonusHours,
                Label : 'Emp Bonus Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : empHotHours,
                Label : 'Emp Hot Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : empHours,
                Label : 'Emp Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : empOtHours,
                Label : 'Emp OT Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : hotHours,
                Label : 'Hot Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : idleHours,
                Label : 'Idle Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : isQtyEdited,
                Label : 'Is Quantity Edited',
            },
            {
                $Type : 'UI.DataField',
                Value : lHrs,
                Label : 'L Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : lunchHours,
                Label : 'Lunch Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : meterStart,
                Label : 'Meter Start',
            },
            {
                $Type : 'UI.DataField',
                Value : meterEnd,
                Label : 'Meter End',
            },
            {
                $Type : 'UI.DataField',
                Value : ot1Hrs,
                Label : 'Ot1 Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : ot2Hrs,
                Label : 'Ot2 Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : otHours,
                Label : 'Ot Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : outputQty,
                Label : 'Output Qty',
            },
            {
                $Type : 'UI.DataField',
                Value : s1Hrs,
                Label : 'S1 Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : s2Hrs,
                Label : 'S2 Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : s3Hrs,
                Label : 'S3 Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : sHrs,
                Label : 'S Hours',
            },
            {
                $Type : 'UI.DataField',
                Value : unit,
                Label : 'Unit',
            },
            {
                $Type : 'UI.DataField',
                Value : fromTime,
                Label : 'From Time',
            },
            {
                $Type : 'UI.DataField',
                Value : toTime,
                Label : 'To Time',
            },
        ],
    },
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : assetId,
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : assetName,
        },
    },
);

annotate service.TimeSheetHeader with {
    companyCode @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Companies',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : companyCode,
                    ValueListProperty : 'CompanyCode',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'CompanyCodeName',
                }
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

annotate service.Companies with {
    CompanyCode @Common.Text: CompanyCodeName
};


annotate service.TimeSheetHeader with {
    project @(
        Common.Label : 'Project',
        Common.Text : project.projectDescription,
        Common.Text.@UI.TextArrangement : #TextOnly,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'ProjectsVH',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : project_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'projectDescription',
                },
                {
                    $Type : 'Common.ValueListParameterIn',
                    LocalDataProperty : companyCode,
                    ValueListProperty : 'companyCode',
                },
            ],
            Label : 'Select Project',
        },
        Common.ExternalID : project.projectDescription,
    )
};

annotate service.ProjectsVH with {
    ID @UI.Hidden;
};


annotate service.AssetTimeSheets with {
    wbs @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Wbs',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : wbs,
                    ValueListProperty : 'assetWbs',
                },
                {
                    $Type : 'Common.ValueListParameterIn',
                    LocalDataProperty : header.project_ID,
                    ValueListProperty : 'project_ID',
                }
            ],
            Label : 'Select WBS',
        },
        Common.ValueListWithFixedValues : false,
)};



annotate service.AssetTimeSheets with {
    costCode @(
        Common.Text : costCodeName,
        Common.Text.@UI.TextArrangement : #TextOnly,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'CostBreakdownStructure',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : costCode,
                    ValueListProperty : 'code',
                },
                {
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : costCodeName,
                    ValueListProperty : 'name',
                }
            ],
            Label : 'Select Cost Code',
        },
        Common.ValueListWithFixedValues : false,
)};


annotate service.AssetTimeSheets with {
    prodCode @(
        Common.Text : prodName,
        Common.Text.@UI.TextArrangement : #TextOnly,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'CBSResourceMaterial',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : prodCode,
                    ValueListProperty : 'productId',
                },
                {
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : prodName,
                    ValueListProperty : 'productName',
                },
                {
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : prodUnit,
                    ValueListProperty : 'unitofMeasure',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'productType',
                },
                {
                    $Type : 'Common.ValueListParameterIn',
                    LocalDataProperty : costCode,
                    ValueListProperty : 'cbsNodeCode'
                }
            ],
            Label : 'Select Productivity Code',
        },
    )
};

annotate service.CBSResourceMaterial with {
    productId @UI.Hidden;
};



annotate service.AssetTimeSheets with {
    employee @(
        // This links the ID to the Name for display purposes
        Common.Text : employeeName, 
        Common.TextArrangement : #TextOnly,
        
        Common.Label : 'Employee',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'EmployeeDetails',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterIn',
                    LocalDataProperty : employee_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : employeeName,
                    ValueListProperty : 'fullName',
                }
            ],
        },
        Common.ValueListWithFixedValues : false,
    )
};



