sap.ui.define([
    "sap/ui/core/mvc/ControllerExtension",
    "sap/m/MessageToast",
    "sap/ui/core/Fragment"
], function (ControllerExtension, MessageToast, Fragment) {
    "use strict";


    return ControllerExtension.extend("ns.commodity.ext.controller.CommodityListReportExt", {

        override: {
            onAfterRendering: function () {

                var oView = this.base.getView();

                var aTables = oView.findAggregatedObjects(true, function (o) {
                    return o.isA("sap.ui.mdc.Table");
                });

                if (!aTables.length) return;

                var oTable = aTables[0];

                if (this._bAttached) return;

                oTable.attachRowPress(async function (oEvent) {

                    var oContext = oEvent.getParameter("bindingContext");
                    if (!oContext) return;

                    if (this._oDialog) {
                        this._oDialog.destroy();
                        this._oDialog = null;
                    }

                    this._oDialog = await Fragment.load({
                        id: "CommodityEditDlg",
                        name: "ns.commodity.ext.controller.fragment.CommodityEditDialog",
                        controller: this
                    });
                    console.log("Dialog loading...");
                    this.base.getView().addDependent(this._oDialog);

                    this._oDialog.setBindingContext(oContext);
                    this._oDialog.open();

                }.bind(this));

                this._bAttached = true;
            }
        },

        onSave: async function () {
            const oContext = this._oDialog.getBindingContext();
            const oModel = oContext.getModel();

            try {
                await oModel.submitBatch("$auto");

                MessageToast.show("Updated successfully");
                this._oDialog.close();

            } catch (e) {
                MessageToast.show("Update failed");
                console.error(e);
            }
        },

        onCancel: function () {
            this._oDialog.close();
        }

    });
});
