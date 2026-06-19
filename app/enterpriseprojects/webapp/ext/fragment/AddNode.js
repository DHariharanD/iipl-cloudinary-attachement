sap.ui.define(
  [
    "sap/m/MessageToast",
    "sap/m/MessageBox",
    "sap/ui/core/Fragment",
    "sap/ui/model/Filter",
  ],
  function (MessageToast, MessageBox, Fragment, Filter) {
    "use strict";

    function getSuffixLength(parentCode) {
      const len = parentCode ? parentCode.length : 0;
      if (len < 6) return 2;
      if (len === 6) return 3;
      return 4;
    }

    async function generateNextCode(oModel, parentId, parentCode) {
      const SUFFIX_LENGTH = getSuffixLength(parentCode);

      const aCtx = await oModel
        .bindList("/ProjectPlanning", null, null, [
          new Filter("parent_ID", "EQ", parentId),
        ])
        .requestContexts();

      const aSeq = aCtx
        .map((c) => c.getObject())
        .filter(
          (o) =>
            o.projectElementDescription &&
            o.projectElementDescription.startsWith(parentCode)
        )
        .map((o) => {
          const suffix = o.projectElementDescription.slice(parentCode.length);
          return parseInt(suffix, 10);
        })
        .filter((n) => !isNaN(n));

      if (!aSeq.length) {
        return parentCode + String(1).padStart(SUFFIX_LENGTH, "0");
      }

      const nextSeq = Math.max(...aSeq) + 1;
      return parentCode + String(nextSeq).padStart(SUFFIX_LENGTH, "0");
    }

    return {
      _pDialog: null,
      _oParentContext: null,

      onPress: async function (oEvent) {
        const oButton = oEvent.getSource();
        this._oParentContext = oButton.getBindingContext();

        if (!this._oParentContext) {
          MessageToast.show("No context found");
          return;
        }

        
        const oView = oButton.getParent().getParent();

        if (!this._pDialog) {
          this._pDialog = Fragment.load({
            id: oView.getId(),
            name: "ns.enterpriseprojects.ext.fragment.AddNodeProjectwbs",
            controller: this,
          }).then((oDialog) => {
            oView.addDependent(oDialog);
            return oDialog;
          });
        }

        this._pDialog.then((oDialog) => {
          oDialog.open();
          oDialog.attachAfterOpen(() => {
            const sPrefix = oDialog
              .getId()
              .split("--")
              .slice(0, -1)
              .join("--");
            Fragment.byId(sPrefix, "wbsInpName").setValue("");
            Fragment.byId(sPrefix, "wbsInpDesc").setValue("");
          });
        });
      },

      onSubmit: async function (oEvent) {
        const oDialog = oEvent.getSource().getParent();
        const sPrefix = oDialog.getId().split("--").slice(0, -1).join("--");

        const oName = Fragment.byId(sPrefix, "wbsInpName");
        const oDesc = Fragment.byId(sPrefix, "wbsInpDesc");

        if (!oName.getValue()) {
          MessageBox.warning("Name is required");
          return;
        }

        const oModel = this._oParentContext.getModel();
        const parentObj = this._oParentContext.getObject();

        const groupId = "wbsNodeCreateGroup";

        const oList = oModel.bindList("/ProjectPlanning", null, null, null, {
          $$updateGroupId: groupId,
        });

        oDialog.setBusy(true);

        oList.create({
          ID: crypto.randomUUID(),
          projectElementDescription: oName.getValue(),
          projectId: oDesc.getValue(),
          parent_ID: parentObj.ID,
          plshierarchy_ID: parentObj.plshierarchy_ID,
        });

        try {
          await oModel.submitBatch(groupId);
          MessageToast.show("Created successfully");
          oDialog.close();

          await this._oParentContext.requestRefresh();

          const oBinding = this._oParentContext.getBinding();
          if (oBinding && oBinding.refresh) {
            oBinding.refresh();
          }
        } catch (e) {
          MessageBox.error("Creation failed: " + e.message);
        } finally {
          oDialog.setBusy(false);
        }
      },

      onCancel: function (oEvent) {
        oEvent.getSource().getParent().close();
      },
    };
  }
);