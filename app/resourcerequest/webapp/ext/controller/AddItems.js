sap.ui.define([
    "sap/ui/core/Fragment",
    "sap/m/MessageToast",
    "sap/ui/model/json/JSONModel"
], function (Fragment, MessageToast, JSONModel) {
    "use strict";

    const FRAG_ID = "AddBoqDlg";
    let oDialog;
    let that;
    let _ctx = null;
    const FRAG_ID_CBS = "AddBoqCbsDlg";
    let oCbsDialog;
    const FRAG_ID_RES = "addResourceDialog";
    let oResDialog;

    function byId(id) {
        return sap.ui.core.Fragment.byId(FRAG_ID, id);
    }

    async function loadDialog() {
        if (!oDialog) {
            oDialog = await Fragment.load({
                id: FRAG_ID,
                name: "ns.resourcerequest.ext.fragment.AddBoqItemsDialog",
                controller: that
            });
        }
        return oDialog;
    }
    async function loadCbsDialog() {
        if (!oCbsDialog) {
            oCbsDialog = await Fragment.load({
                id: FRAG_ID_CBS,
                name: "ns.resourcerequest.ext.fragment.AddBoqCbs",
                controller: that
            });
        }
        return oCbsDialog;
    }
    async function loadResDialog() {
        if (!oResDialog) {
            oResDialog = await Fragment.load({
                id: FRAG_ID_RES,
                name: "ns.resourcerequest.ext.fragment.AddBoqResources",  // ⚠ match your app namespace
                controller: that
            });
        }
        return oResDialog;
    }

    that = {

        addBoqItems: async function (oContext) {
            _ctx = oContext;
            const boqId = oContext.getProperty("boq_ID");
            const oModel = oContext.getModel();
            const oDlg = await loadDialog();
            oDlg.setBusy(true);

            try {
                const aAllBoqContexts = await oModel.bindList(
                    "/BillofQuantityItems", null, null, null,
                    {
                        $filter: `bqitemsHierarchy_ID eq ${boqId}`
                    }
                ).requestContexts();

                const aAllBoqItems = aAllBoqContexts.map(c => c.getObject());
                const aExistingContexts = await oModel.bindList(oContext.getPath() + "/requestBoqItems").requestContexts();
                const existingIds = new Set(aExistingContexts.map(c => c.getProperty("boqItem_ID")));
                const aFiltered = aAllBoqItems.filter(item => !existingIds.has(item.ID));

                oDlg.setModel(new JSONModel({ items: aFiltered }), "boqModel");
                oDlg.open();

            } catch (error) {
                console.error(error);
                sap.m.MessageToast.show("Error loading BOQ items");
            } finally {
                oDlg.setBusy(false);
            }
        },


        onCancelBoqItem: function () {
            if (oDialog) {
                oDialog.close();
            }
        },

        onSaveBoqItem: async function () {

            if (!_ctx) {
                return MessageToast.show("Error: No Context Found");
            }
            const oCtx = _ctx;
            const oModel = oCtx.getModel();
            const sGroup = "childCreateGroup";
            const tbl = byId("boqTable");
            const aSelected = tbl.getSelectedItems();
            if (!aSelected.length) {
                return MessageToast.show("Please select at least one BOQ item");
            }
            const oChild = oModel.bindList(
                oCtx.getPath() + "/requestBoqItems",
                null, null, null,
                { $$updateGroupId: sGroup }
            );

            aSelected.forEach(oItem => {
                const oBoq = oItem.getBindingContext("boqModel").getObject();
                oChild.create({
                    item: oBoq.item,
                    description: oBoq.description,
                    unitOfMeasurement: oBoq.unitOfMeasurement,
                    quantity: oBoq.quantity,
                    bill: oBoq.bill,
                    section: oBoq.section,
                    page: oBoq.page,
                    revision: oBoq.revision,
                    retention: oBoq.retention,
                    advance: oBoq.advance,
                    peformanceBond: oBoq.peformanceBond,
                    bankGuarantee: oBoq.bankGuarantee,
                    sumBack: oBoq.sumBack,
                    boqNo: oBoq.boqNo,
                    pcRate: oBoq.pcRate,
                    nonClient: oBoq.nonClient,
                    excludeActiveBudget: oBoq.excludeActiveBudget,
                    boqItem_ID: oBoq.ID
                });

            });
            try {
                await oModel.submitBatch(sGroup);
                await oCtx.requestRefresh();
                oDialog.close();
                MessageToast.show("BOQ Items added successfully");
            } catch (error) {
                MessageToast.show("Error saving data");
                console.error(error);
            }
        },

        //==================CBS=================================

        addCbs: async function (oContext) {

            _ctx = oContext;
            const oModel = oContext.getModel();
            const oDlg = await loadCbsDialog();
            oDlg.setBusy(true);

            try {
                const aBoqContexts = await oModel.bindList(oContext.getPath() + "/requestBoqItems").requestContexts();
                const boqUUIDs = aBoqContexts.map(c => c.getProperty("boqItem_ID"));

                if (!boqUUIDs.length) {
                    MessageToast.show("No BOQ items added yet");
                    oDlg.setBusy(false);
                    return;
                }

                const aCbsContexts = await oModel.bindList("/cbs").requestContexts();
                const aAllCbs = aCbsContexts.map(c => c.getObject());
                const aFiltered = aAllCbs.filter(cbs => boqUUIDs.includes(cbs.parent_ID));
                oDlg.setModel(new JSONModel({ items: aFiltered }), "cbsModel");
                oDlg.open();

            } catch (error) {
                console.error(error);
                MessageToast.show("Error loading CBS data");
            } finally {
                oDlg.setBusy(false);
            }
        },
        onCloseCbs: function () {
            if (oCbsDialog) {
                oCbsDialog.close();
            }
        },
        onAddCbsConfirm: async function () {
            if (!_ctx) {
                return MessageToast.show("No context found");
            }
            const oCtx = _ctx;
            const oModel = oCtx.getModel();
            const sGroup = "childCreateGroup";
            const tbl = sap.ui.core.Fragment.byId(FRAG_ID_CBS, "cbsTable");
            const aSelected = tbl.getSelectedItems();
            if (!aSelected.length) {
                return MessageToast.show("Please select at least one CBS");
            }

            const oChild = oModel.bindList(
                oCtx.getPath() + "/requestCbs",
                null, null, null,
                { $$updateGroupId: sGroup }
            );

            aSelected.forEach(oItem => {
                const oCbs = oItem.getBindingContext("cbsModel").getObject();
                console.log(oCbs);
                oChild.create({
                    code: oCbs.code,
                    name: oCbs.name,
                    descr: oCbs.descr,
                    boqCbs_ID: oCbs.ID
                });
            });
            try {
                await oModel.submitBatch(sGroup);
                await oCtx.requestRefresh();
                oCbsDialog.close();
                MessageToast.show("CBS added successfully");
            } catch (error) {
                console.error(error);
                MessageToast.show("Error saving CBS");
            }
        },


        //==============Resources===============


        addResource: async function (oContext) {

            _ctx = oContext;

            const oModel = oContext.getModel();
            const oDlg = await loadResDialog();
            oDlg.setBusy(true);

            try {

                const projectId = oContext.getProperty("project_ID");

                if (!projectId) {
                    MessageToast.show("Project ID not found");
                    return;
                }

                const sPath = `/BillofQuantityHeader?$filter=project_ID eq ${projectId}&$expand=BillofQuantityItems($expand=cbsResource)`;

                const oBinding = oModel.bindList("/BillofQuantityHeader", null, null, null, {
                    $filter: `project_ID eq ${projectId}`,
                    $expand: "bqHeaderHierarchies($expand=boqResource)"
                });

                const aContexts = await oBinding.requestContexts(); 

                const aResources = aContexts.flatMap(ctx =>
                    (ctx.getObject().bqHeaderHierarchies || [])
                        .flatMap(h => h.boqResource || [])
                );

                if (!aResources.length) {
                    MessageToast.show("No resources found for this project");
                }

                oDlg.setModel(new JSONModel({ items: aResources }), "resModel");
                oDlg.open();

            } catch (error) {
                console.error(error);
                MessageToast.show("Error loading resources");
            } finally {
                oDlg.setBusy(false);
            }
        },
        onCloseResource: function () {
            if (oResDialog) {
                oResDialog.close();
            }
        },
        onAddResourceConfirm: async function () {

            if (!_ctx) {
                return MessageToast.show("No context found");
            }

            const oCtx = _ctx;
            const oModel = oCtx.getModel();
            const sGroup = "childCreateGroup";

            const tbl = sap.ui.core.Fragment.byId(FRAG_ID_RES, "resTable");
            const aSelected = tbl.getSelectedItems();

            if (!aSelected.length) {
                return MessageToast.show("Please select at least one Resource");
            }

            const oChild = oModel.bindList(
                oCtx.getPath() + "/requestCbsResource",
                null, null, null,
                { $$updateGroupId: sGroup }
            );

            aSelected.forEach(oItem => {
                const oRes = oItem.getBindingContext("resModel").getObject();
                oChild.create({
                    code: oRes.code,
                    name: oRes.name,
                    descr: oRes.descr,
                    requestedQuantity: oRes.requestedQuantity,
                    availableQuantity: oRes.quantity
                });
            });

            try {
                await oModel.submitBatch(sGroup);
                await oCtx.requestRefresh();
                oResDialog.close();
                MessageToast.show("Resource added successfully");
            } catch (error) {
                console.error(error);
                MessageToast.show("Error saving Resource");
            }
        }
    };
    return that;
});