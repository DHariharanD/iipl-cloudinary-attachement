sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/costbreakdownhierarchy/test/integration/pages/CostBreakDownHierarchiesList",
	"ns/costbreakdownhierarchy/test/integration/pages/CostBreakDownHierarchiesObjectPage"
], function (JourneyRunner, CostBreakDownHierarchiesList, CostBreakDownHierarchiesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/costbreakdownhierarchy') + '/test/flpSandbox.html#nscostbreakdownhierarchy-tile',
        pages: {
			onTheCostBreakDownHierarchiesList: CostBreakDownHierarchiesList,
			onTheCostBreakDownHierarchiesObjectPage: CostBreakDownHierarchiesObjectPage
        },
        async: true
    });

    return runner;
});

