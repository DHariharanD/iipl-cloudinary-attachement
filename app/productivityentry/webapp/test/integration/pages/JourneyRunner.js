sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/productivityentry/test/integration/pages/DailyProductivityVoucherList",
	"ns/productivityentry/test/integration/pages/DailyProductivityVoucherObjectPage"
], function (JourneyRunner, DailyProductivityVoucherList, DailyProductivityVoucherObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/productivityentry') + '/test/flpSandbox.html#nsproductivityentry-tile',
        pages: {
			onTheDailyProductivityVoucherList: DailyProductivityVoucherList,
			onTheDailyProductivityVoucherObjectPage: DailyProductivityVoucherObjectPage
        },
        async: true
    });

    return runner;
});

