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

                    const CBSHierarchy = [
                        {
                            "ID": "",
                            "Name": "",
                            "Description": ""
                        }
                    ];
                    const CBS = [
                        {
                            "ID": "",
                            "Name": "",
                            "Code": "",
                            "Description": "",
                            "ParentCode": "",
                            "HierarchyID": "",
                        }
                    ];
                    const CBSMaterial = [
                        {
                            "ID": "",
                            "cbsNode_ID": "",
                            "ProductID": "",
                            "ProductName": "",
                            "UnitOfMeasure": "",
                        }
                    ];
                   
                    // ================= WORKBOOK =================

                    const wb = XLSX.utils.book_new();

                    function createSheet(data, widths) {
                        const ws = XLSX.utils.json_to_sheet(data);
                        ws["!cols"] = widths.map(w => ({ wch: w }));
                        return ws;
                    }

                    // ================= CREATE SHEETS =================

                    const ws1 = createSheet(CBSHierarchy, [20, 25, 30]);
                    const ws2 = createSheet(CBS, [20, 20, 25, 30, 50, 50]);
                    const ws3 = createSheet(CBSMaterial, [22, 50, 50, 50,30,20]);
                  

                    // ================= APPEND =================

                    XLSX.utils.book_append_sheet(wb, ws1, "CBSHierarchy");
                    XLSX.utils.book_append_sheet(wb, ws2, "CBS");
                    XLSX.utils.book_append_sheet(wb, ws3, "CBSMaterial");

                    // ================= DOWNLOAD =================

                    XLSX.writeFile(wb, "CBS_Template.xlsx");

                    MessageToast.show("Excel Template Downloaded Successfully");

                },
                function () {
                    MessageToast.show("Failed to load XLSX library");
                }
            );
        }
    };
});