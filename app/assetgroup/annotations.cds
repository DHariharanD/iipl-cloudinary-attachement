using AssetGroupService as service from '../../srv/asset-group-service';

annotate service.AssetGroups with @(

    UI.LineItem                      : [
        {
            $Type: 'UI.DataField',
            Value: code,
            Label: 'Code',
        },
        {
            $Type: 'UI.DataField',
            Value: name,
            Label: 'Name',
        },
        {
            $Type: 'UI.DataField',
            Value: depreciationPercent,
            Label: 'Dep.%',
        },
        {
            $Type: 'UI.DataField',
            Value: depreciationType,
            Label: 'Dep. Type',
        },
        {
            $Type: 'UI.DataField',
            Value: depreciationMethod,
            Label: 'Dep. Method',
        },
        {
            $Type: 'UI.DataField',
            Value: assetCode,
            Label: 'Asset',
        },
        {
            $Type: 'UI.DataField',
            Value: assetGroupLevel,
            Label: 'Group Level',
        },
    ],

    UI.SelectionFields               : [
        code,
        name,
    ],

    UI.HeaderInfo                    : {
        TypeName      : 'Asset Group',
        TypeNamePlural: 'Asset Groups',
        Title         : {
            $Type: 'UI.DataField',
            Value: name,
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: code,
        },
    },

    UI.Facets                        : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneralInformation',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneralInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'AccountInfo',
            Label : 'Account Information',
            Target: '@UI.FieldGroup#AccountInfo',
        },
    ],

    UI.FieldGroup #GeneralInformation: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Code',
                Value: code,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Name',
                Value: name,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Arabic Name',
                Value: arabicName,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Level',
                Value: level,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Depreciation %',
                Value: depreciationPercent,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Depreciation Type',
                Value: depreciationType,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Depreciation Method',
                Value: depreciationMethod,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Revenue Generation',
                Value: revenueGeneration,
            },
            {
                $Type: 'UI.DataField',
                Label: 'PMVE Service Applicable',
                Value: pmveServiceApplicable,
            },
        ],
    },

    UI.FieldGroup #AccountInfo       : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Asset Account',
                Value: assetAccount,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Asset Account Desc',
                Value: assetAccountDesc,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Accum. Dep. Account',
                Value: accumDepAccount,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Accum. Dep. Account Desc',
                Value: accumDepAccountDesc,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Service Expense Account',
                Value: serviceExpenseAccount,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Service Expense Desc',
                Value: serviceExpenseDesc,
            },
        ],
    },
);

annotate service.AssetGroups with {
    parent @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'AssetGroups',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: parent_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'level',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'code',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'name',
            },
        ],
    }
};

annotate service.AssetGroups with {
    code            @Common.Label: 'Code';
    name            @Common.Label: 'Name';
    assetCode       @Common.Label: 'Asset';
    assetGroupLevel @Common.Label: 'Group Level';
};
