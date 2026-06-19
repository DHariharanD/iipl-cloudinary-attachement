sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/trip/test/integration/pages/TripsList",
	"ns/trip/test/integration/pages/TripsObjectPage"
], function (JourneyRunner, TripsList, TripsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/trip') + '/test/flpSandbox.html#nstrip-tile',
        pages: {
			onTheTripsList: TripsList,
			onTheTripsObjectPage: TripsObjectPage
        },
        async: true
    });

    return runner;
});

