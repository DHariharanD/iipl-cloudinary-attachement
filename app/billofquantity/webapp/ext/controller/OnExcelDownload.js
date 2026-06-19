sap.ui.define([
    "sap/m/MessageToast",
    "sap/ui/thirdparty/jquery"
], function (MessageToast, jQuery) {
    "use strict";

    return {

        ExcelTemplate: function () {

            jQuery.sap.includeScript(
                "https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js",
                "xlsxLib",
                function () {

                    if (typeof XLSX === "undefined") {
                        MessageToast.show("XLSX not loaded!");
                        return;
                    }


                    const data = [{
                        "S.No": "",
                        "Job No": "",
                        "Bill": "",
                        "Section": "",
                        "Page": "",
                        "Revision": "",
                        "Item No": "",
                        "BoQ No": "",
                        "Narration": "",
                        "Description": "",
                        "Unit": "",
                        "Quantity": "",
                        "Unit Price": ""
                    }];

                    const wb = XLSX.utils.book_new();
                    const ws = XLSX.utils.json_to_sheet(data);

                    ws["!cols"] = [
                        { wch: 8 },
                        { wch: 20 },
                        { wch: 10 },
                        { wch: 15 },
                        { wch: 10 },
                        { wch: 10 },
                        { wch: 15 },
                        { wch: 15 },
                        { wch: 25 },
                        { wch: 40 },
                        { wch: 10 },
                        { wch: 15 },
                        { wch: 15 }
                    ];

                    XLSX.utils.book_append_sheet(wb, ws, "BoQ (PS not incl)");

                    XLSX.writeFile(wb, "BOQ_Upload_Template.xlsx");

                    MessageToast.show("Template Downloaded");

                },
                function () {
                    MessageToast.show("Failed to load XLSX library");
                }
            );
        }
    };
});