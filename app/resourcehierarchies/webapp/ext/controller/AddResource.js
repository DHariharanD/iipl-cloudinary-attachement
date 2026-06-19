sap.ui.define(
  [
    "sap/ui/core/Fragment",
    "sap/ui/model/json/JSONModel",
    "sap/m/MessageToast",
    "sap/m/MessageBox",
  ],
  function (Fragment, JSONModel, MessageToast, MessageBox) {
    "use strict";

    let that;

    let oProductDialog = null;
    let oGLDialog = null;
    let oActivityDialog = null;
    let oWorkforceDialog = null;
    let oSubcontractDialog = null;

    let _savedCtx = null;



    function getObjectPageLayout() {
      let oObjectPage = null;

      sap.ui.core.Element.registry.forEach(function (oEl) {
        if (oEl.isA && oEl.isA("sap.uxap.ObjectPageLayout")) {
          if (
            oEl.getId().includes("ResourceHierarchies_HierarchiesObjectPage")
          ) {
            oObjectPage = oEl;
          }
        }
      });

      return oObjectPage;
    }

    function _resolveContext(oInput) {
      if (!oInput) return null;

      if (typeof oInput.getSource === "function") {
        return oInput.getSource().getBindingContext();
      }

      if (typeof oInput.getPath === "function") {
        return oInput;
      }

      return null;
    }

    /* =========================================================== */
    /* Dialog Loaders */
    /* =========================================================== */

    async function loadProductDialog(oView) {
      if (oProductDialog && oProductDialog.isDestroyed()) {
        oProductDialog = null;
      }

      if (!oProductDialog) {
        oProductDialog = await Fragment.load({
          id: "ProductDlg",
          name: "ns.resourcehierarchies.ext.fragment.AddProductDialog",
          controller: that,
        });

        oView.addDependent(oProductDialog);
      }

      return oProductDialog;
    }

    async function loadGLDialog(oView) {
      if (oGLDialog && oGLDialog.isDestroyed()) {
        oGLDialog = null;
      }

      if (!oGLDialog) {
        oGLDialog = await Fragment.load({
          id: "GLDlg",
          name: "ns.resourcehierarchies.ext.fragment.AddGLDialog",
          controller: that,
        });

        oView.addDependent(oGLDialog);
      }

      return oGLDialog;
    }

    async function loadActivityDialog(oView) {
      if (oActivityDialog && oActivityDialog.isDestroyed()) {
        oActivityDialog = null;
      }

      if (!oActivityDialog) {
        oActivityDialog = await Fragment.load({
          id: "ActivityTypeDlg",
          name: "ns.resourcehierarchies.ext.fragment.AddActivityTypeDialog",
          controller: that,
        });

        oView.addDependent(oActivityDialog);
      }

      return oActivityDialog;
    }
    async function loadWorkforceDialog(oView) {
      if (oWorkforceDialog && oWorkforceDialog.isDestroyed()) {
        oWorkforceDialog = null;
      }

      if (!oWorkforceDialog) {
        oWorkforceDialog = await Fragment.load({
          id: "WorkforceDlg",
          name: "ns.resourcehierarchies.ext.fragment.AddWorkforceDialog",
          controller: that,
        });

        oView.addDependent(oWorkforceDialog);
      }

      return oWorkforceDialog;
    }
    async function loadSubcontractDialog(oView) {
      if (oSubcontractDialog && oSubcontractDialog.isDestroyed()) {
        oSubcontractDialog = null;
      }

      if (!oSubcontractDialog) {
        oSubcontractDialog = await Fragment.load({
          id: "SubcontractDlg",
          name: "ns.resourcehierarchies.ext.fragment.AddSubcontractDialog",
          controller: that,
        });

        oView.addDependent(oSubcontractDialog);
      }

      return oSubcontractDialog;
    }

    that = {
      onSelectAllProduct: function (oEvent) {
        const bSel = oEvent.getParameter("selected");
        const oModel = oProductDialog.getModel("rtModel");
        const aItems = oModel.getProperty("/items") || [];

        aItems.forEach((i) => {
          if (i.isEnabled) i.isSelected = bSel;
        });

        oModel.refresh();
      },

      onSelectAllGL: function (oEvent) {
        const bSel = oEvent.getParameter("selected");

        const oModel = oGLDialog.getModel("rtModel");

        const aItems = oModel.getProperty("/items") || [];

        aItems.forEach((i) => {
          if (i.isEnabled) i.isSelected = bSel;
        });

        oModel.refresh();
      },
      onSelectAllSubcontract: function (oEvent) {
        const bSel = oEvent.getParameter("selected");
        const oModel = oSubcontractDialog.getModel("rtModel");
        const aItems = oModel.getProperty("/items") || [];

        aItems.forEach((i) => {
          if (i.isEnabled) i.isSelected = bSel;
        });

        oModel.refresh();
      },
      addSubContract: async function (oInput) {
        let oCtx = _resolveContext(oInput);
        const oView = getObjectPageLayout();

        if (!oCtx && oView) oCtx = oView.getBindingContext();
        if (!oCtx) return MessageToast.show("No binding context found");

        _savedCtx = oCtx;

        const dlg = await loadSubcontractDialog(oView);
        dlg.open();
        dlg.setBusy(true);

        try {
          const obj = await oCtx.requestObject();
          const parentId = obj.ID;
          const oModel = this.getModel();

          const aProductContexts = await oModel
            .bindList("/Products")
            .requestContexts();
          const aProductDescriptionContexts = await oModel
            .bindList("/ProductDescriptions")
            .requestContexts();

          const aProducts = aProductContexts.map((c) => c.getObject());
          const aProductDescription = aProductDescriptionContexts.map((c) =>
            c.getObject(),
          );

          // const aRMContexts = await oModel
          //   .bindList("/ResourceSubcontract", null, null, null, {
          //     $filter: `parent_ID eq '${parentId}'`,
          //   })
          //   .requestContexts();

          // const used = new Set(aRMContexts.map((c) => c.getObject().productId));

          const descMap = new Map();
          aProductDescription.forEach((d) => {
            descMap.set(d.Product, d.ProductDescription);
          });
          const items = aProducts.map((p) => ({
            ...p,
            ProductDescription: descMap.get(p.Product) || "",
            // isEnabled: !used.has(p.Product),
            // isSelected: false,
          }));

          const typeSet = new Set(
            items.map((i) => i.ProductType).filter(Boolean),
          );
          const uniqueTypes = [{ key: "", text: "All Types" }];
          typeSet.forEach((t) => uniqueTypes.push({ key: t, text: t }));

          dlg.setModel(new JSONModel({ items, uniqueTypes }), "rtModel");
        } catch (e) {
          console.error(e);
          MessageToast.show("Failed to load Subcontracts");
        } finally {
          dlg.setBusy(false);
        }
      },
      onConfirmSubcontract: async function () {
        const oModel = _savedCtx.getModel();
        const parentId = _savedCtx.getProperty("ID");

        const items = oSubcontractDialog
          .getModel("rtModel")
          .getProperty("/items");

        const selected = items.filter((i) => i.isSelected);

        if (!selected.length) {
          return MessageToast.show("Select at least one Subcontract");
        }

        const group = "subcontractCreateGroup";

        try {
          const bind = oModel.bindList(
            _savedCtx.getPath() + "/resourceSubcontract",
            null,
            null,
            null,
            { $$updateGroupId: group },
          );

          selected.forEach((s) => {
            bind.create({
              ID: crypto.randomUUID(),
              parent_ID: parentId,
              subcontractId: s.Product,
              subcontractName: s.ProductDescription,
              subcontractType: s.ProductType,
              unitOfMeasure: s.unitOfMeasure || "EA",
            });
          });

          await oModel.submitBatch(group);

          MessageToast.show("Subcontracts added");
          oSubcontractDialog.close();
          _savedCtx.requestRefresh();
        } catch (e) {
          console.error(e);
          MessageToast.show("Save failed");
        }
      },
      onSubcontractSearch: function () {
        const oTable = sap.ui.core.Fragment.byId(
          "SubcontractDlg",
          "tblSubcontract",
        );

        if (!oTable) return;

        const oBinding = oTable.getBinding("items");
        if (!oBinding) return;

        const sId = sap.ui.core.Fragment.byId(
          "SubcontractDlg",
          "inpSubcontractId",
        )
          .getValue()
          .trim();

        const sName = sap.ui.core.Fragment.byId(
          "SubcontractDlg",
          "inpSubcontractName",
        )
          .getValue()
          .trim();

        const sType = sap.ui.core.Fragment.byId(
          "SubcontractDlg",
          "inpSubcontractType",
        ).getSelectedKey();

        const aFilters = [];

        if (sId) {
          aFilters.push(
            new sap.ui.model.Filter(
              "subcontractId",
              sap.ui.model.FilterOperator.Contains,
              sId,
            ),
          );
        }

        if (sName) {
          aFilters.push(
            new sap.ui.model.Filter(
              "subcontractName",
              sap.ui.model.FilterOperator.Contains,
              sName,
            ),
          );
        }

        if (sType) {
          aFilters.push(
            new sap.ui.model.Filter(
              "subcontractType",
              sap.ui.model.FilterOperator.Contains,
              sType,
            ),
          );
        }

        oBinding.filter(aFilters);
      },
      onCancelSubcontract: function () {
        if (oSubcontractDialog) {
          oSubcontractDialog.close();
        }
      },

      AddProducts: async function (oInput) {
        let oCtx = _resolveContext(oInput);
        const oView = getObjectPageLayout();

        if (!oCtx && oView) {
          oCtx = oView.getBindingContext();
        }

        if (!oCtx) {
          return MessageToast.show("No binding context found");
        }
        _savedCtx = oCtx;
        const dlg = await loadProductDialog(oView);
        dlg.open();
        dlg.setBusy(true);

        try {
          const obj = await oCtx.requestObject();
          const oModel = this.getModel();

          const [aProductContexts, aExistingProducts, aProductDescriptionContexts, aValuationLedgerAccountContexts] = await Promise.all([oModel.bindList("/Products").requestContexts(),

          oModel.bindList("/ResourceMaterial", null, null, null, { $filter: `parent_ID eq '${obj.ID}'`, }).requestContexts(),
          oModel.bindList("/ProductDescriptions").requestContexts(),
          oModel.bindList("/ProductValuationLedgerAccount").requestContexts()
          ]);

          // Convert Contexts to Objects
          const aProducts = aProductContexts.map(c => c.getObject());
          const aExistingProductObjects = aExistingProducts.map(c => c.getObject());
          const aProductDescriptions = aProductDescriptionContexts.map(c => c.getObject());

          const aValuationLedgerAccounts =
            aValuationLedgerAccountContexts.map(c =>
              c.getObject()
            );

          console.log("Existing products:", aExistingProductObjects);

          const existingProductIds = new Set(aExistingProductObjects.map(p => p.productId));

          const descMap = new Map();

          aProductDescriptions.forEach(d => { descMap.set(d.Product, d.ProductDescription); });

          const valuationMap = new Map();

          aValuationLedgerAccounts.forEach(v => {
            if (!valuationMap.has(v.Product)) {
              valuationMap.set(v.Product, []);
            }
            valuationMap.get(v.Product).push(v);
          });

          const items = aProducts
            .filter(p => !existingProductIds.has(p.Product))
            .map(p => {

              const valuation =
                (valuationMap.get(p.Product) || [])[0] || {};

              return {
                ...p,
                ProductDescription:
                  descMap.get(p.Product) || "",

                MovingAveragePrice:
                  valuation.MovingAveragePrice || "",

                Currency:
                  valuation.Currency || "",

                isEnabled: true,
                isSelected: false
              };
            });

          const typeSet = new Set(items.map(i => i.ProductType).filter(Boolean));
          const uniqueTypes = [{ key: "", text: "All Types" }];

          typeSet.forEach(t => { uniqueTypes.push({ key: t, text: t }); });

          dlg.setModel(new JSONModel({ items, uniqueTypes }), "rtModel");
          dlg.setBusy(false);
        } catch (e) {
          console.error(e);
          dlg.setBusy(false);
          MessageToast.show("Failed to load products");
        }
      },

      onConfirmProduct: async function () {
        const oModel = _savedCtx.getModel();
        const parentId = _savedCtx.getProperty("ID");

        const items = oProductDialog.getModel("rtModel").getProperty("/items");

        const selected = items.filter((i) => i.isSelected && i.isEnabled);

        if (!selected.length) {
          return MessageToast.show("Select at least one product");
        }
        const group = "productCreateGroup";
        try {
          const bind = oModel.bindList("/ResourceMaterial", null, null, null, {
            $$updateGroupId: group,
          });
          selected.forEach((p) => {
            bind.create({
              ID: crypto.randomUUID(),
              parent_ID: parentId,
              productId: p.Product,
              productName: p.ProductDescription,
              productType: p.ProductType,
              unitofMeasure: p.BaseUnit,
            });
          });
          await oModel.submitBatch(group);
          MessageToast.show("Products added");
          oProductDialog.close();
          _savedCtx.requestRefresh();
        } catch (e) {
          console.error(e);
          MessageToast.show("Save failed");
        }
      },

      onProductSearch: function () {
        const oTable = sap.ui.core.Fragment.byId("ProductDlg", "tblProduct");

        if (!oTable) return;

        const oBinding = oTable.getBinding("items");

        if (!oBinding) return;

        const sProdId = sap.ui.core.Fragment.byId("ProductDlg", "inpProdId")
          .getValue()
          .trim();

        const sProdName = sap.ui.core.Fragment.byId("ProductDlg", "inpProdName")
          .getValue()
          .trim();

        const sProdType = sap.ui.core.Fragment.byId(
          "ProductDlg",
          "inpProdType",
        ).getSelectedKey();
        const aFilters = [];
        if (sProdId) {
          aFilters.push(
            new sap.ui.model.Filter(
              "Product",
              sap.ui.model.FilterOperator.Contains,
              sProdId,
            ),
          );
        }
        if (sProdName) {
          aFilters.push(
            new sap.ui.model.Filter(
              "productName",
              sap.ui.model.FilterOperator.Contains,
              sProdName,
            ),
          );
        }
        if (sProdType) {
          aFilters.push(
            new sap.ui.model.Filter(
              "ProductType",
              sap.ui.model.FilterOperator.Contains,
              sProdType,
            ),
          );
        }
        oBinding.filter(aFilters);
      },

      onGLFilter: function () {
        const oTable = sap.ui.core.Fragment.byId("GLDlg", "tblGL");
        if (!oTable) return;

        const oBinding = oTable.getBinding("items");
        if (!oBinding) return;

        const sGLAcc = sap.ui.core.Fragment.byId("GLDlg", "searchGLAccount")
          .getValue()
          .trim();

        const sGLName = sap.ui.core.Fragment.byId("GLDlg", "searchGLName")
          .getValue()
          .trim();

        const aFilters = [];

        if (sGLAcc) {
          aFilters.push(
            new sap.ui.model.Filter(
              "GLAccount",
              sap.ui.model.FilterOperator.Contains,
              sGLAcc,
            ),
          );
        }

        if (sGLName) {
          aFilters.push(
            new sap.ui.model.Filter(
              "GLAccountLongName",
              sap.ui.model.FilterOperator.Contains,
              sGLName,
            ),
          );
        }

        oBinding.filter(aFilters);
      },

      addGlResource: async function (oInput) {
        let oCtx = _resolveContext(oInput);
        const oView = getObjectPageLayout();
        if (!oCtx && oView) { oCtx = oView.getBindingContext(); }
        if (!oCtx) { return MessageToast.show("No binding context found"); }
        _savedCtx = oCtx;
        const dlg = await loadGLDialog(oView);
        dlg.open();
        dlg.setBusy(true);

        try {
          const obj = await oCtx.requestObject();
          const oModel = this.getModel();

          const oExistingBinding = oModel.bindList("/ResourceGl", null, null, null, { $filter: `parent_ID eq '${obj.ID}'` });
          const [aGlContexts, aExistingGlContexts] = await Promise.all([oModel.bindList("/GlAccounts").requestContexts(), oExistingBinding.requestContexts()]);
          const aGlAccounts = aGlContexts.map(c => c.getObject());
          const aExistingGlAccounts = await Promise.all(aExistingGlContexts.map(c => c.requestObject()));
          const existingGLNos = new Set(aExistingGlAccounts.map(g => g.GLNo));
          const items = aGlAccounts.filter(g => !existingGLNos.has(g.GLAccount)).map(item => ({ ...item }));

          dlg.setModel(new JSONModel({ items }), "rtModel");

        } catch (e) {
          console.error(e);
          MessageToast.show("Failed to load GL accounts");
        } finally {
          dlg.setBusy(false);
        }
      },

      onConfirmGL: async function () {
        const oModel = _savedCtx.getModel();
        const parentId = _savedCtx.getProperty("ID");
        const items = oGLDialog.getModel("rtModel").getProperty("/items");
        const selected = items.filter((i) => i.isSelected && i.isEnabled);

        const group = "glCreateGroup";
        const bind = oModel.bindList(_savedCtx.getPath() + "/resourceGlAccounts", null, null, null, { $$updateGroupId: group });
        selected.forEach((g) => {
          bind.create({
            parent_ID: parentId,
            GLNo: g.GLAccount || "",
            GLName: (g.GLAccountLongName || "").substring(0, 50),
          });
        });

        try {
          await oModel.submitBatch(group);
          MessageToast.show("GL accounts added");
          oGLDialog.close();
          _savedCtx.requestRefresh();
        } catch (e) {
          console.error("Batch error: ", e);
          MessageToast.show("Save failed");
        }
      },

      addAsset: async function (oInput) {

        let oCtx = _resolveContext(oInput);

        const oView = getObjectPageLayout();

        if (!oCtx && oView) {
          oCtx = oView.getBindingContext();
        }

        if (!oCtx) {
          return MessageToast.show("No binding context found");
        }

        _savedCtx = oCtx;

        const dlg = await loadActivityDialog(oView);

        dlg.open();
        dlg.setBusy(true);

        try {

          const obj = await oCtx.requestObject();

          console.log("Current Object:", obj);

          const oModel = this.getModel();

          const [
            aAssetContexts,
            aExistingAssetContexts
          ] = await Promise.all([

            oModel.bindList("/Activities").requestContexts(),

            oModel.bindList(
              "/ResourceAssets",
              null,
              null,
              null,
              {
                $filter: `parent_ID eq '${obj.ID}'`
              }
            ).requestContexts()

          ]);

          const aActivities = await Promise.all(
            aAssetContexts.map(c => c.requestObject())
          );

          console.log("All Activities:", aActivities);

          const aExistingAssets = await Promise.all(
            aExistingAssetContexts.map(c => c.requestObject())
          );

          console.log("Existing Resource Assets:", aExistingAssets);

          const existingAssets = new Set(
            aExistingAssets.map(a => a.Asset)
          );

          console.log("Existing Assets Set:", existingAssets);

          const items = aActivities
            .filter(a => !existingAssets.has(a.CostCtrActivityType))
            .map(item => ({
              ...item,
              isSelected: false,
              isEnabled: true
            }));

          console.log("Filtered Items:", items);

          dlg.setModel(
            new JSONModel({ items }),
            "rtModel"
          );

        } catch (err) {

          console.error(err);

          MessageToast.show("Error loading Activity Types");

        } finally {

          dlg.setBusy(false);

        }
      },

      onActivityConfirm: async function () {
        if (!_savedCtx) {
          return MessageToast.show("Session lost");
        }

        const oModel = _savedCtx.getModel();
        const parentId = _savedCtx.getProperty("ID");
        const groupId = "activityCreateGroup";

        const oTable = sap.ui.core.Fragment.byId(
          "ActivityTypeDlg",
          "tblActivityTypes",
        );

        const aSelected = oTable.getSelectedContexts();

        if (!aSelected.length) {
          return MessageToast.show("Select at least one activity type");
        }
        const oChild = oModel.bindList(_savedCtx.getPath() + "/resourceAssets", null, null, null, { $$updateGroupId: groupId },);

        aSelected.forEach((oCtxSel) => {
          const oData = oCtxSel.getObject();
          oChild.create({
            ID: crypto.randomUUID(),
            parent_ID: parentId,
            Asset: oData.CostCtrActivityType,
            name: oData.CostCtrActivityTypeName,
          });
        });

        try {
          await oModel.submitBatch(groupId);
          MessageToast.show("Activity Types added");
          if (oActivityDialog) {
            oActivityDialog.close();
            oActivityDialog.destroy();
            oActivityDialog = null;
          }
          _savedCtx.requestRefresh();
        } catch (err) {
          console.error(err);
          MessageBox.error("Save failed");
        }
      },

      onActivityCancel: function () {
        if (oActivityDialog) {
          oActivityDialog.close();
          oActivityDialog.destroy();

          oActivityDialog = null;
        }
      },




      onCancelProduct: function () {
        if (oProductDialog) {
          oProductDialog.close();
        }
      },
      onCancelGL: function () {
        if (oGLDialog) {
          oGLDialog.close();
        }
      },

      addWorkforce: async function (oInput) {

        let oCtx = _resolveContext(oInput);

        const oView = getObjectPageLayout();

        if (!oCtx && oView) {
          oCtx = oView.getBindingContext();
        }

        if (!oCtx) {
          return MessageToast.show("No binding context found");
        }

        _savedCtx = oCtx;

        const dlg = await loadWorkforceDialog(oView);

        dlg.open();
        dlg.setBusy(true);

        try {

          const obj = await oCtx.requestObject();

          console.log("Current Object:", obj);

          const oModel = this.getModel();

          const [
            aWorkforceContexts,
            aExistingWorkforceContexts
          ] = await Promise.all([

            oModel
              .bindList("/EmployeeDetails")
              .requestContexts(),

            oModel.bindList(
              "/ResourceWorkforce",
              null,
              null,
              null,
              {
                $filter: `parent_ID eq '${obj.ID}'`
              }
            ).requestContexts()

          ]);

          // Fetch all employee details
          const aWorkforceData = await Promise.all(
            aWorkforceContexts.map(c => c.requestObject())
          );

          console.log("All Workforce Data:", aWorkforceData);

          // Fetch existing workforce records
          const aExistingWorkforce = await Promise.all(
            aExistingWorkforceContexts.map(c => c.requestObject())
          );

          console.log("Existing Workforce:", aExistingWorkforce);

          // Existing names from ResourceWorkforce
          const existingAssignments = new Set(
            aExistingWorkforce.map(w => w.name)
          );

          console.log("Existing Assignment IDs:", existingAssignments);

          // Filter employees not already added
          const items = aWorkforceData
            .filter(w => !existingAssignments.has(w.name))
            .map(item => ({
              ...item,
              isSelected: false,
              isEnabled: true
            }));

          console.log("Filtered Workforce Items:", items);

          dlg.setModel(
            new JSONModel({ items }),
            "rtModel"
          );

        } catch (err) {

          console.error(err);

          MessageToast.show("Error loading Workforce data");

        } finally {

          dlg.setBusy(false);

        }
      },

      onWorkforceSearch: function () {
        const oTable = sap.ui.core.Fragment.byId(
          "WorkforceDlg",
          "tblWorkforce",
        );
        if (!oTable) return;
        const oBinding = oTable.getBinding("items");
        if (!oBinding) return;
        const sId = sap.ui.core.Fragment.byId("WorkforceDlg", "searchWFId")
          .getValue()
          .trim();

        const sLevel = sap.ui.core.Fragment.byId(
          "WorkforceDlg",
          "searchWFLevel",
        )
          .getValue()
          .trim();

        const aFilters = [];
        if (sId) {
          aFilters.push(
            new sap.ui.model.Filter(
              "CostCtrActivityType",
              sap.ui.model.FilterOperator.Contains,
              sId,
            ),
          );
        }

        if (sLevel) {
          aFilters.push(
            new sap.ui.model.Filter(
              "CostCtrActivityTypeCategory",
              sap.ui.model.FilterOperator.Contains,
              sLevel,
            ),
          );
        }
        oBinding.filter(aFilters);
      },

      onWorkforceConfirm: async function () {
        if (!_savedCtx) {
          return MessageToast.show("Session lost");
        }

        const oModel = _savedCtx.getModel();

        const parentId = _savedCtx.getProperty("ID");

        const groupId = "workforceCreateGroup";

        const oTable = sap.ui.core.Fragment.byId(
          "WorkforceDlg",
          "tblWorkforce",
        );
        const aSelected = oTable.getSelectedContexts();
        if (!aSelected.length) {
          return MessageToast.show("Select at least one workforce item");
        }
        const oChild = oModel.bindList(
          _savedCtx.getPath() + "/resourceWorkforce",
          null,
          null,
          null,
          { $$updateGroupId: groupId },
        );
        aSelected.forEach((oCtxSel) => {
          const oData = oCtxSel.getObject();
          oChild.create({
            ID: crypto.randomUUID(),
            parent_ID: parentId,
            name: oData.name,
            description: oData.description,
          });
        });

        try {
          await oModel.submitBatch(groupId);
          MessageToast.show("Workforce added successfully");
          if (oWorkforceDialog) {
            oWorkforceDialog.close();
            oWorkforceDialog.destroy();
            oWorkforceDialog = null;
          }
          _savedCtx.requestRefresh();
        } catch (err) {
          console.error(err);
          MessageBox.error("Save failed");
        }
      },
      onWorkforceCancel: function () {
        if (oWorkforceDialog) {
          oWorkforceDialog.close();
          oWorkforceDialog.destroy();
          oWorkforceDialog = null;
        }
      },
    };

    return that;
  },
);

