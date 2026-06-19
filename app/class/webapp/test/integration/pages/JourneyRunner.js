sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/class/test/integration/pages/classList",
	"ns/class/test/integration/pages/classObjectPage"
], function (JourneyRunner, classList, classObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/class') + '/test/flpSandbox.html#nsclass-tile',
        pages: {
			onTheclassList: classList,
			onTheclassObjectPage: classObjectPage
        },
        async: true
    });

    return runner;
});

