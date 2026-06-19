sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/documents/test/integration/pages/DocumentDefsList",
	"ns/documents/test/integration/pages/DocumentDefsObjectPage"
], function (JourneyRunner, DocumentDefsList, DocumentDefsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/documents') + '/test/flpSandbox.html#nsdocuments-tile',
        pages: {
			onTheDocumentDefsList: DocumentDefsList,
			onTheDocumentDefsObjectPage: DocumentDefsObjectPage
        },
        async: true
    });

    return runner;
});

