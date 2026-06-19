sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/costbreakdownstructure/test/integration/pages/CostBreakdownStructureList",
	"ns/costbreakdownstructure/test/integration/pages/CostBreakdownStructureObjectPage"
], function (JourneyRunner, CostBreakdownStructureList, CostBreakdownStructureObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/costbreakdownstructure') + '/test/flpSandbox.html#nscostbreakdownstructure-tile',
        pages: {
			onTheCostBreakdownStructureList: CostBreakdownStructureList,
			onTheCostBreakdownStructureObjectPage: CostBreakdownStructureObjectPage
        },
        async: true
    });

    return runner;
});

