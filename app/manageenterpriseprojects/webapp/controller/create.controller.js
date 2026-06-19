sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/m/MessageToast"
], function (Controller, JSONModel, MessageToast) {
    "use strict";

    return Controller.extend("ns.manageenterpriseprojects.controller.Create", {

        onInit: function () {
            var oModel = new JSONModel([]);
            this.getView().setModel(oModel, "treeModel");
        },

        onBack: function () {
            this.getOwnerComponent().getRouter().navTo("RouteView1");
        },
        onAddParent: function () {
            var oModel = this.getView().getModel("treeModel");
            var aData = oModel.getData();
            if (aData.length > 0) {
                MessageToast.show("Only one parent allowed");
                return;
            }
            aData.push({
                ProjectElementDescription: "New Parent",
                ProjectElement: "P-1",
                children: []
            });
            oModel.setData(aData);
        },

        onAddChild: function () {

            var oTable = this.byId("treeTable");
            var iIndex = oTable.getSelectedIndex();
            if (iIndex === -1) {
                MessageToast.show("Select parent first");
                return;
            }
            var oContext = oTable.getContextByIndex(iIndex);
            var oNode = oContext.getObject();
            if (oNode.children && oNode.children.length >= 0) {
                if (oNode.children === undefined) {
                    oNode.children = [];
                }
                oNode.children.push({
                    ProjectElementDescription: "New Child",
                    ProjectElement: "C-" + (oNode.children.length + 1),
                    children: [] // keep empty but won't allow deeper add
                });
                this.getView().getModel("treeModel").refresh();
            }
        },


        onSave: function () {
            var oView = this.getView();
            var oHeader = {
                Project: oView.byId("projectId").getValue(),
                ProjectDescription: oView.byId("projectName").getValue(),
                EnterpriseProjectType: oView.byId("enpttype").getValue(),
                ProjectProfileCode: oView.byId("enprofilecode").getValue(),
                CompanyCode: oView.byId("enempcode").getValue(),
                ProjectStartDate: oView.byId("startDate").getValue(),
                ProjectEndDate: oView.byId("endDate").getValue(),
                PriorityCode: oView.byId("profile").getValue(),
                ProfitCenter: oView.byId("enpc").getValue(),
                ResponsibleCostCenter: oView.byId("encc").getValue(),
                ProjectCurrency: "AED"
            };
            var aTree = oView.getModel("treeModel").getData();
            console.log("Header:", oHeader);
            console.log("Tree:", aTree);
            MessageToast.show("Data Ready (Next: Save to CAP)");
        },
    });
});