sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/assetservice/test/integration/pages/AssetList",
	"ns/assetservice/test/integration/pages/AssetObjectPage"
], function (JourneyRunner, AssetList, AssetObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/assetservice') + '/test/flpSandbox.html#nsassetservice-tile',
        pages: {
			onTheAssetList: AssetList,
			onTheAssetObjectPage: AssetObjectPage
        },
        async: true
    });

    return runner;
});

