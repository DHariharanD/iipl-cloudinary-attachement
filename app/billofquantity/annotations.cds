using BillofQuantityService as service from '../../srv/boq-service';
using from '../../db/billofquantities/bill-of-quantity';

annotate service.BillofQuantityHeader with @(
    UI.SelectionFields                   : [
        projectName,
        startSrNo,
        vrNo,
        boqType_code,
    ],
    UI.LineItem                          : [
        {
            $Type: 'UI.DataField',
            Value: startSrNo,
            Label: '{i18n>Srno}',
        },
        {
            $Type: 'UI.DataField',
            Value: projectName,
            Label: '{i18n>Project}',
        },
        {
            $Type: 'UI.DataField',
            Value: vrNo,
            Label: '{i18n>VrNo}',
        },
        {
            $Type: 'UI.DataField',
            Value: boqType_code,
            Label: '{i18n>BoqType}',
        },
    ],
    UI.HeaderInfo                        : {
        TypeName      : '{i18n>Boq}',
        TypeNamePlural: '{i18n>Boq}',
        Title         : {
            $Type: 'UI.DataField',
            Value: projectName,
        },
        TypeImageUrl  : 'sap-icon://money-bills',
    },
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
                    Label : '{i18n>BoqItems}',
                    ID    : 'i18nBoqItems',
                    Target: 'bqHeaderHierarchies/@UI.LineItem#i18nBoqItems',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Attachments}',
            ID    : 'AttachmentsFacet',
            Target: 'attachments/@UI.LineItem'
        }
    ],
    UI.FieldGroup #i18nGeneralInformation: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: projectName,
                Label: '{i18n>Project}'
            },
            {
                $Type: 'UI.DataField',
                Value: boqType_code,
                Label: '{i18n>BoqType}'
            },
            {
                $Type: 'UI.DataField',
                Value: startSrNo,
                Label: '{i18n>StartSrNo}'
            },
            {
                $Type: 'UI.DataField',
                Value: vrNo,
                Label: '{i18n>VrNo1}'
            },
            {
                $Type: 'UI.DataField',
                Value: company_CompanyCode,
                Label: '{i18n>CompanyCode}'
            },
        ],
    },
);

annotate service.BillofQuantityHeader with {
    project @Common.Label: '{i18n>ProjectId}'
};

annotate service.Projects with {
    ID @UI.Hidden;
};

annotate service.BillofQuantityHeader with {
    projectName @(
        Common.ValueList: {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Projects',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: projectName,
                    ValueListProperty: 'project'
                },
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: project_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'projectDescription'
                }
            ],
            Label         : 'Project',
        },
        Common.Label    : 'Project Name',
    )
};

annotate BillofQuantityService.BillofQuantityItem with {
    wbsElement @(
        Common.Text           : wbsElement.projectElementDescription,
        Common.TextArrangement: #TextOnly,

        Common.ValueList      : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'ProjectPlanning',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterIn',
                    ValueListProperty: 'plshierarchy_ID',
                    LocalDataProperty: 'bqitemsHierarchy/project_ID'
                },
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    ValueListProperty: 'ID',
                    LocalDataProperty: 'wbsElement_ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'projectElementDescription',
                }
            ],
            Label         : 'WBS Elements',
        }
    )
};


annotate service.ProjectPlanning with {
    ID @(
        Common.Text           : projectElementDescription,
        Common.TextArrangement: #TextOnly
    )
};

annotate service.BillofQuantityHeader with {
    startSrNo @Common.Label: '{i18n>Srno1}'
};

annotate service.BillofQuantityHeader with {
    vrNo @Common.Label: '{i18n>Vrno}'
};

annotate service.CostBreakdownStructure with {
    name @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'CostBreakdownStructure',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: name,
                ValueListProperty: 'name',
            }, ],
        },
        Common.ValueListWithFixedValues: false,
    )
};

annotate service.BillofQuantityItem with {
    cbs @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'CostBreakdownStructure',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: cbs_ID,
                ValueListProperty: 'ID',
            }, ],
        },
        Common.ValueListWithFixedValues: false,
    )
};

