sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/assetmaster/test/integration/pages/AssetMasterList",
	"ns/assetmaster/test/integration/pages/AssetMasterObjectPage"
], function (JourneyRunner, AssetMasterList, AssetMasterObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/assetmaster') + '/test/flpSandbox.html#nsassetmaster-tile',
        pages: {
			onTheAssetMasterList: AssetMasterList,
			onTheAssetMasterObjectPage: AssetMasterObjectPage
        },
        async: true
    });

    return runner;
});

