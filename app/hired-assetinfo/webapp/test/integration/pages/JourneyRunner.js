sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/hiredassetinfo/test/integration/pages/HiredAssetsList",
	"ns/hiredassetinfo/test/integration/pages/HiredAssetsObjectPage"
], function (JourneyRunner, HiredAssetsList, HiredAssetsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/hiredassetinfo') + '/test/flpSandbox.html#nshiredassetinfo-tile',
        pages: {
			onTheHiredAssetsList: HiredAssetsList,
			onTheHiredAssetsObjectPage: HiredAssetsObjectPage
        },
        async: true
    });

    return runner;
});