annotate service.CostBreakdownStructure with {
    ID @(
        Common.Text                    : name,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate service.BillofQuantityHeader with {
    ID @UI.Hidden;
};


annotate service.BillofQuantityItem with @(

    UI.LineItem #i18nBoqItems  : [
        {
            $Type: 'UI.DataField',
            Value: item,
            Label: '{i18n>Item}'
        },
        {
            $Type: 'UI.DataField',
            Value: description,
            Label: '{i18n>Description}'
        },
        {
            $Type: 'UI.DataField',
            Value: unitOfMeasurement,
            Label: '{i18n>UnitOfMeasurement}'
        },
        {
            $Type: 'UI.DataField',
            Value: quantity,
            Label: '{i18n>Quantity}'
        },
        {
            $Type: 'UI.DataField',
            Value: wbsElement_ID,
            Label: '{i18n>WbsElement}'
        },
    ],

    UI.Facets                  : [

        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Overview',
            ID    : 'Overview',
            Target: '@UI.FieldGroup#Overview',
        },

        {
            $Type : 'UI.CollectionFacet',
            Label : 'Mapping',
            ID    : 'Mapping',

            Facets: [

                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'CBS',
                    ID    : 'CBS',
                    Target: 'boqcbs/@UI.LineItem#CBS',
                },

                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Resources',
                    ID    : 'BoqResource',
                    Target: 'boqResource/@UI.LineItem#BoqResource',
                }

            ],
        },
    ],


    UI.FieldGroup #i18nOverview: {
        $Type: 'UI.FieldGroupType',
        Data : [],
    },

    UI.FieldGroup #Overview    : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: item,
                Label: '{i18n>Item}'
            },
            {
                $Type: 'UI.DataField',
                Value: description,
                Label: '{i18n>Description}'
            },
            {
                $Type: 'UI.DataField',
                Value: quantity,
                Label: '{i18n>Quantity}'
            },
            {
                $Type: 'UI.DataField',
                Value: unitOfMeasurement,
                Label: '{i18n>UnitOfMeasurement}'
            },
            {
                $Type: 'UI.DataField',
                Value: bill,
                Label: '{i18n>Bill}'
            },
            {
                $Type: 'UI.DataField',
                Value: section,
                Label: '{i18n>Section}'
            },
            {
                $Type: 'UI.DataField',
                Value: page,
                Label: '{i18n>Page}'
            },
            {
                $Type: 'UI.DataField',
                Value: revision,
                Label: '{i18n>Revision}'
            },
            {
                $Type: 'UI.DataField',
                Value: retention,
                Label: '{i18n>Retention}'
            },
            {
                $Type: 'UI.DataField',
                Value: advance,
                Label: '{i18n>Advance}'
            },
            {
                $Type: 'UI.DataField',
                Value: peformanceBond,
                Label: '{i18n>PeformanceBond}'
            },
            {
                $Type: 'UI.DataField',
                Value: bankGuarantee,
                Label: '{i18n>BankGuarantee}'
            },
            {
                $Type: 'UI.DataField',
                Value: boqNo,
                Label: '{i18n>BoqNo}'
            },
            {
                $Type: 'UI.DataField',
                Value: wbsElement_ID,
                Label: '{i18n>Wbs}'
            },
            {
                $Type: 'UI.DataField',
                Value: sumBack,
                Label: '{i18n>SumBackToBack}'
            },
            {
                $Type: 'UI.DataField',
                Value: pcRate,
                Label: '{i18n>PcRate}'
            },
            {
                $Type: 'UI.DataField',
                Value: nonClient,
                Label: '{i18n>NonClient}'
            },
            {
                $Type: 'UI.DataField',
                Value: excludeActiveBudget,
                Label: '{i18n>ExcludeActiveBudget}'
            },
        ],
    },

    UI.HeaderInfo              : {
        Title         : {
            $Type: 'UI.DataField',
            Value: description
        },
        TypeName      : '',
        TypeNamePlural: '',
    },
);


annotate service.BoqResource with @(
    UI.LineItem #BoqResource: [
        {
            $Type: 'UI.DataField',
            Value: code,
            Label: 'Code'
        },
        {
            $Type: 'UI.DataField',
            Value: name,
            Label: 'Name'
        },
        {
            $Type: 'UI.DataField',
            Value: descr,
            Label: 'Description'
        }
    ],
    UI.CreateHidden         : true,
);


annotate service.boqCbsMapping with @(
    UI.LineItem #CbsResource: [
        {
            $Type: 'UI.DataField',
            Value: productId,
            Label: 'Product Id'
        },
        {
            $Type: 'UI.DataField',
            Value: productName,
            Label: 'Product Name'
        },
        {
            $Type: 'UI.DataField',
            Value: productType,
            Label: 'Product Type'
        },
    ],
    UI.CreateHidden         : true,
);

annotate service.BoqCbs with @(
    UI.LineItem #CBS: [{
        $Type: 'UI.DataField',
        Value: name,
        Label: 'Name'
    }, ],
    UI.CreateHidden : true,
);
annotate service.BillofQuantityHeader with {
    boqType @Common.Label : 'Boq  Code'
};

annotate service.BillofQuantityItem with {
    description @UI.MultiLineText : true
};

annotate service.BillofQuantityHeader with {
    company_CompanyCode @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Companies',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : company_CompanyCode,
                    ValueListProperty : 'CompanyCode',
                },
            ],
            Label : 'Select Company Code',
        },
        Common.ValueListWithFixedValues : true,
)};

annotate service.Companies with {
    CompanyCode @Common.Text : CompanyCodeName
};

