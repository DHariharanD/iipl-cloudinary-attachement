sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/ui/model/Filter",
    "sap/ui/model/FilterOperator"
], function (Controller, JSONModel, Filter, FilterOperator) {
    "use strict";

    return Controller.extend("ns.manageenterpriseprojects.controller.Detail", {

        onInit: function () {
            this.getOwnerComponent().getRouter()
                .getRoute("RouteDetail")
                .attachPatternMatched(this._onObjectMatched, this);
        },

        onBack: function () {
            this.getOwnerComponent().getRouter().navTo("RouteView1");
        },

        _onObjectMatched: function (oEvent) {

            var sProjectId = oEvent.getParameter("arguments").projectId;
            var oModel = this.getView().getModel();

            var that = this;

            // OData V4 Binding
            var oBinding = oModel.bindList("/ProjectElement", null, null, [
                new Filter("ProjectUUID", FilterOperator.EQ, sProjectId)
            ]);

            oBinding.requestContexts().then(function (aContexts) {

                // Convert contexts to plain objects
                var aFlatData = aContexts.map(function (oContext) {
                    return oContext.getObject();
                });

                console.log("Flat Data:", aFlatData);

                // ================= HEADER MODEL =================
                // Take first object for detail screen
                var oDetailModel = new JSONModel(aFlatData[0] || {});
                that.getView().setModel(oDetailModel, "detailModel");

                // ================= TREE MODEL =================
                var oTree = that._buildTree(aFlatData);

                var oTreeModel = new JSONModel(oTree);
                that.getView().setModel(oTreeModel, "treeModel");

                console.log("Tree Data:", oTree);

            }).catch(function (err) {
                console.error("Error fetching data", err);
            });
        },

        // 🌳 SAME TREE LOGIC
        _buildTree: function (aData) {

            var mMap = {};
            var aRoots = [];

            aData.forEach(function (oItem) {
                oItem.children = [];
                mMap[oItem.ProjectElementUUID] = oItem;
            });

            aData.forEach(function (oItem) {

                if (
                    !oItem.ParentObjectUUID ||
                    oItem.ParentObjectUUID === "00000000-0000-0000-0000-000000000000"
                ) {
                    aRoots.push(oItem);
                } else {
                    var oParent = mMap[oItem.ParentObjectUUID];
                    if (oParent) {
                        oParent.children.push(oItem);
                    }
                }
            });

            return aRoots;
        }

    });
});