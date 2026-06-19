sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/customerapplication/test/integration/pages/CustomerList",
	"ns/customerapplication/test/integration/pages/CustomerObjectPage"
], function (JourneyRunner, CustomerList, CustomerObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/customerapplication') + '/test/flpSandbox.html#nscustomerapplication-tile',
        pages: {
			onTheCustomerList: CustomerList,
			onTheCustomerObjectPage: CustomerObjectPage
        },
        async: true
    });

    return runner;
});

