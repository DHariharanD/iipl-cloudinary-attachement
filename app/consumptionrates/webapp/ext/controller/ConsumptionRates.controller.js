sap.ui.define([
    "sap/ui/core/Fragment",
    "sap/ui/model/json/JSONModel",
    "sap/m/MessageToast",
    "sap/ui/model/Filter",
    "sap/ui/model/FilterOperator"
], function (Fragment, JSONModel, MessageToast, Filter, FilterOperator) {
    "use strict";

    let oMaterialDialog = null;
    let oCurrentContext = null;

    return {

        onAfterRendering: function () {
            var that = this;
            setTimeout(function () {
                that._attachMaterialVH();
            }, 1000);
        },
        _attachMaterialVH: function () {
            console.log("_attachMaterialVH called, base exists:", !!this.base);
            if (!this.base || !this.base.getView()) {
                setTimeout(this._attachMaterialVH.bind(this), 300);
                return;
            }

            const oView = this.base.getView();
            let bFound = false;

            oView.findAggregatedObjects(true).forEach(function (oControl) {
                if (oControl.isA("sap.m.Input") && oControl.getBindingInfo("value") && oControl.getBindingInfo("value").parts && oControl.getBindingInfo("value").parts[0]) {
                    console.log("INPUT PATH:", oControl.getBindingInfo("value").parts[0].path);
                }
            }.bind(this));

            if (!bFound) {
                setTimeout(this._attachMaterialVH.bind(this), 300);
            }
        },


        onOpenMaterialDialog: async function (oEvent) {
            const oView = this.base.getView();
            oCurrentContext = oEvent.getSource().getBindingContext();

            if (!oCurrentContext) {
                MessageToast.show("No binding context found");
                return;
            }

            try {
                if (oMaterialDialog && oMaterialDialog.isDestroyed()) {
                    oMaterialDialog = null;
                }

                if (!oMaterialDialog) {
                    oMaterialDialog = await Fragment.load({
                        id: "MaterialDlg",
                        name: "ns.consumptionrates.ext.fragment.MaterialDialog",
                        controller: this
                    });
                    oView.addDependent(oMaterialDialog);
                }

                oMaterialDialog.setBusy(true);

                const oModel = oView.getModel();

                // fetch all pages of Products
                const fetchAll = async (url) => {
                    let results = [];
                    let nextUrl = url;
                    while (nextUrl) {
                        const res = await fetch(nextUrl).then(r => r.json());
                        results = results.concat(res.value || []);
                        nextUrl = res['@odata.nextLink'] || null;
                    }
                    return results;
                };

                const sBase = "/odata/v4/ConsumptionRateService/";

                const [aProducts, aDescriptions] = await Promise.all([
                    fetchAll(`${sBase}Products?$select=Product,ProductType,BaseUnit&$top=5000`),
                    fetchAll(`${sBase}ProductDescriptions?$select=Product,ProductDescription&$filter=Language eq 'EN'&$top=5000`)
                ]);

                console.log("✅ Products:", aProducts.length);
                console.log("✅ Descriptions:", aDescriptions.length);
                console.log("✅ Sample product:", aProducts[0]);
                console.log("✅ Sample desc:", aDescriptions[0]);

                const oDescMap = new Map();
                aDescriptions.forEach(d => {
                    oDescMap.set(String(d.Product).trim(), d.ProductDescription);
                });

                const aAllowedTypes = ["ROH", "HALB", "FERT", "HAWA", "ZTRA"];

                const aItems = aProducts
                    .filter(p => aAllowedTypes.includes(p.ProductType || ""))
                    .map(p => ({
                        productId: p.Product,
                        productName: oDescMap.get(String(p.Product).trim()) || "",
                        productType: p.ProductType || "",
                        unitofMeasure: p.BaseUnit || "NA"
                    }));

                console.log("✅ Filtered items:", aItems.length);
                console.log("✅ Sample item:", aItems[0]);

                const oJsonModel = new JSONModel({ items: aItems });
                oMaterialDialog.setModel(oJsonModel, "matModel");
                oMaterialDialog.open();

            } catch (e) {
                console.error("Dialog error:", e);
                MessageToast.show("Failed to load materials: " + e.message);
            } finally {
                if (oMaterialDialog) {
                    oMaterialDialog.setBusy(false);
                }
            }
        },

        onMaterialSearch: function () {

            const oTable = Fragment.byId("MaterialDlg", "tblMaterial");
            if (!oTable) return;

            const oBinding = oTable.getBinding("items");
            if (!oBinding) return;

            const sId = Fragment.byId("MaterialDlg", "inpMatId").getValue().trim();
            const sName = Fragment.byId("MaterialDlg", "inpMatName").getValue().trim();

            const aFilters = [];

            if (sId) {
                aFilters.push(
                    new Filter("productId", FilterOperator.Contains, sId)
                );
            }

            if (sName) {
                aFilters.push(
                    new Filter("productName", FilterOperator.Contains, sName)
                );
            }

            oBinding.filter(aFilters);
        },

        onConfirmMaterial: function () {

            const oTable = Fragment.byId("MaterialDlg", "tblMaterial");
            if (!oTable) return;

            const oSelectedItem = oTable.getSelectedItem();

            if (!oSelectedItem) {
                MessageToast.show("Please select a material");
                return;
            }

            const oData = oSelectedItem.getBindingContext("matModel").getObject();

            if (!oCurrentContext) {
                MessageToast.show("Context lost");
                return;
            }

            const oModel = oCurrentContext.getModel();
            const sPath = oCurrentContext.getPath();

            oModel.setProperty(sPath + "/materialId", oData.productId);
            oModel.setProperty(sPath + "/materialDescription", oData.productName);
            oModel.setProperty(sPath + "/consUOM", oData.unitofMeasure);
            oModel.setProperty(sPath + "/productType", oData.productType);

            MessageToast.show("Material selected");

            oMaterialDialog.close();
        },

        onCancelMaterial: function () {
            if (oMaterialDialog) {
                oMaterialDialog.close();
            }
        }
    };
});