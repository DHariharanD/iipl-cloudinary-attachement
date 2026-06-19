using BOQContractService as service from '../../srv/boq-contract-service';

annotate service.BOQContract with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Vr No.',
                Value: vrNo,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Vr Date',
                Value: vrDate,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Type',
                Value: type_code,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Project',
                Value: project,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Project Description',
                Value: projectDesc,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Sub Job',
                Value: subJob,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Sub Job Description',
                Value: subJobDesc,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Sub Contract Type',
                Value: subContractType,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Start Sr No',
                Value: startSrNo,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Request No.',
                Value: requestNo,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Agreement Vr',
                Value: agreementVrNo,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Agreement Name',
                Value: agreementName,
            },
        ],
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : '{i18n>GeneralInformation}',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Items',
            ID    : 'i18nSubContractItems',
            Target: 'items/@UI.LineItem#i18nSubContractItems',
        },
    ],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Label: 'Vr No.',
            Value: vrNo,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Vr Date',
            Value: vrDate,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Type}',
            Value: type_code,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Project',
            Value: project,
        },
        {
            $Type: 'UI.DataField',
            Value: agreementVrNo,
            Label: 'Agreement Vr',
        },
        {
            $Type: 'UI.DataField',
            Value: agreementName,
            Label: 'Agreement Name',
        },
        {
            $Type: 'UI.DataField',
            Value: subJob,
            Label: 'Sub Job',
        },
        {
            $Type: 'UI.DataField',
            Value: subContractType,
            Label: 'Sub Contract Type',
        },
        {
            $Type: 'UI.DataField',
            Value: requestNo,
            Label: 'Request No.',
        },
        {
            $Type: 'UI.DataField',
            Value: startSrNo,
            Label: 'Starts No.',
        },
        {
            $Type: 'UI.DataField',
            Value: subJobDesc,
            Label: 'Sub Job Desc',
        },
    ],
    UI.SelectionFields           : [
        project,
        subContractType,
        subJob,
    ],
    UI.HeaderInfo                : {
        TypeName      : '{i18n>Name}',
        TypeNamePlural: '',
        Description   : {
            $Type: 'UI.DataField',
            Value: projectDesc,
        },
    },
);

annotate service.BOQContract with {
    project @Common.Label: '{i18n>Project}'
};

annotate service.BOQContract with {
    subContractType @Common.Label: 'Sub Contract Type'
};

annotate service.BOQContract with {
    subJob @Common.Label: 'Sub Job'
};

annotate service.ContractItems with @(UI.LineItem #i18nSubContractItems: [
    {
        $Type                : 'UI.DataField',
        Value                : resource,
        Label                : '{i18n>Resource}',
        ![@HTML5.CssDefaults]: {width: '10rem'},
    },
    {
        $Type                : 'UI.DataField',
        Value                : resourceName,
        Label                : 'Resource Name',
        ![@HTML5.CssDefaults]: {width: '12rem'},
    },
    {
        $Type                : 'UI.DataField',
        Value                : costCode,
        Label                : 'Cost Code',
        ![@HTML5.CssDefaults]: {width: '8rem'},
    },
    {
        $Type                : 'UI.DataField',
        Value                : costCodeDescription,
        Label                : 'Cost Code Description',
        ![@HTML5.CssDefaults]: {width: '12rem'},
    },
    {
        $Type                : 'UI.DataField',
        Value                : wbs,
        Label                : '{i18n>Wbs}',
        ![@HTML5.CssDefaults]: {width: '8rem'},
    },
    {
        $Type                : 'UI.DataField',
        Value                : unit,
        Label                : '{i18n>Unit}',
        ![@HTML5.CssDefaults]: {width: '5rem'},
    },
    {
        $Type                : 'UI.DataField',
        Value                : quantity,
        Label                : 'Quantity',
        ![@HTML5.CssDefaults]: {width: '8rem'},
    },
    {
        $Type                : 'UI.DataField',
        Value                : rate,
        Label                : '{i18n>Rate}',
        ![@HTML5.CssDefaults]: {width: '7rem'},
    },
    {
        $Type                : 'UI.DataField',
        Value                : discountPercent,
        Label                : 'Discount %',
        ![@HTML5.CssDefaults]: {width: '8rem'},
    },
    {
        $Type                : 'UI.DataField',
        Value                : discountedRate,
        Label                : 'Discounted Rate',
        ![@HTML5.CssDefaults]: {width: '9rem'},
    },
    {
        $Type                : 'UI.DataField',
        Value                : amount,
        Label                : '{i18n>Amount}',
        ![@HTML5.CssDefaults]: {width: '8rem'},
    },
    {
        $Type                : 'UI.DataField',
        Value                : vatRate,
        Label                : 'Vat Rate',
        ![@HTML5.CssDefaults]: {width: '6rem'},
    },
]);