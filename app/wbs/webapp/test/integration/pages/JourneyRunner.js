sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/wbs/test/integration/pages/wbsList",
	"ns/wbs/test/integration/pages/wbsObjectPage"
], function (JourneyRunner, wbsList, wbsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/wbs') + '/test/flpSandbox.html#nswbs-tile',
        pages: {
			onThewbsList: wbsList,
			onThewbsObjectPage: wbsObjectPage
        },
        async: true
    });

    return runner;
});

