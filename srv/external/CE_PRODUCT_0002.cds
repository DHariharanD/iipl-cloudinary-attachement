/* checksum : 29a190ec7894b65fe200be5522c16061 */
@cds.external                                       : true
@CodeList.UnitsOfMeasure.Url                        : '../../../../default/iwbep/common/0001/$metadata'
@CodeList.UnitsOfMeasure.CollectionPath             : 'UnitsOfMeasure'
@CodeList.CurrencyCodes.Url                         : '../../../../default/iwbep/common/0001/$metadata'
@CodeList.CurrencyCodes.CollectionPath              : 'Currencies'
@Common.ApplyMultiUnitBehaviorForSortingAndFiltering: true
@Capabilities.FilterFunctions                       : [
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
@Capabilities.SupportedFormats                      : [
  'application/json',
  'application/pdf'
]
@PDF.Features.DocumentDescriptionReference          : '../../../../default/iwbep/common/0001/$metadata'
@PDF.Features.DocumentDescriptionCollection         : 'MyDocumentDescriptions'
@PDF.Features.ArchiveFormat                         : true
@PDF.Features.Border                                : true
@PDF.Features.CoverPage                             : true
@PDF.Features.FitToPage                             : true
@PDF.Features.FontName                              : true
@PDF.Features.FontSize                              : true
@PDF.Features.HeaderFooter                          : true
@PDF.Features.IANATimezoneFormat                    : true
@PDF.Features.Margin                                : true
@PDF.Features.Padding                               : true
@PDF.Features.ResultSizeDefault                     : 20000
@PDF.Features.ResultSizeMaximum                     : 20000
@PDF.Features.Signature                             : true
@PDF.Features.TextDirectionLayout                   : true
@PDF.Features.Treeview                              : true
@PDF.Features.UploadToFileShare                     : true
@Capabilities.KeyAsSegmentSupported                 : true
@Capabilities.AsynchronousRequestsSupported         : true
service CE_PRODUCT_0002 {
  @cds.external                                                    : true
  @cds.persistence.skip                                            : true
  @Common.Label                                                    : 'Product'
  @Common.Messages                                                 : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties        : [

    {
      NavigationProperty: _ProductDescription,
      InsertRestrictions: {Insertable: true}
    },
    {
      NavigationProperty: _ProductUnitOfMeasure,
      InsertRestrictions: {Insertable: true}
    },
  ]
  @Capabilities.SearchRestrictions.Searchable                      : false
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported            : true
  @Capabilities.UpdateRestrictions.NonUpdatableProperties          : ['Product']
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: [
    '_ProductDescription',
    '_ProductUnitOfMeasure',
  ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported               : true
  @Capabilities.DeleteRestrictions.Deletable                       : false
  @Core.OptimisticConcurrency                                      : ['LastChangeDateTime']
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions    : [{
    Property          : WeightUnit,
    AllowedExpressions: 'MultiValue'
  }, ]
  entity Product {
        @Core.Immutable                   : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Product'
        @Common.QuickInfo                 : 'Product Number'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTNUMBER'
    key Product        : String(40) not null;

        @Common.SAPObjectNodeTypeReference: 'ProductType'
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Product Type'
        @Common.Heading                   : 'PTyp'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTTYPE'
        ProductType    : String(4) not null;
        BaseUnit       : String(3) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Base unit ISO code'
        @Common.Heading                   : 'BUI'
        @Common.QuickInfo                 : 'Base unit of measure in ISO code'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=MEINS_ISO'
        BaseISOUnit    : String(3) not null;

        @Common.SAPObjectNodeTypeReference: 'ProductItemCategoryGroup'
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Gen. item cat. grp'
        @Common.Heading                   : 'ItCGr'
        @Common.QuickInfo                 : 'General item category group'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=MTPOS_MARA'
        to_Description : Association to one ProductDescription
                           on  to_Description.Product  = $self.Product
                           and to_Description.Language = 'EN';
        to_WeightUnit  : Association to one ProductUnitOfMeasure
                           on to_WeightUnit.Product = $self.Product;
  };


  @cds.external                                                    : true
  @cds.persistence.skip                                            : true
  @Common.Label                                                    : 'Product Description'
  @Capabilities.SearchRestrictions.Searchable                      : false
  @Capabilities.InsertRestrictions.RequiredProperties              : ['Language']
  @Capabilities.InsertRestrictions.Insertable                      : false
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported            : true
  @Capabilities.UpdateRestrictions.NonUpdatableProperties          : ['Language']
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: ['_Product']
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported               : true
  @Core.OptimisticConcurrency                                      : ['_Product/LastChangeDateTime']
  entity ProductDescription {
        @Core.Computed          : true
        @Common.IsUpperCase     : true
        @Common.Label           : 'Product'
        @Common.QuickInfo       : 'Product Number'
        @Common.DocumentationRef: 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTNUMBER'
    key Product            : String(40) not null;

        @Core.Immutable         : true
        @Common.Label           : 'Language Key'
        @Common.Heading         : 'Language'
        @Common.DocumentationRef: 'urn:sap-com:documentation:key?=type=DE&id=SPRAS'
    key Language           : String(2) not null;

        @Common.Label           : 'Product Description'
        @Common.DocumentationRef: 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTDESCRIPTION'
        ProductDescription : String(40) not null;
        _Product           : Association to one Product
                               on _Product.Product = Product;
  };

  @cds.external                                                    : true
  @cds.persistence.skip                                            : true
  @Common.Label                                                    : 'Product Unit of Measure'
  @Capabilities.NavigationRestrictions.RestrictedProperties        : [{
    NavigationProperty: _ProductUnitOfMeasureEAN,
    InsertRestrictions: {Insertable: true}
  }]
  @Capabilities.SearchRestrictions.Searchable                      : false
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported            : true
  @Capabilities.UpdateRestrictions.NonUpdatableProperties          : [
    'AlternativeSAPUnit',
    'AlternativeISOUnit'
  ]
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: [
    '_Product',
    '_ProductUnitOfMeasureEAN'
  ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported               : true
  @Capabilities.InsertRestrictions.Insertable                      : false
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions    : [{Property: WeightUnit, }, ]
  entity ProductUnitOfMeasure {
        @Core.Computed          : true
        @Common.IsUpperCase     : true
        @Common.Label           : 'Product'
        @Common.QuickInfo       : 'Product Number'
        @Common.DocumentationRef: 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTNUMBER'
    key Product    : String(40) not null;

        @Common.IsUnit          : true
        @Common.Label           : 'Unit of Weight'
        @Common.Heading         : 'WUn'
        @Common.DocumentationRef: 'urn:sap-com:documentation:key?=type=DE&id=GEWEI'
        WeightUnit : String(3) not null;
        _Product   : Association to one Product
                       on _Product.Product = Product;
  };

  @cds.external                                                    : true
  @cds.persistence.skip                                            : true
  @Common.Label                                                    : 'Product Valuation'
  @Common.Messages                                                 : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties        : [
    {
      NavigationProperty: _Product,
      InsertRestrictions: {Insertable: false},
      DeepUpdateSupport : {Supported: false}
    },
    {
      NavigationProperty: _ProductValuationAccounting,
      InsertRestrictions: {Insertable: true}
    },
    {
      NavigationProperty: _ProductValuationCosting,
      InsertRestrictions: {Insertable: true}
    },
    {
      NavigationProperty: _ProductValuationLedgerAccount,
      InsertRestrictions: {Insertable: true}
    },
    {
      NavigationProperty: _ProductValuationLedgerPrices,
      InsertRestrictions: {Insertable: true}
    }
  ]
  @Capabilities.SearchRestrictions.Searchable                      : false
  @Capabilities.InsertRestrictions.RequiredProperties              : ['ValuationArea']
  @Capabilities.InsertRestrictions.Insertable                      : false
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported            : true
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: [
    '_Product',
    '_ProductValuationAccounting',
    '_ProductValuationCosting',
    '_ProductValuationLedgerAccount',
    '_ProductValuationLedgerPrices'
  ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported               : true
  @Capabilities.DeleteRestrictions.Deletable                       : false
  @Core.OptimisticConcurrency                                      : ['_Product/LastChangeDateTime']
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions    : [
    {
      Property          : StandardPrice,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : ProductPriceUnitQuantity,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : MovingAveragePrice,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : BaseUnit,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : BaseISOUnit,
      AllowedExpressions: 'MultiValue'
    }
  ]
  entity ProductValuation {
        @Core.Computed                    : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Product'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTNUMBER'
    key Product                        : String(40) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Valuation Area'
        @Common.Heading                   : 'ValA'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=BWKEY'
    key ValuationArea                  : String(4) not null;

        @Common.SAPObjectNodeTypeReference: 'ProductValuationType'
        @Core.ComputedDefaultValue        : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Valuation Type'
        @Common.Heading                   : 'Val. Type'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=BWTAR_D'
    key ValuationType                  : String(10) not null;

        @Common.SAPObjectNodeTypeReference: 'ProductValuationClass'
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Valuation Class'
        @Common.Heading                   : 'ValCl'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=BKLAS'
        ValuationClass                 : String(4) not null;

        @Common.SAPObjectNodeTypeReference: 'PriceDeterminationControl'
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Price Determ.'
        @Common.Heading                   : 'Price Determination'
        @Common.QuickInfo                 : 'Material Price Determination: Control'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=CK_ML_ABST'
        PriceDeterminationControl      : String(1) not null;

        @Measures.ISOCurrency             : Currency
        @Common.Label                     : 'Standard price'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=STPRS'
        StandardPrice                  : Decimal (precision : 11) not null;

        @Measures.Unit                    : BaseUnit
        @Measures.UNECEUnit               : BaseISOUnit
        @Common.Label                     : 'Price Unit'
        @Common.Heading                   : 'per'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PEINH'
        ProductPriceUnitQuantity       : Decimal (precision : 5) not null;

        @Common.SAPObjectNodeTypeReference: 'ProductPriceControl'
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Price Control'
        @Common.Heading                   : 'Pr.'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=INVENTORYVALUATIONPROCEDURE'
        InventoryValuationProcedure    : String(1) not null;

        @Measures.ISOCurrency             : Currency
        @Common.Label                     : 'Moving price'
        @Common.Heading                   : 'MovAvgPrice'
        @Common.QuickInfo                 : 'Moving Average Price/Periodic Unit Price'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=VERPR'
        MovingAveragePrice             : Decimal (precision : 11) not null;

        @Common.SAPObjectNodeTypeReference: 'ProductValuationCategory'
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Valuation Category'
        @Common.Heading                   : 'ValCat'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=BWTTY_D'
        ValuationCategory              : String(1) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Product Usage'
        @Common.Heading                   : 'U'
        @Common.QuickInfo                 : 'Usage of the Product'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTUSAGETYPE'
        ProductUsageType               : String(1) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Product Origin'
        @Common.Heading                   : 'O'
        @Common.QuickInfo                 : 'Origin of the Product'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTORIGINTYPE'
        ProductOriginType              : String(1) not null;

        @Common.Label                     : 'In-House Production'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=J_1BOWNPRO'
        IsProducedInhouse              : Boolean not null;

        @Common.Label                     : 'Del. flag val. type'
        @Common.Heading                   : 'VTy'
        @Common.QuickInfo                 : 'Deletion flag for all material data of a valuation type'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=LVOBA'
        IsMarkedForDeletion            : Boolean not null;

        @Common.SAPObjectNodeTypeReference: 'ProductValuationClass'
        @Common.IsUpperCase               : true
        @Common.Label                     : 'VC: Sales Order Stk'
        @Common.Heading                   : 'VCl S'
        @Common.QuickInfo                 : 'Valuation Class for Sales Order Stock'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=EKLAS'
        ValuationClassSalesOrderStock  : String(4) not null;

        @Common.SAPObjectNodeTypeReference: 'ProductValuationClass'
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Proj. stk val. class'
        @Common.Heading                   : 'VCl P'
        @Common.QuickInfo                 : 'Valuation Class for Project Stock'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=QKLAS'
        ProjectStockValuationClass     : String(4) not null;

        @Common.SAPObjectNodeTypeReference: 'Currency'
        @Common.IsCurrency                : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Currency'
        @Common.Heading                   : 'Crcy'
        @Common.QuickInfo                 : 'Currency Key'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
        Currency                       : String(3) not null;

        @Common.IsUnit                    : true
        @Common.Label                     : 'Base Unit of Measure'
        @Common.Heading                   : 'BUn'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=MEINS'
        BaseUnit                       : String(3) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Base unit ISO code'
        @Common.Heading                   : 'BUI'
        @Common.QuickInfo                 : 'Base unit of measure in ISO code'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=MEINS_ISO'
        BaseISOUnit                    : String(3) not null;
        _Product                       : Association to one Product
                                           on _Product.Product = Product;

        @Common.Composition: true
        _ProductValuationAccounting    : Composition of one ProductValuationAccounting
                                           on _ProductValuationAccounting._ProductValuation = $self;

        @Common.Composition: true
        _ProductValuationCosting       : Composition of one ProductValuationCosting
                                           on _ProductValuationCosting._ProductValuation = $self;

        @Common.Composition: true
        _ProductValuationLedgerAccount : Composition of many ProductValuationLedgerAccount
                                           on _ProductValuationLedgerAccount._ProductValuation = $self;

        @Common.Composition: true
        _ProductValuationLedgerPrices  : Composition of many ProductValuationLedgerPrices
                                           on _ProductValuationLedgerPrices._ProductValuation = $self;
  };

  @cds.external                                                    : true
  @cds.persistence.skip                                            : true
  @Common.Label                                                    : 'Product Valuation Accounting'
  @Common.Messages                                                 : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties        : [
    {
      NavigationProperty: _Product,
      InsertRestrictions: {Insertable: false},
      DeepUpdateSupport : {Supported: false}
    },
    {
      NavigationProperty: _ProductValuation,
      DeepUpdateSupport : {Supported: false}
    }
  ]
  @Capabilities.SearchRestrictions.Searchable                      : false
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported            : true
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: [
    '_Product',
    '_ProductValuation'
  ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported               : true
  @Capabilities.InsertRestrictions.Insertable                      : false
  @Capabilities.DeleteRestrictions.Deletable                       : false
  @Core.OptimisticConcurrency                                      : ['_Product/LastChangeDateTime']
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions    : [
    {
      Property          : CommercialPrice1InCoCodeCrcy,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : CommercialPrice2InCoCodeCrcy,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : CommercialPrice3InCoCodeCrcy,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : FuturePrice,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : TaxPricel1InCoCodeCrcy,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : TaxPrice2InCoCodeCrcy,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : TaxPrice3InCoCodeCrcy,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : TaxBasedPricesPriceUnitQty,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : BaseUnit,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : BaseISOUnit,
      AllowedExpressions: 'MultiValue'
    }
  ]
  entity ProductValuationAccounting {
        @Core.Computed                    : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Product'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTNUMBER'
    key Product                      : String(40) not null;

        @Core.Computed                    : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Valuation Area'
        @Common.Heading                   : 'ValA'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=BWKEY'
    key ValuationArea                : String(4) not null;

        @Common.SAPObjectNodeTypeReference: 'ProductValuationType'
        @Core.Computed                    : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Valuation Type'
        @Common.Heading                   : 'Val. Type'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=BWTAR_D'
    key ValuationType                : String(10) not null;

        @Measures.ISOCurrency             : Currency
        @Common.Label                     : 'Commercial price 1'
        @Common.Heading                   : 'Comm. pr. 1'
        @Common.QuickInfo                 : 'Valuation price based on commercial law: level 1'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=BWPRH'
        CommercialPrice1InCoCodeCrcy : Decimal (precision : 11) not null;

        @Measures.ISOCurrency             : Currency
        @Common.Label                     : 'Commercial price 2'
        @Common.Heading                   : 'Comm. pr. 2'
        @Common.QuickInfo                 : 'Valuation price based on commercial law: level 2'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=BWPH1'
        CommercialPrice2InCoCodeCrcy : Decimal (precision : 11) not null;

        @Measures.ISOCurrency             : Currency
        @Common.Label                     : 'Commercial price 3'
        @Common.Heading                   : 'Coml pr. 3'
        @Common.QuickInfo                 : 'Valuation price based on commercial law: level 3'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=VJBWH'
        CommercialPrice3InCoCodeCrcy : Decimal (precision : 11) not null;

        @Common.IsDigitSequence           : true
        @Common.Label                     : 'Devaluation Ind.'
        @Common.Heading                   : 'DevIn'
        @Common.QuickInfo                 : 'Lowest value: devaluation indicator'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=ABWKZ'
        DevaluationYearCount         : String(2) not null;

        @Measures.ISOCurrency             : Currency
        @Common.Label                     : 'Future Price'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=DZKPRS'
        FuturePrice                  : Decimal (precision : 11) not null;

        @Common.Label                     : 'Valid from'
        @Common.Heading                   : 'Valid fm'
        @Common.QuickInfo                 : 'Date as of which the price is valid'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=DZKDAT'
        FuturePriceValidityStartDate : Date;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'LIFO Pool'
        @Common.Heading                   : 'Pool'
        @Common.QuickInfo                 : 'Pool number for LIFO valuation'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=MYPOOL'
        LIFOValuationPoolNumber      : String(4) not null;

        @Measures.ISOCurrency             : Currency
        @Common.Label                     : 'Tax price 1'
        @Common.QuickInfo                 : 'Valuation price based on tax law: level 1'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=BWPRS'
        TaxPricel1InCoCodeCrcy       : Decimal (precision : 11) not null;

        @Measures.ISOCurrency             : Currency
        @Common.Label                     : 'Tax price 2'
        @Common.QuickInfo                 : 'Valuation price based on tax law: level 2'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=BWPS1'
        TaxPrice2InCoCodeCrcy        : Decimal (precision : 11) not null;

        @Measures.ISOCurrency             : Currency
        @Common.Label                     : 'Tax price 3'
        @Common.QuickInfo                 : 'Valuation price based on tax law: level 3'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=VJBWS'
        TaxPrice3InCoCodeCrcy        : Decimal (precision : 11) not null;

        @Measures.Unit                    : BaseUnit
        @Measures.UNECEUnit               : BaseISOUnit
        @Common.Label                     : 'Price Unit'
        @Common.Heading                   : 'PrUnit'
        @Common.QuickInfo                 : 'Price unit for valuation prices based on tax/commercial law'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=BWPEI'
        TaxBasedPricesPriceUnitQty   : Decimal (precision : 5) not null;

        @Common.Label                     : 'TRUE'
        @Common.QuickInfo                 : 'Data element for domain BOOLE: TRUE (=''X'') and FALSE (='' '')'
        IsLIFOAndFIFORelevant        : Boolean not null;

        @Common.SAPObjectNodeTypeReference: 'Currency'
        @Common.IsCurrency                : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Currency'
        @Common.Heading                   : 'Crcy'
        @Common.QuickInfo                 : 'Currency Key'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
        Currency                     : String(3) not null;

        @Common.IsUnit                    : true
        @Common.Label                     : 'Base Unit of Measure'
        @Common.Heading                   : 'BUn'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=MEINS'
        BaseUnit                     : String(3) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Base unit ISO code'
        @Common.Heading                   : 'BUI'
        @Common.QuickInfo                 : 'Base unit of measure in ISO code'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=MEINS_ISO'
        BaseISOUnit                  : String(3) not null;
        _Product                     : Association to one Product
                                         on _Product.Product = Product;
        _ProductValuation            : Association to one ProductValuation
                                         on _ProductValuation.ValuationType = ValuationType;
  };

  @cds.external                                                    : true
  @cds.persistence.skip                                            : true
  @Common.Label                                                    : 'Product Valuation Costing'
  @Common.Messages                                                 : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties        : [
    {
      NavigationProperty: _Product,
      InsertRestrictions: {Insertable: false},
      DeepUpdateSupport : {Supported: false}
    },
    {
      NavigationProperty: _ProductValuation,
      DeepUpdateSupport : {Supported: false}
    }
  ]
  @Capabilities.SearchRestrictions.Searchable                      : false
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported            : true
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: [
    '_Product',
    '_ProductValuation'
  ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported               : true
  @Capabilities.InsertRestrictions.Insertable                      : false
  @Capabilities.DeleteRestrictions.Deletable                       : false
  @Core.OptimisticConcurrency                                      : ['_Product/LastChangeDateTime']
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions    : [
    {
      Property          : PlannedPrice1InCoCodeCrcy,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : PlannedPrice2InCoCodeCrcy,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : PlannedPrice3InCoCodeCrcy,
      AllowedExpressions: 'MultiValue'
    }
  ]
  entity ProductValuationCosting {
        @Core.Computed                    : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Product'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTNUMBER'
    key Product                     : String(40) not null;

        @Core.Computed                    : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Valuation Area'
        @Common.Heading                   : 'ValA'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=BWKEY'
    key ValuationArea               : String(4) not null;

        @Common.SAPObjectNodeTypeReference: 'ProductValuationType'
        @Core.Computed                    : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Valuation Type'
        @Common.Heading                   : 'Val. Type'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=BWTAR_D'
    key ValuationType               : String(10) not null;

        @Common.Label                     : 'With Qty Structure'
        @Common.Heading                   : 'Cost Est. with Qty Structure'
        @Common.QuickInfo                 : 'Material Is Costed with Quantity Structure'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=CK_EKALREL'
        ProductIsCostedWithQtyStruc : Boolean not null;

        @Common.Label                     : 'Material origin'
        @Common.Heading                   : 'MO'
        @Common.QuickInfo                 : 'Material-related origin'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=HKMAT'
        IsMaterialRelatedOrigin     : Boolean not null;

        @Common.SAPObjectNodeTypeReference: 'CostOriginGroup'
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Origin Group'
        @Common.Heading                   : 'OrGp'
        @Common.QuickInfo                 : 'Origin Group as Subdivision of Cost Element'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=HRKFT'
        CostOriginGroup             : String(4) not null;

        @Common.SAPObjectNodeTypeReference: 'CostingOverheadGroup'
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Overhead Group'
        @Common.Heading                   : 'Ovrhd Grp'
        @Common.QuickInfo                 : 'Costing Overhead Group'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=CK_KOSGR'
        CostingOverheadGroup        : String(10) not null;

        @Measures.ISOCurrency             : Currency
        @Common.Label                     : 'Planned price 1'
        @Common.Heading                   : 'PlanPrice 1'
        @Common.QuickInfo                 : 'Future Planned Price 1'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=DZPLP1'
        PlannedPrice1InCoCodeCrcy   : Decimal (precision : 11) not null;

        @Measures.ISOCurrency             : Currency
        @Common.Label                     : 'Planned price 2'
        @Common.Heading                   : 'PlanPrice 2'
        @Common.QuickInfo                 : 'Future Planned Price 2'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=DZPLP2'
        PlannedPrice2InCoCodeCrcy   : Decimal (precision : 11) not null;

        @Measures.ISOCurrency             : Currency
        @Common.Label                     : 'Planned price 3'
        @Common.Heading                   : 'PlanPrice 3'
        @Common.QuickInfo                 : 'Future Planned Price 3'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=DZPLP3'
        PlannedPrice3InCoCodeCrcy   : Decimal (precision : 11) not null;

        @Common.Label                     : 'Planned price date 1'
        @Common.Heading                   : 'PP date 1'
        @Common.QuickInfo                 : 'Date from Which Future Planned Price 1 Is Valid'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=DZPLD1'
        FuturePlndPrice1ValdtyDate  : Date;

        @Common.Label                     : 'Planned price date 2'
        @Common.Heading                   : 'PP date 2'
        @Common.QuickInfo                 : 'Date from Which Future Planned Price 2 Is Valid'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=DZPLD2'
        FuturePlndPrice2ValdtyDate  : Date;

        @Common.Label                     : 'Planned price date 3'
        @Common.Heading                   : 'PP date 3'
        @Common.QuickInfo                 : 'Date from Which Future Planned Price 3 Is Valid'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=DZPLD3'
        FuturePlndPrice3ValdtyDate  : Date;

        @Common.SAPObjectNodeTypeReference: 'Currency'
        @Common.IsCurrency                : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Currency'
        @Common.Heading                   : 'Crcy'
        @Common.QuickInfo                 : 'Currency Key'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
        Currency                    : String(3) not null;
        _Product                    : Association to one Product
                                        on _Product.Product = Product;
        _ProductValuation           : Association to one ProductValuation
                                        on _ProductValuation.ValuationType = ValuationType;
  };

  @cds.external                                                    : true
  @cds.persistence.skip                                            : true
  @Common.Label                                                    : 'Product Valuation Ledger Account'
  @Common.Messages                                                 : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties        : [
    {
      NavigationProperty: _Product,
      InsertRestrictions: {Insertable: false},
      DeepUpdateSupport : {Supported: false}
    },
    {
      NavigationProperty: _ProductValuation,
      DeepUpdateSupport : {Supported: false}
    }
  ]
  @Capabilities.SearchRestrictions.Searchable                      : false
  @Capabilities.InsertRestrictions.RequiredProperties              : [
    'CurrencyRole',
    'Ledger'
  ]
  @Capabilities.InsertRestrictions.Insertable                      : false
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported            : true
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: [
    '_Product',
    '_ProductValuation'
  ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported               : true
  @Capabilities.DeleteRestrictions.Deletable                       : false
  @Core.OptimisticConcurrency                                      : ['_Product/LastChangeDateTime']
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions    : [
    {
      Property          : ProductPriceUnitQuantity,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : MovingAveragePrice,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : StandardPrice,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : BaseUnit,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : BaseISOUnit,
      AllowedExpressions: 'MultiValue'
    }
  ]
  entity ProductValuationLedgerAccount {
        @Core.Computed                    : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Product'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTNUMBER'
    key Product                  : String(40) not null;

        @Core.Computed                    : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Valuation Area'
        @Common.Heading                   : 'ValA'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=BWKEY'
    key ValuationArea            : String(4) not null;

        @Common.SAPObjectNodeTypeReference: 'ProductValuationType'
        @Core.Computed                    : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Valuation Type'
        @Common.Heading                   : 'Val. Type'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=BWTAR_D'
    key ValuationType            : String(10) not null;

        @Common.SAPObjectNodeTypeReference: 'CurrencyRole'
        @Common.Label                     : 'Currency/Valuation'
        @Common.Heading                   : 'CrcyTy./ValView'
        @Common.QuickInfo                 : 'External Currency Type and Valuation View'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=FINS_EXT_CURTYPE'
    key CurrencyRole             : String(2) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Ledger'
        @Common.Heading                   : 'Ld'
        @Common.QuickInfo                 : 'Ledger in General Ledger Accounting'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=FINS_LEDGER'
    key Ledger                   : String(2) not null;

        @Common.SAPObjectNodeTypeReference: 'ProductPriceControl'
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Price Control'
        @Common.Heading                   : 'Pr.'
        @Common.QuickInfo                 : 'Price Control Indicator'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=VPRSV'
        ProductPriceControl      : String(1) not null;

        @Measures.Unit                    : BaseUnit
        @Measures.UNECEUnit               : BaseISOUnit
        @Common.Label                     : 'Price Unit'
        @Common.Heading                   : 'per'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PEINH'
        ProductPriceUnitQuantity : Decimal (precision : 5) not null;

        @Common.SAPObjectNodeTypeReference: 'Currency'
        @Common.IsCurrency                : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Currency'
        @Common.Heading                   : 'Crcy'
        @Common.QuickInfo                 : 'Currency Key'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
        Currency                 : String(3) not null;

        @Measures.ISOCurrency             : Currency
        @Common.Label                     : 'Per. Unit Price'
        @Common.Heading                   : 'Per.Unit Price'
        @Common.QuickInfo                 : 'Periodic Unit Price'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=CK_PVPRS_1'
        MovingAveragePrice       : Decimal (precision : 11) not null;

        @Measures.ISOCurrency             : Currency
        @Common.Label                     : 'Standard Price'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=CK_STPRS_1'
        StandardPrice            : Decimal (precision : 11) not null;

        @Common.IsUnit                    : true
        @Common.Label                     : 'Base Unit of Measure'
        @Common.Heading                   : 'BUn'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=MEINS'
        BaseUnit                 : String(3) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Base unit ISO code'
        @Common.Heading                   : 'BUI'
        @Common.QuickInfo                 : 'Base unit of measure in ISO code'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=MEINS_ISO'
        BaseISOUnit              : String(3) not null;
        _Product                 : Association to one Product
                                     on _Product.Product = Product;
        _ProductValuation        : Association to one ProductValuation
                                     on _ProductValuation.ValuationType = ValuationType;
  };

  @cds.external                                                    : true
  @cds.persistence.skip                                            : true
  @Common.Label                                                    : 'Product Valuation Ledger Prices'
  @Common.Messages                                                 : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties        : [
    {
      NavigationProperty: _Product,
      InsertRestrictions: {Insertable: false},
      DeepUpdateSupport : {Supported: false}
    },
    {
      NavigationProperty: _ProductValuation,
      DeepUpdateSupport : {Supported: false}
    }
  ]
  @Capabilities.SearchRestrictions.Searchable                      : false
  @Capabilities.InsertRestrictions.RequiredProperties              : [
    'CurrencyRole',
    'Ledger'
  ]
  @Capabilities.InsertRestrictions.Insertable                      : false
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported            : true
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: [
    '_Product',
    '_ProductValuation'
  ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported               : true
  @Capabilities.DeleteRestrictions.Deletable                       : false
  @Core.OptimisticConcurrency                                      : ['_Product/LastChangeDateTime']
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions    : [
    {
      Property          : ProductPriceUnitQuantity,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : FuturePrice,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : BaseUnit,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property          : BaseISOUnit,
      AllowedExpressions: 'MultiValue'
    }
  ]
  entity ProductValuationLedgerPrices {
        @Core.Computed                    : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Product'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTNUMBER'
    key Product                      : String(40) not null;

        @Core.Computed                    : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Valuation Area'
        @Common.Heading                   : 'ValA'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=BWKEY'
    key ValuationArea                : String(4) not null;

        @Common.SAPObjectNodeTypeReference: 'ProductValuationType'
        @Core.Computed                    : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Valuation Type'
        @Common.Heading                   : 'Val. Type'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=BWTAR_D'
    key ValuationType                : String(10) not null;

        @Common.SAPObjectNodeTypeReference: 'CurrencyRole'
        @Common.Label                     : 'Currency/Valuation'
        @Common.Heading                   : 'CrcyTy./ValView'
        @Common.QuickInfo                 : 'External Currency Type and Valuation View'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=FINS_EXT_CURTYPE'
    key CurrencyRole                 : String(2) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Ledger'
        @Common.Heading                   : 'Ld'
        @Common.QuickInfo                 : 'Ledger in General Ledger Accounting'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=FINS_LEDGER'
    key Ledger                       : String(2) not null;

        @Measures.Unit                    : BaseUnit
        @Measures.UNECEUnit               : BaseISOUnit
        @Common.Label                     : 'Price Unit'
        @Common.Heading                   : 'per'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PEINH'
        ProductPriceUnitQuantity     : Decimal (precision : 5) not null;

        @Common.SAPObjectNodeTypeReference: 'Currency'
        @Common.IsCurrency                : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Currency'
        @Common.Heading                   : 'Crcy'
        @Common.QuickInfo                 : 'Currency Key'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
        Currency                     : String(3) not null;

        @Measures.ISOCurrency             : Currency
        @Common.Label                     : 'Future Price'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=DZKPRS'
        FuturePrice                  : Decimal (precision : 11) not null;

        @Common.Label: 'Valid From'
        FuturePriceValidityStartDate : Date;

        @Common.IsUnit                    : true
        @Common.Label                     : 'Base Unit of Measure'
        @Common.Heading                   : 'BUn'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=MEINS'
        BaseUnit                     : String(3) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Base unit ISO code'
        @Common.Heading                   : 'BUI'
        @Common.QuickInfo                 : 'Base unit of measure in ISO code'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=MEINS_ISO'
        BaseISOUnit                  : String(3) not null;
        _Product                     : Association to one Product
                                         on _Product.Product = Product;
        _ProductValuation            : Association to one ProductValuation
                                         on _ProductValuation.ValuationType = ValuationType;
  };

};
