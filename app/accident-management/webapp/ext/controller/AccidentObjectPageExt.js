sap.ui.define([
    "sap/m/MessageBox",
    "sap/m/MessageToast",
    "sap/ui/core/BusyIndicator"
], function (MessageBox, MessageToast, BusyIndicator) {
    "use strict";

    var ACCEPTED_FILE_TYPES = [
        ".pdf", ".doc", ".docx",
        ".xls", ".xlsx",
        ".png", ".jpg", ".jpeg",
        ".txt", ".csv"
    ].join(",");

    var MAX_FILE_SIZE_BYTES = 10 * 1024 * 1024;

    function findViewFromControl(oControl) {
        while (oControl) {
            if (oControl.isA && oControl.isA("sap.ui.core.mvc.View")) {
                return oControl;
            }
            oControl = oControl.getParent && oControl.getParent();
        }
        return null;
    }

    function getView(oHandlerContext, aActionArgs) {
        if (oHandlerContext && oHandlerContext.base && oHandlerContext.base.getView) {
            return oHandlerContext.base.getView();
        }

        if (oHandlerContext && oHandlerContext.getView) {
            return oHandlerContext.getView();
        }

        for (var i = 0; i < aActionArgs.length; i++) {
            if (aActionArgs[i] && aActionArgs[i].getSource) {
                return findViewFromControl(aActionArgs[i].getSource());
            }
        }

        return null;
    }

    function getContextFromArgument(oArg) {
        if (!oArg) {
            return null;
        }

        if (Array.isArray(oArg)) {
            for (var i = 0; i < oArg.length; i++) {
                var oArrayContext = getContextFromArgument(oArg[i]);
                if (oArrayContext) {
                    return oArrayContext;
                }
            }
        }

        if (oArg.getPath && oArg.getModel) {
            return oArg;
        }

        if (oArg.getBindingContext) {
            return oArg.getBindingContext();
        }

        if (oArg.context && oArg.context.getPath && oArg.context.getModel) {
            return oArg.context;
        }

        if (oArg.contexts) {
            return getContextFromArgument(oArg.contexts);
        }

        return null;
    }

    function isAccidentContext(oContext) {
        return !!(
            oContext &&
            oContext.getPath &&
            oContext.getPath().indexOf("/Accident(") === 0
        );
    }

    function getElementRegistry() {
        return sap.ui.core &&
            sap.ui.core.Element &&
            sap.ui.core.Element.registry &&
            sap.ui.core.Element.registry.all &&
            sap.ui.core.Element.registry.all();
    }

    function forEachRegisteredElement(fnCallback) {
        var mElements = getElementRegistry();

        if (!mElements) {
            return null;
        }

        for (var sId in mElements) {
            if (Object.prototype.hasOwnProperty.call(mElements, sId)) {
                var vResult = fnCallback(mElements[sId], sId);
                if (vResult) {
                    return vResult;
                }
            }
        }

        return null;
    }

    function findAccidentStateFromRegistry() {
        return forEachRegisteredElement(function (oElement) {
            var oContext = oElement.getBindingContext && oElement.getBindingContext();

            if (isAccidentContext(oContext)) {
                return {
                    context: oContext,
                    model: oContext.getModel(),
                    view: findViewFromControl(oElement)
                };
            }

            return null;
        });
    }

    function resolveAccidentState(oHandlerContext, aActionArgs) {
        var oView = getView(oHandlerContext, aActionArgs);
        var oContext = null;

        for (var i = 0; i < aActionArgs.length; i++) {
            oContext = getContextFromArgument(aActionArgs[i]);
            if (isAccidentContext(oContext)) {
                break;
            }
        }

        if (!isAccidentContext(oContext) && oView && oView.getBindingContext) {
            oContext = oView.getBindingContext();
        }

        if (isAccidentContext(oContext)) {
            return {
                context: oContext,
                model: oContext.getModel(),
                view: oView || findViewFromControl(oContext.getObject && oContext.getObject())
            };
        }

        return findAccidentStateFromRegistry() || {
            context: null,
            model: oView && oView.getModel && oView.getModel(),
            view: oView
        };
    }

    function getAttachmentsTable(oView) {
        var oTable = null;

        if (oView) {
            var sViewId = oView.getId();
            oTable = oView.byId("fe::table::attachments::LineItem-innerTable");

            if (!oTable) {
                oTable = sap.ui.getCore().byId(sViewId + "--fe::table::attachments::LineItem-innerTable");
            }
        }

        if (oTable) {
            return oTable;
        }

        return forEachRegisteredElement(function (oElement, sId) {
            if (sId.indexOf("fe::table::attachments::LineItem-innerTable") !== -1) {
                return oElement;
            }
            return null;
        });
    }

    var AttachmentActions = {
        onUploadAttachment: function () {
            var oHandlerContext = this;
            var aActionArgs = Array.prototype.slice.call(arguments);
            var oInput = document.createElement("input");

            oInput.type = "file";
            oInput.accept = ACCEPTED_FILE_TYPES;

            oInput.onchange = function (oChangeEvent) {
                var oFile = oChangeEvent.target.files[0];
                if (oFile) {
                    AttachmentActions._onFileSelected.call(oHandlerContext, oFile, aActionArgs);
                }
            };

            oInput.click();
        },

        _onFileSelected: function (oFile, aActionArgs) {
            if (oFile.size > MAX_FILE_SIZE_BYTES) {
                MessageBox.error(
                    "File is too large. Maximum allowed size is 10 MB.\n" +
                    "Selected file: " + (oFile.size / (1024 * 1024)).toFixed(2) + " MB"
                );
                return;
            }

            var oHandlerContext = this;
            var oReader = new FileReader();

            oReader.onload = function (oLoadEvent) {
                var sDataUri = oLoadEvent.target.result;
                var sBase64 = sDataUri.split(",")[1];
                var sMediaType = oFile.type || "application/octet-stream";

                AttachmentActions._callUploadAction.call(
                    oHandlerContext,
                    oFile.name,
                    sMediaType,
                    sBase64,
                    aActionArgs
                );
            };

            oReader.onerror = function () {
                MessageBox.error("Could not read the selected file. Please try again.");
            };

            oReader.readAsDataURL(oFile);
        },

        _callUploadAction: function (sFileName, sMediaType, sBase64Content, aActionArgs) {
            var oState = resolveAccidentState(this, aActionArgs || []);
            var oModel = oState.model;
            var oContext = oState.context;

            if (!oContext) {
                MessageBox.error(
                    "Cannot determine the current Accident record. " +
                    "Please save the record before uploading attachments."
                );
                return;
            }

            var sAccidentId = oContext.getProperty("ID");

            if (!sAccidentId) {
                MessageBox.error(
                    "Cannot determine the current Accident ID. " +
                    "Please save the record before uploading attachments."
                );
                return;
            }

            if (!oModel) {
                MessageBox.error("Cannot determine the Accident service model.");
                return;
            }

            BusyIndicator.show(0);

            var oOperation = oModel.bindContext("/uploadAccidentFile(...)");
            oOperation.setParameter("accident_ID", sAccidentId);
            oOperation.setParameter("fileName", sFileName);
            oOperation.setParameter("mediaType", sMediaType);
            oOperation.setParameter("content", sBase64Content);

            oOperation.execute()
                .then(function () {
                    BusyIndicator.hide();
                    MessageToast.show("'" + sFileName + "' uploaded successfully.");
                    oModel.refresh();
                })
                .catch(function (oError) {
                    BusyIndicator.hide();
                    MessageBox.error("Upload failed:\n" + (
                        oError && oError.message
                            ? oError.message
                            : "An unknown error occurred during upload."
                    ));
                });
        },

        onDeleteAttachment: function () {
            var aActionArgs = Array.prototype.slice.call(arguments);
            var oState = resolveAccidentState(this, aActionArgs);
            var oTable = getAttachmentsTable(oState.view);

            if (!oTable) {
                MessageBox.error(
                    "Could not locate the Attachments table. " +
                    "Please inspect the generated table ID and update the controller."
                );
                return;
            }

            var aSelectedItems = oTable.getSelectedItems ? oTable.getSelectedItems() : [];

            if (aSelectedItems.length === 0) {
                MessageBox.warning("Please select an attachment to delete.");
                return;
            }

            var oSelectedContext = aSelectedItems[0].getBindingContext();
            var sAttachmentId = oSelectedContext.getProperty("ID");
            var sFileName = oSelectedContext.getProperty("fileName");

            MessageBox.confirm(
                "Delete attachment '" + sFileName + "'?\n" +
                "This will permanently remove the file from Cloudinary storage.",
                {
                    title: "Confirm Delete",
                    onClose: function (sAction) {
                        if (sAction === MessageBox.Action.OK) {
                            AttachmentActions._callDeleteAction.call(this, sAttachmentId, aActionArgs);
                        }
                    }.bind(this)
                }
            );
        },

        _callDeleteAction: function (sAttachmentId, aActionArgs) {
            var oState = resolveAccidentState(this, aActionArgs || []);
            var oModel = oState.model;

            if (!oModel) {
                MessageBox.error("Cannot determine the Accident service model.");
                return;
            }

            BusyIndicator.show(0);

            var oOperation = oModel.bindContext("/deleteAccidentFile(...)");
            oOperation.setParameter("attachment_ID", sAttachmentId);

            oOperation.execute()
                .then(function () {
                    BusyIndicator.hide();
                    MessageToast.show("Attachment deleted successfully.");
                    oModel.refresh();
                })
                .catch(function (oError) {
                    BusyIndicator.hide();
                    MessageBox.error("Delete failed:\n" + (
                        oError && oError.message
                            ? oError.message
                            : "An unknown error occurred during deletion."
                    ));
                });
        }
    };

    return AttachmentActions;
});
