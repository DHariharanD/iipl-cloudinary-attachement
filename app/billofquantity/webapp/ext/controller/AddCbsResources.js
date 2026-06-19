sap.ui.define([
    "sap/ui/core/Fragment",
    "sap/ui/model/json/JSONModel",
    "sap/m/MessageToast"
], function (Fragment, JSONModel, MessageToast) {
    "use strict";

    const FRAG_ID = "BoqResDlg";

    let oDialog;
    let _ctx = null;

    function getTable(id) {
        return sap.ui.core.Fragment.byId(FRAG_ID, id);
    }

    async function loadDialog() {
        if (!oDialog) {
            oDialog = await Fragment.load({
                id: FRAG_ID,
                name: "ns.billofquantity.ext.controller.fragment.BoqResourceDialog",
                controller: that
            });
        }
        return oDialog;
    }

    const that = {

        addCbsResource: async function (oEvent) {
            if (oEvent && oEvent.getSource) {
                _ctx = oEvent.getSource().getBindingContext();
            } else {
                _ctx = oEvent;
            }

            if (!_ctx || !_ctx.getPath) {
                MessageToast.show("No valid context found");
                return;
            }

            try {
                const oModel = _ctx.getModel();
                const sCurrentBoqId = _ctx.getProperty("ID");

                const aBoqCbsContexts = await oModel
                    .bindList("/BoqCbs", null, null, null, {
                        $filter: `parent_ID eq ${sCurrentBoqId}`
                    })
                    .requestContexts();

                if (!aBoqCbsContexts.length) {
                    const oDlg = await loadDialog();
                    oDlg.setModel(new JSONModel([]), "resourceMdl");
                    oDlg.open();
                    MessageToast.show("No CBS assigned to this BOQ yet.");
                    return;
                }

                const aCbsIds = aBoqCbsContexts.map(
                    c => c.getProperty("cbsId")
                );

                const sCbsFilter = aCbsIds
                    .map(id => `cbsNode_ID eq '${id}'`)
                    .join(" or ");

                const aResContexts = await oModel
                    .bindList("/CBSResourceMaterial", null, null, null, {
                        $filter: sCbsFilter
                    })
                    .requestContexts();

                const aResources = aResContexts.map(c => c.getObject());

                const oDlg = await loadDialog();
                oDlg.setModel(new JSONModel(aResources), "resourceMdl");
                oDlg.open();

            } catch (e) {
                console.error("Resource Load Error:", e);
                MessageToast.show("Failed to load resources");
            }
        },

        onConfirmBoqResource: async function () {

            if (!_ctx) {
                return MessageToast.show("No BOQ context");
            }

            const tbl = getTable("tblBoqResource");
            const aSel = tbl.getSelectedItems();

            if (!aSel.length) {
                return MessageToast.show("Select at least one resource");
            }

            const oModel = _ctx.getModel();
            const sGroup = "boqResCreate";

            const oList = oModel.bindList(
                _ctx.getPath() + "/boqResource",
                null,
                null,
                null,
                { $$updateGroupId: sGroup }
            );

            aSel.forEach(oItem => {

                const oData =
                    oItem.getBindingContext("resourceMdl").getObject();

                oList.create({
                    code: oData.productId,
                    name: oData.productName,
                    descr: oData.productType,
                    cbsNode_ID: oData.cbsNode_ID,
                    outPutQuantity:oData.outputQTY,
                    quantity: oData.quantity,
                    rate: oData.rate,
                });

            });

            try {
                await oModel.submitBatch(sGroup);
                await _ctx.requestRefresh();

                MessageToast.show("Resources Added");
                oDialog.close();

            } catch (e) {
                console.error(e);
                MessageToast.show("Save Failed");
            }
        },

        onCloseBoqResource: function () {
            if (oDialog) {
                oDialog.close();
            }
        }
    };

    return that;
});