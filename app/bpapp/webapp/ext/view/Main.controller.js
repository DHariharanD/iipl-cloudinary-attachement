sap.ui.define(
    [
        'sap/fe/core/PageController',
        'sap/m/MessageToast'
    ],
    function (PageController, MessageToast) {
        'use strict';

        return PageController.extend('ns.bpapp.ext.view.Main', {

            onInit: function () {
                PageController.prototype.onInit.apply(this, arguments);

                var oModel = this.getAppComponent().getModel();
                if (!oModel) {
                    oModel = this.getOwnerComponent().getModel();
                }

                var oListBinding = oModel.bindList("/BusinessPartners", null, null, null, {
                    "$$updateGroupId": "mySaveGroup"
                });

                // ✅ Store the context as a variable on the controller (this._oContext)
                this._oContext = oListBinding.create({
                    BusinessPartnerCategory: "1",
                    BusinessPartnerGrouping: "BP02",
                    FirstName: "",
                    LastName: ""
                });

                this.getView().setBindingContext(this._oContext);
            },

             onSave: async function () {
                var oModel = this.getView().getModel();
                var oContext = this._oContext;
                if (!oContext) {
                    MessageToast.show("No data context found to save.");
                    return;
                }
                try {
                    await oModel.submitBatch("mySaveGroup");
                    await oContext.created();
                    var sId = oContext.getProperty("BusinessPartner");
                    MessageToast.show("Business Partner " + sId + " Created Successfully");

                } catch (oError) {
                    console.error("Save Error:", oError);
                    MessageToast.show("Creation failed. Check console for S/4 response.");
                }
            },
            onCancel: function () {
                var oModel = this.getView().getModel();

                if (oModel) {
                    // discard changes
                    oModel.resetChanges();
                }

                // navigate back
                this.getOwnerComponent().getRouter().navTo("RouteMain");
            }

        });
    }
);