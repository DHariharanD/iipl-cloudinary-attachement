sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/enterpriseprojects/test/integration/pages/ProjectsList",
	"ns/enterpriseprojects/test/integration/pages/ProjectsObjectPage"
], function (JourneyRunner, ProjectsList, ProjectsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/enterpriseprojects') + '/test/flpSandbox.html#nsenterpriseprojects-tile',
        pages: {
			onTheProjectsList: ProjectsList,
			onTheProjectsObjectPage: ProjectsObjectPage
        },
        async: true
    });

    return runner;
});

