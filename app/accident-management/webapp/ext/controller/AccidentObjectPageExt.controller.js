sap.ui.define([
    "sap/ui/core/mvc/ControllerExtension",
    "ns/accidentmanagement/accidentmanagement/ext/controller/AccidentObjectPageExt"
], function (ControllerExtension, AccidentObjectPageExt) {
    "use strict";

    return ControllerExtension.extend(
        "ns.accidentmanagement.accidentmanagement.ext.controller.AccidentObjectPageExt",
        Object.assign({
            override: {
                onAfterRendering: function () {
                    // Reserved for future object page lifecycle hooks.
                }
            }
        }, AccidentObjectPageExt)
    );
});
