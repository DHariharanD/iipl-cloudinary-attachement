sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/assetinfo/test/integration/pages/AssetInfoList",
	"ns/assetinfo/test/integration/pages/AssetInfoObjectPage"
], function (JourneyRunner, AssetInfoList, AssetInfoObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/assetinfo') + '/test/flpSandbox.html#nsassetinfo-tile',
        pages: {
			onTheAssetInfoList: AssetInfoList,
			onTheAssetInfoObjectPage: AssetInfoObjectPage
        },
        async: true
    });

    return runner;
});

