sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/consumptionrates/test/integration/pages/ConsumptionRatesList",
	"ns/consumptionrates/test/integration/pages/ConsumptionRatesObjectPage"
], function (JourneyRunner, ConsumptionRatesList, ConsumptionRatesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/consumptionrates') + '/test/flpSandbox.html#nsconsumptionrates-tile',
        pages: {
			onTheConsumptionRatesList: ConsumptionRatesList,
			onTheConsumptionRatesObjectPage: ConsumptionRatesObjectPage
        },
        async: true
    });

    return runner;
});

