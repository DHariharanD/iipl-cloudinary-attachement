sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/allocations/test/integration/pages/AllocationsList",
	"ns/allocations/test/integration/pages/AllocationsObjectPage"
], function (JourneyRunner, AllocationsList, AllocationsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/allocations') + '/test/flpSandbox.html#nsallocations-tile',
        pages: {
			onTheAllocationsList: AllocationsList,
			onTheAllocationsObjectPage: AllocationsObjectPage
        },
        async: true
    });

    return runner;
});

