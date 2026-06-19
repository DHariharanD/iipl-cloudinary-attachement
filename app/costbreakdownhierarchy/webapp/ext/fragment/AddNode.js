sap.ui.define([
    "sap/m/MessageToast",
    "sap/ui/core/Fragment",
    "sap/ui/model/json/JSONModel",
    "sap/m/SelectDialog",
    "sap/m/StandardListItem",
    "sap/m/MessageBox"
], function (MessageToast, Fragment, JSONModel, SelectDialog, StandardListItem, MessageBox) {
    "use strict";

    return {
        _pDialog: null,
        _mode: "NODE",
        _selectedProducts: [],
        _productVH: null,
        _oParentContext: null,

        onPress: function (oEvent) {
            const oButton = oEvent.getSource();
            this._oParentContext = oButton.getBindingContext();
            const oView = oButton.getParent().getParent();

            if (!this._pDialog) {
                this._pDialog = Fragment.load({
                    id: oView.getId(),
                    name: "ns.costbreakdownhierarchy.ext.fragment.AddNodeDialog",
                    controller: this
                }).then(oDialog => {
                    oView.addDependent(oDialog);
                    return oDialog;
                });
            }

            this._pDialog.then(oDialog => {
                this._mode = "NODE";
                this._selectedProducts = [];

                const sPrefix = oDialog.getId().split("--").slice(0, -1).join("--");
                const oRB = Fragment.byId(sPrefix, "cbhModeRB");
                const oLbl = Fragment.byId(sPrefix, "cbhLblMainField");
                const oInput = Fragment.byId(sPrefix, "cbhMainField");
                const oDesc = Fragment.byId(sPrefix, "cbhDesc");

                oRB.setSelectedIndex(0);
                oLbl.setText("Node Name");
                oInput.setShowValueHelp(false);
                oInput.setValue("");
                oInput.setEnabled(true);
                oDesc.setValue("");
                oDialog.open();
            });
        },

        onTypeChange: function (oEvent) {
            const iIndex = oEvent.getParameter("selectedIndex");
            this._mode = (iIndex === 0) ? "NODE" : "PRODUCT";
            this._selectedProducts = [];

            this._pDialog.then(d => {
                const sPrefix = d.getId().split("--").slice(0, -1).join("--");
                const oLbl = Fragment.byId(sPrefix, "cbhLblMainField");
                const oInput = Fragment.byId(sPrefix, "cbhMainField");
                const oDesc = Fragment.byId(sPrefix, "cbhDesc");

                oInput.setValue("");
                oDesc.setValue("");

                if (this._mode === "NODE") {
                    oLbl.setText("Node Name");
                    oInput.setShowValueHelp(false);
                    oInput.setEnabled(true);
                } else {
                    oLbl.setText("Product(s)");
                    oInput.setShowValueHelp(true);
                    oInput.setPlaceholder("Select products via value help...");

                }
            });
        },

        onProductVH: async function () {
            if (this._mode !== "PRODUCT") return;

            if (!this._productVH) {
                this._productVH = new SelectDialog({
                    title: "Select Products",
                    multiSelect: true,
                    rememberSelections: true,
                    confirm: e => {
                        const aSelectedItems = e.getParameter("selectedItems");

                        this._selectedProducts = aSelectedItems.map(item => item.getBindingContext().getObject());

                        this._pDialog.then(d => {
                            const sPrefix = d.getId().split("--").slice(0, -1).join("--");

                            const sText = this._selectedProducts.length > 0
                                ? `${this._selectedProducts.length} Product(s) Selected`
                                : "";

                            Fragment.byId(sPrefix, "cbhMainField").setValue(sText);

                            if (this._selectedProducts.length === 1) {
                                Fragment.byId(sPrefix, "cbhDesc").setValue(this._selectedProducts[0].descr || "");
                            } else {
                                Fragment.byId(sPrefix, "cbhDesc").setValue("");
                            }
                        });
                    }
                });
            }

            const resp = await fetch("/odata/v4/ResourceServices/ResourceMaterial");
            const data = await resp.json();

            this._productVH.setModel(new JSONModel(data.value || []));
            this._productVH.bindAggregation("items", {
                path: "/",
                template: new StandardListItem({
                    title: "{productName}",
                    description: "{productId}",
                    info: "{unitofMeasure}"
                })
            });

            this._productVH.open();
        },

        onSubmit: async function () {
            this._pDialog.then(async d => {
                const sPrefix = d.getId().split("--").slice(0, -1).join("--");
                const oInput = Fragment.byId(sPrefix, "cbhMainField");
                const oDesc = Fragment.byId(sPrefix, "cbhDesc");
                const oModel = d.getModel();

                const parent = this._oParentContext.getObject();
                const oListBinding = oModel.bindList("/CostBreakdownStructure");

                

                try {
                    if (this._mode === "NODE") {
                        const name = oInput.getValue();
                        const descr = oDesc.getValue();
                        if(!name) {
                            oInput.setValueState("Error");
                            oInput.setValueStateText("Name is required");
                            return;
                        } else {
                            oInput.setValueState("None");
                        }
                        d.setBusy(true);

                        await oListBinding.create({
                            ID: crypto.randomUUID(),
                            name: name,
                            descr: descr,
                            code: name,
                            parent_ID: parent.ID,
                            cbshierarchy_ID: parent.cbshierarchy_ID
                        }).created();

                    } else if (this._mode === "PRODUCT") {
                        if (this._selectedProducts.length === 0) {
                            throw new Error("Please select at least one product.");
                        }


                        const aCreationPromises = this._selectedProducts.map(product => {
                            const oCreateData = {
                                ID: crypto.randomUUID(),
                                name: product.productName,
                                code: product.productId,
                                descr: product.descr || "",
                                parent_ID: parent.ID,
                                cbshierarchy_ID: parent.cbshierarchy_ID
                            };
                            return oListBinding.create(oCreateData).created();
                        });

                        await Promise.all(aCreationPromises);
                    }

                    d.setBusy(false);
                    d.close();
                    MessageToast.show("Created successfully");
                    oModel.refresh();

                } catch (e) {
                    d.setBusy(false);
                    MessageBox.error(e.message || "Create failed");
                }
            });
        },

        onCancel: function () {
            this._pDialog.then(oDialog => oDialog.close());
        }
    };
});
