sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/bpapp/test/integration/pages/BusinessPartnersMain"
], function (JourneyRunner, BusinessPartnersMain) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/bpapp') + '/test/flpSandbox.html#nsbpapp-tile',
        pages: {
			onTheBusinessPartnersMain: BusinessPartnersMain
        },
        async: true
    });

    return runner;
});

