sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/projectprimaveramapping/test/integration/pages/ProjectPrimaveraMappingList",
	"ns/projectprimaveramapping/test/integration/pages/ProjectPrimaveraMappingObjectPage"
], function (JourneyRunner, ProjectPrimaveraMappingList, ProjectPrimaveraMappingObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/projectprimaveramapping') + '/test/flpSandbox.html#nsprojectprimaveramapping-tile',
        pages: {
			onTheProjectPrimaveraMappingList: ProjectPrimaveraMappingList,
			onTheProjectPrimaveraMappingObjectPage: ProjectPrimaveraMappingObjectPage
        },
        async: true
    });

    return runner;
});

