sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/resourcehierarchies/test/integration/FirstJourney',
		'ns/resourcehierarchies/test/integration/pages/ResourceHierarchiesList',
		'ns/resourcehierarchies/test/integration/pages/ResourceHierarchiesObjectPage'
    ],
    function(JourneyRunner, opaJourney, ResourceHierarchiesList, ResourceHierarchiesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/resourcehierarchies') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheResourceHierarchiesList: ResourceHierarchiesList,
					onTheResourceHierarchiesObjectPage: ResourceHierarchiesObjectPage
                }
            },
            opaJourney.run
        );
    }
);