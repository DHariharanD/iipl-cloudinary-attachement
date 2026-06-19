/* checksum : 806746682c16e23ddeec26027cf6accc */
@cds.external : true
@CodeList.CurrencyCodes.Url : '../../../../default/iwbep/common/0001/$metadata'
@CodeList.CurrencyCodes.CollectionPath : 'Currencies'
@Common.ApplyMultiUnitBehaviorForSortingAndFiltering : true
@Capabilities.FilterFunctions : [
  'eq',
  'ne',
  'gt',
  'ge',
  'lt',
  'le',
  'and',
  'or',
  'contains',
  'startswith',
  'endswith',
  'any',
  'all'
]
@SAP__support.TechnicalInfoLinks.Url : '../../../../default/iwbep/common/0001/$metadata'
@SAP__support.TechnicalInfoLinks.FunctionImport : 'GetTechnicalInfoLinks'
@Capabilities.SupportedFormats : [ 'application/json', 'application/pdf' ]
@PDF.Features.DocumentDescriptionReference : '../../../../default/iwbep/common/0001/$metadata'
@PDF.Features.DocumentDescriptionCollection : 'MyDocumentDescriptions'
@PDF.Features.ArchiveFormat : true
@PDF.Features.Border : true
@PDF.Features.CoverPage : true
@PDF.Features.FitToPage : true
@PDF.Features.FontName : true
@PDF.Features.FontSize : true
@PDF.Features.HeaderFooter : true
@PDF.Features.IANATimezoneFormat : true
@PDF.Features.Margin : true
@PDF.Features.Padding : true
@PDF.Features.ResultSizeDefault : 20000
@PDF.Features.ResultSizeMaximum : 20000
@PDF.Features.Signature : true
@PDF.Features.TextDirectionLayout : true
@PDF.Features.Treeview : true
@PDF.Features.UploadToFileShare : true
@Capabilities.KeyAsSegmentSupported : true
@Capabilities.AsynchronousRequestsSupported : true
service S4FixedAsset {
  @cds.external : true
  type D_SK_CrteMstrFxdAstTxDeprP {
    @Common.IsDigitSequence : true
    @Common.Label : 'Capital Impr.Year'
    @Common.Heading : 'Capital Improvement Year'
    @Common.QuickInfo : 'Slovakia: Capital Improvement Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLOFAA_SK_CPTL_IMPRV_YEAR'
    SK_CapitalImprovementYear : String(4) not null;
  };

  @cds.external : true
  type D_ChangeFixedAssetGeneralP {
    @Common.Label : 'Description'
    @Common.Heading : 'Asset Description'
    @Common.QuickInfo : 'Asset Description'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TXA50_ANLT'
    FixedAssetDescription : String(50) not null;
    @Common.Label : 'Description (2)'
    @Common.Heading : 'Asset description (2)'
    @Common.QuickInfo : 'Additional asset description'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TXA50_MORE'
    AssetAdditionalDescription : String(50) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Serial Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AM_SERNR'
    AssetSerialNumber : String(18) not null;
    @Common.Label : 'Ordered On'
    @Common.Heading : 'PO Date'
    @Common.QuickInfo : 'Asset Purchase Order Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BSTDT'
    FixedAssetOrderDate : Date;
    @Common.IsUnit : true
    @Common.Label : 'Base Unit of Measure'
    @Common.Heading : 'BUn'
    BaseUnitSAPCode : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'ISO Code'
    @Common.Heading : 'ISO'
    @Common.QuickInfo : 'ISO Code for Unit of Measurement'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ISOCD_UNIT'
    BaseUnitISOCode : String(3) not null;
  };

  @cds.external : true
  type D_GlobChgFixedAssetValuationP {
    @Common.Label : 'Valid From'
    @Common.QuickInfo : 'Date for Beginning of Validity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ADATU'
    ValidityStartDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Action Indicator'
    @Common.Heading : 'Object Action Indicator'
    @Common.QuickInfo : 'Action indicator for create, change, and delete operations'
    FixedAssetObjectActionCode : String(2) not null;
    _JP_Imprmt : D_JP_ChgFxdAstImprmtPostingP not null;
    _SK_TaxDepreciation : D_SK_ChgFxdAstTaxDepreciationP not null;
  };

  @cds.external : true
  type D_CreateFixedAssetAcctAsgtP {
    @Common.IsUpperCase : true
    @Common.Label : 'Cost Center'
    @Common.Heading : 'Cost Ctr'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KOSTL'
    CostCenter : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'WBS Element'
    @Common.QuickInfo : 'Work Breakdown Structure Element (WBS Element) Edited'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PS_POSID_EDIT'
    WBSElementExternalID : String(24) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Profit Center'
    @Common.Heading : 'Profit Ctr'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PRCTR'
    ProfitCenter : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Segment'
    @Common.QuickInfo : 'Segment for Segmental Reporting'
    Segment : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Plant'
    @Common.Heading : 'Plnt'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WERKS_D'
    Plant : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Location'
    @Common.QuickInfo : 'Asset location'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=STORT'
    AssetLocation : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Room'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=RAUMNR'
    Room : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'License Plate Number'
    @Common.Heading : 'LicensePlateNo.'
    @Common.QuickInfo : 'License Plate No. of Vehicle'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AM_KFZKZ'
    VehicleLicensePlateNumber : String(15) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Tax Jurisdiction'
    @Common.Heading : 'Tax Jur.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TXJCD'
    TaxJurisdiction : String(15) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Business Place'
    @Common.Heading : 'BP'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BUPLA'
    BusinessPlace : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Fund'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BP_GEBER'
    Fund : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Grant'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GM_GRANT_NBR'
    GrantID : String(20) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Functional Area'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FKBER'
    FunctionalArea : String(16) not null;
  };

  @cds.external : true
  type D_CrteMstrFxdAstLedgerP {
    @Common.IsUpperCase : true
    @Common.Label : 'Ledger'
    @Common.Heading : 'Ld'
    @Common.QuickInfo : 'Ledger in General Ledger Accounting'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FINS_LEDGER'
    Ledger : String(2) not null;
    @Common.Label : 'Capitalized On'
    @Common.Heading : 'Cap.Date'
    @Common.QuickInfo : 'Asset Capitalization Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AKTIVD'
    AssetCapitalizationDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Truth Value'
    @Common.QuickInfo : 'Truth Value: True/False'
    IsDeleted : Boolean not null;
    _Valuation : many D_CrteMstrFxdAstValuationP not null;
  };

  @cds.external : true
  type D_ChangeFixedAssetLedgerP {
    @Common.IsUpperCase : true
    @Common.Label : 'Ledger'
    @Common.Heading : 'Ld'
    @Common.QuickInfo : 'Ledger in General Ledger Accounting'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FINS_LEDGER'
    Ledger : String(2) not null;
    @Common.Label : 'Capitalized On'
    @Common.Heading : 'Cap.Date'
    @Common.QuickInfo : 'Asset Capitalization Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AKTIVD'
    AssetCapitalizationDate : Date;
    @Common.Label : 'Deactivation on'
    @Common.Heading : 'Deact.Date'
    @Common.QuickInfo : 'Deactivation Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=DEAKT'
    AssetDeactivationDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Action Indicator'
    @Common.Heading : 'Object Action Indicator'
    @Common.QuickInfo : 'Action indicator for create, change, and delete operations'
    FixedAssetObjectActionCode : String(2) not null;
    _Valuation : many D_ChangeFixedAssetValuationP not null;
  };

  @cds.external : true
  type D_JP_CrteMstrFxdAssetAnnex16P {
    @Common.IsUpperCase : true
    @Common.Label : 'Asset Structure'
    @Common.QuickInfo : 'Japan: Asset Structure of Annex16'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_ANX16_STRC'
    JP_Annex16AssetStructure : String(5) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Asset Item'
    @Common.QuickInfo : 'Japan: Asset Item of Annex16'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_ANX16_ITEM'
    JP_Annex16AssetItem : String(5) not null;
    @Common.Label : 'Lease Agreement Date'
    @Common.Heading : 'Leas.Date'
    @Common.QuickInfo : 'Japan: Leasing Agreement Date of Annex16-4 Report'
    JP_Annex16LeasingAgrmtDate : Date;
  };

  @cds.external : true
  type D_IN_ChgFixedAssetBlockDataP {
    @Common.IsUpperCase : true
    @Common.Label : 'Block Key'
    @Common.QuickInfo : 'India: Block Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_BLK_KEY'
    IN_AssetBlock : String(5) not null;
    @Common.Label : 'Asset put to use'
    @Common.Heading : 'Asset put to use date'
    @Common.QuickInfo : 'India: Put to use date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_AST_PUT_USE'
    IN_AssetPutToUseDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Addnl Blk Key'
    @Common.Heading : 'Additional Depreciation Block Key'
    @Common.QuickInfo : 'India: Additional Depreciation Block Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_ADNL_BLK_KEY'
    IN_AdditionalAssetBlock : String(5) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'R & D Asset'
    @Common.QuickInfo : 'India: R & D Asset'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_R_AND_D_ASSET'
    IN_AssetIsResearchAndDev : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Prior year'
    @Common.Heading : 'Prior Year or Not for current year calculation'
    @Common.QuickInfo : 'India: Prior Year Transaction'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_PRIOR_YR'
    IN_AssetIsPriorYear : String(1) not null;
  };

  @cds.external : true
  type D_RS_CrteFxdAstTxDepreciationP {
    @Common.IsDigitSequence : true
    @Common.Label : 'Exclusion Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_RS_EXCLUSION_YEAR'
    RS_GroupDeprExclusionYear : String(4) not null;
    @Common.Label : 'Last Invoice Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_RS_LAST_INVOICE_DATE'
    RS_AssetLastInvoiceDate : Date;
  };

  @cds.external : true
  type D_SK_ChgFxdAstTaxDepreciationP {
    @Common.IsDigitSequence : true
    @Common.Label : 'Capital Impr.Year'
    @Common.Heading : 'Capital Improvement Year'
    @Common.QuickInfo : 'Slovakia: Capital Improvement Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLOFAA_SK_CPTL_IMPRV_YEAR'
    SK_CapitalImprovementYear : String(4) not null;
  };

  @cds.external : true
  type D_CreateFixedAssetInventoryP {
    @Common.IsUpperCase : true
    @Common.Label : 'Inventory Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INVNR_ANLA'
    Inventory : String(25) not null;
    @Common.Label : 'Last Inventory On'
    @Common.Heading : 'Inv.Date'
    @Common.QuickInfo : 'Last Inventory Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=IVDAT_ANLA'
    LastInventoryDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Inventory Note'
    @Common.QuickInfo : 'Supplementary Inventory Specifications'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INVZU_ANLA'
    InventoryNote : String(15) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Include Asset'
    @Common.Heading : 'II'
    @Common.QuickInfo : 'Inventory Indicator'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INKEN'
    InventoryIsCounted : Boolean not null;
  };

  @cds.external : true
  type D_CrteMstrFxdAstAcctAsgtP {
    @Common.IsUpperCase : true
    @Common.Label : 'Cost Center'
    @Common.Heading : 'Cost Ctr'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KOSTL'
    CostCenter : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'WBS Element'
    @Common.QuickInfo : 'Work Breakdown Structure Element (WBS Element) Edited'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PS_POSID_EDIT'
    WBSElementExternalID : String(24) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Profit Center'
    @Common.Heading : 'Profit Ctr'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PRCTR'
    ProfitCenter : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Segment'
    @Common.QuickInfo : 'Segment for Segmental Reporting'
    Segment : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Plant'
    @Common.Heading : 'Plnt'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WERKS_D'
    Plant : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Location'
    @Common.QuickInfo : 'Asset location'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=STORT'
    AssetLocation : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Room'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=RAUMNR'
    Room : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'License Plate Number'
    @Common.Heading : 'LicensePlateNo.'
    @Common.QuickInfo : 'License Plate No. of Vehicle'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AM_KFZKZ'
    VehicleLicensePlateNumber : String(15) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Tax Jurisdiction'
    @Common.Heading : 'Tax Jur.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TXJCD'
    TaxJurisdiction : String(15) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Business Place'
    @Common.Heading : 'BP'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BUPLA'
    BusinessPlace : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Fund'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BP_GEBER'
    Fund : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Grant'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GM_GRANT_NBR'
    GrantID : String(20) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Functional Area'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FKBER'
    FunctionalArea : String(16) not null;
  };

  @cds.external : true
  type D_JP_CrteMstrFxdAstPrprtyTaxP {
    @Common.IsUpperCase : true
    @Common.Label : 'Japan City Code'
    @Common.Heading : 'City Code'
    @Common.QuickInfo : 'Japan: City Code of Property Tax Report'
    JP_PrptyTxRptCity : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Japan Class. Key'
    @Common.Heading : 'Classification Key'
    @Common.QuickInfo : 'Japan: Classification Key of Property Tax Report'
    JP_PrptyTxRptClassfctnKey : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Spec.Depr. Code'
    @Common.Heading : 'Special Depreciation Code'
    @Common.QuickInfo : 'Japan: Special Depreciation Code of Property Tax Report'
    JP_PrptyTxRptSpclDepr : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Additional Dep. Code'
    @Common.Heading : 'Additional Depreciation Code'
    @Common.QuickInfo : 'Japan: Additional Depreciation Code of Property Tax Report'
    JP_PrptyTxRptAddlDepr : String(8) not null;
  };

  @cds.external : true
  type D_JP_CrteMstrAstImprmtPostgP {
    @Common.Label : 'Impairment Post Date'
    @Common.Heading : 'Impairment posting Date'
    @Common.QuickInfo : 'Japan: Impairment Posting Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_JP_DI'
    JP_ImpairmentPostingDate : Date;
    @Measures.ISOCurrency : CompanyCodeCurrency
    @Common.Label : 'APC in Co. Code Crcy'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Company Code Crcy'
    JP_ImpAcqnProdCostAmtInCCCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : GlobalCurrency
    @Common.Label : 'APC in Global Crcy'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Global Currency'
    JP_ImpAcqnProdCostAmtInGCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency1
    @Common.Label : 'APC in Currency 1'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy1'
    JP_ImpAcqnProdCostAmtInFDCrcy1 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency2
    @Common.Label : 'APC in Currency 2'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy2'
    JP_ImpAcqnProdCostAmtInFDCrcy2 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency3
    @Common.Label : 'APC in Currency 3'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy3'
    JP_ImpAcqnProdCostAmtInFDCrcy3 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency4
    @Common.Label : 'APC in Currency 4'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy4'
    JP_ImpAcqnProdCostAmtInFDCrcy4 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency5
    @Common.Label : 'APC in Currency 5'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy5'
    JP_ImpAcqnProdCostAmtInFDCrcy5 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency6
    @Common.Label : 'APC in Currency 6'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy6'
    JP_ImpAcqnProdCostAmtInFDCrcy6 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency7
    @Common.Label : 'APC in Currency 7'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy7'
    JP_ImpAcqnProdCostAmtInFDCrcy7 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency8
    @Common.Label : 'APC in Currency 8'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy8'
    JP_ImpAcqnProdCostAmtInFDCrcy8 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : CompanyCodeCurrency
    @Common.Label : 'BAI in Co. Code Crcy'
    @Common.QuickInfo : 'Japan: Book Value After Impairment Posting in Co. Code Crcy'
    JP_AftImprmtBookAmtInCCCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : GlobalCurrency
    @Common.Label : 'BAI in Global Crcy'
    @Common.QuickInfo : 'Japan: Book Value After Impairment Posting in Global Crcy'
    JP_AftImprmtBookAmtInGlobCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency1
    @Common.Label : 'BAI in Currency 1'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy1'
    JP_AftImprmtBookAmtInFDCrcy1 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency2
    @Common.Label : 'BAI in Currency 2'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy2'
    JP_AftImprmtBookAmtInFDCrcy2 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency3
    @Common.Label : 'BAI in Currency 3'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy3'
    JP_AftImprmtBookAmtInFDCrcy3 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency4
    @Common.Label : 'BAI in Currency 4'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy4'
    JP_AftImprmtBookAmtInFDCrcy4 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency5
    @Common.Label : 'BAI in Currency 5'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy5'
    JP_AftImprmtBookAmtInFDCrcy5 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency6
    @Common.Label : 'BAI in Currency 6'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy6'
    JP_AftImprmtBookAmtInFDCrcy6 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency7
    @Common.Label : 'BAI in Currency 7'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy7'
    JP_AftImprmtBookAmtInFDCrcy7 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency8
    @Common.Label : 'BAI in Currency 8'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy8'
    JP_AftImprmtBookAmtInFDCrcy8 : Decimal(precision: 23) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'CompanyCode Currency'
    @Common.Heading : 'CCCrcy'
    @Common.QuickInfo : 'Company Code Currency'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FINS_CURRH'
    CompanyCodeCurrency : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Global Currency'
    GlobalCurrency : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 1'
    @Common.Heading : 'Freely Defined Currency 1'
    @Common.QuickInfo : 'Freely Defined Currency 1'
    FreeDefinedCurrency1 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 2'
    @Common.Heading : 'Freely Defined Currency 2'
    @Common.QuickInfo : 'Freely Defined Currency 2'
    FreeDefinedCurrency2 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 3'
    @Common.Heading : 'Freely Defined Currency 3'
    @Common.QuickInfo : 'Freely Defined Currency 3'
    FreeDefinedCurrency3 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 4'
    @Common.Heading : 'Freely Defined Currency 4'
    @Common.QuickInfo : 'Freely Defined Currency 4'
    FreeDefinedCurrency4 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 5'
    @Common.Heading : 'Freely Defined Currency 5'
    @Common.QuickInfo : 'Freely Defined Currency 5'
    FreeDefinedCurrency5 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 6'
    @Common.Heading : 'Freely Defined Currency 6'
    @Common.QuickInfo : 'Freely Defined Currency 6'
    FreeDefinedCurrency6 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 7'
    @Common.Heading : 'Freely Defined Currency 7'
    @Common.QuickInfo : 'Freely Defined Currency 7'
    FreeDefinedCurrency7 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 8'
    @Common.Heading : 'Freely Defined Currency 8'
    @Common.QuickInfo : 'Freely Defined Currency 8'
    FreeDefinedCurrency8 : String(3) not null;
  };

  @cds.external : true
  type D_PT_ChangeFixedAssetDataP {
    @Common.IsUpperCase : true
    @Common.Label : 'Vehicle Type'
    @Common.QuickInfo : 'Portugal: Vehicle Type'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_VEHICLETYPE'
    PT_VehicleTypeByEnergy : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Veh. W/o. Limit'
    @Common.Heading : 'Is vehicle Without Limit'
    @Common.QuickInfo : 'Portugal: Is Vehicle Without Limit'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_ISVEHICLEWOLIMIT'
    PT_VehicleIsWithoutLimit : Boolean not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Repair Link'
    @Common.Heading : 'Repair Asset Link'
    @Common.QuickInfo : 'Portugal: Repair Asset Link'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_REPAIRASSETLINK'
    PT_BigRepairAssetLink : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Land Asset Link'
    @Common.QuickInfo : 'Portugal: Land Asset Link'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_LANDASSETLINK'
    PT_LandAssetLink : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Form Categ.'
    @Common.Heading : 'Report Form Category'
    @Common.QuickInfo : 'Portugal: Asset Report Form Category'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_ASSETREPFORMCAT'
    PT_AssetReportFormCategory : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Amort. Reval.'
    @Common.Heading : 'Is Amort. Asset Revaluated'
    @Common.QuickInfo : 'Portugal: Is Amortized Asset Revaluated'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_ISAMASSETREVAL'
    PT_AmortizedAssetIsReevaluated : Boolean not null;
  };

  @cds.external : true
  type D_CreateFixedAssetValuationP {
    @Common.IsDigitSequence : true
    @Common.Label : 'Depreciation Area'
    @Common.Heading : 'Ar.'
    @Common.QuickInfo : 'Depreciation Area Real or Derived'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AFABER'
    AssetDepreciationArea : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Truth Value'
    @Common.QuickInfo : 'Truth Value: True/False'
    IsDeleted : Boolean not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Negative Val.Allowed'
    @Common.Heading : 'Neg'
    @Common.QuickInfo : 'Indicator: Negative Values Allowed'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=XNEGA'
    NegativeAmountIsAllowed : Boolean not null;
    @Common.Label : 'Dep. Start Date'
    @Common.Heading : 'Depreciation Calculation Start Date'
    @Common.QuickInfo : 'Depreciation Calculation Start Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AFABG'
    DepreciationStartDate : Date;
    @Common.Label : 'Special Depreciation'
    @Common.Heading : 'SDep.Start'
    @Common.QuickInfo : 'Start Date for Special Depreciation'
    SpecialDeprStartDate : Date;
    @Common.Label : 'Operating Readiness'
    @Common.QuickInfo : 'Asset Accounting:  Date of Operating Readiness'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INBDA'
    AssetOpgReadinessDate : Date;
    @Common.IsDigitSequence : true
    @Common.Label : 'Fiscal Year'
    DeprKeyChangeoverYear : String(4) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Changeover Period'
    @Common.Heading : 'ChPrd'
    @Common.QuickInfo : 'Changeover Period of Depreciation Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=UMPER'
    DeprKeyChangeoverPeriod : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Expired Useful Life'
    @Common.Heading : 'EUL'
    @Common.QuickInfo : 'Expired Useful Life in Years at Start of the Fiscal Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NDABJ'
    ExpiredUsefulLifeInYrs : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Expired UL Periods'
    @Common.Heading : 'ELP'
    @Common.QuickInfo : 'Expired Useful Life in Periods at Start of Fiscal Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NDABP'
    ExpiredUsefulLifeInPerds : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Exp.spec.dep. life'
    @Common.Heading : 'DSL'
    @Common.QuickInfo : 'Yrs Expired up to Fisc.Yr Start from Start of Spec.Dep.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANDSJ'
    SpclExpiredUsefulLifeInYrs : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Exp.UL Periods SDep.'
    @Common.Heading : 'DLP'
    @Common.QuickInfo : 'Expired Useful Life in Periods during FY from SDep Start Dat'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANDSP'
    SpclExpiredUsefulLifeInPerds : String(3) not null;
    _GlobTimeBasedValuation : many D_GlobCrteFixedAssetValuationP not null;
    _TimeBasedValuation : many D_CreateFixedAssetTmeBsdValnP not null;
  };

  @cds.external : true
  type D_CrteMstrFxdAstValuationP {
    @Common.IsDigitSequence : true
    @Common.Label : 'Depreciation Area'
    @Common.Heading : 'Ar.'
    @Common.QuickInfo : 'Depreciation Area Real or Derived'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AFABER'
    AssetDepreciationArea : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Truth Value'
    @Common.QuickInfo : 'Truth Value: True/False'
    IsDeleted : Boolean not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Negative Val.Allowed'
    @Common.Heading : 'Neg'
    @Common.QuickInfo : 'Indicator: Negative Values Allowed'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=XNEGA'
    NegativeAmountIsAllowed : Boolean not null;
    @Common.Label : 'Dep. Start Date'
    @Common.Heading : 'Depreciation Calculation Start Date'
    @Common.QuickInfo : 'Depreciation Calculation Start Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AFABG'
    DepreciationStartDate : Date;
    @Common.Label : 'Special Depreciation'
    @Common.Heading : 'SDep.Start'
    @Common.QuickInfo : 'Start Date for Special Depreciation'
    SpecialDeprStartDate : Date;
    @Common.Label : 'Operating Readiness'
    @Common.QuickInfo : 'Asset Accounting:  Date of Operating Readiness'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INBDA'
    AssetOpgReadinessDate : Date;
    @Common.IsDigitSequence : true
    @Common.Label : 'Fiscal Year'
    DeprKeyChangeoverYear : String(4) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Changeover Period'
    @Common.Heading : 'ChPrd'
    @Common.QuickInfo : 'Changeover Period of Depreciation Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=UMPER'
    DeprKeyChangeoverPeriod : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Expired Useful Life'
    @Common.Heading : 'EUL'
    @Common.QuickInfo : 'Expired Useful Life in Years at Start of the Fiscal Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NDABJ'
    ExpiredUsefulLifeInYrs : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Expired UL Periods'
    @Common.Heading : 'ELP'
    @Common.QuickInfo : 'Expired Useful Life in Periods at Start of Fiscal Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NDABP'
    ExpiredUsefulLifeInPerds : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Exp.spec.dep. life'
    @Common.Heading : 'DSL'
    @Common.QuickInfo : 'Yrs Expired up to Fisc.Yr Start from Start of Spec.Dep.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANDSJ'
    SpclExpiredUsefulLifeInYrs : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Exp.UL Periods SDep.'
    @Common.Heading : 'DLP'
    @Common.QuickInfo : 'Expired Useful Life in Periods during FY from SDep Start Dat'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANDSP'
    SpclExpiredUsefulLifeInPerds : String(3) not null;
    _GlobTimeBasedValuation : many D_GlobCrteMstrFxdAstValuationP not null;
    _TimeBasedValuation : many D_CrteMstrFxdAstTmeBsdValnP not null;
  };

  @cds.external : true
  type D_PT_CreateFixedAssetDataP {
    @Common.IsUpperCase : true
    @Common.Label : 'Vehicle Type'
    @Common.QuickInfo : 'Portugal: Vehicle Type'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_VEHICLETYPE'
    PT_VehicleTypeByEnergy : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Veh. W/o. Limit'
    @Common.Heading : 'Is vehicle Without Limit'
    @Common.QuickInfo : 'Portugal: Is Vehicle Without Limit'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_ISVEHICLEWOLIMIT'
    PT_VehicleIsWithoutLimit : Boolean not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Repair Link'
    @Common.Heading : 'Repair Asset Link'
    @Common.QuickInfo : 'Portugal: Repair Asset Link'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_REPAIRASSETLINK'
    PT_BigRepairAssetLink : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Land Asset Link'
    @Common.QuickInfo : 'Portugal: Land Asset Link'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_LANDASSETLINK'
    PT_LandAssetLink : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Form Categ.'
    @Common.Heading : 'Report Form Category'
    @Common.QuickInfo : 'Portugal: Asset Report Form Category'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_ASSETREPFORMCAT'
    PT_AssetReportFormCategory : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Amort. Reval.'
    @Common.Heading : 'Is Amort. Asset Revaluated'
    @Common.QuickInfo : 'Portugal: Is Amortized Asset Revaluated'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_ISAMASSETREVAL'
    PT_AmortizedAssetIsReevaluated : Boolean not null;
  };

  @cds.external : true
  type D_CreateFixedAssetOriginP {
    @Common.IsUpperCase : true
    @Common.Label : 'Supplier'
    @Common.QuickInfo : 'Account Number of Supplier (Other Key Word)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AM_LIFNR'
    Supplier : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Ctry/Reg. of Origin'
    @Common.QuickInfo : 'Asset''s Country/Region of Origin'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AM_LAND1'
    AssetCountryOfOrigin : String(3) not null;
    @Common.Label : 'Manufacturer'
    @Common.Heading : 'Manufacturer of Asset'
    @Common.QuickInfo : 'Manufacturer of Asset'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=HERST'
    AssetManufacturerName : String(30) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Fiscal Year'
    OriginalAcquisitionFiscalYear : String(4) not null;
    @Measures.ISOCurrency : OriginalAcquisitionCurrency
    @Common.Label : 'Original Value'
    @Common.QuickInfo : 'Original Acquisition Value'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=URWRT'
    OriginalAcquisitionAmount : Decimal(precision: 23) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Orig Acq Crcy'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Original Acquisition Value Currency'
    OriginalAcquisitionCurrency : String(3) not null;
    @Common.Label : 'In-House Prod. Perc.'
    @Common.Heading : 'In-H.Pro'
    @Common.QuickInfo : 'In-House Production Percentage'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANTEI'
    InHouseProdnPercent : Decimal(5, 2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Type name'
    @Common.QuickInfo : 'Asset type name'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TYPBZ_ANLA'
    AssetTypeName : String(15) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Trading Partner No.'
    @Common.Heading : 'Tr.Prt'
    @Common.QuickInfo : 'Company ID of Trading Partner'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=RASSC'
    PartnerCompany : String(6) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Purchased Used'
    @Common.QuickInfo : 'Asset Acquired Used'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=XAFABCH'
    AssetIsAcquiredUsed : Boolean not null;
  };

  @cds.external : true
  type D_PL_CrteMstrFxdAstTmIdpSAFTP {
    @Common.Label : 'Acqn./Prodn. Date'
    @Common.Heading : 'Date of Acquisition/Production'
    @Common.QuickInfo : 'Fixed Asset Acquisition/Production Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_ACQN_PRODN_DATE'
    PL_AcquisitionProductionDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Acquisition Doc Type'
    @Common.Heading : 'Acquisition Document Type'
    @Common.QuickInfo : 'Acquisition Document Type'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_ACQN_DOC_TYPE'
    PL_AcquisitionDocumentType : String(1) not null;
    @Common.Label : 'OT Document Number'
    @Common.QuickInfo : 'Asset Acquisition Form/OT Document Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_ACQN_FORM_NMBR'
    PL_AcquisitionFormNumber : String(25) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'SAFT Asset Tax Group'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_AST_TAX_GROUP'
    PL_AssetTaxGroup : String(2) not null;
  };

  @cds.external : true
  type D_JP_CrteFxdAstImprmtPostingP {
    @Common.Label : 'Impairment Post Date'
    @Common.Heading : 'Impairment posting Date'
    @Common.QuickInfo : 'Japan: Impairment Posting Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_JP_DI'
    JP_ImpairmentPostingDate : Date;
    @Measures.ISOCurrency : CompanyCodeCurrency
    @Common.Label : 'APC in Co. Code Crcy'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Company Code Crcy'
    JP_ImpAcqnProdCostAmtInCCCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : GlobalCurrency
    @Common.Label : 'APC in Global Crcy'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Global Currency'
    JP_ImpAcqnProdCostAmtInGCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency1
    @Common.Label : 'APC in Currency 1'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy1'
    JP_ImpAcqnProdCostAmtInFDCrcy1 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency2
    @Common.Label : 'APC in Currency 2'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy2'
    JP_ImpAcqnProdCostAmtInFDCrcy2 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency3
    @Common.Label : 'APC in Currency 3'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy3'
    JP_ImpAcqnProdCostAmtInFDCrcy3 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency4
    @Common.Label : 'APC in Currency 4'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy4'
    JP_ImpAcqnProdCostAmtInFDCrcy4 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency5
    @Common.Label : 'APC in Currency 5'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy5'
    JP_ImpAcqnProdCostAmtInFDCrcy5 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency6
    @Common.Label : 'APC in Currency 6'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy6'
    JP_ImpAcqnProdCostAmtInFDCrcy6 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency7
    @Common.Label : 'APC in Currency 7'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy7'
    JP_ImpAcqnProdCostAmtInFDCrcy7 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency8
    @Common.Label : 'APC in Currency 8'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy8'
    JP_ImpAcqnProdCostAmtInFDCrcy8 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : CompanyCodeCurrency
    @Common.Label : 'BAI in Co. Code Crcy'
    @Common.QuickInfo : 'Japan: Book Value After Impairment Posting in Co. Code Crcy'
    JP_AftImprmtBookAmtInCCCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : GlobalCurrency
    @Common.Label : 'BAI in Global Crcy'
    @Common.QuickInfo : 'Japan: Book Value After Impairment Posting in Global Crcy'
    JP_AftImprmtBookAmtInGlobCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency1
    @Common.Label : 'BAI in Currency 1'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy1'
    JP_AftImprmtBookAmtInFDCrcy1 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency2
    @Common.Label : 'BAI in Currency 2'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy2'
    JP_AftImprmtBookAmtInFDCrcy2 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency3
    @Common.Label : 'BAI in Currency 3'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy3'
    JP_AftImprmtBookAmtInFDCrcy3 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency4
    @Common.Label : 'BAI in Currency 4'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy4'
    JP_AftImprmtBookAmtInFDCrcy4 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency5
    @Common.Label : 'BAI in Currency 5'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy5'
    JP_AftImprmtBookAmtInFDCrcy5 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency6
    @Common.Label : 'BAI in Currency 6'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy6'
    JP_AftImprmtBookAmtInFDCrcy6 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency7
    @Common.Label : 'BAI in Currency 7'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy7'
    JP_AftImprmtBookAmtInFDCrcy7 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency8
    @Common.Label : 'BAI in Currency 8'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy8'
    JP_AftImprmtBookAmtInFDCrcy8 : Decimal(precision: 23) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'CompanyCode Currency'
    @Common.Heading : 'CCCrcy'
    @Common.QuickInfo : 'Company Code Currency'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FINS_CURRH'
    CompanyCodeCurrency : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Global Currency'
    GlobalCurrency : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 1'
    @Common.Heading : 'Freely Defined Currency 1'
    @Common.QuickInfo : 'Freely Defined Currency 1'
    FreeDefinedCurrency1 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 2'
    @Common.Heading : 'Freely Defined Currency 2'
    @Common.QuickInfo : 'Freely Defined Currency 2'
    FreeDefinedCurrency2 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 3'
    @Common.Heading : 'Freely Defined Currency 3'
    @Common.QuickInfo : 'Freely Defined Currency 3'
    FreeDefinedCurrency3 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 4'
    @Common.Heading : 'Freely Defined Currency 4'
    @Common.QuickInfo : 'Freely Defined Currency 4'
    FreeDefinedCurrency4 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 5'
    @Common.Heading : 'Freely Defined Currency 5'
    @Common.QuickInfo : 'Freely Defined Currency 5'
    FreeDefinedCurrency5 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 6'
    @Common.Heading : 'Freely Defined Currency 6'
    @Common.QuickInfo : 'Freely Defined Currency 6'
    FreeDefinedCurrency6 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 7'
    @Common.Heading : 'Freely Defined Currency 7'
    @Common.QuickInfo : 'Freely Defined Currency 7'
    FreeDefinedCurrency7 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 8'
    @Common.Heading : 'Freely Defined Currency 8'
    @Common.QuickInfo : 'Freely Defined Currency 8'
    FreeDefinedCurrency8 : String(3) not null;
  };

  @cds.external : true
  type D_GlobCrteFixedAssetValuationP {
    @Common.Label : 'Valid From'
    @Common.QuickInfo : 'Date for Beginning of Validity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ADATU'
    ValidityStartDate : Date;
    _JP_Imprmt : D_JP_CrteFxdAstImprmtPostingP not null;
    _SK_TaxDepreciation : D_SK_CrteFxdAstTxDepreciationP not null;
  };

  @cds.external : true
  type D_GlobCrteFxdAstTmeIndepP {
    _EUNationalClassification : D_CrteFxdAstEUNatlClsfctnP not null;
    _IN_AssetBlockData : D_IN_CrteFixedAssetBlockDataP not null;
    _JP_Annex16 : D_JP_CreateFixedAssetAnnex16P not null;
    _JP_PropertyTax : D_JP_CrteFxdAssetPropertyTaxP not null;
    _PL_TmIdpSAFT : D_PL_CrteFxdAstTmeIndepSAFTP not null;
    _PT_AssetData : D_PT_CreateFixedAssetDataP not null;
    _RS_TaxDepr : D_RS_CrteFxdAstTxDepreciationP not null;
  };

  @cds.external : true
  type D_CrteMstrFxdAstTmeBsdValnP {
    @Common.Label : 'Valid From'
    @Common.QuickInfo : 'Date for Beginning of Validity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ADATU'
    ValidityStartDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Depreciation Key'
    @Common.Heading : 'DepKy'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AFASL'
    DepreciationKey : String(4) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Useful Life'
    @Common.Heading : 'Use'
    @Common.QuickInfo : 'Planned Useful Life in Years'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NDJAR'
    PlannedUsefulLifeInYears : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Usef.Life in Periods'
    @Common.Heading : 'Per'
    @Common.QuickInfo : 'Planned Useful Life in Periods'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NDPER'
    PlannedUsefulLifeInPeriods : String(3) not null;
    @Common.Label : 'Variable Dep.Portion'
    @Common.Heading : 'Var.Prtn'
    @Common.QuickInfo : 'Variable Depreciation Portion'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=APROP'
    VariableDeprPercent : Decimal(7, 4) not null;
    @Common.Label : 'Scrap Value Percent'
    @Common.Heading : 'Scrap Val. [%]'
    @Common.QuickInfo : 'Scrap Value as Percentage of APC'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SCHRW_PROZ'
    AcqnProdnCostScrapPercent : Decimal(14, 11) not null;
    @Common.Label : 'Percentage'
    @Common.Heading : 'Base Value Percentage'
    @Common.QuickInfo : 'Base Value Percentage'
    DeprCalcBaseValuePercent : Decimal(16, 13) not null;
    @Common.Label : 'Shift Factor'
    @Common.Heading : 'MSFac'
    @Common.QuickInfo : 'Multiple-Shift Factor for Multiple Shift Operation'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MSFAK'
    ShiftOperationFactor : Decimal(3, 2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Asset Shutdown'
    @Common.Heading : 'Sdown'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=XSTIL'
    IsShutDown : Boolean not null;
    @Measures.ISOCurrency : CompanyCodeCurrency
    @Common.Label : 'Value in CompCd Crcy'
    @Common.Heading : 'Scrap Val in CC Crcy'
    @Common.QuickInfo : 'Scrap Value in Company Code Currency'
    ScrapAmountInCoCodeCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : GlobalCurrency
    @Common.Label : 'Value in Gl. Crcy'
    @Common.Heading : 'Scrap Value in Gl. Crcy'
    @Common.QuickInfo : 'Scrap Value in Global Currency'
    ScrapAmountInGlobCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency1
    @Common.Label : 'Value in Currency 1'
    @Common.Heading : 'Scrap Value in Crcy 1'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 1'
    ScrapAmountInFreeDefinedCrcy1 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency2
    @Common.Label : 'Value in Currency 2'
    @Common.Heading : 'Scrap Value in Crcy 2'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 2'
    ScrapAmountInFreeDefinedCrcy2 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency3
    @Common.Label : 'Value in Currency 3'
    @Common.Heading : 'Scrap Value in Crcy 3'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 3'
    ScrapAmountInFreeDefinedCrcy3 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency4
    @Common.Label : 'Value in Currency 4'
    @Common.Heading : 'Scrap Value in Crcy 4'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 4'
    ScrapAmountInFreeDefinedCrcy4 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency5
    @Common.Label : 'Value in Currency 5'
    @Common.Heading : 'Scrap Value in Crcy 5'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 5'
    ScrapAmountInFreeDefinedCrcy5 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency6
    @Common.Label : 'Value in Currency 6'
    @Common.Heading : 'Scrap Value in Crcy 6'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 6'
    ScrapAmountInFreeDefinedCrcy6 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency7
    @Common.Label : 'Value in Currency 7'
    @Common.Heading : 'Scrap Value in Crcy 7'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 7'
    ScrapAmountInFreeDefinedCrcy7 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency8
    @Common.Label : 'Value in Currency 8'
    @Common.Heading : 'Scrap Value in Crcy 8'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 8'
    ScrapAmountInFreeDefinedCrcy8 : Decimal(precision: 23) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'CompanyCode Currency'
    @Common.Heading : 'CCCrcy'
    @Common.QuickInfo : 'Company Code Currency'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FINS_CURRH'
    CompanyCodeCurrency : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Global Currency'
    GlobalCurrency : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 1'
    @Common.Heading : 'Freely Defined Currency 1'
    @Common.QuickInfo : 'Freely Defined Currency 1'
    FreeDefinedCurrency1 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 2'
    @Common.Heading : 'Freely Defined Currency 2'
    @Common.QuickInfo : 'Freely Defined Currency 2'
    FreeDefinedCurrency2 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 3'
    @Common.Heading : 'Freely Defined Currency 3'
    @Common.QuickInfo : 'Freely Defined Currency 3'
    FreeDefinedCurrency3 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 4'
    @Common.Heading : 'Freely Defined Currency 4'
    @Common.QuickInfo : 'Freely Defined Currency 4'
    FreeDefinedCurrency4 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 5'
    @Common.Heading : 'Freely Defined Currency 5'
    @Common.QuickInfo : 'Freely Defined Currency 5'
    FreeDefinedCurrency5 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 6'
    @Common.Heading : 'Freely Defined Currency 6'
    @Common.QuickInfo : 'Freely Defined Currency 6'
    FreeDefinedCurrency6 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 7'
    @Common.Heading : 'Freely Defined Currency 7'
    @Common.QuickInfo : 'Freely Defined Currency 7'
    FreeDefinedCurrency7 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 8'
    @Common.Heading : 'Freely Defined Currency 8'
    @Common.QuickInfo : 'Freely Defined Currency 8'
    FreeDefinedCurrency8 : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Usage Object'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FAA_UO'
    FixedAssetUsageObject : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Revaluation Index ID'
    @Common.Heading : 'Asset Revaluation: Index ID'
    @Common.QuickInfo : 'Asset Revaluation: Index ID'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FAA_RV_INDEX_ID'
    AssetRevaluationIndex : String(10) not null;
  };

  @cds.external : true
  type D_PL_ChgFxdAstTmeDepdntSAFTP {
    @Common.IsUpperCase : true
    @Common.Label : 'Customer Acc.Invoice'
    @Common.Heading : 'Customer Invoice Accounting Document'
    @Common.QuickInfo : 'Customer Invoice Accounting Document'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_CUST_INVC_ACCTG_DOC'
    PL_CustInvcAccountingDocument : String(10) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Fiscal Year'
    @Common.Heading : 'Customer Invoice Fiscal Year'
    @Common.QuickInfo : 'Customer Invoice Fiscal Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_CUST_INVC_FSCL_YR'
    PL_CustomerInvoiceFiscalYear : String(4) not null;
  };

  @cds.external : true
  type D_ChangeFixedAssetInventoryP {
    @Common.IsUpperCase : true
    @Common.Label : 'Inventory Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INVNR_ANLA'
    Inventory : String(25) not null;
    @Common.Label : 'Last Inventory On'
    @Common.Heading : 'Inv.Date'
    @Common.QuickInfo : 'Last Inventory Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=IVDAT_ANLA'
    LastInventoryDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Inventory Note'
    @Common.QuickInfo : 'Supplementary Inventory Specifications'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INVZU_ANLA'
    InventoryNote : String(15) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Include Asset'
    @Common.Heading : 'II'
    @Common.QuickInfo : 'Inventory Indicator'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INKEN'
    InventoryIsCounted : Boolean not null;
  };

  @cds.external : true
  type D_PL_CrteFxdAstTmeDepdntSAFTP {
    @Common.IsUpperCase : true
    @Common.Label : 'Customer Acc.Invoice'
    @Common.Heading : 'Customer Invoice Accounting Document'
    @Common.QuickInfo : 'Customer Invoice Accounting Document'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_CUST_INVC_ACCTG_DOC'
    PL_CustInvcAccountingDocument : String(10) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Fiscal Year'
    @Common.Heading : 'Customer Invoice Fiscal Year'
    @Common.QuickInfo : 'Customer Invoice Fiscal Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_CUST_INVC_FSCL_YR'
    PL_CustomerInvoiceFiscalYear : String(4) not null;
  };

  @cds.external : true
  type D_ChgFxdAstEUNatlClsfctnP {
    @Common.IsUpperCase : true
    @Common.Label : 'Natl. Clfn. Code'
    @Common.Heading : 'National Classification Code'
    @Common.QuickInfo : 'National Classification Code'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_NATL_CLFN_CODE'
    NationalClassification : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Tax Depr. Group'
    @Common.Heading : 'Tax Depreciation Group'
    @Common.QuickInfo : 'Tax Depreciation Group'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_TAX_DEPR_GRP'
    TaxDepreciationGroup : String(4) not null;
  };

  @cds.external : true
  type D_RS_ChgFxdAstTaxDepreciationP {
    @Common.IsDigitSequence : true
    @Common.Label : 'Exclusion Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_RS_EXCLUSION_YEAR'
    RS_GroupDeprExclusionYear : String(4) not null;
    @Common.Label : 'Last Invoice Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_RS_LAST_INVOICE_DATE'
    RS_AssetLastInvoiceDate : Date;
  };

  @cds.external : true
  type D_CrteMstrFxdAstInventoryP {
    @Common.IsUpperCase : true
    @Common.Label : 'Inventory Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INVNR_ANLA'
    Inventory : String(25) not null;
    @Common.Label : 'Last Inventory On'
    @Common.Heading : 'Inv.Date'
    @Common.QuickInfo : 'Last Inventory Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=IVDAT_ANLA'
    LastInventoryDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Inventory Note'
    @Common.QuickInfo : 'Supplementary Inventory Specifications'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INVZU_ANLA'
    InventoryNote : String(15) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Include Asset'
    @Common.Heading : 'II'
    @Common.QuickInfo : 'Inventory Indicator'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INKEN'
    InventoryIsCounted : Boolean not null;
  };

  @cds.external : true
  type D_ChangeFixedAssetTmeBsdValnP {
    @Common.Label : 'Valid From'
    @Common.QuickInfo : 'Date for Beginning of Validity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ADATU'
    ValidityStartDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Action Indicator'
    @Common.Heading : 'Object Action Indicator'
    @Common.QuickInfo : 'Action indicator for create, change, and delete operations'
    FixedAssetObjectActionCode : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Depreciation Key'
    @Common.Heading : 'DepKy'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AFASL'
    DepreciationKey : String(4) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Useful Life'
    @Common.Heading : 'Use'
    @Common.QuickInfo : 'Planned Useful Life in Years'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NDJAR'
    PlannedUsefulLifeInYears : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Usef.Life in Periods'
    @Common.Heading : 'Per'
    @Common.QuickInfo : 'Planned Useful Life in Periods'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NDPER'
    PlannedUsefulLifeInPeriods : String(3) not null;
    @Common.Label : 'Variable Dep.Portion'
    @Common.Heading : 'Var.Prtn'
    @Common.QuickInfo : 'Variable Depreciation Portion'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=APROP'
    VariableDeprPercent : Decimal(7, 4) not null;
    @Common.Label : 'Scrap Value Percent'
    @Common.Heading : 'Scrap Val. [%]'
    @Common.QuickInfo : 'Scrap Value as Percentage of APC'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SCHRW_PROZ'
    AcqnProdnCostScrapPercent : Decimal(14, 11) not null;
    @Common.Label : 'Percentage'
    @Common.Heading : 'Base Value Percentage'
    @Common.QuickInfo : 'Base Value Percentage'
    DeprCalcBaseValuePercent : Decimal(16, 13) not null;
    @Common.Label : 'Shift Factor'
    @Common.Heading : 'MSFac'
    @Common.QuickInfo : 'Multiple-Shift Factor for Multiple Shift Operation'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MSFAK'
    ShiftOperationFactor : Decimal(3, 2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Asset Shutdown'
    @Common.Heading : 'Sdown'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=XSTIL'
    IsShutDown : Boolean not null;
    @Measures.ISOCurrency : CompanyCodeCurrency
    @Common.Label : 'Value in CompCd Crcy'
    @Common.Heading : 'Scrap Val in CC Crcy'
    @Common.QuickInfo : 'Scrap Value in Company Code Currency'
    ScrapAmountInCoCodeCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : GlobalCurrency
    @Common.Label : 'Value in Gl. Crcy'
    @Common.Heading : 'Scrap Value in Gl. Crcy'
    @Common.QuickInfo : 'Scrap Value in Global Currency'
    ScrapAmountInGlobCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency1
    @Common.Label : 'Value in Currency 1'
    @Common.Heading : 'Scrap Value in Crcy 1'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 1'
    ScrapAmountInFreeDefinedCrcy1 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency2
    @Common.Label : 'Value in Currency 2'
    @Common.Heading : 'Scrap Value in Crcy 2'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 2'
    ScrapAmountInFreeDefinedCrcy2 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency3
    @Common.Label : 'Value in Currency 3'
    @Common.Heading : 'Scrap Value in Crcy 3'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 3'
    ScrapAmountInFreeDefinedCrcy3 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency4
    @Common.Label : 'Value in Currency 4'
    @Common.Heading : 'Scrap Value in Crcy 4'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 4'
    ScrapAmountInFreeDefinedCrcy4 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency5
    @Common.Label : 'Value in Currency 5'
    @Common.Heading : 'Scrap Value in Crcy 5'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 5'
    ScrapAmountInFreeDefinedCrcy5 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency6
    @Common.Label : 'Value in Currency 6'
    @Common.Heading : 'Scrap Value in Crcy 6'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 6'
    ScrapAmountInFreeDefinedCrcy6 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency7
    @Common.Label : 'Value in Currency 7'
    @Common.Heading : 'Scrap Value in Crcy 7'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 7'
    ScrapAmountInFreeDefinedCrcy7 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency8
    @Common.Label : 'Value in Currency 8'
    @Common.Heading : 'Scrap Value in Crcy 8'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 8'
    ScrapAmountInFreeDefinedCrcy8 : Decimal(precision: 23) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'CompanyCode Currency'
    @Common.Heading : 'CCCrcy'
    @Common.QuickInfo : 'Company Code Currency'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FINS_CURRH'
    CompanyCodeCurrency : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Global Currency'
    GlobalCurrency : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 1'
    @Common.Heading : 'Freely Defined Currency 1'
    @Common.QuickInfo : 'Freely Defined Currency 1'
    FreeDefinedCurrency1 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 2'
    @Common.Heading : 'Freely Defined Currency 2'
    @Common.QuickInfo : 'Freely Defined Currency 2'
    FreeDefinedCurrency2 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 3'
    @Common.Heading : 'Freely Defined Currency 3'
    @Common.QuickInfo : 'Freely Defined Currency 3'
    FreeDefinedCurrency3 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 4'
    @Common.Heading : 'Freely Defined Currency 4'
    @Common.QuickInfo : 'Freely Defined Currency 4'
    FreeDefinedCurrency4 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 5'
    @Common.Heading : 'Freely Defined Currency 5'
    @Common.QuickInfo : 'Freely Defined Currency 5'
    FreeDefinedCurrency5 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 6'
    @Common.Heading : 'Freely Defined Currency 6'
    @Common.QuickInfo : 'Freely Defined Currency 6'
    FreeDefinedCurrency6 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 7'
    @Common.Heading : 'Freely Defined Currency 7'
    @Common.QuickInfo : 'Freely Defined Currency 7'
    FreeDefinedCurrency7 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 8'
    @Common.Heading : 'Freely Defined Currency 8'
    @Common.QuickInfo : 'Freely Defined Currency 8'
    FreeDefinedCurrency8 : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Usage Object'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FAA_UO'
    FixedAssetUsageObject : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Revaluation Index ID'
    @Common.Heading : 'Asset Revaluation: Index ID'
    @Common.QuickInfo : 'Asset Revaluation: Index ID'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FAA_RV_INDEX_ID'
    AssetRevaluationIndex : String(10) not null;
  };

  @cds.external : true
  type D_JP_CrteFxdAssetPropertyTaxP {
    @Common.IsUpperCase : true
    @Common.Label : 'Japan City Code'
    @Common.Heading : 'City Code'
    @Common.QuickInfo : 'Japan: City Code of Property Tax Report'
    JP_PrptyTxRptCity : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Japan Class. Key'
    @Common.Heading : 'Classification Key'
    @Common.QuickInfo : 'Japan: Classification Key of Property Tax Report'
    JP_PrptyTxRptClassfctnKey : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Spec.Depr. Code'
    @Common.Heading : 'Special Depreciation Code'
    @Common.QuickInfo : 'Japan: Special Depreciation Code of Property Tax Report'
    JP_PrptyTxRptSpclDepr : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Additional Dep. Code'
    @Common.Heading : 'Additional Depreciation Code'
    @Common.QuickInfo : 'Japan: Additional Depreciation Code of Property Tax Report'
    JP_PrptyTxRptAddlDepr : String(8) not null;
  };

  @cds.external : true
  type D_GlobCrteMstrFxdAstValuationP {
    @Common.Label : 'Valid From'
    @Common.QuickInfo : 'Date for Beginning of Validity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ADATU'
    ValidityStartDate : Date;
    _JP_Imprmt : D_JP_CrteMstrAstImprmtPostgP not null;
    _SK_TaxDepreciation : D_SK_CrteMstrFxdAstTxDeprP not null;
  };

  @cds.external : true
  type D_SK_CrteFxdAstTxDepreciationP {
    @Common.IsDigitSequence : true
    @Common.Label : 'Capital Impr.Year'
    @Common.Heading : 'Capital Improvement Year'
    @Common.QuickInfo : 'Slovakia: Capital Improvement Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLOFAA_SK_CPTL_IMPRV_YEAR'
    SK_CapitalImprovementYear : String(4) not null;
  };

  @cds.external : true
  type D_CreateFixedAssetLedgerP {
    @Common.IsUpperCase : true
    @Common.Label : 'Ledger'
    @Common.Heading : 'Ld'
    @Common.QuickInfo : 'Ledger in General Ledger Accounting'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FINS_LEDGER'
    Ledger : String(2) not null;
    @Common.Label : 'Capitalized On'
    @Common.Heading : 'Cap.Date'
    @Common.QuickInfo : 'Asset Capitalization Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AKTIVD'
    AssetCapitalizationDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Truth Value'
    @Common.QuickInfo : 'Truth Value: True/False'
    IsDeleted : Boolean not null;
    _Valuation : many D_CreateFixedAssetValuationP not null;
  };

  @cds.external : true
  type D_GlobCrteMstrFxdAstTmeDepdntP {
    @Common.Label : 'Valid From'
    @Common.QuickInfo : 'Date for Beginning of Validity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ADATU'
    ValidityStartDate : Date;
    _CN_AuditDataExtraction : D_CN_CrteMstrFxdAstAudDEXP not null;
    _PL_TmDepSAFT : D_PL_CrteMstrFxdAstTmDepSAFTP not null;
  };

  @cds.external : true
  type D_CrteMstrFxdAstOriginP {
    @Common.IsUpperCase : true
    @Common.Label : 'Supplier'
    @Common.QuickInfo : 'Account Number of Supplier (Other Key Word)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AM_LIFNR'
    Supplier : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Ctry/Reg. of Origin'
    @Common.QuickInfo : 'Asset''s Country/Region of Origin'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AM_LAND1'
    AssetCountryOfOrigin : String(3) not null;
    @Common.Label : 'Manufacturer'
    @Common.Heading : 'Manufacturer of Asset'
    @Common.QuickInfo : 'Manufacturer of Asset'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=HERST'
    AssetManufacturerName : String(30) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Fiscal Year'
    OriginalAcquisitionFiscalYear : String(4) not null;
    @Measures.ISOCurrency : OriginalAcquisitionCurrency
    @Common.Label : 'Original Value'
    @Common.QuickInfo : 'Original Acquisition Value'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=URWRT'
    OriginalAcquisitionAmount : Decimal(precision: 23) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Orig Acq Crcy'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Original Acquisition Value Currency'
    OriginalAcquisitionCurrency : String(3) not null;
    @Common.Label : 'In-House Prod. Perc.'
    @Common.Heading : 'In-H.Pro'
    @Common.QuickInfo : 'In-House Production Percentage'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANTEI'
    InHouseProdnPercent : Decimal(5, 2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Type name'
    @Common.QuickInfo : 'Asset type name'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TYPBZ_ANLA'
    AssetTypeName : String(15) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Trading Partner No.'
    @Common.Heading : 'Tr.Prt'
    @Common.QuickInfo : 'Company ID of Trading Partner'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=RASSC'
    PartnerCompany : String(6) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Purchased Used'
    @Common.QuickInfo : 'Asset Acquired Used'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=XAFABCH'
    AssetIsAcquiredUsed : Boolean not null;
  };

  @cds.external : true
  type D_GlobCrteMstrFxdAstTmeIndepP {
    _EUNationalClassification : D_CrteMstrFxdAstEUNatlClsfctnP not null;
    _IN_AssetBlockData : D_IN_CrteMstrFxdAstBlockDataP not null;
    _JP_Annex16 : D_JP_CrteMstrFxdAssetAnnex16P not null;
    _JP_PropertyTax : D_JP_CrteMstrFxdAstPrprtyTaxP not null;
    _PL_TmIdpSAFT : D_PL_CrteMstrFxdAstTmIdpSAFTP not null;
    _PT_AssetData : D_PT_CrteMstrFixedAssetDataP not null;
    _RS_TaxDepr : D_RS_CrteMstrFxdAstTxDeprP not null;
  };

  @cds.external : true
  type D_CrteFxdAstEUNatlClsfctnP {
    @Common.IsUpperCase : true
    @Common.Label : 'Natl. Clfn. Code'
    @Common.Heading : 'National Classification Code'
    @Common.QuickInfo : 'National Classification Code'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_NATL_CLFN_CODE'
    NationalClassification : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Tax Depr. Group'
    @Common.Heading : 'Tax Depreciation Group'
    @Common.QuickInfo : 'Tax Depreciation Group'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_TAX_DEPR_GRP'
    TaxDepreciationGroup : String(4) not null;
  };

  @cds.external : true
  type D_CN_ChgFxdAstAudDtaXtrctnP {
    @Common.IsUpperCase : true
    @Common.Label : 'Usage Code'
    @Common.QuickInfo : 'China: CADE Fixed Asset Usage Type'
    CN_CADEFixedAssetUsage : String(10) not null;
  };

  @cds.external : true
  type D_GlobChgFxdAstTmeDependentP {
    @Common.Label : 'Valid From'
    @Common.QuickInfo : 'Date for Beginning of Validity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ADATU'
    ValidityStartDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Action Indicator'
    @Common.Heading : 'Object Action Indicator'
    @Common.QuickInfo : 'Action indicator for create, change, and delete operations'
    FixedAssetObjectActionCode : String(2) not null;
    _CN_AuditDataExtraction : D_CN_ChgFxdAstAudDtaXtrctnP not null;
    _PL_TmDepSAFT : D_PL_ChgFxdAstTmeDepdntSAFTP not null;
  };

  @cds.external : true
  type D_CN_CrteMstrFxdAstAudDEXP {
    @Common.IsUpperCase : true
    @Common.Label : 'Usage Code'
    @Common.QuickInfo : 'China: CADE Fixed Asset Usage Type'
    CN_CADEFixedAssetUsage : String(10) not null;
  };

  @cds.external : true
  type D_JP_ChgFxdAstImprmtPostingP {
    @Common.Label : 'Impairment Post Date'
    @Common.Heading : 'Impairment posting Date'
    @Common.QuickInfo : 'Japan: Impairment Posting Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_JP_DI'
    JP_ImpairmentPostingDate : Date;
    @Measures.ISOCurrency : CompanyCodeCurrency
    @Common.Label : 'APC in Co. Code Crcy'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Company Code Crcy'
    JP_ImpAcqnProdCostAmtInCCCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : GlobalCurrency
    @Common.Label : 'APC in Global Crcy'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Global Currency'
    JP_ImpAcqnProdCostAmtInGCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency1
    @Common.Label : 'APC in Currency 1'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy1'
    JP_ImpAcqnProdCostAmtInFDCrcy1 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency2
    @Common.Label : 'APC in Currency 2'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy2'
    JP_ImpAcqnProdCostAmtInFDCrcy2 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency3
    @Common.Label : 'APC in Currency 3'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy3'
    JP_ImpAcqnProdCostAmtInFDCrcy3 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency4
    @Common.Label : 'APC in Currency 4'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy4'
    JP_ImpAcqnProdCostAmtInFDCrcy4 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency5
    @Common.Label : 'APC in Currency 5'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy5'
    JP_ImpAcqnProdCostAmtInFDCrcy5 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency6
    @Common.Label : 'APC in Currency 6'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy6'
    JP_ImpAcqnProdCostAmtInFDCrcy6 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency7
    @Common.Label : 'APC in Currency 7'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy7'
    JP_ImpAcqnProdCostAmtInFDCrcy7 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency8
    @Common.Label : 'APC in Currency 8'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy8'
    JP_ImpAcqnProdCostAmtInFDCrcy8 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : CompanyCodeCurrency
    @Common.Label : 'BAI in Co. Code Crcy'
    @Common.QuickInfo : 'Japan: Book Value After Impairment Posting in Co. Code Crcy'
    JP_AftImprmtBookAmtInCCCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : GlobalCurrency
    @Common.Label : 'BAI in Global Crcy'
    @Common.QuickInfo : 'Japan: Book Value After Impairment Posting in Global Crcy'
    JP_AftImprmtBookAmtInGlobCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency1
    @Common.Label : 'BAI in Currency 1'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy1'
    JP_AftImprmtBookAmtInFDCrcy1 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency2
    @Common.Label : 'BAI in Currency 2'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy2'
    JP_AftImprmtBookAmtInFDCrcy2 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency3
    @Common.Label : 'BAI in Currency 3'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy3'
    JP_AftImprmtBookAmtInFDCrcy3 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency4
    @Common.Label : 'BAI in Currency 4'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy4'
    JP_AftImprmtBookAmtInFDCrcy4 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency5
    @Common.Label : 'BAI in Currency 5'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy5'
    JP_AftImprmtBookAmtInFDCrcy5 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency6
    @Common.Label : 'BAI in Currency 6'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy6'
    JP_AftImprmtBookAmtInFDCrcy6 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency7
    @Common.Label : 'BAI in Currency 7'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy7'
    JP_AftImprmtBookAmtInFDCrcy7 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency8
    @Common.Label : 'BAI in Currency 8'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy8'
    JP_AftImprmtBookAmtInFDCrcy8 : Decimal(precision: 23) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'CompanyCode Currency'
    @Common.Heading : 'CCCrcy'
    @Common.QuickInfo : 'Company Code Currency'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FINS_CURRH'
    CompanyCodeCurrency : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Global Currency'
    GlobalCurrency : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 1'
    @Common.Heading : 'Freely Defined Currency 1'
    @Common.QuickInfo : 'Freely Defined Currency 1'
    FreeDefinedCurrency1 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 2'
    @Common.Heading : 'Freely Defined Currency 2'
    @Common.QuickInfo : 'Freely Defined Currency 2'
    FreeDefinedCurrency2 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 3'
    @Common.Heading : 'Freely Defined Currency 3'
    @Common.QuickInfo : 'Freely Defined Currency 3'
    FreeDefinedCurrency3 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 4'
    @Common.Heading : 'Freely Defined Currency 4'
    @Common.QuickInfo : 'Freely Defined Currency 4'
    FreeDefinedCurrency4 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 5'
    @Common.Heading : 'Freely Defined Currency 5'
    @Common.QuickInfo : 'Freely Defined Currency 5'
    FreeDefinedCurrency5 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 6'
    @Common.Heading : 'Freely Defined Currency 6'
    @Common.QuickInfo : 'Freely Defined Currency 6'
    FreeDefinedCurrency6 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 7'
    @Common.Heading : 'Freely Defined Currency 7'
    @Common.QuickInfo : 'Freely Defined Currency 7'
    FreeDefinedCurrency7 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 8'
    @Common.Heading : 'Freely Defined Currency 8'
    @Common.QuickInfo : 'Freely Defined Currency 8'
    FreeDefinedCurrency8 : String(3) not null;
  };

  @cds.external : true
  type D_JP_ChgFixedAssetPropertyTaxP {
    @Common.IsUpperCase : true
    @Common.Label : 'Japan City Code'
    @Common.Heading : 'City Code'
    @Common.QuickInfo : 'Japan: City Code of Property Tax Report'
    JP_PrptyTxRptCity : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Japan Class. Key'
    @Common.Heading : 'Classification Key'
    @Common.QuickInfo : 'Japan: Classification Key of Property Tax Report'
    JP_PrptyTxRptClassfctnKey : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Spec.Depr. Code'
    @Common.Heading : 'Special Depreciation Code'
    @Common.QuickInfo : 'Japan: Special Depreciation Code of Property Tax Report'
    JP_PrptyTxRptSpclDepr : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Additional Dep. Code'
    @Common.Heading : 'Additional Depreciation Code'
    @Common.QuickInfo : 'Japan: Additional Depreciation Code of Property Tax Report'
    JP_PrptyTxRptAddlDepr : String(8) not null;
  };

  @cds.external : true
  type D_ChangeFixedAssetValuationP {
    @Common.IsDigitSequence : true
    @Common.Label : 'Depreciation Area'
    @Common.Heading : 'Ar.'
    @Common.QuickInfo : 'Depreciation Area Real or Derived'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AFABER'
    AssetDepreciationArea : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Action Indicator'
    @Common.Heading : 'Object Action Indicator'
    @Common.QuickInfo : 'Action indicator for create, change, and delete operations'
    FixedAssetObjectActionCode : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Negative Val.Allowed'
    @Common.Heading : 'Neg'
    @Common.QuickInfo : 'Indicator: Negative Values Allowed'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=XNEGA'
    NegativeAmountIsAllowed : Boolean not null;
    @Common.Label : 'Dep. Start Date'
    @Common.Heading : 'Depreciation Calculation Start Date'
    @Common.QuickInfo : 'Depreciation Calculation Start Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AFABG'
    DepreciationStartDate : Date;
    @Common.Label : 'Special Depreciation'
    @Common.Heading : 'SDep.Start'
    @Common.QuickInfo : 'Start Date for Special Depreciation'
    SpecialDeprStartDate : Date;
    @Common.Label : 'Operating Readiness'
    @Common.QuickInfo : 'Asset Accounting:  Date of Operating Readiness'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INBDA'
    AssetOpgReadinessDate : Date;
    @Common.IsDigitSequence : true
    @Common.Label : 'Fiscal Year'
    DeprKeyChangeoverYear : String(4) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Changeover Period'
    @Common.Heading : 'ChPrd'
    @Common.QuickInfo : 'Changeover Period of Depreciation Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=UMPER'
    DeprKeyChangeoverPeriod : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Expired Useful Life'
    @Common.Heading : 'EUL'
    @Common.QuickInfo : 'Expired Useful Life in Years at Start of the Fiscal Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NDABJ'
    ExpiredUsefulLifeInYrs : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Expired UL Periods'
    @Common.Heading : 'ELP'
    @Common.QuickInfo : 'Expired Useful Life in Periods at Start of Fiscal Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NDABP'
    ExpiredUsefulLifeInPerds : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Exp.spec.dep. life'
    @Common.Heading : 'DSL'
    @Common.QuickInfo : 'Yrs Expired up to Fisc.Yr Start from Start of Spec.Dep.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANDSJ'
    SpclExpiredUsefulLifeInYrs : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Exp.UL Periods SDep.'
    @Common.Heading : 'DLP'
    @Common.QuickInfo : 'Expired Useful Life in Periods during FY from SDep Start Dat'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANDSP'
    SpclExpiredUsefulLifeInPerds : String(3) not null;
    _GlobTimeBasedValuation : many D_GlobChgFixedAssetValuationP not null;
    _TimeBasedValuation : many D_ChangeFixedAssetTmeBsdValnP not null;
  };

  @cds.external : true
  type D_JP_CreateFixedAssetAnnex16P {
    @Common.IsUpperCase : true
    @Common.Label : 'Asset Structure'
    @Common.QuickInfo : 'Japan: Asset Structure of Annex16'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_ANX16_STRC'
    JP_Annex16AssetStructure : String(5) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Asset Item'
    @Common.QuickInfo : 'Japan: Asset Item of Annex16'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_ANX16_ITEM'
    JP_Annex16AssetItem : String(5) not null;
    @Common.Label : 'Lease Agreement Date'
    @Common.Heading : 'Leas.Date'
    @Common.QuickInfo : 'Japan: Leasing Agreement Date of Annex16-4 Report'
    JP_Annex16LeasingAgrmtDate : Date;
  };

  @cds.external : true
  type D_PT_CrteMstrFixedAssetDataP {
    @Common.IsUpperCase : true
    @Common.Label : 'Vehicle Type'
    @Common.QuickInfo : 'Portugal: Vehicle Type'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_VEHICLETYPE'
    PT_VehicleTypeByEnergy : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Veh. W/o. Limit'
    @Common.Heading : 'Is vehicle Without Limit'
    @Common.QuickInfo : 'Portugal: Is Vehicle Without Limit'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_ISVEHICLEWOLIMIT'
    PT_VehicleIsWithoutLimit : Boolean not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Repair Link'
    @Common.Heading : 'Repair Asset Link'
    @Common.QuickInfo : 'Portugal: Repair Asset Link'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_REPAIRASSETLINK'
    PT_BigRepairAssetLink : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Land Asset Link'
    @Common.QuickInfo : 'Portugal: Land Asset Link'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_LANDASSETLINK'
    PT_LandAssetLink : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Form Categ.'
    @Common.Heading : 'Report Form Category'
    @Common.QuickInfo : 'Portugal: Asset Report Form Category'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_ASSETREPFORMCAT'
    PT_AssetReportFormCategory : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Amort. Reval.'
    @Common.Heading : 'Is Amort. Asset Revaluated'
    @Common.QuickInfo : 'Portugal: Is Amortized Asset Revaluated'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_ISAMASSETREVAL'
    PT_AmortizedAssetIsReevaluated : Boolean not null;
  };

  @cds.external : true
  type D_RS_CrteMstrFxdAstTxDeprP {
    @Common.IsDigitSequence : true
    @Common.Label : 'Exclusion Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_RS_EXCLUSION_YEAR'
    RS_GroupDeprExclusionYear : String(4) not null;
    @Common.Label : 'Last Invoice Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_RS_LAST_INVOICE_DATE'
    RS_AssetLastInvoiceDate : Date;
  };

  @cds.external : true
  type D_GlobChgFxdAstTmeIndependentP {
    _EUNationalClassification : D_ChgFxdAstEUNatlClsfctnP not null;
    _IN_AssetBlockData : D_IN_ChgFixedAssetBlockDataP not null;
    _JP_Annex16 : D_JP_ChangeFixedAssetAnnex16P not null;
    _JP_PropertyTax : D_JP_ChgFixedAssetPropertyTaxP not null;
    _PL_TmIdpSAFT : D_PL_ChgFxdAstTmeIndepSAFTP not null;
    _PT_AssetData : D_PT_ChangeFixedAssetDataP not null;
    _RS_TaxDepr : D_RS_ChgFxdAstTaxDepreciationP not null;
  };

  @cds.external : true
  type D_CrteMstrFxdAstEUNatlClsfctnP {
    @Common.IsUpperCase : true
    @Common.Label : 'Natl. Clfn. Code'
    @Common.Heading : 'National Classification Code'
    @Common.QuickInfo : 'National Classification Code'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_NATL_CLFN_CODE'
    NationalClassification : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Tax Depr. Group'
    @Common.Heading : 'Tax Depreciation Group'
    @Common.QuickInfo : 'Tax Depreciation Group'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_TAX_DEPR_GRP'
    TaxDepreciationGroup : String(4) not null;
  };

  @cds.external : true
  type D_PL_CrteFxdAstTmeIndepSAFTP {
    @Common.Label : 'Acqn./Prodn. Date'
    @Common.Heading : 'Date of Acquisition/Production'
    @Common.QuickInfo : 'Fixed Asset Acquisition/Production Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_ACQN_PRODN_DATE'
    PL_AcquisitionProductionDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Acquisition Doc Type'
    @Common.Heading : 'Acquisition Document Type'
    @Common.QuickInfo : 'Acquisition Document Type'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_ACQN_DOC_TYPE'
    PL_AcquisitionDocumentType : String(1) not null;
    @Common.Label : 'OT Document Number'
    @Common.QuickInfo : 'Asset Acquisition Form/OT Document Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_ACQN_FORM_NMBR'
    PL_AcquisitionFormNumber : String(25) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'SAFT Asset Tax Group'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_AST_TAX_GROUP'
    PL_AssetTaxGroup : String(2) not null;
  };

  @cds.external : true
  type D_CreateFixedAssetTmeBsdValnP {
    @Common.Label : 'Valid From'
    @Common.QuickInfo : 'Date for Beginning of Validity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ADATU'
    ValidityStartDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Depreciation Key'
    @Common.Heading : 'DepKy'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AFASL'
    DepreciationKey : String(4) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Useful Life'
    @Common.Heading : 'Use'
    @Common.QuickInfo : 'Planned Useful Life in Years'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NDJAR'
    PlannedUsefulLifeInYears : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Usef.Life in Periods'
    @Common.Heading : 'Per'
    @Common.QuickInfo : 'Planned Useful Life in Periods'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NDPER'
    PlannedUsefulLifeInPeriods : String(3) not null;
    @Common.Label : 'Variable Dep.Portion'
    @Common.Heading : 'Var.Prtn'
    @Common.QuickInfo : 'Variable Depreciation Portion'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=APROP'
    VariableDeprPercent : Decimal(7, 4) not null;
    @Common.Label : 'Scrap Value Percent'
    @Common.Heading : 'Scrap Val. [%]'
    @Common.QuickInfo : 'Scrap Value as Percentage of APC'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SCHRW_PROZ'
    AcqnProdnCostScrapPercent : Decimal(14, 11) not null;
    @Common.Label : 'Percentage'
    @Common.Heading : 'Base Value Percentage'
    @Common.QuickInfo : 'Base Value Percentage'
    DeprCalcBaseValuePercent : Decimal(16, 13) not null;
    @Common.Label : 'Shift Factor'
    @Common.Heading : 'MSFac'
    @Common.QuickInfo : 'Multiple-Shift Factor for Multiple Shift Operation'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MSFAK'
    ShiftOperationFactor : Decimal(3, 2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Asset Shutdown'
    @Common.Heading : 'Sdown'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=XSTIL'
    IsShutDown : Boolean not null;
    @Measures.ISOCurrency : CompanyCodeCurrency
    @Common.Label : 'Value in CompCd Crcy'
    @Common.Heading : 'Scrap Val in CC Crcy'
    @Common.QuickInfo : 'Scrap Value in Company Code Currency'
    ScrapAmountInCoCodeCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : GlobalCurrency
    @Common.Label : 'Value in Gl. Crcy'
    @Common.Heading : 'Scrap Value in Gl. Crcy'
    @Common.QuickInfo : 'Scrap Value in Global Currency'
    ScrapAmountInGlobCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency1
    @Common.Label : 'Value in Currency 1'
    @Common.Heading : 'Scrap Value in Crcy 1'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 1'
    ScrapAmountInFreeDefinedCrcy1 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency2
    @Common.Label : 'Value in Currency 2'
    @Common.Heading : 'Scrap Value in Crcy 2'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 2'
    ScrapAmountInFreeDefinedCrcy2 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency3
    @Common.Label : 'Value in Currency 3'
    @Common.Heading : 'Scrap Value in Crcy 3'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 3'
    ScrapAmountInFreeDefinedCrcy3 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency4
    @Common.Label : 'Value in Currency 4'
    @Common.Heading : 'Scrap Value in Crcy 4'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 4'
    ScrapAmountInFreeDefinedCrcy4 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency5
    @Common.Label : 'Value in Currency 5'
    @Common.Heading : 'Scrap Value in Crcy 5'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 5'
    ScrapAmountInFreeDefinedCrcy5 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency6
    @Common.Label : 'Value in Currency 6'
    @Common.Heading : 'Scrap Value in Crcy 6'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 6'
    ScrapAmountInFreeDefinedCrcy6 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency7
    @Common.Label : 'Value in Currency 7'
    @Common.Heading : 'Scrap Value in Crcy 7'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 7'
    ScrapAmountInFreeDefinedCrcy7 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency8
    @Common.Label : 'Value in Currency 8'
    @Common.Heading : 'Scrap Value in Crcy 8'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 8'
    ScrapAmountInFreeDefinedCrcy8 : Decimal(precision: 23) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'CompanyCode Currency'
    @Common.Heading : 'CCCrcy'
    @Common.QuickInfo : 'Company Code Currency'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FINS_CURRH'
    CompanyCodeCurrency : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Global Currency'
    GlobalCurrency : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 1'
    @Common.Heading : 'Freely Defined Currency 1'
    @Common.QuickInfo : 'Freely Defined Currency 1'
    FreeDefinedCurrency1 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 2'
    @Common.Heading : 'Freely Defined Currency 2'
    @Common.QuickInfo : 'Freely Defined Currency 2'
    FreeDefinedCurrency2 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 3'
    @Common.Heading : 'Freely Defined Currency 3'
    @Common.QuickInfo : 'Freely Defined Currency 3'
    FreeDefinedCurrency3 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 4'
    @Common.Heading : 'Freely Defined Currency 4'
    @Common.QuickInfo : 'Freely Defined Currency 4'
    FreeDefinedCurrency4 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 5'
    @Common.Heading : 'Freely Defined Currency 5'
    @Common.QuickInfo : 'Freely Defined Currency 5'
    FreeDefinedCurrency5 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 6'
    @Common.Heading : 'Freely Defined Currency 6'
    @Common.QuickInfo : 'Freely Defined Currency 6'
    FreeDefinedCurrency6 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 7'
    @Common.Heading : 'Freely Defined Currency 7'
    @Common.QuickInfo : 'Freely Defined Currency 7'
    FreeDefinedCurrency7 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Free Defined Crcy 8'
    @Common.Heading : 'Freely Defined Currency 8'
    @Common.QuickInfo : 'Freely Defined Currency 8'
    FreeDefinedCurrency8 : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Usage Object'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FAA_UO'
    FixedAssetUsageObject : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Revaluation Index ID'
    @Common.Heading : 'Asset Revaluation: Index ID'
    @Common.QuickInfo : 'Asset Revaluation: Index ID'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FAA_RV_INDEX_ID'
    AssetRevaluationIndex : String(10) not null;
  };

  @cds.external : true
  type D_ChangeFixedAssetOriginP {
    @Common.IsUpperCase : true
    @Common.Label : 'Supplier'
    @Common.QuickInfo : 'Account Number of Supplier (Other Key Word)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AM_LIFNR'
    Supplier : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Ctry/Reg. of Origin'
    @Common.QuickInfo : 'Asset''s Country/Region of Origin'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AM_LAND1'
    AssetCountryOfOrigin : String(3) not null;
    @Common.Label : 'Manufacturer'
    @Common.Heading : 'Manufacturer of Asset'
    @Common.QuickInfo : 'Manufacturer of Asset'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=HERST'
    AssetManufacturerName : String(30) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Fiscal Year'
    OriginalAcquisitionFiscalYear : String(4) not null;
    @Measures.ISOCurrency : OriginalAcquisitionCurrency
    @Common.Label : 'Original Value'
    @Common.QuickInfo : 'Original Acquisition Value'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=URWRT'
    OriginalAcquisitionAmount : Decimal(precision: 23) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Orig Acq Crcy'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Original Acquisition Value Currency'
    OriginalAcquisitionCurrency : String(3) not null;
    @Common.Label : 'In-House Prod. Perc.'
    @Common.Heading : 'In-H.Pro'
    @Common.QuickInfo : 'In-House Production Percentage'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANTEI'
    InHouseProdnPercent : Decimal(5, 2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Type name'
    @Common.QuickInfo : 'Asset type name'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TYPBZ_ANLA'
    AssetTypeName : String(15) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Trading Partner No.'
    @Common.Heading : 'Tr.Prt'
    @Common.QuickInfo : 'Company ID of Trading Partner'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=RASSC'
    PartnerCompany : String(6) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Purchased Used'
    @Common.QuickInfo : 'Asset Acquired Used'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=XAFABCH'
    AssetIsAcquiredUsed : Boolean not null;
  };

  @cds.external : true
  type D_CN_CrteFxdAstAudDtaXtrctnP {
    @Common.IsUpperCase : true
    @Common.Label : 'Usage Code'
    @Common.QuickInfo : 'China: CADE Fixed Asset Usage Type'
    CN_CADEFixedAssetUsage : String(10) not null;
  };

  @cds.external : true
  type D_CreateFixedAssetGeneralP {
    @Common.Label : 'Description'
    @Common.Heading : 'Asset Description'
    @Common.QuickInfo : 'Asset Description'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TXA50_ANLT'
    FixedAssetDescription : String(50) not null;
    @Common.Label : 'Description (2)'
    @Common.Heading : 'Asset description (2)'
    @Common.QuickInfo : 'Additional asset description'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TXA50_MORE'
    AssetAdditionalDescription : String(50) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Serial Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AM_SERNR'
    AssetSerialNumber : String(18) not null;
    @Common.Label : 'Ordered On'
    @Common.Heading : 'PO Date'
    @Common.QuickInfo : 'Asset Purchase Order Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BSTDT'
    FixedAssetOrderDate : Date;
    @Common.IsUnit : true
    @Common.Label : 'Base Unit of Measure'
    @Common.Heading : 'BUn'
    BaseUnitSAPCode : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'ISO Code'
    @Common.Heading : 'ISO'
    @Common.QuickInfo : 'ISO Code for Unit of Measurement'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ISOCD_UNIT'
    BaseUnitISOCode : String(3) not null;
  };

  @cds.external : true
  type D_JP_ChangeFixedAssetAnnex16P {
    @Common.IsUpperCase : true
    @Common.Label : 'Asset Structure'
    @Common.QuickInfo : 'Japan: Asset Structure of Annex16'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_ANX16_STRC'
    JP_Annex16AssetStructure : String(5) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Asset Item'
    @Common.QuickInfo : 'Japan: Asset Item of Annex16'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_ANX16_ITEM'
    JP_Annex16AssetItem : String(5) not null;
    @Common.Label : 'Lease Agreement Date'
    @Common.Heading : 'Leas.Date'
    @Common.QuickInfo : 'Japan: Leasing Agreement Date of Annex16-4 Report'
    JP_Annex16LeasingAgrmtDate : Date;
  };

  @cds.external : true
  type D_CrteMstrFxdAstGeneralP {
    @Common.Label : 'Description'
    @Common.Heading : 'Asset Description'
    @Common.QuickInfo : 'Asset Description'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TXA50_ANLT'
    FixedAssetDescription : String(50) not null;
    @Common.Label : 'Description (2)'
    @Common.Heading : 'Asset description (2)'
    @Common.QuickInfo : 'Additional asset description'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TXA50_MORE'
    AssetAdditionalDescription : String(50) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Serial Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AM_SERNR'
    AssetSerialNumber : String(18) not null;
    @Common.Label : 'Ordered On'
    @Common.Heading : 'PO Date'
    @Common.QuickInfo : 'Asset Purchase Order Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BSTDT'
    FixedAssetOrderDate : Date;
    @Common.IsUnit : true
    @Common.Label : 'Base Unit of Measure'
    @Common.Heading : 'BUn'
    BaseUnitSAPCode : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'ISO Code'
    @Common.Heading : 'ISO'
    @Common.QuickInfo : 'ISO Code for Unit of Measurement'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ISOCD_UNIT'
    BaseUnitISOCode : String(3) not null;
  };

  @cds.external : true
  type D_CrteMstrFxdAstReferenceP {
    @Common.IsUpperCase : true
    @Common.Label : 'Company Code'
    @Common.Heading : 'CoCd'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BUKRS'
    CompanyCode : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Asset'
    @Common.QuickInfo : 'Main Asset Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN1'
    MasterFixedAsset : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Subnumber'
    @Common.Heading : 'SNo.'
    @Common.QuickInfo : 'Asset Subnumber'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN2'
    FixedAsset : String(4) not null;
  };

  @cds.external : true
  type D_IN_CrteFixedAssetBlockDataP {
    @Common.IsUpperCase : true
    @Common.Label : 'Block Key'
    @Common.QuickInfo : 'India: Block Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_BLK_KEY'
    IN_AssetBlock : String(5) not null;
    @Common.Label : 'Asset put to use'
    @Common.Heading : 'Asset put to use date'
    @Common.QuickInfo : 'India: Put to use date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_AST_PUT_USE'
    IN_AssetPutToUseDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Addnl Blk Key'
    @Common.Heading : 'Additional Depreciation Block Key'
    @Common.QuickInfo : 'India: Additional Depreciation Block Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_ADNL_BLK_KEY'
    IN_AdditionalAssetBlock : String(5) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'R & D Asset'
    @Common.QuickInfo : 'India: R & D Asset'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_R_AND_D_ASSET'
    IN_AssetIsResearchAndDev : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Prior year'
    @Common.Heading : 'Prior Year or Not for current year calculation'
    @Common.QuickInfo : 'India: Prior Year Transaction'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_PRIOR_YR'
    IN_AssetIsPriorYear : String(1) not null;
  };

  @cds.external : true
  type D_PL_CrteMstrFxdAstTmDepSAFTP {
    @Common.IsUpperCase : true
    @Common.Label : 'Customer Acc.Invoice'
    @Common.Heading : 'Customer Invoice Accounting Document'
    @Common.QuickInfo : 'Customer Invoice Accounting Document'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_CUST_INVC_ACCTG_DOC'
    PL_CustInvcAccountingDocument : String(10) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Fiscal Year'
    @Common.Heading : 'Customer Invoice Fiscal Year'
    @Common.QuickInfo : 'Customer Invoice Fiscal Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_CUST_INVC_FSCL_YR'
    PL_CustomerInvoiceFiscalYear : String(4) not null;
  };

  @cds.external : true
  type D_ChangeFixedAssetAcctAsgtP {
    @Common.Label : 'Valid From'
    @Common.QuickInfo : 'Date for Beginning of Validity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ADATU'
    ValidityStartDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Action Indicator'
    @Common.Heading : 'Object Action Indicator'
    @Common.QuickInfo : 'Action indicator for create, change, and delete operations'
    FixedAssetObjectActionCode : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Cost Center'
    @Common.Heading : 'Cost Ctr'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KOSTL'
    CostCenter : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'WBS Element'
    @Common.QuickInfo : 'Work Breakdown Structure Element (WBS Element) Edited'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PS_POSID_EDIT'
    WBSElementExternalID : String(24) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Profit Center'
    @Common.Heading : 'Profit Ctr'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PRCTR'
    ProfitCenter : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Segment'
    @Common.QuickInfo : 'Segment for Segmental Reporting'
    Segment : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Plant'
    @Common.Heading : 'Plnt'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WERKS_D'
    Plant : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Location'
    @Common.QuickInfo : 'Asset location'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=STORT'
    AssetLocation : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Room'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=RAUMNR'
    Room : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'License Plate Number'
    @Common.Heading : 'LicensePlateNo.'
    @Common.QuickInfo : 'License Plate No. of Vehicle'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AM_KFZKZ'
    VehicleLicensePlateNumber : String(15) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Tax Jurisdiction'
    @Common.Heading : 'Tax Jur.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TXJCD'
    TaxJurisdiction : String(15) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Business Place'
    @Common.Heading : 'BP'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BUPLA'
    BusinessPlace : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Fund'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BP_GEBER'
    Fund : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Grant'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GM_GRANT_NBR'
    GrantID : String(20) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Functional Area'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FKBER'
    FunctionalArea : String(16) not null;
  };

  @cds.external : true
  type D_IN_CrteMstrFxdAstBlockDataP {
    @Common.IsUpperCase : true
    @Common.Label : 'Block Key'
    @Common.QuickInfo : 'India: Block Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_BLK_KEY'
    IN_AssetBlock : String(5) not null;
    @Common.Label : 'Asset put to use'
    @Common.Heading : 'Asset put to use date'
    @Common.QuickInfo : 'India: Put to use date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_AST_PUT_USE'
    IN_AssetPutToUseDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Addnl Blk Key'
    @Common.Heading : 'Additional Depreciation Block Key'
    @Common.QuickInfo : 'India: Additional Depreciation Block Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_ADNL_BLK_KEY'
    IN_AdditionalAssetBlock : String(5) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'R & D Asset'
    @Common.QuickInfo : 'India: R & D Asset'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_R_AND_D_ASSET'
    IN_AssetIsResearchAndDev : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Prior year'
    @Common.Heading : 'Prior Year or Not for current year calculation'
    @Common.QuickInfo : 'India: Prior Year Transaction'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_PRIOR_YR'
    IN_AssetIsPriorYear : String(1) not null;
  };

  @cds.external : true
  type D_PL_ChgFxdAstTmeIndepSAFTP {
    @Common.Label : 'Acqn./Prodn. Date'
    @Common.Heading : 'Date of Acquisition/Production'
    @Common.QuickInfo : 'Fixed Asset Acquisition/Production Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_ACQN_PRODN_DATE'
    PL_AcquisitionProductionDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Acquisition Doc Type'
    @Common.Heading : 'Acquisition Document Type'
    @Common.QuickInfo : 'Acquisition Document Type'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_ACQN_DOC_TYPE'
    PL_AcquisitionDocumentType : String(1) not null;
    @Common.Label : 'OT Document Number'
    @Common.QuickInfo : 'Asset Acquisition Form/OT Document Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_ACQN_FORM_NMBR'
    PL_AcquisitionFormNumber : String(25) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'SAFT Asset Tax Group'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_AST_TAX_GROUP'
    PL_AssetTaxGroup : String(2) not null;
  };

  @cds.external : true
  type D_GlobCrteFxdAstTmeDepdntP {
    @Common.Label : 'Valid From'
    @Common.QuickInfo : 'Date for Beginning of Validity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ADATU'
    ValidityStartDate : Date;
    _CN_AuditDataExtraction : D_CN_CrteFxdAstAudDtaXtrctnP not null;
    _PL_TmDepSAFT : D_PL_CrteFxdAstTmeDepdntSAFTP not null;
  };

  @cds.external : true
  type SAP__Message {
    code : String not null;
    message : String not null;
    target : String;
    additionalTargets : many String not null;
    transition : Boolean not null;
    @odata.Type : 'Edm.Byte'
    numericSeverity : Integer not null;
    longtextUrl : String;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Fixed Asset'
  @Common.Messages : SAP__Messages
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.InsertRestrictions.Insertable : false
  @Capabilities.DeleteRestrictions.Deletable : false
  @Capabilities.UpdateRestrictions.Updatable : false
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_FixedAssetAssgmt', '_FixedAssetLedger', '_FixedAssetValuation' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Core.OptimisticConcurrency : [ 'LastChangeDateTime' ]
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions : [
    { Property: OriginalAcquisitionAmount, AllowedExpressions: 'MultiValue' }
  ]
  entity FixedAsset {
    @Core.ComputedDefaultValue : true
    @Common.IsUpperCase : true
    @Common.Label : 'Company Code'
    @Common.Heading : 'CoCd'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BUKRS'
    key CompanyCode : String(4) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Asset'
    @Common.QuickInfo : 'Main Asset Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN1'
    key MasterFixedAsset : String(12) not null;
    @Core.ComputedDefaultValue : true
    @Common.IsUpperCase : true
    @Common.Label : 'Subnumber'
    @Common.Heading : 'SNo.'
    @Common.QuickInfo : 'Asset Subnumber'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN2'
    key FixedAsset : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Completeness Status'
    AssetCompletenessStatus : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Lifecycle Status'
    AssetLifecycleStatus : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'AuC Status'
    @Common.Heading : 'Status of Asset under Construction'
    @Common.QuickInfo : 'Asset Under Construction Status'
    AssetUnderConstructionStatus : String(1) not null;
    @Core.Computed : true
    @Common.Label : 'Main Asset'
    @Common.QuickInfo : 'Indicator for Main Asset'
    IsMainAsset : Boolean not null;
    @Core.Computed : true
    @Common.Label : 'Post-Capitalization'
    @Common.QuickInfo : 'Fixed Asset with Post-Capitalization'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FAA_MD_XPOSTCAP'
    AssetIsForPostCapitalization : Boolean not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Asset Class'
    @Common.Heading : 'Class'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLKL'
    AssetClass : String(8) not null;
    @Common.Label : 'Master Data Layout'
    @Common.Heading : 'Layout'
    @Common.QuickInfo : 'Layout for Asset Master Data'
    AssetScreenLayout : String(20) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Account Determ.'
    @Common.Heading : 'Account Determination'
    @Common.QuickInfo : 'Account Determination'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KTOGR'
    AssetAccountDetermination : String(8) not null;
    @Common.Label : 'Description'
    @Common.Heading : 'Asset Description'
    @Common.QuickInfo : 'Asset Description'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TXA50_ANLT'
    FixedAssetDescription : String(50) not null;
    @Common.Label : 'Description (2)'
    @Common.Heading : 'Asset description (2)'
    @Common.QuickInfo : 'Additional asset description'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TXA50_MORE'
    AssetAdditionalDescription : String(50) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Serial Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AM_SERNR'
    AssetSerialNumber : String(18) not null;
    @Common.Label : 'Ordered On'
    @Common.Heading : 'PO Date'
    @Common.QuickInfo : 'Asset Purchase Order Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BSTDT'
    FixedAssetOrderDate : Date;
    @Core.Computed : true
    @Common.Label : 'Internal SAP Code'
    @Common.QuickInfo : 'Unit of Measurement, Internal SAP Code (No Conversion)'
    BaseUnitSAPCode : String(3) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'ISO Code'
    @Common.Heading : 'ISO'
    @Common.QuickInfo : 'ISO Code for Unit of Measurement'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ISOCD_UNIT'
    BaseUnitISOCode : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Supplier'
    @Common.QuickInfo : 'Account Number of Supplier (Other Key Word)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AM_LIFNR'
    Supplier : String(10) not null;
    @Common.Label : 'Purchased Used'
    @Common.QuickInfo : 'Asset Acquired Used'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=XAFABCH'
    AssetIsAcquiredUsed : Boolean not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Ctry/Reg. of Origin'
    @Common.QuickInfo : 'Asset''s Country/Region of Origin'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AM_LAND1'
    AssetCountryOfOrigin : String(3) not null;
    @Common.Label : 'Manufacturer'
    @Common.Heading : 'Manufacturer of Asset'
    @Common.QuickInfo : 'Manufacturer of Asset'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=HERST'
    AssetManufacturerName : String(30) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Original Asset'
    @Common.Heading : 'Orig. Asset'
    @Common.QuickInfo : 'Original Asset That Was Transferred'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AIBN1'
    OriginalMasterFixedAsset : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Asset Sub-No. AuC'
    @Common.Heading : 'SNo. AuC'
    @Common.QuickInfo : 'Original Asset That Was Transferred'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AIBN2'
    OriginalFixedAsset : String(4) not null;
    @Common.Label : 'Acq. Orig. Asset On'
    @Common.Heading : 'Aq.Org.Ast'
    @Common.QuickInfo : 'Original Acquisition Date of AuC/ Transferred Asset'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AIBDT'
    OriginalFixedAssetValueDate : Date;
    @Common.IsDigitSequence : true
    @Common.Label : 'Org.Acquisition Year'
    @Common.Heading : 'OrgYr'
    @Common.QuickInfo : 'Fiscal Year of Original Acquisition'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=URJHR'
    OriginalAcquisitionFiscalYear : String(4) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Orig Acq Crcy'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Original Acquisition Value Currency'
    OriginalAcquisitionCurrency : String(3) not null;
    @Measures.ISOCurrency : OriginalAcquisitionCurrency
    @Common.Label : 'Original Value'
    @Common.QuickInfo : 'Original Acquisition Value'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=URWRT'
    OriginalAcquisitionAmount : Decimal(precision: 13) not null;
    @Common.Label : 'In-House Prod. Perc.'
    @Common.Heading : 'In-H.Pro'
    @Common.QuickInfo : 'In-House Production Percentage'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANTEI'
    InHouseProdnPercent : Decimal(5, 2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Type name'
    @Common.QuickInfo : 'Asset type name'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TYPBZ_ANLA'
    AssetTypeName : String(15) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Trading Partner No.'
    @Common.Heading : 'Tr.Prt'
    @Common.QuickInfo : 'Company ID of Trading Partner'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=RASSC'
    PartnerCompany : String(6) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Inventory Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INVNR_ANLA'
    Inventory : String(25) not null;
    @Common.Label : 'Last Inventory On'
    @Common.Heading : 'Inv.Date'
    @Common.QuickInfo : 'Last Inventory Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=IVDAT_ANLA'
    LastInventoryDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Inventory Note'
    @Common.QuickInfo : 'Supplementary Inventory Specifications'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INVZU_ANLA'
    InventoryNote : String(15) not null;
    @Common.Label : 'Include Asset'
    @Common.Heading : 'II'
    @Common.QuickInfo : 'Inventory Indicator'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INKEN'
    InventoryIsCounted : Boolean not null;
    @Common.Label : 'Reorganization Date'
    @Common.Heading : 'Reorg.Date'
    @Common.QuickInfo : 'Date of Last Reorganization'
    LastReorganizationDate : Date;
    @Common.Label : 'Legacy Main No.'
    @Common.Heading : 'Legacy Main Asset Number'
    @Common.QuickInfo : 'Legacy Main Asset Number'
    LegacyMasterFixedAsset : String(80) not null;
    @Common.Label : 'Legacy Subnumber'
    @Common.Heading : 'Legacy Asset Subnumber'
    @Common.QuickInfo : 'Legacy Asset Subnumber'
    LegacyFixedAsset : String(5) not null;
    @Common.Label : 'Legacy Comp. Code'
    @Common.Heading : 'Legacy Fixed Asset Company Code'
    @Common.QuickInfo : 'Legacy Fixed Asset Company Code'
    LegacyFixedAssetCompanyCode : String(80) not null;
    @Common.Label : 'Transfer Date'
    @Common.QuickInfo : 'Legacy Data Transfer Date'
    LegacyDataTransferDate : Date;
    @Common.IsDigitSequence : true
    @Common.Label : 'Sequence Number'
    @Common.Heading : 'Seq.No.'
    @Common.QuickInfo : 'Legacy Data Transfer - sequence number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FAA_LDT_SEQNO'
    LegacyDataTransferSequence : String(5) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Created By'
    @Common.QuickInfo : 'Name of Person Responsible for Creating the Object'
    CreatedByUser : String(12) not null;
    @Common.Label : 'Created On'
    @Common.QuickInfo : 'Record Creation Date'
    CreationDate : Date;
    @odata.Precision : 0
    @odata.Type : 'Edm.DateTimeOffset'
    @Core.Computed : true
    @Common.Label : 'Time Stamp'
    @Common.QuickInfo : 'UTC Time Stamp in Short Form (YYYYMMDDhhmmss)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TIMESTAMP'
    CreationDateTime : DateTime;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Changed By'
    @Common.QuickInfo : 'Name of Person Who Changed Object'
    LastChangedByUser : String(12) not null;
    @Common.Label : 'Changed On'
    LastChangeDate : Date;
    @odata.Precision : 0
    @odata.Type : 'Edm.DateTimeOffset'
    @Core.Computed : true
    @Common.Label : 'Time Stamp'
    @Common.QuickInfo : 'UTC Time Stamp in Short Form (YYYYMMDDhhmmss)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TIMESTAMP'
    LastChangeDateTime : DateTime;
    SAP__Messages : many SAP__Message not null;
    @Common.Composition : true
    _FixedAssetAssgmt : Composition of many FixedAssetAssignment on _FixedAssetAssgmt._FixedAsset = $self;
    @Common.Composition : true
    _FixedAssetLedger : Composition of many FixedAssetLedger on _FixedAssetLedger._FixedAsset = $self;
    @Common.Composition : true
    _FixedAssetValuation : Composition of many FixedAssetValuation on _FixedAssetValuation._FixedAsset = $self;
  } actions {
    action CreateFixedAsset(
      @Common.FieldControl : #Mandatory
      @Common.IsUpperCase : true
      @Common.Label : 'Company Code'
      @Common.Heading : 'CoCd'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BUKRS'
      CompanyCode : String(4) not null,
      @Common.FieldControl : #Mandatory
      @Common.IsUpperCase : true
      @Common.Label : 'Asset'
      @Common.QuickInfo : 'Main Asset Number'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN1'
      MasterFixedAsset : String(12) not null,
      @Common.IsUpperCase : true
      @Common.Label : 'Subnumber'
      @Common.Heading : 'SNo.'
      @Common.QuickInfo : 'Asset Subnumber'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN2'
      FixedAsset : String(4) default null,
      @Common.IsUpperCase : true
      @Common.Label : 'Post-Capitalization'
      @Common.QuickInfo : 'Fixed Asset with Post-Capitalization'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FAA_MD_XPOSTCAP'
      AssetIsForPostCapitalization : Boolean,
      _AccountAssignment : D_CreateFixedAssetAcctAsgtP,
      _General : D_CreateFixedAssetGeneralP,
      _GlobMasterData : D_GlobCrteFxdAstTmeIndepP,
      _GlobTimeBasedMasterData : many D_GlobCrteFxdAstTmeDepdntP not null,
      _Inventory : D_CreateFixedAssetInventoryP,
      _Ledger : many D_CreateFixedAssetLedgerP not null,
      _Origin : D_CreateFixedAssetOriginP
    ) returns FixedAsset not null;
    action CreateMasterFixedAsset(
      @Common.FieldControl : #Mandatory
      @Common.IsUpperCase : true
      @Common.Label : 'Company Code'
      @Common.Heading : 'CoCd'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BUKRS'
      CompanyCode : String(4) not null,
      @Common.FieldControl : #Mandatory
      @Common.IsUpperCase : true
      @Common.Label : 'Asset Class'
      @Common.Heading : 'Class'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLKL'
      AssetClass : String(8) not null,
      @Common.IsUpperCase : true
      @Common.Label : 'Post-Capitalization'
      @Common.QuickInfo : 'Fixed Asset with Post-Capitalization'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FAA_MD_XPOSTCAP'
      AssetIsForPostCapitalization : Boolean,
      _AccountAssignment : D_CrteMstrFxdAstAcctAsgtP,
      _General : D_CrteMstrFxdAstGeneralP,
      _GlobMasterData : D_GlobCrteMstrFxdAstTmeIndepP,
      _GlobTimeBasedMasterData : many D_GlobCrteMstrFxdAstTmeDepdntP not null,
      _Inventory : D_CrteMstrFxdAstInventoryP ,
      _Ledger : many D_CrteMstrFxdAstLedgerP not null,
      _Origin : D_CrteMstrFxdAstOriginP,
      _Reference : D_CrteMstrFxdAstReferenceP
    ) returns FixedAsset not null;
    action Change(
      _AccountAssignment : many D_ChangeFixedAssetAcctAsgtP,
      _General : D_ChangeFixedAssetGeneralP,
      _GlobMasterData : D_GlobChgFxdAstTmeIndependentP,
      _GlobTimeBasedMasterData : many D_GlobChgFxdAstTmeDependentP not null,
      _Inventory : D_ChangeFixedAssetInventoryP,
      _Ledger : many D_ChangeFixedAssetLedgerP not null,
      _Origin : D_ChangeFixedAssetOriginP
    ) returns FixedAsset not null;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Fixed Asset Assignment'
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.InsertRestrictions.Insertable : false
  @Capabilities.DeleteRestrictions.Deletable : false
  @Capabilities.UpdateRestrictions.Updatable : false
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_FixedAsset' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  entity FixedAssetAssignment {
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Company Code'
    @Common.Heading : 'CoCd'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BUKRS'
    key CompanyCode : String(4) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Asset'
    @Common.QuickInfo : 'Main Asset Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN1'
    key MasterFixedAsset : String(12) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Subnumber'
    @Common.Heading : 'SNo.'
    @Common.QuickInfo : 'Asset Subnumber'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN2'
    key FixedAsset : String(4) not null;
    @Core.ComputedDefaultValue : true
    @Common.Label : 'Valid To'
    @Common.QuickInfo : 'Date Validity Ends'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BDATU'
    key ValidityEndDate : Date not null;
    @Common.Label : 'Valid From'
    @Common.QuickInfo : 'Date for Beginning of Validity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ADATU'
    ValidityStartDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Controlling Area'
    @Common.Heading : 'COAr'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KOKRS'
    ControllingArea : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Cost Center'
    @Common.Heading : 'Cost Ctr'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KOSTL'
    CostCenter : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'WBS Element'
    @Common.QuickInfo : 'Work Breakdown Structure Element (WBS Element) Edited'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PS_POSID_EDIT'
    WBSElementExternalID : String(24) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Profit Center'
    @Common.Heading : 'Profit Ctr'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PRCTR'
    ProfitCenter : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Segment'
    @Common.QuickInfo : 'Segment for Segmental Reporting'
    Segment : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Plant'
    @Common.Heading : 'Plnt'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WERKS_D'
    Plant : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Location'
    @Common.QuickInfo : 'Asset location'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=STORT'
    AssetLocation : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Room'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=RAUMNR'
    Room : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'License Plate Number'
    @Common.Heading : 'LicensePlateNo.'
    @Common.QuickInfo : 'License Plate No. of Vehicle'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AM_KFZKZ'
    VehicleLicensePlateNumber : String(15) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Tax Jurisdiction'
    @Common.Heading : 'Tax Jur.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TXJCD'
    TaxJurisdiction : String(15) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Business Place'
    @Common.Heading : 'BP'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BUPLA'
    BusinessPlace : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Fund'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BP_GEBER'
    Fund : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Grant'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GM_GRANT_NBR'
    GrantID : String(20) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Functional Area'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FKBER'
    FunctionalArea : String(16) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Reference Transact.'
    @Common.Heading : 'Ref. Tran.'
    @Common.QuickInfo : 'Reference Transaction'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AWTYP'
    ReferenceDocumentType : String(5) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Log. System Source'
    @Common.Heading : 'Log.System'
    @Common.QuickInfo : 'Logical System of Source Document'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AWSYS'
    LogicalSystem : String(10) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Reference Org. Unit'
    @Common.Heading : 'Ref.Org.Un'
    @Common.QuickInfo : 'Reference Organizational Units'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AWORG'
    ReferenceDocumentContext : String(10) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Reference Document'
    @Common.Heading : 'Ref. Doc.'
    @Common.QuickInfo : 'Reference Doc. Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AWREF'
    ReferenceDocument : String(10) not null;
    _FixedAsset : Association to one FixedAsset on _FixedAsset.FixedAsset = FixedAsset;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Globalization Fixed Asset'
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.InsertRestrictions.Insertable : false
  @Capabilities.DeleteRestrictions.Deletable : false
  @Capabilities.UpdateRestrictions.Updatable : false
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_FixedAsset' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  entity FixedAssetCountryData {
    @Common.IsUpperCase : true
    @Common.Label : 'Company Code'
    @Common.Heading : 'CoCd'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BUKRS'
    key CompanyCode : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Asset'
    @Common.QuickInfo : 'Main Asset Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN1'
    key MasterFixedAsset : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Subnumber'
    @Common.Heading : 'SNo.'
    @Common.QuickInfo : 'Asset Subnumber'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN2'
    key FixedAsset : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Asset Structure'
    @Common.QuickInfo : 'Japan: Asset Structure of Annex16'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_ANX16_STRC'
    JP_Annex16AssetStructure : String(5) not null;
    @Common.Label : 'Asset Structure Text'
    JP_Annex16AssetStructureDesc : String(50) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Asset Item'
    @Common.QuickInfo : 'Japan: Asset Item of Annex16'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_ANX16_ITEM'
    JP_Annex16AssetItem : String(5) not null;
    @Common.Label : 'Item Text'
    @Common.Heading : 'Asset Item Text'
    @Common.QuickInfo : 'Asset Item Text'
    JP_Annex16AssetItemDesc : String(50) not null;
    @Common.Label : 'Lease Agreement Date'
    @Common.Heading : 'Leas.Date'
    @Common.QuickInfo : 'Japan: Leasing Agreement Date of Annex16-4 Report'
    JP_Annex16LeasingAgrmtDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'City Code'
    @Common.QuickInfo : 'Japan: City Code of Property Tax Report'
    JP_PrptyTxRptCity : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Class. Key'
    @Common.Heading : 'Classification Key'
    @Common.QuickInfo : 'Japan: Classification Key of Property Tax Report'
    JP_PrptyTxRptClassfctnKey : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Spec.Depr. Code'
    @Common.Heading : 'Special Depreciation Code'
    @Common.QuickInfo : 'Japan: Special Depreciation Code of Property Tax Report'
    JP_PrptyTxRptSpclDepr : String(3) not null;
    @Common.Label : 'Additional Dep. Code'
    @Common.Heading : 'Additional Depreciation Code'
    @Common.QuickInfo : 'Additional Depreciation Code'
    JP_PrptyTxRptAddlDepr : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Block Key'
    @Common.QuickInfo : 'India: Block Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_BLK_KEY'
    IN_AssetBlock : String(5) not null;
    @Common.Label : 'Asset put to use'
    @Common.Heading : 'Asset put to use date'
    @Common.QuickInfo : 'India: Put to use date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_AST_PUT_USE'
    IN_AssetPutToUseDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Addnl Blk Key'
    @Common.Heading : 'Additional Depreciation Block Key'
    @Common.QuickInfo : 'India: Additional Depreciation Block Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_ADNL_BLK_KEY'
    IN_AdditionalAssetBlock : String(5) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'R & D Asset'
    @Common.QuickInfo : 'India: R & D Asset'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_R_AND_D_ASSET'
    IN_AssetIsResearchAndDev : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Prior year'
    @Common.Heading : 'Prior Year or Not for current year calculation'
    @Common.QuickInfo : 'India: Prior Year Transaction'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_IN_PRIOR_YR'
    IN_AssetIsPriorYear : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Vehicle Type'
    @Common.QuickInfo : 'Portugal: Vehicle Type'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_VEHICLETYPE'
    PT_VehicleTypeByEnergy : String(2) not null;
    @Common.Label : 'Veh. W/o. Limit'
    @Common.Heading : 'Is vehicle Without Limit'
    @Common.QuickInfo : 'Portugal: Is Vehicle Without Limit'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_ISVEHICLEWOLIMIT'
    PT_VehicleIsWithoutLimit : Boolean not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Repair Link'
    @Common.Heading : 'Repair Asset Link'
    @Common.QuickInfo : 'Portugal: Repair Asset Link'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_REPAIRASSETLINK'
    PT_BigRepairAssetLink : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Land Asset Link'
    @Common.QuickInfo : 'Portugal: Land Asset Link'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_LANDASSETLINK'
    PT_LandAssetLink : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Form Categ.'
    @Common.Heading : 'Report Form Category'
    @Common.QuickInfo : 'Portugal: Asset Report Form Category'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_ASSETREPFORMCAT'
    PT_AssetReportFormCategory : String(1) not null;
    @Common.Label : 'Amort. Reval.'
    @Common.Heading : 'Is Amort. Asset Revaluated'
    @Common.QuickInfo : 'Portugal: Is Amortized Asset Revaluated'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PT_ISAMASSETREVAL'
    PT_AmortizedAssetIsReevaluated : Boolean not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Exclusion Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_RS_EXCLUSION_YEAR'
    RS_GroupDeprExclusionYear : String(4) not null;
    @Common.Label : 'Last Invoice Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_RS_LAST_INVOICE_DATE'
    RS_AssetLastInvoiceDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Natl. Clfn. Code'
    @Common.Heading : 'National Classification Code'
    @Common.QuickInfo : 'National Classification Code'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_NATL_CLFN_CODE'
    NationalClassification : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Tax Depr. Group'
    @Common.Heading : 'Tax Depreciation Group'
    @Common.QuickInfo : 'Tax Depreciation Group'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_TAX_DEPR_GRP'
    TaxDepreciationGroup : String(4) not null;
    @Common.Label : 'Acqn./Prodn. Date'
    @Common.Heading : 'Date of Acquisition/Production'
    @Common.QuickInfo : 'Fixed Asset Acquisition/Production Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_ACQN_PRODN_DATE'
    PL_AcquisitionProductionDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Acquisition Doc Type'
    @Common.Heading : 'Acquisition Document Type'
    @Common.QuickInfo : 'Acquisition Document Type'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_ACQN_DOC_TYPE'
    PL_AcquisitionDocumentType : String(1) not null;
    @Common.Label : 'OT Document Number'
    @Common.QuickInfo : 'Asset Acquisition Form/OT Document Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_ACQN_FORM_NMBR'
    PL_AcquisitionFormNumber : String(25) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'SAFT Asset Tax Group'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_AST_TAX_GROUP'
    PL_AssetTaxGroup : String(2) not null;
    _FixedAsset : Association to one FixedAsset on _FixedAsset.FixedAsset = FixedAsset;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Fixed Asset Ledger'
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.InsertRestrictions.Insertable : false
  @Capabilities.DeleteRestrictions.Deletable : false
  @Capabilities.UpdateRestrictions.Updatable : false
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_FixedAsset' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  entity FixedAssetLedger {
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Company Code'
    @Common.Heading : 'CoCd'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BUKRS'
    key CompanyCode : String(4) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Asset'
    @Common.QuickInfo : 'Main Asset Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN1'
    key MasterFixedAsset : String(12) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Subnumber'
    @Common.Heading : 'SNo.'
    @Common.QuickInfo : 'Asset Subnumber'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN2'
    key FixedAsset : String(4) not null;
    @Core.ComputedDefaultValue : true
    @Common.IsUpperCase : true
    @Common.Label : 'Ledger'
    @Common.Heading : 'Ld'
    @Common.QuickInfo : 'Ledger in General Ledger Accounting'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FINS_LEDGER'
    key Ledger : String(2) not null;
    @Common.Label : 'Capitalized On'
    @Common.Heading : 'Cap.Date'
    @Common.QuickInfo : 'Asset Capitalization Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AKTIVD'
    AssetCapitalizationDate : Date;
    @Common.Label : 'Deactivation on'
    @Common.Heading : 'Deact.Date'
    @Common.QuickInfo : 'Deactivation Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=DEAKT'
    AssetDeactivationDate : Date;
    @Common.Label : 'First Acquisition on'
    @Common.QuickInfo : 'Asset Value Date of the First Posting'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=DZUGDAT'
    AcquisitionValueDate : Date;
    @Common.IsDigitSequence : true
    @Common.Label : 'FY 1st Acquisition'
    @Common.Heading : 'AcqY'
    @Common.QuickInfo : 'Fiscal Year in Which First Acquisition Was Posted'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=DZUJAHR'
    FirstAcquisitionFiscalYear : String(4) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Per. 1st Acquisition'
    @Common.Heading : 'PAq'
    @Common.QuickInfo : 'Period in Which First Acquisition Was Posted'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=DZUPER'
    FirstAcquisitionFiscalPeriod : String(3) not null;
    _FixedAsset : Association to one FixedAsset on _FixedAsset.FixedAsset = FixedAsset;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Fixed Asset Time-based Valuation'
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.InsertRestrictions.Insertable : false
  @Capabilities.DeleteRestrictions.Deletable : false
  @Capabilities.UpdateRestrictions.Updatable : false
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_FixedAsset', '_FixedAssetValuation' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions : [
    { Property: ScrapAmountInCoCodeCrcy, AllowedExpressions: 'MultiValue' },
    { Property: ScrapAmountInGlobCrcy, AllowedExpressions: 'MultiValue' },
    {
      Property: ScrapAmountInFreeDefinedCrcy1,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: ScrapAmountInFreeDefinedCrcy2,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: ScrapAmountInFreeDefinedCrcy3,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: ScrapAmountInFreeDefinedCrcy4,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: ScrapAmountInFreeDefinedCrcy5,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: ScrapAmountInFreeDefinedCrcy6,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: ScrapAmountInFreeDefinedCrcy7,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: ScrapAmountInFreeDefinedCrcy8,
      AllowedExpressions: 'MultiValue'
    }
  ]
  entity FixedAssetTimeBasedValuation {
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Company Code'
    @Common.Heading : 'CoCd'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BUKRS'
    key CompanyCode : String(4) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Asset'
    @Common.QuickInfo : 'Main Asset Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN1'
    key MasterFixedAsset : String(12) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Subnumber'
    @Common.Heading : 'SNo.'
    @Common.QuickInfo : 'Asset Subnumber'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN2'
    key FixedAsset : String(4) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Ledger'
    @Common.Heading : 'Ld'
    @Common.QuickInfo : 'Ledger in General Ledger Accounting'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FINS_LEDGER'
    key Ledger : String(2) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Depreciation Area'
    @Common.Heading : 'Ar.'
    @Common.QuickInfo : 'Depreciation Area Real or Derived'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AFABER'
    key AssetDepreciationArea : String(2) not null;
    @Core.ComputedDefaultValue : true
    @Common.Label : 'Valid To'
    @Common.QuickInfo : 'Date Validity Ends'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BDATU'
    key ValidityEndDate : Date not null;
    @Common.Label : 'Valid From'
    @Common.QuickInfo : 'Date for Beginning of Validity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ADATU'
    ValidityStartDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Depreciation Key'
    @Common.Heading : 'DepKy'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AFASL'
    DepreciationKey : String(4) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Useful Life'
    @Common.Heading : 'Use'
    @Common.QuickInfo : 'Planned Useful Life in Years'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NDJAR'
    PlannedUsefulLifeInYears : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Usef.Life in Periods'
    @Common.Heading : 'Per'
    @Common.QuickInfo : 'Planned Useful Life in Periods'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NDPER'
    PlannedUsefulLifeInPeriods : String(3) not null;
    @Common.Label : 'Variable Dep.Portion'
    @Common.Heading : 'Var.Prtn'
    @Common.QuickInfo : 'Variable Depreciation Portion'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=APROP'
    VariableDeprPercent : Decimal(7, 4) not null;
    @Common.Label : 'Scrap Value Percent'
    @Common.Heading : 'Scrap Val. [%]'
    @Common.QuickInfo : 'Scrap Value as Percentage of APC'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SCHRW_PROZ'
    AcqnProdnCostScrapPercent : Decimal(14, 11) not null;
    @Common.Label : 'Percentage'
    @Common.Heading : 'Base Value Percentage'
    @Common.QuickInfo : 'Base Value Percentage'
    DeprCalcBaseValuePercent : Decimal(16, 13) not null;
    @Common.Label : 'Shift Factor'
    @Common.Heading : 'MSFac'
    @Common.QuickInfo : 'Multiple-Shift Factor for Multiple Shift Operation'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MSFAK'
    ShiftOperationFactor : Decimal(3, 2) not null;
    @Common.Label : 'Asset Shutdown'
    @Common.Heading : 'Sdown'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=XSTIL'
    IsShutDown : Boolean not null;
    @Measures.ISOCurrency : CompanyCodeCurrency
    @Common.Label : 'Value in CompCd Crcy'
    @Common.Heading : 'Scrap Val in CC Crcy'
    @Common.QuickInfo : 'Scrap Value in Company Code Currency'
    ScrapAmountInCoCodeCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : GlobalCurrency
    @Common.Label : 'Value in Gl. Crcy'
    @Common.Heading : 'Scrap Value in Gl. Crcy'
    @Common.QuickInfo : 'Scrap Value in Global Currency'
    ScrapAmountInGlobCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency1
    @Common.Label : 'Value in Currency 1'
    @Common.Heading : 'Scrap Value in Crcy 1'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 1'
    ScrapAmountInFreeDefinedCrcy1 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency2
    @Common.Label : 'Value in Currency 2'
    @Common.Heading : 'Scrap Value in Crcy 2'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 2'
    ScrapAmountInFreeDefinedCrcy2 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency3
    @Common.Label : 'Value in Currency 3'
    @Common.Heading : 'Scrap Value in Crcy 3'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 3'
    ScrapAmountInFreeDefinedCrcy3 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency4
    @Common.Label : 'Value in Currency 4'
    @Common.Heading : 'Scrap Value in Crcy 4'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 4'
    ScrapAmountInFreeDefinedCrcy4 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency5
    @Common.Label : 'Value in Currency 5'
    @Common.Heading : 'Scrap Value in Crcy 5'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 5'
    ScrapAmountInFreeDefinedCrcy5 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency6
    @Common.Label : 'Value in Currency 6'
    @Common.Heading : 'Scrap Value in Crcy 6'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 6'
    ScrapAmountInFreeDefinedCrcy6 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency7
    @Common.Label : 'Value in Currency 7'
    @Common.Heading : 'Scrap Value in Crcy 7'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 7'
    ScrapAmountInFreeDefinedCrcy7 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency8
    @Common.Label : 'Value in Currency 8'
    @Common.Heading : 'Scrap Value in Crcy 8'
    @Common.QuickInfo : 'Scrap Value in Freely Defined Currency 8'
    ScrapAmountInFreeDefinedCrcy8 : Decimal(precision: 23) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    CompanyCodeCurrency : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    GlobalCurrency : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    FreeDefinedCurrency1 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    FreeDefinedCurrency2 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    FreeDefinedCurrency3 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    FreeDefinedCurrency4 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    FreeDefinedCurrency5 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    FreeDefinedCurrency6 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    FreeDefinedCurrency7 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    FreeDefinedCurrency8 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    FunctionalCurrency : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Usage Object'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FAA_UO'
    FixedAssetUsageObject : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Revaluation Index ID'
    @Common.Heading : 'Asset Revaluation: Index ID'
    @Common.QuickInfo : 'Asset Revaluation: Index ID'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FAA_RV_INDEX_ID'
    AssetRevaluationIndex : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Calc. View Type'
    @Common.Heading : 'Calculation View Type'
    @Common.QuickInfo : 'Calculation View Type'
    DepreciationAreaType : String(1) not null;
    _FixedAsset : Association to one FixedAsset on _FixedAsset.FixedAsset = FixedAsset;
    _FixedAssetValuation : Association to one FixedAssetValuation on _FixedAssetValuation.AssetDepreciationArea = AssetDepreciationArea;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Fixed Asset Valuation'
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.InsertRestrictions.Insertable : false
  @Capabilities.DeleteRestrictions.Deletable : false
  @Capabilities.UpdateRestrictions.Updatable : false
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_FixedAsset', '_FixedAssetTimeBasedValn' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  entity FixedAssetValuation {
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Company Code'
    @Common.Heading : 'CoCd'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BUKRS'
    key CompanyCode : String(4) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Asset'
    @Common.QuickInfo : 'Main Asset Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN1'
    key MasterFixedAsset : String(12) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Subnumber'
    @Common.Heading : 'SNo.'
    @Common.QuickInfo : 'Asset Subnumber'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN2'
    key FixedAsset : String(4) not null;
    @Core.ComputedDefaultValue : true
    @Common.IsUpperCase : true
    @Common.Label : 'Ledger'
    @Common.Heading : 'Ld'
    @Common.QuickInfo : 'Ledger in General Ledger Accounting'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FINS_LEDGER'
    key Ledger : String(2) not null;
    @Core.ComputedDefaultValue : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Depreciation Area'
    @Common.Heading : 'Ar.'
    @Common.QuickInfo : 'Depreciation Area Real or Derived'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AFABER'
    key AssetDepreciationArea : String(2) not null;
    @Common.Label : 'Negative Val.Allowed'
    @Common.Heading : 'Neg'
    @Common.QuickInfo : 'Indicator: Negative Values Allowed'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=XNEGA'
    NegativeAmountIsAllowed : Boolean not null;
    @Common.Label : 'Depreciation Calculation Start Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FIS_AFABG'
    DepreciationStartDate : Date;
    @Common.Label : 'Special Depreciation'
    @Common.Heading : 'SDep.Start'
    @Common.QuickInfo : 'Start Date for Special Depreciation'
    SpecialDeprStartDate : Date;
    @Common.Label : 'Interest Calculation'
    @Common.Heading : 'Int.Start'
    @Common.QuickInfo : 'Start Date for Interest Calculation'
    InterestCalcStartDate : Date;
    @Common.Label : 'Operating Readiness'
    @Common.QuickInfo : 'Asset Accounting:  Date of Operating Readiness'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INBDA'
    AssetOpgReadinessDate : Date;
    @Common.IsDigitSequence : true
    @Common.Label : 'Changeover Year'
    @Common.Heading : 'ChYr'
    @Common.QuickInfo : 'Depreciation Key for the Changeover Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=UMJAR'
    DeprKeyChangeoverYear : String(4) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Changeover Period'
    @Common.Heading : 'ChPrd'
    @Common.QuickInfo : 'Changeover Period of Depreciation Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=UMPER'
    DeprKeyChangeoverPeriod : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Low-Val. Asset Check'
    @Common.Heading : 'LVA'
    @Common.QuickInfo : 'LVA: Maximum Amount Check and Quantity Check'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=XGWGK'
    LowValueAssetAmountCheckType : String(1) not null;
    @Common.Label : 'Last retmt. on'
    @Common.Heading : 'Last ret.'
    @Common.QuickInfo : 'Value date of last retirement for the depreciation area'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ABGDAT_B'
    LastRetirementValueDate : Date;
    @Common.IsDigitSequence : true
    @Common.Label : 'Last Fiscal Yr.'
    @Common.Heading : 'LstFY'
    @Common.QuickInfo : 'Last Fiscal Year for the Annual Values in Asset Acct.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LGJAN'
    AssetCurrentFiscalYear : String(4) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Period Scaling'
    @Common.Heading : 'Period Scale'
    @Common.QuickInfo : 'Period Scaling in Depreciation Start Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PERFY'
    AssetNumberOfPeriods : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Calc. View Type'
    @Common.Heading : 'Calculation View Type'
    @Common.QuickInfo : 'Calculation View Type'
    DepreciationAreaType : String(1) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Expired Useful Life'
    @Common.Heading : 'EUL'
    @Common.QuickInfo : 'Expired Useful Life in Years at Start of the Fiscal Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NDABJ'
    ExpiredUsefulLifeInYrs : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Expired UL Periods'
    @Common.Heading : 'ELP'
    @Common.QuickInfo : 'Expired Useful Life in Periods at Start of Fiscal Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NDABP'
    ExpiredUsefulLifeInPerds : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Exp.spec.dep. life'
    @Common.Heading : 'DSL'
    @Common.QuickInfo : 'Yrs Expired up to Fisc.Yr Start from Start of Spec.Dep.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANDSJ'
    SpclExpiredUsefulLifeInYrs : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Exp.UL Periods SDep.'
    @Common.Heading : 'DLP'
    @Common.QuickInfo : 'Expired Useful Life in Periods during FY from SDep Start Dat'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANDSP'
    SpclExpiredUsefulLifeInPerds : String(3) not null;
    _FixedAsset : Association to one FixedAsset on _FixedAsset.FixedAsset = FixedAsset;
    @Common.Composition : true
    _FixedAssetTimeBasedValn : Composition of many FixedAssetTimeBasedValuation on _FixedAssetTimeBasedValn._FixedAssetValuation = $self;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Globalization Fixed Asset Assignment'
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.InsertRestrictions.Insertable : false
  @Capabilities.DeleteRestrictions.Deletable : false
  @Capabilities.UpdateRestrictions.Updatable : false
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_FixedAsset' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  entity GlobAssetAssignment {
    @Common.IsUpperCase : true
    @Common.Label : 'Company Code'
    @Common.Heading : 'CoCd'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BUKRS'
    key CompanyCode : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Asset'
    @Common.QuickInfo : 'Main Asset Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN1'
    key MasterFixedAsset : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Subnumber'
    @Common.Heading : 'SNo.'
    @Common.QuickInfo : 'Asset Subnumber'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN2'
    key FixedAsset : String(4) not null;
    @Common.Label : 'Valid To'
    @Common.QuickInfo : 'Date Validity Ends'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BDATU'
    key ValidityEndDate : Date not null;
    @Common.Label : 'Valid From'
    @Common.QuickInfo : 'Date for Beginning of Validity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ADATU'
    ValidityStartDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Usage Code'
    @Common.QuickInfo : 'China: CADE Fixed Asset Usage Type'
    CN_CADEFixedAssetUsage : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Customer Acc.Invoice'
    @Common.Heading : 'Customer Invoice Accounting Document'
    @Common.QuickInfo : 'Customer Invoice Accounting Document'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_CUST_INVC_ACCTG_DOC'
    PL_CustInvcAccountingDocument : String(10) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Fiscal Year'
    @Common.Heading : 'Customer Invoice Fiscal Year'
    @Common.QuickInfo : 'Customer Invoice Fiscal Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_PL_CUST_INVC_FSCL_YR'
    PL_CustomerInvoiceFiscalYear : String(4) not null;
    _FixedAsset : Association to one FixedAsset on _FixedAsset.FixedAsset = FixedAsset;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Globalization Fixed Asset Time-based Valuation'
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.InsertRestrictions.Insertable : false
  @Capabilities.DeleteRestrictions.Deletable : false
  @Capabilities.UpdateRestrictions.Updatable : false
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_FixedAsset', '_FixedAssetValuation' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions : [
    {
      Property: JP_ImpAcqnProdCostAmtInCCCrcy,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: JP_ImpAcqnProdCostAmtInGCrcy,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: JP_ImpAcqnProdCostAmtInFDCrcy1,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: JP_ImpAcqnProdCostAmtInFDCrcy2,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: JP_ImpAcqnProdCostAmtInFDCrcy3,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: JP_ImpAcqnProdCostAmtInFDCrcy4,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: JP_ImpAcqnProdCostAmtInFDCrcy5,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: JP_ImpAcqnProdCostAmtInFDCrcy6,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: JP_ImpAcqnProdCostAmtInFDCrcy7,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: JP_ImpAcqnProdCostAmtInFDCrcy8,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: JP_AftImprmtBookAmtInCCCrcy,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: JP_AftImprmtBookAmtInGlobCrcy,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: JP_AftImprmtBookAmtInFDCrcy1,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: JP_AftImprmtBookAmtInFDCrcy2,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: JP_AftImprmtBookAmtInFDCrcy3,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: JP_AftImprmtBookAmtInFDCrcy4,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: JP_AftImprmtBookAmtInFDCrcy5,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: JP_AftImprmtBookAmtInFDCrcy6,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: JP_AftImprmtBookAmtInFDCrcy7,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: JP_AftImprmtBookAmtInFDCrcy8,
      AllowedExpressions: 'MultiValue'
    }
  ]
  entity GlobAssetTimeBasedValuation {
    @Common.IsUpperCase : true
    @Common.Label : 'Company Code'
    @Common.Heading : 'CoCd'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BUKRS'
    key CompanyCode : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Asset'
    @Common.QuickInfo : 'Main Asset Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN1'
    key MasterFixedAsset : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Subnumber'
    @Common.Heading : 'SNo.'
    @Common.QuickInfo : 'Asset Subnumber'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN2'
    key FixedAsset : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Ledger'
    @Common.Heading : 'Ld'
    @Common.QuickInfo : 'Ledger in General Ledger Accounting'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FINS_LEDGER'
    key Ledger : String(2) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Depreciation Area'
    @Common.Heading : 'Ar.'
    @Common.QuickInfo : 'Depreciation Area Real or Derived'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AFABER'
    key AssetDepreciationArea : String(2) not null;
    @Common.Label : 'Valid To'
    @Common.QuickInfo : 'Date Validity Ends'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BDATU'
    key ValidityEndDate : Date not null;
    @Common.Label : 'Valid From'
    @Common.QuickInfo : 'Date for Beginning of Validity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ADATU'
    ValidityStartDate : Date;
    @Common.Label : 'Impairment Post Date'
    @Common.Heading : 'Impairment posting Date'
    @Common.QuickInfo : 'Japan: Impairment Posting Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLO_JP_DI'
    JP_ImpairmentPostingDate : Date;
    @Measures.ISOCurrency : CompanyCodeCurrency
    @Common.Label : 'APC in Co. Code Crcy'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Company Code Crcy'
    JP_ImpAcqnProdCostAmtInCCCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : GlobalCurrency
    @Common.Label : 'APC in Global Crcy'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Global Currency'
    JP_ImpAcqnProdCostAmtInGCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency1
    @Common.Label : 'APC in Currency 1'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy1'
    JP_ImpAcqnProdCostAmtInFDCrcy1 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency2
    @Common.Label : 'APC in Currency 2'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy2'
    JP_ImpAcqnProdCostAmtInFDCrcy2 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency3
    @Common.Label : 'APC in Currency 3'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy3'
    JP_ImpAcqnProdCostAmtInFDCrcy3 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency4
    @Common.Label : 'APC in Currency 4'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy4'
    JP_ImpAcqnProdCostAmtInFDCrcy4 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency5
    @Common.Label : 'APC in Currency 5'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy5'
    JP_ImpAcqnProdCostAmtInFDCrcy5 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency6
    @Common.Label : 'APC in Currency 6'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy6'
    JP_ImpAcqnProdCostAmtInFDCrcy6 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency7
    @Common.Label : 'APC in Currency 7'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy7'
    JP_ImpAcqnProdCostAmtInFDCrcy7 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency8
    @Common.Label : 'APC in Currency 8'
    @Common.QuickInfo : 'Japan: APC Amount at Impairment Posting in Freely Dfnd Crcy8'
    JP_ImpAcqnProdCostAmtInFDCrcy8 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : CompanyCodeCurrency
    @Common.Label : 'BAI in Co. Code Crcy'
    @Common.QuickInfo : 'Japan: Book Value After Impairment Posting in Co. Code Crcy'
    JP_AftImprmtBookAmtInCCCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : GlobalCurrency
    @Common.Label : 'BAI in Global Crcy'
    @Common.QuickInfo : 'Japan: Book Value After Impairment Posting in Global Crcy'
    JP_AftImprmtBookAmtInGlobCrcy : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency1
    @Common.Label : 'BAI in Currency 1'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy1'
    JP_AftImprmtBookAmtInFDCrcy1 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency2
    @Common.Label : 'BAI in Currency 2'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy2'
    JP_AftImprmtBookAmtInFDCrcy2 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency3
    @Common.Label : 'BAI in Currency 3'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy3'
    JP_AftImprmtBookAmtInFDCrcy3 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency4
    @Common.Label : 'BAI in Currency 4'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy4'
    JP_AftImprmtBookAmtInFDCrcy4 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency5
    @Common.Label : 'BAI in Currency 5'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy5'
    JP_AftImprmtBookAmtInFDCrcy5 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency6
    @Common.Label : 'BAI in Currency 6'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy6'
    JP_AftImprmtBookAmtInFDCrcy6 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency7
    @Common.Label : 'BAI in Currency 7'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy7'
    JP_AftImprmtBookAmtInFDCrcy7 : Decimal(precision: 23) not null;
    @Measures.ISOCurrency : FreeDefinedCurrency8
    @Common.Label : 'BAI in Currency 8'
    @Common.QuickInfo : 'Japan: Book Value After Imprmt Posting in Freely Dfnd Crcy8'
    JP_AftImprmtBookAmtInFDCrcy8 : Decimal(precision: 23) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Capital Impr.Year'
    @Common.Heading : 'Capital Improvement Year'
    @Common.QuickInfo : 'Slovakia: Capital Improvement Year'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GLOFAA_SK_CPTL_IMPRV_YEAR'
    SK_CapitalImprovementYear : String(4) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    CompanyCodeCurrency : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    GlobalCurrency : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    FreeDefinedCurrency1 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    FreeDefinedCurrency2 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    FreeDefinedCurrency3 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    FreeDefinedCurrency4 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    FreeDefinedCurrency5 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    FreeDefinedCurrency6 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    FreeDefinedCurrency7 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    FreeDefinedCurrency8 : String(3) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    FunctionalCurrency : String(3) not null;
    _FixedAsset : Association to one FixedAsset on _FixedAsset.FixedAsset = FixedAsset;
    _FixedAssetValuation : Association to one FixedAssetValuation {  };
  };
};

