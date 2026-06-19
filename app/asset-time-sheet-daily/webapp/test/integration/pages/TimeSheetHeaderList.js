sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'ns.com.asset.timesheet.daily.assettimesheetdaily',
            componentId: 'TimeSheetHeaderList',
            contextPath: '/TimeSheetHeader'
        },
        CustomPageDefinitions
    );
});