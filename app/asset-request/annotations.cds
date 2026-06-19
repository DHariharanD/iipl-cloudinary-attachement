using from '../../srv/asset-request-service';
using from '../../db/assets/asset-request';

annotate AssetRequestService.AssetRequest with @(
 
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : company_CompanyCode,
            Label : '{i18n>CompanyCode}',
        },
        {
            $Type : 'UI.DataField',
            Value : fromlocation,
            Label : '{i18n>FromLocation}',
        },
        {
            $Type : 'UI.DataField',
            Value : tolocation,
            Label : 'To Location',
        },
        {
            $Type : 'UI.DataField',
            Value : reqstatus,
            Label : '{i18n>RequestStatus}',
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General Information',
            ID : 'GeneralInformation',
            Target : '@UI.FieldGroup#GeneralInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>RequestAssetItem}',
            ID : 'i18nRequestAssetItem',
            Target : 'items/@UI.LineItem#i18nRequestAssetItem',
        },
    ],
    UI.FieldGroup #GeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : company_CompanyCode,
                Label : '{i18n>CompanyCode}',
            },
            {
                $Type : 'UI.DataField',
                Value : project_ID,
                Label : '{i18n>Project}',
            },
            {
                $Type : 'UI.DataField',
                Value : wbs_ID,
                Label : '{i18n>Wbs}',
            },
            {
                $Type : 'UI.DataField',
                Value : boq_ID,
                Label : '{i18n>Boq}',
            },
            {
                $Type : 'UI.DataField',
                Value : fromlocation,
                Label : '{i18n>FromLocation}',
            },
            {
                $Type : 'UI.DataField',
                Value : reqstatus,
                Label : '{i18n>RequestStatus}',
            },
            {
                $Type : 'UI.DataField',
                Value : tolocation,
                Label : '{i18n>Tolocation}',
            },
        ],
    },
    UI.HeaderInfo : {
        TypeName : 'Asset Request',
        TypeNamePlural : '',
        Title : {
            $Type : 'UI.DataField',
            Value : project.projectDescription,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : company_CompanyCode,
        },
    },
);



annotate AssetRequestService.Companies with {
    CompanyCode @(
        Common.Text : CompanyCodeName,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate AssetRequestService.AssetRequest with {
    project @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Projects',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : project_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterIn',
                    ValueListProperty: 'companyCode',
                    LocalDataProperty: company_CompanyCode,
                },


            ],
            Label : 'Projects',
        },
        Common.ValueListWithFixedValues : false,
        Common.Text : project.projectDescription,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate AssetRequestService.Projects with {
    ID @(
        Common.Text : projectDescription,
        Common.Text.@UI.TextArrangement : #TextOnly,
    )
};

annotate AssetRequestService.AssetRequest with {
    wbs @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'ProjectPlanning',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : wbs_ID,
                    ValueListProperty : 'ID',
                },
                {
                $Type            : 'Common.ValueListParameterIn',
                ValueListProperty: 'plshierarchy_ID',
                LocalDataProperty: project_ID
            }

            ],
            Label : 'WBS',
        },
        Common.ValueListWithFixedValues : false,
        Common.Text : wbs.projectElementDescription,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate AssetRequestService.ProjectPlanning with {
    ID @(
        Common.Text : projectElementDescription,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate AssetRequestService.AssetRequest with {
    boq @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'BillofQuantityHeader',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : boq_ID,
                    ValueListProperty : 'ID',
                },
                 {
                    $Type            : 'Common.ValueListParameterIn',
                    ValueListProperty: 'vrNo',
                    LocalDataProperty: vrNo,
                },

            ],
            Label : 'BOQ',
        },
        Common.ValueListWithFixedValues : false,
        Common.Text : vrNo,
)};

annotate AssetRequestService.BillofQuantityItems with {
    ID @(
        Common.Text : description,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate AssetRequestService.AssetRequest with {
    company @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'company',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : company_CompanyCode,
                    ValueListProperty : 'CompanyCode',
                },
            ],
            Label : 'Company',
        },
        Common.ValueListWithFixedValues : true,
        Common.Text : company.CompanyCodeName,
)};

annotate AssetRequestService.company with {
    CompanyCodeName @(
        Common.Text : CompanyCode,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate AssetRequestService.RequestAssetItems with @(
    UI.LineItem #i18nRequestAssetItem : [
        {
            $Type : 'UI.DataField',
            Value : cbsID,
            Label : '{i18n>Cbs}',
        },
        {
            $Type : 'UI.DataField',
            Value : resourceID,
            Label : '{i18n>Resource}',
        },
        {
            $Type : 'UI.DataField',
            Value : quantity,
            Label : '{i18n>Quantity}',
        },
        {
            $Type : 'UI.DataField',
            Value : fromDate,
            Label : '{i18n>FromDate}',
        },
        {
            $Type : 'UI.DataField',
            Value : toDate,
            Label : '{i18n>ToDate}',
        },
    ]
);

annotate AssetRequestService.company with {
    CompanyCode @Common.Text : CompanyCodeName
};

annotate AssetRequestService.AssetRequest with {
    company_CompanyCode @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'company',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : company_CompanyCode,
                    ValueListProperty : 'CompanyCode',
                },
            ],
            Label : 'Company Code',
        },
        Common.ValueListWithFixedValues : true,
)};

annotate AssetRequestService.BillofQuantityHeader with {
    ID @(
        Common.Text : vrNo,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

