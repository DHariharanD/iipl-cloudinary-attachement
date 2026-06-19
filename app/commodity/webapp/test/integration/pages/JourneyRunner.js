sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/commodity/test/integration/pages/CommoditiesList",
	"ns/commodity/test/integration/pages/CommoditiesObjectPage"
], function (JourneyRunner, CommoditiesList, CommoditiesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/commodity') + '/test/flpSandbox.html#nscommodity-tile',
        pages: {
			onTheCommoditiesList: CommoditiesList,
			onTheCommoditiesObjectPage: CommoditiesObjectPage
        },
        async: true
    });

    return runner;
});

