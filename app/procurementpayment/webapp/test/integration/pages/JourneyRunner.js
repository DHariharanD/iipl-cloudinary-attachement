sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/procurementpayment/test/integration/pages/procurementPaymentList",
	"ns/procurementpayment/test/integration/pages/procurementPaymentObjectPage"
], function (JourneyRunner, procurementPaymentList, procurementPaymentObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/procurementpayment') + '/test/flpSandbox.html#nsprocurementpayment-tile',
        pages: {
			onTheprocurementPaymentList: procurementPaymentList,
			onTheprocurementPaymentObjectPage: procurementPaymentObjectPage
        },
        async: true
    });

    return runner;
});

