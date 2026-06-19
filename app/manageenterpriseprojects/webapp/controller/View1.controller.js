sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/Filter",
    "sap/ui/model/FilterOperator"
], function (Controller, Filter, FilterOperator) {
    "use strict";

    return Controller.extend("ns.manageenterpriseprojects.controller.View1", {

        onInit: function () {

        },

        onSearch: function () {

            var oTable = this.byId("projectTable");
            var oBinding = oTable.getBinding("items");

            var aFilters = [];

            // GET VALUES
            var sProject = this.byId("projectInput").getValue();
            var sProjectDesc = this.byId("projectDescInput").getValue();
            var sSearch = this.byId("globalSearch").getValue();

            // PROJECT FILTER
            if (sProject) {
                aFilters.push(
                    new Filter(
                        "Project",
                        FilterOperator.Contains,
                        sProject
                    )
                );
            }

            // PROJECT DESCRIPTION FILTER
            if (sProjectDesc) {
                aFilters.push(
                    new Filter(
                        "ProjectDescription",
                        FilterOperator.Contains,
                        sProjectDesc
                    )
                );
            }

            // GLOBAL SEARCH
            if (sSearch) {

                var oGlobalFilter = new Filter({
                    filters: [
                        new Filter("Project", FilterOperator.Contains, sSearch),
                        new Filter("ProjectDescription", FilterOperator.Contains, sSearch),
                        new Filter("ProjectCurrency", FilterOperator.Contains, sSearch)
                    ],
                    and: false
                });

                aFilters.push(oGlobalFilter);
            }

            // APPLY FILTERS
            oBinding.filter(aFilters);
        },

        onClear: function () {

            this.byId("projectInput").setValue("");
            this.byId("projectDescInput").setValue("");
            this.byId("globalSearch").setValue("");

            var oTable = this.byId("projectTable");
            oTable.getBinding("items").filter([]);
        },

        onItemPress: function (oEvent) {

            // GET CLICKED ROW
            var oItem = oEvent.getParameter("listItem") || oEvent.getSource();

            // GET BINDING CONTEXT
            var oContext = oItem.getBindingContext();

            if (!oContext) {
                return;
            }

            // GET UUID
            var sUUID = oContext.getProperty("ProjectUUID");

            // NAVIGATE
            this.getOwnerComponent().getRouter().navTo("RouteDetail", {
                projectId: sUUID
            });
        },

        onCreatePress: function () {

            this.getOwnerComponent().getRouter().navTo("RouteCreate");
        }

    });
});