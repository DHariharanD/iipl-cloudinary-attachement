sap.ui.define(
  [
    "sap/m/MessageToast",
    "sap/m/MessageBox",
    "sap/ui/core/Fragment",
    "sap/ui/model/json/JSONModel",
    "sap/m/SelectDialog",
    "sap/m/StandardListItem",
    "sap/ui/model/Filter",
  ],
  function (
    MessageToast,
    MessageBox,
    Fragment,
    JSONModel,
    SelectDialog,
    StandardListItem,
    Filter,
  ) {
    "use strict";

    function getSuffixLength(parentCode) {
      const len = parentCode.length;

      if (len < 6) {
        return 2;
      }
      if ((len == 6)) {
        return 3;
      }

      return 4;
    }

    async function generateNextCode(oModel, parentId, parentCode) {
      const SUFFIX_LENGTH = getSuffixLength(parentCode);

      const aCtx = await oModel
        .bindList("/ResourceCategories", null, null, [
          new sap.ui.model.Filter("parent_ID", "EQ", parentId),
        ])
        .requestContexts();

      const aSeq = aCtx
        .map((c) => c.getObject())
        .filter((o) => o.code && o.code.startsWith(parentCode))
        .map((o) => {
          const suffix = o.code.slice(parentCode.length);
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
      _selectedRT: null,
      _rtVH: null,
      _mode: "NODE",

      onPress: async function (oEvent) {
        const oButton = oEvent.getSource();
        this._oParentContext = oButton.getBindingContext();
        const oParent = this._oParentContext.getObject();

        if (oParent.resourceType_code) {
          MessageToast.show("This node already has a Resource Type");
          return;
        }

        const oView = oButton.getParent().getParent();
        const oModel = this._oParentContext.getModel();

        let aChildren = [];
        const sParentId = oParent.ID;

        if (sParentId) {
          const oListBinding = oModel.bindList(
            "/ResourceCategories",
            null,
            null,
            [new Filter("parent_ID", "EQ", sParentId)],
          );
          try {
            const aCtx = await oListBinding.requestContexts(0, 50);
            aChildren = aCtx.map((c) => c.getObject());
          } catch (e) {
            aChildren = [];
          }
        }

        const bHasChildren = aChildren.length > 0;
        const bHasRTChild = aChildren.some((c) => !!c.resourceType_code);
        const bHasOnlyNodeChildren = bHasChildren && !bHasRTChild;

        if (!this._pDialog) {
          this._pDialog = Fragment.load({
            id: oView.getId(),
            name: "ns.resourcehierarchies.ext.fragment.AddNodeDialog",
            controller: this,
          }).then((oDialog) => {
            oView.addDependent(oDialog);
            return oDialog;
          });
        }

        this._selectedRT = null;

        this._pDialog.then((oDialog) => {
          oDialog.open();
          oDialog.attachAfterOpen(() => {
            const sPrefix = oDialog.getId().split("--").slice(0, -1).join("--");

            const oRB = Fragment.byId(sPrefix, "modeRB");
            const aBtns = oRB.getButtons();
            const oName = Fragment.byId(sPrefix, "inpName");
            const oDesc = Fragment.byId(sPrefix, "inpDesc");
            const oLblRT = Fragment.byId(sPrefix, "lblRT");
            const oInpRT = Fragment.byId(sPrefix, "inpRT");

            oRB.setSelectedIndex(-1);
            oName.setValue("");
            oDesc.setValue("");
            oInpRT.setValue("");

            oLblRT.setVisible(false);
            oInpRT.setVisible(false);

            aBtns[0].setEnabled(true);
            aBtns[1].setEnabled(true);

            if (!bHasChildren || bHasOnlyNodeChildren) {
              this._mode = "NODE";
              aBtns[1].setEnabled(!bHasChildren);
              oRB.setSelectedIndex(0);
            } else {
              this._mode = "RTYPE";
              aBtns[0].setEnabled(false);
              oRB.setSelectedIndex(1);
              oLblRT.setVisible(true);
              oInpRT.setVisible(true);
            }
          });
        });
      },

      onTypeChange: function (oEvent) {
        const iIndex = oEvent.getParameter("selectedIndex");
        const oRB = oEvent.getSource();
        const aBtns = oRB.getButtons();

        if (!aBtns[iIndex].getEnabled()) {
          oRB.setSelectedIndex(this._mode === "NODE" ? 0 : 1);
          return;
        }

        this._mode = iIndex === 0 ? "NODE" : "RTYPE";

        const oDialog = oRB.getParent().getParent();
        const sPrefix = oDialog.getId().split("--").slice(0, -1).join("--");

        Fragment.byId(sPrefix, "inpName").setValue("");
        Fragment.byId(sPrefix, "inpDesc").setValue("");
        Fragment.byId(sPrefix, "inpRT").setValue("");

        this._selectedRT = null;

        Fragment.byId(sPrefix, "lblRT").setVisible(this._mode === "RTYPE");
        Fragment.byId(sPrefix, "inpRT").setVisible(this._mode === "RTYPE");
      },

      onResourceTypeVH: async function () {
        if (this._mode !== "RTYPE") return;

        if (!this._rtVH) {
          this._rtVH = new SelectDialog({
            title: "Select Resource Type",
            confirm: (e) => {
              const obj = e
                .getParameter("selectedItem")
                .getBindingContext()
                .getObject();
              this._selectedRT = obj;

              this._pDialog.then((d) => {
                const sPrefix = d.getId().split("--").slice(0, -1).join("--");
                Fragment.byId(sPrefix, "inpRT").setValue(obj.name);
              });
            },
          });
        }

        const oModel = this.getModel();
        const aCtx = await oModel.bindList("/RtTypes").requestContexts();
        this._rtVH.setModel(new JSONModel(aCtx.map((c) => c.getObject())));
        this._rtVH.bindAggregation("items", {
          path: "/",
          template: new StandardListItem({
            title: "{name}",
            description: "{descr}",
            info: "{code}",
          }),
        });
        this._rtVH.open();
      },

      onSubmit: async function (oEvent) {
        const oDialog = oEvent.getSource().getParent();
        const sPrefix = oDialog.getId().split("--").slice(0, -1).join("--");

        const oName = Fragment.byId(sPrefix, "inpName");
        const oDesc = Fragment.byId(sPrefix, "inpDesc");

        if (!oName.getValue()) {
          MessageBox.warning("Name is required");
          return;
        }

        if (this._mode === "RTYPE" && !this._selectedRT) {
          MessageBox.warning("Please select Resource Type");
          return;
        }

        const oModel = this._oParentContext.getModel();
        const parentObj = this._oParentContext.getObject();

        const sParentCode = parentObj.code;
        const sParentId = parentObj.ID;
        const sNewCode = await generateNextCode(
          oModel,
          sParentId,
          sParentCode,
        );
        const groupId = "nodeCreateGroup";

        const oList = oModel.bindList("/ResourceCategories", null, null, null, {
          $$updateGroupId: groupId,
        });

        oDialog.setBusy(true);

        oList.create({
          ID: crypto.randomUUID(),
          name: oName.getValue(),
          code: sNewCode,
          descr: oDesc.getValue(),
          childType: this._mode === "NODE" ? "N" : "R",
          parent_ID: parentObj.ID,
          ResourceHierarchy_ID: parentObj.ResourceHierarchy_ID,
          resourceType_code:
            this._mode === "RTYPE" ? this._selectedRT.code : null,
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

          if (this.extensionAPI && this.extensionAPI.refresh) {
            this.extensionAPI.refresh();
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
  },
);
