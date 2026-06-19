sap.ui.define([
    "sap/ui/core/Fragment",
    "sap/ui/model/json/JSONModel",
    "sap/m/MessageToast"
], function (Fragment, JSONModel, MessageToast) {

    "use strict";

    let that;
    let oCompanyCodeDialog = null;
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

    async function loadCompanyCodeDialog(oView) {

        if (oCompanyCodeDialog && oCompanyCodeDialog.isDestroyed()) {
            oCompanyCodeDialog = null;
        }
        if (!oCompanyCodeDialog) {
            oCompanyCodeDialog = await Fragment.load({
                id: oView.getId(),
                name: "ns.resourcehierarchies.ext.fragment.AddCompanyCodeDialog",
                controller: that
            });
            oView.addDependent(oCompanyCodeDialog);
        }
        return oCompanyCodeDialog;
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
            const oDialog = await loadCompanyCodeDialog(oView);
            oDialog.open();
            oDialog.setBusy(true);
            try {
                const oModel = oCtx.getModel();
                const aCompanyContexts = await oModel.bindList("/company").requestContexts();
                const aCompanies = await Promise.all(
                    aCompanyContexts.map(c => c.requestObject())
                );
                const aExisting = await oModel.bindList(oCtx.getPath() + "/resourceTypeCompany").requestContexts();
                const existingCodes = new Set(aExisting.map(ctx => ctx.getObject().companyCode));
                const items = aCompanies
                    .filter(c => !existingCodes.has(c.CompanyCode))
                    .map(item => ({
                        CompanyCode: item.CompanyCode,
                        CompanyCodeName: item.CompanyCodeName,
                    }));
                oDialog.setModel(new JSONModel({ items }), "rtModel");
            }
            catch (e) {
                console.error(e);
                MessageToast.show("Failed to load Company Codes");
            }
            finally {
                oDialog.setBusy(false);
            }
        },

        onConfirmCompanyCode: async function () {
            if (!_savedCtx) {
                MessageToast.show("Context lost");
                return;
            }
            const oModel = _savedCtx.getModel();
            const items = oCompanyCodeDialog.getModel("rtModel").getProperty("/items");
            const selected = items.filter(i => i.isSelected);
            if (!selected.length) {
                MessageToast.show("Select at least one Company Code");
                return;
            }
            const groupId = "companyCreateGroup";

            try {
                const oBinding = oModel.bindList(
                    _savedCtx.getPath() + "/resourceTypeCompany",
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
                oCompanyCodeDialog.close();
                MessageToast.show("Company Codes added successfully");
                await _savedCtx.requestRefresh();
            }
            catch (error) {
                console.error(error);
                MessageToast.show("Save failed");
            }
        },

        onCancelCompanyCode: function () {
            oCompanyCodeDialog.close();
        },

        onSelectAllCompanyCode: function (oEvent) {
            const selected = oEvent.getParameter("selected");
            const model = oCompanyCodeDialog.getModel("rtModel");
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