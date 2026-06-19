using WbsService as service from '../../srv/wbs-service';
annotate service.wbs with @(
    UI.SelectionFields : [
        Project,
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : Project,
        },
        {
            $Type : 'UI.DataField',
            Value : ProjectDescription,
            Label : '{i18n>ProjectDescription}',
        },
        {
            $Type : 'UI.DataField',
            Value : ProjectStartDate,
            Label : '{i18n>ProjectStartDate}',
        },
        {
            $Type : 'UI.DataField',
            Value : ProjectEndDate,
            Label : '{i18n>ProjectEndDate}',
        },
        {
            $Type : 'UI.DataField',
            Value : ProjectCurrency,
            Label : '{i18n>ProjectCurrency}',
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'WBS Details',
            ID : 'WBSDetails',
            Target : 'wbspjHierarchies/@UI.LineItem#WBSDetails',
        },
    ],
    UI.HeaderInfo : {
        TypeName : '{i18n>WbsTemplate}',
        TypeNamePlural : '{i18n>WbsTemplate}',
        Title : {
            $Type : 'UI.DataField',
            Value : ProjectDescription,
        },
        TypeImageUrl : 'sap-icon://globe',
    },
);

annotate service.wbs with {
    Project @Common.Label : 'Project'
};

annotate service.wbs with {
    ID @UI.Hidden;
};

annotate service.wbsElement with @(
    UI.LineItem #WBSDetails : [
        {
            $Type : 'UI.DataField',
            Value : name,
            Label : '{i18n>Name}',
        },
        {
            $Type : 'UI.DataField',
            Value : wbsId,
            Label : '{i18n>Id}',
        },
        {
            $Type : 'UI.DataField',
            Value : processingStatus,
            Label : '{i18n>ProcessingStatus}',
        },
        {
            $Type : 'UI.DataField',
            Value : plannedStart,
            Label : '{i18n>PlannedStart}',
        },
        {
            $Type : 'UI.DataField',
            Value : plannedFinish,
            Label : '{i18n>PlannedFinish}',
        },
        {
            $Type : 'UI.DataField',
            Value : responsiableCostCenter,
            Label : '{i18n>ResponsiableCostCenter}',
        },
        {
            $Type : 'UI.DataField',
            Value : profitCenter,
            Label : '{i18n>ProfitCenter}',
        },
        {
            $Type : 'UI.DataField',
            Value : company_CompanyCode,
            Label : '{i18n>CompanyCode}',
        },
    ]
);

annotate service.wbsElement with {
    company @(
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
            Label : 'Company',
        },
        Common.ValueListWithFixedValues : true,
)};

annotate service.Companies with {
    CompanyCode @Common.Text : CompanyCodeName
};

annotate service.wbsElement with {
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

