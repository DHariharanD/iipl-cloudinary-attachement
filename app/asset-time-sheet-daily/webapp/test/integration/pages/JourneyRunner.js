sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/com/asset/timesheet/daily/assettimesheetdaily/test/integration/pages/TimeSheetHeaderList",
	"ns/com/asset/timesheet/daily/assettimesheetdaily/test/integration/pages/TimeSheetHeaderObjectPage",
	"ns/com/asset/timesheet/daily/assettimesheetdaily/test/integration/pages/AssetTimeSheetsObjectPage"
], function (JourneyRunner, TimeSheetHeaderList, TimeSheetHeaderObjectPage, AssetTimeSheetsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/com/asset/timesheet/daily/assettimesheetdaily') + '/test/flpSandbox.html#nscomassettimesheetdailyassett-tile',
        pages: {
			onTheTimeSheetHeaderList: TimeSheetHeaderList,
			onTheTimeSheetHeaderObjectPage: TimeSheetHeaderObjectPage,
			onTheAssetTimeSheetsObjectPage: AssetTimeSheetsObjectPage
        },
        async: true
    });

    return runner;
});

