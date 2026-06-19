sap.ui.define([
    "sap/ui/core/Fragment",
    "sap/ui/model/json/JSONModel",
    "sap/m/MessageToast"
], function (Fragment, JSONModel, MessageToast) {
    "use strict";


    const FRAG_ID = "CBSResDlg";

    let oDialog;
    let _ctx = null;

    function getTable(id) {
        return sap.ui.core.Fragment.byId(FRAG_ID, id);
    }


    async function loadDialog() {

        if (!oDialog) {

            oDialog = await Fragment.load({
                id: FRAG_ID,
                name: "ns.billofquantity.ext.controller.fragment.CbsDialog",
                controller: that
            });
        }

        return oDialog;
    }

    const that = {
        addCbs: async function (oContext, aSelectedContexts) {
            _ctx = oContext;
                const oDlg = await loadDialog();
            oDlg.open();
            oDlg.setBusy(true);
            try {
                const oModel = oContext.getModel();

                const aCBSContexts = await oModel
                    .bindList("/CostBreakdownStructure")
                    .requestContexts();

                const aCBSData = aCBSContexts.map((c) => c.getObject());

            


                oDlg.setModel(
                    new JSONModel(aCBSData),
                    "cbsModel"
                );
                oDlg.setBusy(false);


            } catch (e) {
                console.error(e);
                MessageToast.show("Failed to load CBS");
            }
        },



        onConfirmCbs: async function () {
            if (!_ctx) {
                MessageToast.show("No context");
                return;
            }

            const tbl = getTable("tblCbs");
            const aSelected = tbl.getSelectedItems();

            if (!aSelected.length) {
                MessageToast.show("Select CBS");
                return;
            }

            const oModel = _ctx.getModel();
            const sGroup = "cbsCreateGroup";

            try {
                oModel.resetChanges(sGroup);

                const oListBinding = oModel.bindList("boqcbs", _ctx, null, null, {
                    $$updateGroupId: sGroup
                });

                aSelected.forEach(oItem => {
                    const oData = oItem.getBindingContext("cbsModel").getObject();
                    oListBinding.create({
                        code: oData.code,
                        name: oData.name,
                        descr: oData.descr,
                        cbsId: oData.ID
                    });
                });

                await oModel.submitBatch(sGroup);

                if (oModel.hasPendingChanges(sGroup)) {
                    throw new Error("Batch submission failed - check backend logs");
                }

                await _ctx.requestRefresh();

                MessageToast.show("CBS Added");
                oDialog.close();

            } catch (e) {
                console.error("Detailed Error:", e);
                MessageToast.show("Save failed: " + (e.message || "Unknown Error"));
            }
        },
        onCloseCbsDialog: function () {

            if (oDialog) {
                oDialog.close();
            }
        }

    };


    return that;

});

