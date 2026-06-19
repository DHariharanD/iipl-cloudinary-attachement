using ResourceServices as service from '../../srv/resource-type-service';
using from '../../srv/asset-group-service';
using from '../../db/assets/asset-group';

annotate AssetGroupService.AssetCategory with @(
    UI.SelectionFields : [
        assets,
        grouplevel,
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : assets,
        },
        {
            $Type : 'UI.DataField',
            Value : grouplevel,
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>AssetCategory}',
            ID : 'i18nAssetCategory',
            Target : 'groups/@UI.LineItem#i18nAssetCategory',
        },
    ],
    UI.HeaderInfo : {
        TypeName : 'Asset Category',
        TypeNamePlural : '',
        Title : {
            $Type : 'UI.DataField',
            Value : assets,
        },
    },
);

annotate AssetGroupService.AssetCategory with {
    assets @Common.Label : '{i18n>Assets}'
};

annotate AssetGroupService.AssetCategory with {
    grouplevel @Common.Label : '{i18n>Group}'
};

annotate AssetGroupService.AssetGroup with @(
    UI.LineItem #i18nAssetCategory : [
        {
            $Type : 'UI.DataField',
            Value : assetName,
            Label : '{i18n>Code}',
        },
        {
            $Type : 'UI.DataField',
            Value : groupName,
            Label : '{i18n>Name}',
        },
    ]
);

