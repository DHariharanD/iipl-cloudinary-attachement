sap.ui.define([
    "sap/m/MessageToast",
    "sap/m/upload/UploadSet",
    "sap/m/Dialog",
    "sap/m/Button"
], function (MessageToast, UploadSet, Dialog, Button) {
    "use strict";

    return {

        handleClassUpload: function () {

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
                content: [oUploadSet],

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

                            const payload = {
                                file: base64
                            };

                            try {

                                const response = await fetch("/odata/v4/ClassService/UploadClass", {
                                    method: "POST",
                                    headers: { "Content-Type": "application/json" },
                                    body: JSON.stringify(payload)
                                });

                                if (!response.ok) {
                                    throw new Error("Upload failed");
                                }

                                MessageToast.show("Upload successful");

                            } catch (error) {

                                MessageToast.show("Upload failed");
                                console.error(error);

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