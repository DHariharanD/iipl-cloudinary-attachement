sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/boqcontract/test/integration/pages/BOQContractList",
	"ns/boqcontract/test/integration/pages/BOQContractObjectPage"
], function (JourneyRunner, BOQContractList, BOQContractObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/boqcontract') + '/test/flpSandbox.html#nsboqcontract-tile',
        pages: {
			onTheBOQContractList: BOQContractList,
			onTheBOQContractObjectPage: BOQContractObjectPage
        },
        async: true
    });

    return runner;
});

