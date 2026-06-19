sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/assettype/test/integration/pages/AssetTypesList",
	"ns/assettype/test/integration/pages/AssetTypesObjectPage"
], function (JourneyRunner, AssetTypesList, AssetTypesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/assettype') + '/test/flpSandbox.html#nsassettype-tile',
        pages: {
			onTheAssetTypesList: AssetTypesList,
			onTheAssetTypesObjectPage: AssetTypesObjectPage
        },
        async: true
    });

    return runner;
});

