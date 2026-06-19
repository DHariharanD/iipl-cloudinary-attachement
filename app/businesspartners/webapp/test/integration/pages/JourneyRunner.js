sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/businesspartners/test/integration/pages/BusinessPartnersList",
	"ns/businesspartners/test/integration/pages/BusinessPartnersObjectPage"
], function (JourneyRunner, BusinessPartnersList, BusinessPartnersObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/businesspartners') + '/test/flpSandbox.html#nsbusinesspartners-tile',
        pages: {
			onTheBusinessPartnersList: BusinessPartnersList,
			onTheBusinessPartnersObjectPage: BusinessPartnersObjectPage
        },
        async: true
    });

    return runner;
});

