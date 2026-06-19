sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/billofquantity/test/integration/pages/BillofQuantityHeaderList",
	"ns/billofquantity/test/integration/pages/BillofQuantityHeaderObjectPage"
], function (JourneyRunner, BillofQuantityHeaderList, BillofQuantityHeaderObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/billofquantity') + '/test/flpSandbox.html#nsbillofquantity-tile',
        pages: {
			onTheBillofQuantityHeaderList: BillofQuantityHeaderList,
			onTheBillofQuantityHeaderObjectPage: BillofQuantityHeaderObjectPage
        },
        async: true
    });

    return runner;
});

