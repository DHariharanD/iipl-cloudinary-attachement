sap.ui.define([
    "sap/m/MessageToast",
    "sap/m/upload/UploadSet",
    "sap/m/Dialog",
    "sap/m/Button"
], function (MessageToast, UploadSet, Dialog, Button) {
    "use strict";

    return {

        uploadExcel: function (oContext) {

            const hierarchyId = oContext.getObject().ID;
            let oSelectedItem = null;

            const oUploadSet = new UploadSet({
                fileTypes: ["xlsx"],
                instantUpload: false,
                multiple: false,

                afterItemAdded: function (oEvent) {
                    oSelectedItem = oEvent.getParameter("item");
                }
            });

            const oDialog = new Dialog({
                title: "Upload Excel",
                contentWidth: "30rem",
                content: oUploadSet,

                beginButton: new Button({
                    text: "Upload",
                    type: "Emphasized",

                    press: function () {

                        if (!oSelectedItem) {
                            MessageToast.show("Please select an Excel file");
                            return;
                        }

                        const oFile = oSelectedItem.getFileObject();
                        const reader = new FileReader();

                        reader.onload = async function (e) {

                            const base64 = e.target.result.split(",")[1];

                            try {

                                const oModel = oContext.getModel();

                                await oModel
                                    .bindContext("/uploadResourceCategories(...)")
                                    .setParameter("file", base64)
                                    .setParameter("hierarchyId", hierarchyId)
                                    .execute();

                                MessageToast.show("Upload successful");

                                oModel.refresh();

                            } catch (error) {

                                MessageToast.show("Upload failed");

                            }

                            oDialog.close();
                            oDialog.destroy();
                        };

                        reader.readAsDataURL(oFile);
                    }
                }),

                endButton: new Button({
                    text: "Cancel",
                    press: function () {
                        oDialog.close();
                        oDialog.destroy();
                    }
                })
            });

            oDialog.open();
        }

    };

});