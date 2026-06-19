sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/assetmodel/test/integration/pages/AssetModelList",
	"ns/assetmodel/test/integration/pages/AssetModelObjectPage"
], function (JourneyRunner, AssetModelList, AssetModelObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/assetmodel') + '/test/flpSandbox.html#nsassetmodel-tile',
        pages: {
			onTheAssetModelList: AssetModelList,
			onTheAssetModelObjectPage: AssetModelObjectPage
        },
        async: true
    });

    return runner;
});

