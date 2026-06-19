sap.ui.define([
    "sap/m/Dialog",
    "sap/m/Button",
    "sap/m/upload/UploadSet",
    "sap/m/MessageToast"
], function (Dialog,
    Button,
    UploadSet,
    MessageToast) {
    'use strict';
    return {
        /**
         * Generated event handler.
         *
         * @param oContext the context of the page on which the event was fired. `undefined` for list report page.
         * @param aSelectedContexts the selected contexts of the table rows.
         */
        onUploadEmployeeMaster: function() {
          const oUploadSet = new UploadSet({
                fileTypes: ["csv"],
                uploadEnabled: true,     // enables file picker
                instantUpload: false,    // prevents auto upload
                multiple: false
            });

            const oDialog = new Dialog({
                title: "Upload CSV",
                contentWidth: "30rem",
                content: oUploadSet,

                beginButton: new Button({
                    text: "Upload",
                    type: "Emphasized",
                    press: () => {
                        const aItems = oUploadSet.getItems();
                        if (!aItems.length) {
                            MessageToast.show("Please select a CSV file");
                            return;
                        }
                        this._uploadFile(aItems[0], oDialog);
                    }
                }),

                endButton: new Button({
                    text: "Cancel",
                    press: () => {
                        oDialog.close();
                        oDialog.destroy();
                    }
                })
            });

            oDialog.open();
        },
        _uploadFile: function (file) {
            const oFile = oItem.getFileObject();
            const reader = new FileReader();

            reader.onload = () => {
                const base64 = reader.result.split(",")[1];

                this.getView().getModel()
                    .bindContext("/uploadEmployeeMaster(...)")
                    .setParameter("file", base64)
                    .execute()
                    .then(() => {
                        MessageToast.show("Upload successful");
                        this.getView().getModel().refresh();
                        oDialog.close();
                        oDialog.destroy();
                    });
            };

            reader.readAsDataURL(oFile);
        }
    };
});
