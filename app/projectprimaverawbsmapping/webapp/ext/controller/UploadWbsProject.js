sap.ui.define([
    "sap/m/MessageToast",
    "sap/m/upload/UploadSet",
    "sap/m/Dialog",
    "sap/m/Button"
], function (MessageToast, UploadSet, Dialog, Button) {
    "use strict";

    return {

        onUploadWbsProject: function () {

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
                title: "Upload WBS Project Excel",
                contentWidth: "30rem",
                content: [oUploadSet],

                beginButton: new Button({
                    text: "Upload",
                    type: "Emphasized",
                    press: () => {

                        if (!oSelectedItem) {
                            MessageToast.show("Please select an Excel file");
                            return;
                        }

                        const oFile = oSelectedItem.getFileObject();
                        if (!oFile) {
                            MessageToast.show("File not found");
                            return;
                        }

                        const reader = new FileReader();

                        reader.onload = async (e) => {
                            try {
                                const base64 = e.target.result.split(",")[1];
                                const response = await fetch(
                                    "/odata/v4/ProjectPrimaveraWBSService/UploadWbsProject",
                                    {
                                        method: "POST",
                                        headers: {
                                            "Content-Type": "application/json",
                                            "X-Requested-With": "XMLHttpRequest"
                                        },
                                        body: JSON.stringify({ file: base64 })
                                    }
                                );

                                if (!response.ok) {
                                    const text = await response.text();
                                    throw new Error("HTTP " + response.status + ": " + text);
                                }

                                MessageToast.show("Upload successful");

                                setTimeout(function () {
                                    window.location.reload();
                                }, 1500);

                            } catch (err) {
                                console.error("Upload Error:", err);
                                MessageToast.show("Upload failed: " + (err.message || "Unknown error"));
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