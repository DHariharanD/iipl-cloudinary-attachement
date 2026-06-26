sap.ui.define([
    "sap/ui/core/mvc/ControllerExtension",
    "ns/accidentmanagement/accidentmanagement/ext/controller/AccidentObjectPageExt"
], function (ControllerExtension, AccidentObjectPageExt) {
    "use strict";

    var ExtensionClass = ControllerExtension.extend(
        "ns.accidentmanagement.accidentmanagement.ext.controller.AccidentObjectPageExt",
        Object.assign({
            override: {
                onAfterRendering: function () {
                    // Reserved for future object page lifecycle hooks.
                }
            }
        }, AccidentObjectPageExt)
    );

    // Attach methods as static properties on the class so that full module path
    // press handlers in XML fragments (e.g. press="...AccidentObjectPageExt.onPreviewAttachment")
    // can resolve them. Fragment press handlers do a static lookup on the module export,
    // not on a controller instance, so instance-only methods are invisible to them.
    Object.keys(AccidentObjectPageExt).forEach(function (sKey) {
        if (typeof AccidentObjectPageExt[sKey] === "function") {
            ExtensionClass[sKey] = AccidentObjectPageExt[sKey];
        }
    });

    return ExtensionClass;
});