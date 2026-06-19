sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/assetmake/test/integration/pages/AssetMakeList",
	"ns/assetmake/test/integration/pages/AssetMakeObjectPage"
], function (JourneyRunner, AssetMakeList, AssetMakeObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/assetmake') + '/test/flpSandbox.html#nsassetmake-tile',
        pages: {
			onTheAssetMakeList: AssetMakeList,
			onTheAssetMakeObjectPage: AssetMakeObjectPage
        },
        async: true
    });

    return runner;
});

