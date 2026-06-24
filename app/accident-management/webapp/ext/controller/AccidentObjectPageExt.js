sap.ui.define([
    "sap/m/MessageBox",
    "sap/m/MessageToast",
    "sap/ui/core/BusyIndicator",
    "sap/m/Dialog",
    "sap/m/Button",
    "sap/m/VBox",
    "sap/m/HBox",
    "sap/m/Label",
    "sap/m/Input",
    "sap/m/TextArea",
    "sap/m/Text"
], function (
    MessageBox,
    MessageToast,
    BusyIndicator,
    Dialog,
    Button,
    VBox,
    HBox,
    Label,
    Input,
    TextArea,
    Text
) {
    "use strict";

    // ── Constants ─────────────────────────────────────────────────────────────

    var ACCEPTED_FILE_TYPES = [
        ".pdf", ".doc", ".docx",
        ".xls", ".xlsx",
        ".png", ".jpg", ".jpeg",
        ".txt", ".csv"
    ].join(",");

    var MAX_FILE_SIZE_BYTES = 10 * 1024 * 1024;   // 10 MB

    // ── Private helpers ───────────────────────────────────────────────────────

    function formatFileSize(bytes) {
        if (bytes < 1024)             { return bytes + " B"; }
        if (bytes < 1024 * 1024)      { return (bytes / 1024).toFixed(1) + " KB"; }
        return (bytes / (1024 * 1024)).toFixed(2) + " MB";
    }

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
        if (!oArg) { return null; }

        if (Array.isArray(oArg)) {
            for (var i = 0; i < oArg.length; i++) {
                var oArrCtx = getContextFromArgument(oArg[i]);
                if (oArrCtx) { return oArrCtx; }
            }
        }

        if (oArg.getPath && oArg.getModel)      { return oArg; }
        if (oArg.getBindingContext)              { return oArg.getBindingContext(); }
        if (oArg.context && oArg.context.getPath && oArg.context.getModel) { return oArg.context; }
        if (oArg.contexts)                       { return getContextFromArgument(oArg.contexts); }
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
        if (!mElements) { return null; }

        for (var sId in mElements) {
            if (Object.prototype.hasOwnProperty.call(mElements, sId)) {
                var vResult = fnCallback(mElements[sId], sId);
                if (vResult) { return vResult; }
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
                    model:   oContext.getModel(),
                    view:    findViewFromControl(oElement)
                };
            }
            return null;
        });
    }

    function resolveAccidentState(oHandlerContext, aActionArgs) {
        var oView    = getView(oHandlerContext, aActionArgs);
        var oContext = null;

        for (var i = 0; i < aActionArgs.length; i++) {
            oContext = getContextFromArgument(aActionArgs[i]);
            if (isAccidentContext(oContext)) { break; }
        }

        if (!isAccidentContext(oContext) && oView && oView.getBindingContext) {
            oContext = oView.getBindingContext();
        }

        if (isAccidentContext(oContext)) {
            return {
                context: oContext,
                model:   oContext.getModel(),
                view:    oView || findViewFromControl(oContext.getObject && oContext.getObject())
            };
        }

        return findAccidentStateFromRegistry() || {
            context: null,
            model:   oView && oView.getModel && oView.getModel(),
            view:    oView
        };
    }

    function getAttachmentsTable(oView) {
        var oTable = null;

        if (oView) {
            var sViewId = oView.getId();
            oTable = oView.byId("fe::table::attachments::LineItem-innerTable");

            if (!oTable) {
                oTable = sap.ui.getCore().byId(
                    sViewId + "--fe::table::attachments::LineItem-innerTable"
                );
            }
        }

        if (oTable) { return oTable; }

        return forEachRegisteredElement(function (oElement, sId) {
            if (sId.indexOf("fe::table::attachments::LineItem-innerTable") !== -1) {
                return oElement;
            }
            return null;
        });
    }

    // ── Dialog builder ────────────────────────────────────────────────────────

    /**
     * Builds and opens the pre-upload confirmation dialog.
     *
     * Shows auto-filled read-only fields (name, type, size) and a description
     * TextArea the user fills in before confirming the upload.
     *
     * The actual upload is only triggered when the user clicks "Upload" —
     * cancelling here means nothing is sent to Cloudinary.
     *
     * @param {File}     oFile           The File object from the file picker.
     * @param {string}   sBase64         Raw base64 content (no data URI prefix).
     * @param {Array}    aActionArgs     Original action arguments (for state resolution).
     * @param {object}   oHandlerContext `this` from the calling action handler.
     * @param {object}   oView           SAP UI5 view reference, used as dialog parent.
     */
    function openUploadDialog(oFile, sBase64, aActionArgs, oHandlerContext, oView) {

        // ── Read-only fields showing auto-detected file metadata ──────────────

        var oFileNameInput = new Input({
            value:    oFile.name,
            editable: false,
            width:    "100%"
        });

        var oFileTypeInput = new Input({
            value:    oFile.type || "application/octet-stream",
            editable: false,
            width:    "100%"
        });

        var oFileSizeInput = new Input({
            value:    formatFileSize(oFile.size) + " (" + oFile.size + " bytes)",
            editable: false,
            width:    "100%"
        });

        // ── Editable description field ────────────────────────────────────────

        var oDescriptionArea = new TextArea({
            placeholder: "Describe what this document covers, e.g. 'Police report filed at Koramangala station on 12-Jun-2025'",
            rows:        4,
            width:       "100%",
            maxLength:   500
        });

        // ── Layout ────────────────────────────────────────────────────────────

        var labelStyle = { paddingBottom: "4px", paddingTop: "12px" };

        var oContent = new VBox({
            width: "100%",
            items: [
                // File Name
                new Label({ text: "File Name", design: "Bold" }).addStyleClass("sapUiTinyMarginTop"),
                oFileNameInput,

                // File Type
                new Label({ text: "File Type", design: "Bold" }).addStyleClass("sapUiTinyMarginTop"),
                oFileTypeInput,

                // File Size
                new Label({ text: "File Size", design: "Bold" }).addStyleClass("sapUiTinyMarginTop"),
                oFileSizeInput,

                // Description (editable)
                new Label({ text: "Description", design: "Bold" }).addStyleClass("sapUiSmallMarginTop"),
                oDescriptionArea
            ]
        }).addStyleClass("sapUiSmallMarginBeginEnd sapUiSmallMarginBottom");

        // ── Dialog ────────────────────────────────────────────────────────────

        var oDialog = new Dialog({
            title:         "Upload Attachment",
            contentWidth:  "480px",
            resizable:     true,
            content:       [oContent],

            beginButton: new Button({
                text:  "Upload",
                type:  "Emphasized",
                press: function () {
                    var sDescription = oDescriptionArea.getValue();
                    oDialog.close();

                    AttachmentActions._callUploadAction.call(
                        oHandlerContext,
                        oFile.name,
                        oFile.type || "application/octet-stream",
                        sBase64,
                        sDescription,
                        aActionArgs
                    );
                }
            }),

            endButton: new Button({
                text:  "Cancel",
                press: function () {
                    oDialog.close();
                }
            }),

            afterClose: function () {
                oDialog.destroy();
            }
        });

        // Attach to view for proper lifecycle; fall back to static area
        if (oView && oView.addDependent) {
            oView.addDependent(oDialog);
        }

        oDialog.open();
    }

    // ── Attachment action handlers ────────────────────────────────────────────

    var AttachmentActions = {

        // ── onUploadAttachment ────────────────────────────────────────────────
        /**
         * Entry point wired to the "Upload Attachment" toolbar button in manifest.json.
         *
         * Opens a hidden file input.  After the user picks a file:
         *   1. Validates file size (≤ 10 MB).
         *   2. Reads the file as a Data URL (base64).
         *   3. Opens the confirmation dialog with auto-filled metadata fields
         *      and an editable description field.
         *   4. The actual upload to Cloudinary only happens when the user
         *      confirms inside the dialog.
         */
        onUploadAttachment: function () {
            var oHandlerContext = this;
            var aActionArgs     = Array.prototype.slice.call(arguments);
            var oState          = resolveAccidentState(oHandlerContext, aActionArgs);

            // ── Safety check: must be an active (saved) Accident record ───────
            // The manifest's visible binding (HasActiveEntity === true) already
            // hides this button during new-record creation, but we double-guard here.
            if (!oState.context) {
                MessageBox.error(
                    "Cannot determine the current Accident record.\n" +
                    "Please save the record before uploading attachments."
                );
                return;
            }

            var oInput  = document.createElement("input");
            oInput.type = "file";
            oInput.accept = ACCEPTED_FILE_TYPES;

            oInput.onchange = function (oChangeEvent) {
                var oFile = oChangeEvent.target.files[0];
                if (!oFile) { return; }

                // ── File size guard ───────────────────────────────────────────
                if (oFile.size > MAX_FILE_SIZE_BYTES) {
                    MessageBox.error(
                        "File is too large. Maximum allowed size is 10 MB.\n" +
                        "Selected file: " + formatFileSize(oFile.size)
                    );
                    return;
                }

                // ── Read as base64 ────────────────────────────────────────────
                var oReader   = new FileReader();

                oReader.onload = function (oLoadEvent) {
                    var sDataUri = oLoadEvent.target.result;
                    var sBase64  = sDataUri.split(",")[1];  // strip "data:...;base64,"

                    openUploadDialog(
                        oFile,
                        sBase64,
                        aActionArgs,
                        oHandlerContext,
                        oState.view
                    );
                };

                oReader.onerror = function () {
                    MessageBox.error("Could not read the selected file. Please try again.");
                };

                oReader.readAsDataURL(oFile);
            };

            oInput.click();
        },

        // ── _callUploadAction ─────────────────────────────────────────────────
        /**
         * Called by the dialog's Upload button.
         * Fires the OData action uploadAccidentFile with all parameters.
         *
         * @param {string} sFileName       Original file name.
         * @param {string} sMediaType      MIME type.
         * @param {string} sBase64Content  Raw base64 content (no data URI prefix).
         * @param {string} sDescription    User-entered document description.
         * @param {Array}  aActionArgs     Original action arguments.
         */
        _callUploadAction: function (sFileName, sMediaType, sBase64Content, sDescription, aActionArgs) {
            var oState   = resolveAccidentState(this, aActionArgs || []);
            var oModel   = oState.model;
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
                    "Cannot read the Accident ID. " +
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
            oOperation.setParameter("fileName",    sFileName);
            oOperation.setParameter("mediaType",   sMediaType);
            oOperation.setParameter("content",     sBase64Content);
            oOperation.setParameter("description", sDescription || "");

            oOperation.execute()
                .then(function () {
                    BusyIndicator.hide();
                    MessageToast.show("'" + sFileName + "' uploaded successfully.");
                    oModel.refresh();
                })
                .catch(function (oError) {
                    BusyIndicator.hide();
                    MessageBox.error(
                        "Upload failed:\n" + (
                            oError && oError.message
                                ? oError.message
                                : "An unknown error occurred during upload."
                        )
                    );
                });
        },

        // ── onDeleteAttachment ────────────────────────────────────────────────
        /**
         * Entry point wired to the "Delete Attachment" toolbar button.
         * Reads the selected row from the attachments table and confirms deletion.
         */
        onDeleteAttachment: function () {
            var aActionArgs = Array.prototype.slice.call(arguments);
            var oState      = resolveAccidentState(this, aActionArgs);
            var oTable      = getAttachmentsTable(oState.view);

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
            var sAttachmentId   = oSelectedContext.getProperty("ID");
            var sFileName       = oSelectedContext.getProperty("fileName");

            MessageBox.confirm(
                "Permanently delete '" + sFileName + "'?\n" +
                "This will remove the file from Cloudinary storage and cannot be undone.",
                {
                    title:   "Confirm Delete",
                    onClose: function (sAction) {
                        if (sAction === MessageBox.Action.OK) {
                            AttachmentActions._callDeleteAction.call(
                                this, sAttachmentId, aActionArgs
                            );
                        }
                    }.bind(this)
                }
            );
        },

        // ── _callDeleteAction ─────────────────────────────────────────────────
        /**
         * Fires the OData action deleteAccidentFile for the given attachment ID.
         */
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
                    MessageBox.error(
                        "Delete failed:\n" + (
                            oError && oError.message
                                ? oError.message
                                : "An unknown error occurred during deletion."
                        )
                    );
                });
        }
    };

    return AttachmentActions;
});