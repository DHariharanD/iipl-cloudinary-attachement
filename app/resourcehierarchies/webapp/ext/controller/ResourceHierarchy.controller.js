sap.ui.define([
    "sap/ui/core/mvc/ControllerExtension"
], function (ControllerExtension) {
    "use strict";

    return ControllerExtension.extend(
        "ns.resourcehierarchies.ext.controller.ResourceHierarchy",
        {

            override: {

                routing: {

                    onAfterBinding: function () {

                        console.log("onAfterBinding triggered");

                        const oObjectPage =
                            this.base.getView().byId("fe::ObjectPage");

                        if (!oObjectPage) {
                            console.log("ObjectPage missing");
                            return;
                        }

                        console.log("ObjectPage:", oObjectPage);

                        const oContext =
                            oObjectPage.getBindingContext();

                        if (!oContext) {
                            console.log("Binding Context missing");
                            return;
                        }

                        console.log(
                            "Binding Context:",
                            oContext
                        );

                        const oModel =
                            oContext.getModel();

                        // IMPORTANT:
                        // Force expand of resourceType
                        const oBindingContext =
                            oModel.bindContext(
                                oContext.getPath(),
                                null,
                                {
                                    $expand: "resourceType"
                                }
                            );

                        oBindingContext
                            .requestObject()
                            .then(function (oObject) {

                                console.log(
                                    "FINAL OBJECT:",
                                    oObject
                                );

                                if (!oObject) {
                                    console.log(
                                        "Object missing"
                                    );
                                    return;
                                }

                                const aSections =
                                    oObjectPage.getSections();

                                // Hide all sections except Overview
                                aSections.forEach(function (oSection) {

                                    const sId =
                                        oSection.getId();

                                    if (
                                        sId.endsWith("Overview")
                                    ) {
                                        oSection.setVisible(true);
                                    } else {
                                        oSection.setVisible(false);
                                    }

                                });

                                // Get Type Code
                                const sTypeCode =
                                    oObject.resourceType_code ||
                                    oObject.resourceType?.code;

                                console.log(
                                    "Type Code:",
                                    sTypeCode
                                );

                                if (!sTypeCode) {

                                    console.log(
                                        "Type code missing"
                                    );

                                    return;
                                }

                                // Show sections based on type
                                aSections.forEach(function (oSection) {

                                    const sId =
                                        oSection.getId();

                                    switch (sTypeCode) {

                                        case "MT":

                                            if (
                                                sId.endsWith(
                                                    "Products"
                                                )
                                            ) {
                                                oSection.setVisible(
                                                    true
                                                );
                                            }

                                            break;

                                        case "GL":

                                            if (
                                                sId.endsWith(
                                                    "GLAccounts"
                                                )
                                            ) {
                                                oSection.setVisible(
                                                    true
                                                );
                                            }

                                            break;

                                        case "AT":

                                            if (
                                                sId.endsWith(
                                                    "Assets"
                                                )
                                            ) {
                                                oSection.setVisible(
                                                    true
                                                );
                                            }

                                            break;

                                        case "MP":

                                            if (
                                                sId.endsWith(
                                                    "WorkForce"
                                                )
                                            ) {
                                                oSection.setVisible(
                                                    true
                                                );
                                            }

                                            break;

                                        case "SC":

                                            if (
                                                sId.endsWith(
                                                    "SubContract"
                                                )
                                            ) {
                                                oSection.setVisible(
                                                    true
                                                );
                                            }

                                            break;
                                    }

                                });

                            })
                            .catch(function (oError) {

                                console.error(
                                    "Error while loading object",
                                    oError
                                );

                            });

                    }

                }

            }

        }

    );

});