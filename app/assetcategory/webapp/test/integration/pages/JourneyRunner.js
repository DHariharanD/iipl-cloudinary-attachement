sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/assetcategory/test/integration/pages/AssetCategoryList",
	"ns/assetcategory/test/integration/pages/AssetCategoryObjectPage"
], function (JourneyRunner, AssetCategoryList, AssetCategoryObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/assetcategory') + '/test/flpSandbox.html#nsassetcategory-tile',
        pages: {
			onTheAssetCategoryList: AssetCategoryList,
			onTheAssetCategoryObjectPage: AssetCategoryObjectPage
        },
        async: true
    });

    return runner;
});

