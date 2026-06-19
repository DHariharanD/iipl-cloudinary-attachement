sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/employeemaster/test/integration/pages/EmployeeMasterList",
	"ns/employeemaster/test/integration/pages/EmployeeMasterObjectPage"
], function (JourneyRunner, EmployeeMasterList, EmployeeMasterObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/employeemaster') + '/test/flpSandbox.html#nsemployeemaster-tile',
        pages: {
			onTheEmployeeMasterList: EmployeeMasterList,
			onTheEmployeeMasterObjectPage: EmployeeMasterObjectPage
        },
        async: true
    });

    return runner;
});

