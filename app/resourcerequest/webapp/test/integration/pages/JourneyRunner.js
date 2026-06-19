sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/resourcerequest/test/integration/pages/ResourceRequestsList",
	"ns/resourcerequest/test/integration/pages/ResourceRequestsObjectPage"
], function (JourneyRunner, ResourceRequestsList, ResourceRequestsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/resourcerequest') + '/test/flpSandbox.html#nsresourcerequest-tile',
        pages: {
			onTheResourceRequestsList: ResourceRequestsList,
			onTheResourceRequestsObjectPage: ResourceRequestsObjectPage
        },
        async: true
    });

    return runner;
});

