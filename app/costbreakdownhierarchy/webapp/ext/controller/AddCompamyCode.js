sap.ui.define([
    "sap/ui/core/Fragment",
    "sap/ui/model/json/JSONModel",
    "sap/m/MessageToast"
], function (Fragment, JSONModel, MessageToast) {

    "use strict";

    let that;              //        test
    let oDialog = null;
    let _savedCtx = null;

    function getObjectPageLayout() {
        let oObjectPage = null;
        sap.ui.core.Element.registry.forEach(function (oEl) {
            if (oEl.isA && oEl.isA("sap.uxap.ObjectPageLayout")) {
                if (oEl.getBindingContext()) {
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

    async function loadDialog(oView) {
        if (oDialog && oDialog.isDestroyed()) {
            oDialog = null;
        }

        if (!oDialog) {
            oDialog = await Fragment.load({
                id: oView.getId(),
                name: "ns.costbreakdownhierarchy.ext.fragment.CbsCompanyCodeDialog",
                controller: that
            });
            oView.addDependent(oDialog);
        }
        return oDialog;
    }

    that = {

        addCompanyCode: async function (oInput) {

            let oCtx = _resolveContext(oInput);
            const oView = getObjectPageLayout();

            if (!oCtx && oView) {
                oCtx = oView.getBindingContext();
            }

            if (!oCtx) {
                MessageToast.show("No binding context found");
                return;
            }

            _savedCtx = oCtx;

            const oDialogLoaded = await loadDialog(oView);
            oDialogLoaded.open();
            oDialogLoaded.setBusy(true);

            try {
                const oModel = oCtx.getModel();

                const aContexts = await oModel.bindList("/company").requestContexts();

                const items = aContexts.map(ctx => {
                    const obj = ctx.getObject();
                    return {
                        CompanyCode: obj.CompanyCode,
                        CompanyCodeName: obj.CompanyCodeName,   
                        isSelected: false,
                        isEnabled: true
                    };
                });

                oDialogLoaded.setModel(new JSONModel({ items }), "rtModel");

            } catch (e) {
                console.error(e);
                MessageToast.show("Failed to load Company Codes");
            } finally {
                oDialogLoaded.setBusy(false);
            }
        },

        
        onConfirmCompanyCode: async function () {

            if (!_savedCtx) {
                MessageToast.show("Context lost");
                return;
            }

            const oModel = _savedCtx.getModel();
            const items = oDialog.getModel("rtModel").getProperty("/items");
            const selected = items.filter(i => i.isSelected);

            if (!selected.length) {
                MessageToast.show("Select at least one Company Code");
                return;
            }

            const groupId = "cbsCompanyCreateGroup";

            try {

                const oBinding = oModel.bindList(
                    _savedCtx.getPath() + "/cbsTypeCompany",
                    null,
                    null,
                    null,
                    { $$updateGroupId: groupId }
                );

                selected.forEach(company => {
                    oBinding.create({
                        ID: crypto.randomUUID(),
                        companyCode: company.CompanyCode,
                        companyName: company.CompanyCodeName
                    });
                });

                await oModel.submitBatch(groupId);

                oDialog.close();

                MessageToast.show("Company Codes added successfully");

                await _savedCtx.requestRefresh();

            } catch (error) {
                console.error(error);
                MessageToast.show("Save failed");
            }
        },
        
        onCancelCompanyCode: function () {
            oDialog.close();
        },

        onSelectAllCompanyCode: function (oEvent) {

            const selected = oEvent.getParameter("selected");
            const model = oDialog.getModel("rtModel");
            const items = model.getProperty("/items");

            items.forEach(i => {
                if (i.isEnabled) {
                    i.isSelected = selected;
                }
            });

            model.refresh();
        }
    };

    return that;
});