sap.ui.define([
    "sap/m/MessageToast",
    "sap/ui/thirdparty/jquery"
], function (MessageToast, jQuery) {
    "use strict";

    return {

        DownloadTemplate: function () {

            jQuery.sap.includeScript(
                "https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js",
                "xlsxLib",
                function () {

                    if (typeof XLSX === "undefined") {
                        MessageToast.show("XLSX not loaded!");
                        return;
                    }

                    // ================= PROJECTS =================
                    const Projects = [{
                        "project": "",
                        "projectDescription": "",
                        "projectStartDate": "",
                        "projectEndDate": "",
                        "projectCurrency": "",
                        "projectManager": "",
                        "awardedDate": "",
                        "status": "",
                        "advance": "",
                        "retention": "",
                        "defectLiability": "",
                        "performanceSecurity": "",
                        "advancePaymentGuarantee": "",
                        "companyCode": ""
                    }];

                    // ================= PROJECT PLANNING =================
                    const ProjectPlanning = [{
                        "projectElementDescription": "",
                        "plannedStartDate": "",
                        "plannedEndDate": "",
                        "projectId": "",
                        "processingStatus": "",
                        "costCenter": "",
                        "profitCenter": "",
                        "parent_ID": "",
                        "plshierarchy_ID": ""
                    }];

                    // ================= WBS BOQ =================
                    const WbsBoq = [{
                        "item": "",
                        "description": "",
                        "unitOfMeasurement": "",
                        "quantity": "",
                        "bill": "",
                        "section": "",
                        "page": "",
                        "revision": "",
                        "retention": "",
                        "advance": "",
                        "parent_ID": "",
                        "projectPlanning_ID": ""
                    }];

                    // ================= BOQ RESOURCES =================
                    const BoqResources = [{
                        "productId": "",
                        "productName": "",
                        "descr": "",
                        "unitofMeasure": "",
                        "type": "",
                        "parent_ID": ""
                    }];

                    // ================= WORKBOOK =================
                    const wb = XLSX.utils.book_new();

                    function createSheet(data, widths) {
                        const ws = XLSX.utils.json_to_sheet(data);
                        ws["!cols"] = widths.map(w => ({ wch: w }));
                        return ws;
                    }

                    // ================= CREATE SHEETS =================
                    const ws1 = createSheet(Projects, [25, 40, 20, 20, 20, 25, 20, 15, 15, 15, 20, 20, 25, 15]);
                    const ws2 = createSheet(ProjectPlanning, [40, 20, 20, 25, 25, 20, 20, 36, 36]);
                    const ws3 = createSheet(WbsBoq, [15, 40, 20, 15, 10, 10, 10, 10, 15, 15, 36, 36]);
                    const ws4 = createSheet(BoqResources, [25, 40, 40, 20, 20, 36]);

                    // ================= APPEND =================
                    XLSX.utils.book_append_sheet(wb, ws1, "Projects");
                    XLSX.utils.book_append_sheet(wb, ws2, "ProjectPlanning");
                    XLSX.utils.book_append_sheet(wb, ws3, "WbsBoq");
                    XLSX.utils.book_append_sheet(wb, ws4, "BoqResources");

                    // ================= DOWNLOAD =================
                    XLSX.writeFile(wb, "Enterprise_Project_Template.xlsx");

                    MessageToast.show("Enterprise Template Downloaded");

                },
                function () {
                    MessageToast.show("Failed to load XLSX library");
                }
            );
        }
    };
});