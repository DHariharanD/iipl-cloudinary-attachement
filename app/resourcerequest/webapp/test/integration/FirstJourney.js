sap.ui.define([
    "sap/ui/test/opaQunit",
    "./pages/JourneyRunner"
], function (opaTest, runner) {
    "use strict";

    function journey() {
        QUnit.module("First journey");

        opaTest("Start application", function (Given, When, Then) {
            Given.iStartMyApp();

            Then.onTheResourceRequestsList.iSeeThisPage();
            Then.onTheResourceRequestsList.onTable().iCheckColumns(1, {"project":{"header":"project"}});

        });


        opaTest("Navigate to ObjectPage", function (Given, When, Then) {
            // Note: this test will fail if the ListReport page doesn't show any data
            
            When.onTheResourceRequestsList.onFilterBar().iExecuteSearch();
            
            Then.onTheResourceRequestsList.onTable().iCheckRows();

            When.onTheResourceRequestsList.onTable().iPressRow(0);
            Then.onTheResourceRequestsObjectPage.iSeeThisPage();

        });

        opaTest("Teardown", function (Given, When, Then) { 
            // Cleanup
            Given.iTearDownMyApp();
        });
    }

    runner.run([journey]);
});