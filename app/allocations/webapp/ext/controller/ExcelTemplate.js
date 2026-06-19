sap.ui.define([
    "sap/m/MessageToast",
    "sap/ui/thirdparty/jquery"
], function (MessageToast, jQuery) {
    "use strict";

    return {

        downloadTemplate: function () {
            jQuery.sap.includeScript(
                "https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js",
                "xlsxLib",
                function () {
                    if (typeof XLSX === "undefined") {
                        MessageToast.show("XLSX not loaded!");
                        return;
                    }

                    // ================= DATA =================

                    const Allocations = [
                        {
                            "Project": "",
                            "WBS": "",
                            "BOQ": "",
                            "Cost Code": "",
                            "FloorZone Reference": "",
                            "Notes": ""
                        }
                    ];

                    // ================= WORKBOOK =================

                    const wb = XLSX.utils.book_new();

                    function createSheet(data, widths) {
                        const ws = XLSX.utils.json_to_sheet(data);
                        ws["!cols"] = widths.map(w => ({ wch: w }));
                        return ws;
                    }

                    // ================= CREATE SHEET =================

                    const ws = createSheet(Allocations, [20, 20, 15, 20, 30, 40]);

                    // ================= APPEND =================

                    XLSX.utils.book_append_sheet(wb, ws, "Allocations");

                    // ================= DOWNLOAD =================

                    XLSX.writeFile(wb, "Allocations_Template.xlsx");

                    MessageToast.show("Excel Template Downloaded Successfully");

                },
                function () {
                    MessageToast.show("Failed to load XLSX library");
                }
            );
        }


    };
});