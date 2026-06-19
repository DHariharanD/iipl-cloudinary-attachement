sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/fuel/test/integration/pages/fuelRequestList",
	"ns/fuel/test/integration/pages/fuelRequestObjectPage"
], function (JourneyRunner, fuelRequestList, fuelRequestObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/fuel') + '/test/flpSandbox.html#nsfuel-tile',
        pages: {
			onThefuelRequestList: fuelRequestList,
			onThefuelRequestObjectPage: fuelRequestObjectPage
        },
        async: true
    });

    return runner;
});

