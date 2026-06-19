sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/assetgroup/test/integration/pages/AssetGroupsList",
	"ns/assetgroup/test/integration/pages/AssetGroupsObjectPage"
], function (JourneyRunner, AssetGroupsList, AssetGroupsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/assetgroup') + '/test/flpSandbox.html#nsassetgroup-tile',
        pages: {
			onTheAssetGroupsList: AssetGroupsList,
			onTheAssetGroupsObjectPage: AssetGroupsObjectPage
        },
        async: true
    });

    return runner;
});

