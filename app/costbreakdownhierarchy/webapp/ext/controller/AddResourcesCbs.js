// sap.ui.define(
//   [
//     "sap/ui/core/Fragment",
//     "sap/ui/model/json/JSONModel",
//     "sap/m/MessageToast",
//     "sap/ui/model/Filter",
//     "sap/ui/model/FilterOperator",
//   ],
//   function (Fragment, JSONModel, MessageToast, Filter, FilterOperator) {
//     "use strict";

//     const FRAG_ID = "CBSResDlg";
//     let oDialog;
//     let that;
//     let _ctx = null;

//     async function loadDialog() {
//       if (!oDialog) {
//         oDialog = await Fragment.load({
//           id: FRAG_ID,
//           name: "ns.costbreakdownhierarchy.ext.fragment.AddResourceDialog",
//           controller: that,
//         });
//       }
//       return oDialog;
//     }

//     that = {

//       onSearch: function () {
//         const sIdSearch = Fragment.byId(FRAG_ID, "searchId").getValue();
//         const sNameSearch = Fragment.byId(FRAG_ID, "searchName").getValue();
//         const sTypeSelect = Fragment.byId(FRAG_ID, "selectType").getSelectedKey();

//         const aFilters = [];

//         if (sIdSearch) {
//           aFilters.push(new Filter("productId", FilterOperator.Contains, sIdSearch));
//         }

//         if (sNameSearch) {
//           aFilters.push(new Filter("productName", FilterOperator.Contains, sNameSearch));
//         }

//         if (sTypeSelect && sTypeSelect !== "All") {
//           aFilters.push(new Filter("productType", FilterOperator.EQ, sTypeSelect));
//         }

//         const oTable = Fragment.byId(FRAG_ID, "tblCBSMat");
//         oTable.getBinding("items").filter(aFilters);
//       },

//       onSelectAll: function (oEvent) {
//         const bSelected = oEvent.getParameter("selected");
//         const oRtModel = oDialog.getModel("rtModel");
//         const aItems = oRtModel.getProperty("/items");

//         aItems.forEach((item) => {
//           if (item.isEnabled) {
//             item.isSelected = bSelected;
//           }
//         });

//         oRtModel.refresh();
//       },

//       addCbsRes: async function (oContext) {
//         _ctx = oContext;
//         const oModel = oContext.getModel();

//         const oDlg = await loadDialog();
//         oDlg.setBusy(true);

//         try {
//           const aAllMatContexts = await oModel.bindList("/ResourceMaterial").requestContexts();
//           const aAllGlContexts = await oModel.bindList("/ResourceGl").requestContexts();
//           const aAllScContexts = await oModel.bindList("/ResourceSubcontract").requestContexts();
//           const aAllMpContexts = await oModel.bindList("/ResourceWorkforce").requestContexts();
//           const aAllAtContexts = await oModel.bindList("/ResourceAssets").requestContexts();

//           const aAllMaterials = aAllMatContexts.map(c => c.getObject());
//           const aAllGl = aAllGlContexts.map(c => c.getObject());
//           const aAllSc = aAllScContexts.map(c => c.getObject());
//           const aAllMp = aAllMpContexts.map(c => c.getObject());
//           const aAllAt = aAllAtContexts.map(c => c.getObject());

//           const typeMap = {
//             MT: "Material",
//             MP: "Manpower",
//             GL: "GL Account",
//             AT: "Asset",
//             SC: "Subcontractor"
//           };

//           const formatData = (data, typeCode) => {
//             return data.map(item => ({
//               ID: item.ID,
//               productId: item.productId || item.code || item.GLNo || item.Asset || item.subcontractId || item.WorkAssignmentExternalID,
//               productName: item.productName || item.name || item.description || item.GLName || item.AssetName || item.subcontractName || item.ServiceCostLevel,
//               productType: typeMap[typeCode],
//               unitofMeasure: item.unitofMeasure || "EA",
//               isSelected: false,
//               isEnabled: true
//             }));
//           };

//           let aMergedData = [
//             ...formatData(aAllMaterials, "MT"),
//             ...formatData(aAllMp, "MP"),
//             ...formatData(aAllGl, "GL"),
//             ...formatData(aAllAt, "AT"),
//             ...formatData(aAllSc, "SC")
//           ];

//           const aExistingContexts = await oModel
//             .bindList(oContext.getPath() + "/resourceMaterials")
//             .requestContexts();

//           const existingIds = new Set(
//             aExistingContexts.map(c => c.getProperty("resourceMat_ID"))
//           );

//           aMergedData.forEach(item => {
//             if (existingIds.has(item.ID)) {
//               item.isEnabled = false;
//             }
//           });

//           const uniqueTypes = [
//             ...new Set(aMergedData.map(i => i.productType))
//           ];

//           const aDropdownData = [
//             { key: "All", text: "All Types" },
//             ...uniqueTypes.map(t => ({ key: t, text: t }))
//           ];

//           oDlg.setModel(new JSONModel({items: aMergedData,uniqueTypes: aDropdownData}),"rtModel");

//           Fragment.byId(FRAG_ID, "searchId").setValue("");
//           Fragment.byId(FRAG_ID, "searchName").setValue("");
//           Fragment.byId(FRAG_ID, "selectType").setSelectedKey("All");
//           Fragment.byId(FRAG_ID, "tblCBSMat").getBinding("items").filter([]);

//           oDlg.open();

//         } catch (e) {
//           console.error(e);
//           MessageToast.show("Error loading resources");
//         } finally {
//           oDlg.setBusy(false);
//         }
//       },

//       onCancelPress: function () {
//         if (oDialog) {
//           oDialog.close();
//         }
//       },

//       onVHConfirm: async function () {
//         if (!_ctx) {
//           return MessageToast.show("Error: No Context Found");
//         }

//         const oDlg = oDialog;
//         oDlg.setBusy(true);

//         const oCtx = _ctx;
//         const oModel = oCtx.getModel();
//         const sGroup = "childCreateGroup";

//         const oRtModel = oDlg.getModel("rtModel");
//         const aAllItems = oRtModel.getProperty("/items");

//         const aItemsToAdd = aAllItems.filter(
//           item => item.isSelected && item.isEnabled
//         );

//         if (aItemsToAdd.length === 0) {
//           oDlg.setBusy(false);
//           return MessageToast.show("Please select at least one new item");
//         }

//         const oChildList = oModel.bindList(
//           oCtx.getPath() + "/resourceMaterials",
//           null,
//           null,
//           null,
//           { $$updateGroupId: sGroup }
//         );

//         aItemsToAdd.forEach(oData => {
//           oChildList.create({
//             ID: crypto.randomUUID(),
//             resourceMat_ID: oData.ID,
//             productId: oData.productId,
//             productName: oData.productName,
//             productType: oData.productType,
//             unitofMeasure: oData.unitofMeasure || "EA",
//           });
//         });

//         try {
//           await oModel.submitBatch(sGroup);
//           await oCtx.requestRefresh();

//           MessageToast.show("Resource added successfully");
//           oDlg.close();

//         } catch (err) {
//           console.error(err);
//           sap.m.MessageBox.error("Error saving data: " + err.message);
//         } finally {
//           oDlg.setBusy(false);
//         }
//       },
//     };

//     return that;
//   }
// );