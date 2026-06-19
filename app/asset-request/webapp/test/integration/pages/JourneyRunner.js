sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/assetrequest/test/integration/pages/AssetRequestList",
	"ns/assetrequest/test/integration/pages/AssetRequestObjectPage"
], function (JourneyRunner, AssetRequestList, AssetRequestObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/assetrequest') + '/test/flpSandbox.html#nsassetrequest-tile',
        pages: {
			onTheAssetRequestList: AssetRequestList,
			onTheAssetRequestObjectPage: AssetRequestObjectPage
        },
        async: true
    });

    return runner;
});

