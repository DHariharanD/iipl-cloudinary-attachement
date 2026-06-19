sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/projectboqmapping/test/integration/pages/ProjectBOQMappingList",
	"ns/projectboqmapping/test/integration/pages/ProjectBOQMappingObjectPage"
], function (JourneyRunner, ProjectBOQMappingList, ProjectBOQMappingObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/projectboqmapping') + '/test/flpSandbox.html#nsprojectboqmapping-tile',
        pages: {
			onTheProjectBOQMappingList: ProjectBOQMappingList,
			onTheProjectBOQMappingObjectPage: ProjectBOQMappingObjectPage
        },
        async: true
    });

    return runner;
});

