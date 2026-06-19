sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/projectprimaverawbsmapping/test/integration/pages/PrimaveraProjectsList",
	"ns/projectprimaverawbsmapping/test/integration/pages/PrimaveraProjectsObjectPage"
], function (JourneyRunner, PrimaveraProjectsList, PrimaveraProjectsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/projectprimaverawbsmapping') + '/test/flpSandbox.html#nsprojectprimaverawbsmapping-tile',
        pages: {
			onThePrimaveraProjectsList: PrimaveraProjectsList,
			onThePrimaveraProjectsObjectPage: PrimaveraProjectsObjectPage
        },
        async: true
    });

    return runner;
});

