sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/resourcecategories/test/integration/FirstJourney',
		'ns/resourcecategories/test/integration/pages/ResourceCategoriesList',
		'ns/resourcecategories/test/integration/pages/ResourceCategoriesObjectPage'
    ],
    function(JourneyRunner, opaJourney, ResourceCategoriesList, ResourceCategoriesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/resourcecategories') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheResourceCategoriesList: ResourceCategoriesList,
					onTheResourceCategoriesObjectPage: ResourceCategoriesObjectPage
                }
            },
            opaJourney.run
        );
    }
);