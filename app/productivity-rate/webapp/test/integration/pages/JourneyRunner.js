sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/productivityrate/test/integration/pages/ProductivityRatesList",
	"ns/productivityrate/test/integration/pages/ProductivityRatesObjectPage"
], function (JourneyRunner, ProductivityRatesList, ProductivityRatesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/productivityrate') + '/test/flpSandbox.html#nsproductivityrate-tile',
        pages: {
			onTheProductivityRatesList: ProductivityRatesList,
			onTheProductivityRatesObjectPage: ProductivityRatesObjectPage
        },
        async: true
    });

    return runner;
});

