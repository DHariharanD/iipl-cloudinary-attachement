sap.ui.define([
    "sap/m/MessageToast",
    "sap/ui/core/Fragment",
    "sap/ui/model/json/JSONModel"
], function (
    MessageToast,
    Fragment,
    JSONModel
) {
    "use strict";

    return {

        _oResDialog: null,
        _oCbsDialog: null,


       
   AddResource: async function (oListBinding) {

    // ✅ Get root view safely
    const oView = sap.ui.getCore().byId("appRootView");

    if (!this._oResDialog) {

        this._oResDialog = await Fragment.load({
            name: "ns.projectboqmapping.ext.fragment.AddBoqResources",
            controller: this
        });

        oView.addDependent(this._oResDialog);
    }

    const resp = await fetch("/odata/v4/ResourceServices/ResourceMaterial");

    const data = await resp.json();

    const oModel = new JSONModel(data.value || []);

    this._oResDialog.setModel(oModel);

    this._oResDialog.open();
}

,


        
        AddCbs: async function () {

            const oView = this.getView?.() || sap.ui.getCore().byId("__xmlview0");

            if (!this._oCbsDialog) {

                this._oCbsDialog = await Fragment.load({
                    name: "ns.projectboqmapping.ext.fragment.AddBoqCbs",
                    controller: this
                });

                oView.addDependent(this._oCbsDialog);
            }

            const resp = await fetch(
                "/odata/v4/CostBreakdownStructureService/CBSResourceMaterial"
            );

            const data = await resp.json();

            const oModel = new JSONModel(data.value || []);

            this._oCbsDialog.setModel(oModel);

            this._oCbsDialog.open();
        },


        onAddResourceConfirm: function () {

            const oTable = Fragment.byId(
                "addResourceDialog",
                "resTable"
            );

            const aItems = oTable.getSelectedItems();

            if (!aItems.length) {
                MessageToast.show("Select at least one Resource");
                return;
            }

            const aSelected = aItems.map(i =>
                i.getBindingContext().getObject()
            );

            console.log("Selected Resources:", aSelected);

            MessageToast.show("Resources Added");

            this._oResDialog.close();
        },


        
        onAddCbsConfirm: function () {

            const oTable = Fragment.byId(
                "addCbsDialog",
                "cbsTable"
            );

            const aItems = oTable.getSelectedItems();

            if (!aItems.length) {
                MessageToast.show("Select at least one CBS");
                return;
            }

            const aSelected = aItems.map(i =>
                i.getBindingContext().getObject()
            );

            console.log("Selected CBS:", aSelected);

            MessageToast.show("CBS Added");

            this._oCbsDialog.close();
        },


        
        onCloseResource: function () {
            this._oResDialog.close();
        },

        onCloseCbs: function () {
            this._oCbsDialog.close();
        }

    };
});
