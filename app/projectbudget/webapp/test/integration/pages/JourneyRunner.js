sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/projectbudget/test/integration/pages/ProjectBudgetList",
	"ns/projectbudget/test/integration/pages/ProjectBudgetObjectPage"
], function (JourneyRunner, ProjectBudgetList, ProjectBudgetObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/projectbudget') + '/test/flpSandbox.html#nsprojectbudget-tile',
        pages: {
			onTheProjectBudgetList: ProjectBudgetList,
			onTheProjectBudgetObjectPage: ProjectBudgetObjectPage
        },
        async: true
    });

    return runner;
});

