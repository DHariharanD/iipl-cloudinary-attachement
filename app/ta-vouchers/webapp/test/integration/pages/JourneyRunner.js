sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/tavouchers/test/integration/pages/TAVouchersList",
	"ns/tavouchers/test/integration/pages/TAVouchersObjectPage"
], function (JourneyRunner, TAVouchersList, TAVouchersObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/tavouchers') + '/test/flpSandbox.html#nstavouchers-tile',
        pages: {
			onTheTAVouchersList: TAVouchersList,
			onTheTAVouchersObjectPage: TAVouchersObjectPage
        },
        async: true
    });

    return runner;
});

