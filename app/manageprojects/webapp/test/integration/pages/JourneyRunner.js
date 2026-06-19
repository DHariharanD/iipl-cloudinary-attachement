sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/manageprojects/test/integration/pages/ProjectsecList",
	"ns/manageprojects/test/integration/pages/ProjectsecObjectPage"
], function (JourneyRunner, ProjectsecList, ProjectsecObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/manageprojects') + '/test/flpSandbox.html#nsmanageprojects-tile',
        pages: {
			onTheProjectsecList: ProjectsecList,
			onTheProjectsecObjectPage: ProjectsecObjectPage
        },
        async: true
    });

    return runner;
});

