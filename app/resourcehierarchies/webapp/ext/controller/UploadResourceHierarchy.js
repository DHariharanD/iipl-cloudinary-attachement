sap.ui.define([
    "sap/m/MessageToast",
    "sap/m/upload/UploadSet",
    "sap/m/Dialog",
    "sap/m/Button"
], function (MessageToast, UploadSet, Dialog, Button) {
    "use strict";

    return {

        onUploadResourceHierarchy: function (oContext) {

    let oSelectedItem = null;

    // ✅ store model safely
    const oModel = this.getModel();

    const oUploadSet = new UploadSet({
        fileTypes: ["xlsx"],
        instantUpload: false,
        multiple: false,

        afterItemAdded: function (oEvent) {
            oSelectedItem = oEvent.getParameter("item");
        }
    });

    const oDialog = new Dialog({
        title: "Upload Resource Hierarchy Excel",
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

                        await oModel
                            .bindContext("/uploadResourceTypes(...)")
                            .setParameter("file", base64)
                            .execute();

                        MessageToast.show("Upload successful");

                        oModel.refresh();

                    } catch (error) {

                        console.error(error);
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