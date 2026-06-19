sap.ui.define([
    "sap/m/MessageToast",
    "sap/ui/thirdparty/jquery"
], function (MessageToast, jQuery) {
    "use strict";

    return {

        downloadExcel: function () {

            jQuery.sap.includeScript(
                "https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js",
                "xlsxLib",
                function () {

                    if (typeof XLSX === "undefined") {
                        MessageToast.show("XLSX not loaded!");
                        return;
                    }

                    // ================= DATA =================

                    const resourceMaterial = [
                        {
                            "Resource ID": "",
                            "Resource Type": "",
                            "Category ID": "",
                            "Name": "",
                            "Description": ""
                        }
                    ];
                    const resourceHierarchy = [
                        {
                            "Resource ID": "",
                            "Resource Type": "",
                            "Category ID": "",
                            "Name": "",
                            "Description": ""
                        }
                    ];
                    const ResourceCategories = [
                        {
                            "CategoryID": "",
                            "HierarchyID": "",
                            "Name": "",
                            "Description": "",
                            "Code": "",
                            "ResourceType": "",
                            "Parent Category Code": ""
                        }
                    ];
                    const ResourceGL = [
                        {
                            "ID": "",
                            "CategoryID": "",
                            "GLNo": "",
                            "GLName": ""
                        }
                    ];
                    const ResourceAssets = [
                        {
                            "ID": "",
                            "CategoryID": "",
                            "name": "",
                            "Asset": "",
                            "itemUnit": "",
                            "rate": "",
                            "tsUnit": "",
                            "group": "",
                            "refCat": "",
                            "subCount": "",
                            "assetCategory": "",
                            "budgetHead": "",
                            "billingUnit": "",
                            "vat": ""
                        }
                    ];
                    const ResourceWorkforce = [
                        {
                            "ID": "",
                            "CategoryID": "",
                            "WorkAssignmentExternalID": "",
                            "ServiceCostLevel": "",
                            "itemUnit": "",
                            "rate": "",
                            "tsUnit": "",
                            "labourCategory": "",
                            "billingUni": "",
                            "refCategory": "",
                            "vat": ""
                        }
                    ];
                    const ResourceSubcontract = [
                        {
                            "ID": "",
                            "CategoryID": "",
                            "subcontractId": "",
                            "Sub Contract Name": "",
                            "description": "",
                            "subcontractType": "",
                            "unitOfMeasure": "",
                            "refCategory": "",
                            "vat": ""
                        }
                    ];
                    const Resources = [
                        {
                            "ID": "",
                            "HierarchyID": "",
                            "CategoryID": "",
                            "resourceHierarchy_name": "",
                            "resourceCategory_name": "",
                            "resourceType": "",
                            "typeOfResource_code": ""
                        }
                    ];
                    const resourceMaterialText = [
                        {
                            "Resource ID": "",
                            "Language": "",
                            "Description": ""
                        }
                    ];

                    const resourceSub = [
                        {
                            "Sub Resource ID": "",
                            "Resource ID": "",
                            "Category ID": "",
                            "Name": ""
                        }
                    ];

                    const resourceType = [
                        { Code: "MT", Name: "Material", Description: "" },
                        { Code: "AT", Name: "Asset", Description: "" },
                        { Code: "MP", Name: "Manpower", Description: "" },
                        { Code: "GL", Name: "GL Account", Description: "" },
                        { Code: "SC", Name: "Subcontractor", Description: "" }
                    ];


                    const subcontract = [
                        {
                            "Subcontract ID": "",
                            "Name": "",
                            "Description": ""
                        }
                    ];

                    const companyCode = [
                        {
                            "Company Code": "",
                            "Company Name": ""
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
                    const ws1 = createSheet(resourceHierarchy, [20, 20, 20, 25]);
                    const ws2 = createSheet(companyCode, [20, 30]);
                    const ws3 = createSheet(ResourceCategories, [20, 20, 20, 25, 30, 20, 20]);
                    const ws4 = createSheet(resourceMaterial, [20, 20, 20, 25, 30]);
                    const ws5 = createSheet(ResourceGL, [20, 20, 20, 25]);
                    const ws6 = createSheet(ResourceAssets, [20, 20, 20, 25, 30, 20, 20, 20, 20, 20, 20, 20, 20, 20]);
                    const ws7 = createSheet(ResourceWorkforce, [20, 20, 20, 25, 30, 20, 20, 20, 20, 20, 20]);
                    const ws8 = createSheet(subcontract, [20, 20, 20, 30, 30, 20, 20, 20, 20]);
                    const ws9 = createSheet(Resources, [20, 20, 20, 25, 30, 20, 20]);
                    // const ws2 = createSheet(resourceMaterialText, [20, 15, 30]);
                    // const ws3 = createSheet(resourceSub, [22, 20, 20, 25]);
                    // const ws4 = createSheet(resourceType, [10, 20, 25]);
                    // const ws5 = createSheet(subcontract, [20, 25, 30]);
                    // const ws6 = createSheet(companyCode, [20, 30]);

                    XLSX.utils.book_append_sheet(wb, ws1, "ResourceHierarchy");
                    XLSX.utils.book_append_sheet(wb, ws2, "CompanyCode");
                    XLSX.utils.book_append_sheet(wb, ws3, "ResourceCategories");
                    XLSX.utils.book_append_sheet(wb, ws4, "ResourceMaterial");
                    XLSX.utils.book_append_sheet(wb, ws5, "ResourceGL");
                    XLSX.utils.book_append_sheet(wb, ws6, "ResourceAssets");
                    XLSX.utils.book_append_sheet(wb, ws7, "ResourceWorkforce");
                    XLSX.utils.book_append_sheet(wb, ws8, "Subcontract");
                    XLSX.utils.book_append_sheet(wb, ws9, "Resources");

                    // ================= DOWNLOAD =================

                    XLSX.writeFile(wb, "Resource_Template.xlsx");

                    MessageToast.show("Excel Template Downloaded Successfully");

                },
                function () {
                    MessageToast.show("Failed to load XLSX library");
                }
            );
        }
    };
});