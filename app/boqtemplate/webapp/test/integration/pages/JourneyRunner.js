sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/boqtemplate/test/integration/pages/BillofQuantityTemplatesList",
	"ns/boqtemplate/test/integration/pages/BillofQuantityTemplatesObjectPage"
], function (JourneyRunner, BillofQuantityTemplatesList, BillofQuantityTemplatesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/boqtemplate') + '/test/flpSandbox.html#nsboqtemplate-tile',
        pages: {
			onTheBillofQuantityTemplatesList: BillofQuantityTemplatesList,
			onTheBillofQuantityTemplatesObjectPage: BillofQuantityTemplatesObjectPage
        },
        async: true
    });

    return runner;
});

