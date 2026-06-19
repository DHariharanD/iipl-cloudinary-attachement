sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"employeedetails/test/integration/pages/EmployeeDetailsList",
	"employeedetails/test/integration/pages/EmployeeDetailsObjectPage"
], function (JourneyRunner, EmployeeDetailsList, EmployeeDetailsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('employeedetails') + '/test/flpSandbox.html#employeedetails-tile',
        pages: {
			onTheEmployeeDetailsList: EmployeeDetailsList,
			onTheEmployeeDetailsObjectPage: EmployeeDetailsObjectPage
        },
        async: true
    });

    return runner;
});

