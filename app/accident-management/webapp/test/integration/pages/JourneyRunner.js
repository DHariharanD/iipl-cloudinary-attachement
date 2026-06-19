sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/accidentmanagement/accidentmanagement/test/integration/pages/AccidentList",
	"ns/accidentmanagement/accidentmanagement/test/integration/pages/AccidentObjectPage"
], function (JourneyRunner, AccidentList, AccidentObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/accidentmanagement/accidentmanagement') + '/test/flpSandbox.html#nsaccidentmanagementaccidentma-tile',
        pages: {
			onTheAccidentList: AccidentList,
			onTheAccidentObjectPage: AccidentObjectPage
        },
        async: true
    });

    return runner;
});

