sap.ui.define([
    "sap/ui/test/opaQunit",
    "./pages/JourneyRunner"
], function (opaTest, runner) {
    "use strict";

    function journey() {
        QUnit.module("First journey");

        opaTest("Start application", function (Given, When, Then) {
            Given.iStartMyApp();

            Then.onThefuelRequestList.iSeeThisPage();
            Then.onThefuelRequestList.onTable().iCheckColumns(3, {"vehicle_ID":{"header":"Vehicle"},"Driver":{"header":"driver"},"Status":{"header":"status"}});

        });


        opaTest("Navigate to ObjectPage", function (Given, When, Then) {
            // Note: this test will fail if the ListReport page doesn't show any data
            
            When.onThefuelRequestList.onFilterBar().iExecuteSearch();
            
            Then.onThefuelRequestList.onTable().iCheckRows();

            When.onThefuelRequestList.onTable().iPressRow(0);
            Then.onThefuelRequestObjectPage.iSeeThisPage();

        });

        opaTest("Teardown", function (Given, When, Then) { 
            // Cleanup
            Given.iTearDownMyApp();
        });
    }

    runner.run([journey]);
});