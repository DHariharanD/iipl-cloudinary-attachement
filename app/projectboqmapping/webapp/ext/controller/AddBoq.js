sap.ui.define([
  "sap/ui/core/Fragment",
  "sap/ui/model/json/JSONModel",
  "sap/m/MessageToast"
], function (Fragment, JSONModel, MessageToast) {
  "use strict";

  const FRAG_ID = "AddBoqDlg";
  let oDialog;
  let _ctx;

  function getTable(id) {
    return sap.ui.core.Fragment.byId(FRAG_ID, id);
  }

  const controller = {
    addBoq: async function (oContext) {
      try {
        _ctx = oContext;

        const sProjectId =
          oContext.getProperty("plshierarchy_ID") ||
          oContext.getProperty("ID");

        if (!sProjectId) {
          MessageToast.show("Project not found");
          return;
        }

        const sUrl =
          "/odata/v4/BillofQuantityService/BillofQuantityItem" +
          "?$filter=bqitemsHierarchy/project/ID eq " + sProjectId;

        const res = await fetch(sUrl, {
          headers: { Accept: "application/json" }
        });

        const data = await res.json();

        if (!oDialog) {
          await Fragment.load({
            id: FRAG_ID,
            name: "ns.projectboqmapping.ext.fragment.AddBoqDialog",
            controller
          });
          oDialog = sap.ui.core.Fragment.byId(FRAG_ID, "dlgAddBoq");
        }

        oDialog.setModel(new sap.ui.model.json.JSONModel(data.value), "rtModel");
        oDialog.open();

      } catch (e) {
        console.error(e);
        MessageToast.show("Failed to load BOQs");
      }
    }

    ,
    onConfirmBoq: async function () {
      if (!_ctx) {
        return MessageToast.show("No WBS context found");
      }
      const oModel = _ctx.getModel();
      const sGroup = "boqCreateGroup";
      const oTable = getTable("tblBoq");
      const aSelected = oTable.getSelectedItems();
      if (!aSelected.length) {
        return MessageToast.show("Select at least one BOQ");
      }
      const oBoqList = oModel.bindList(
        _ctx.getPath() + "/WbsBoq",
        null,
        null,
        null,
        { $$updateGroupId: sGroup }
      );

      aSelected.forEach(oItem => {
        const oData = oItem.getBindingContext("rtModel").getObject();

        oBoqList.create({
          item: oData.item,
          description: oData.description,
          unitOfMeasurement: oData.unitOfMeasurement,
          quantity: oData.quantity != null ? String(oData.quantity) : null,
          bill: oData.bill,
          section: oData.section,
          page: oData.page,
          revision: oData.revision,
          retention: oData.retention,
          advance: oData.advance
        });
      });

      try {
        await oModel.submitBatch(sGroup);
        await _ctx.requestRefresh();
        MessageToast.show("BOQs added successfully");
        oDialog.close();
      } catch (e) {
        console.error(e);
        MessageToast.show("Error saving BOQs");
      }
    },

    onCancel: function () {
      oDialog?.close();
    }
  };

  return controller;
});
