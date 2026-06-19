/* checksum : 49048a1e1adf3d3213ac4fc219a311b4 */
@cds.external : true
@odata.containment : true
@CodeList.CurrencyCodes.Url : '../../../../default/iwbep/common/0001/$metadata'
@CodeList.CurrencyCodes.CollectionPath : 'Currencies'
@CodeList.UnitsOfMeasure.Url : '../../../../default/iwbep/common/0001/$metadata'
@CodeList.UnitsOfMeasure.CollectionPath : 'UnitsOfMeasure'
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
service CE_SALESORDER_0001 {
  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Variant Configuration Characteristic'
  entity VarConfignCharacteristic_Type {
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Object Key'
    @Common.Heading : 'Key of Referencing Object'
    @Common.QuickInfo : 'IB: Key of a Referencing Object'
    key VarConfigurationBusObjectKey : String(50) not null;
    @Core.Computed : true
    @Common.Label : 'SAP Obj Node Type'
    @Common.Heading : 'SAP Object Node Type'
    @Common.QuickInfo : 'SAP Object Node Type'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SBO_NODE_TYPE'
    key VarConfigurationBusObjectType : String(30) not null;
    @Core.Computed : true
    @Common.Label : 'Instance ID'
    key VarConfignInstceInternalID : Integer not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Characteristic Name'
    @Common.Heading : 'Char. Name'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ATNAM'
    key Characteristic : String(30) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Format'
    @Common.QuickInfo : 'Data type of characteristic'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ATFOR'
    CharcDataType : String(4) not null;
    @Core.Computed : true
    @Common.Label : 'Template'
    @Common.QuickInfo : 'Value with template'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ATSCH'
    CharcTemplate : String(70) not null;
    @Common.IsCurrency : true
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS_CURC'
    Currency : String(3);
    @Common.IsUnit : true
    @Core.Computed : true
    @Common.Label : 'Internal UoM'
    @Common.Heading : 'MU'
    @Common.QuickInfo : 'Unit of Measurement'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MSEHI'
    CharcValueUnit : String(3);
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'ISO Code'
    @Common.Heading : 'ISO'
    @Common.QuickInfo : 'ISO Code for Unit of Measurement'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ISOCD_UNIT'
    VarCnfCharcISOUnit : String(3);
    @Core.Computed : true
    @Common.Label : 'Is Read-Only'
    @Common.QuickInfo : 'Is read-only'
    IsReadOnly : Boolean not null;
    @Core.Computed : true
    @Common.Label : 'Entry Required'
    EntryIsRequired : Boolean not null;
    @Core.Computed : true
    @Common.Label : 'Charc. Not To Be Displayed'
    @Common.QuickInfo : 'Characteristic Not To Be Displayed'
    CharcIsHidden : Boolean not null;
    @Core.Computed : true
    @Common.Label : 'Additional Values'
    @Common.QuickInfo : 'Indicator: Additional Values'
    AdditionalValueIsAllowed : Boolean not null;
    @Core.Computed : true
    @Common.Label : 'Multiple Values Allowed'
    @Common.QuickInfo : 'Multiple Values Are Allowed'
    MultipleValuesAreAllowed : Boolean not null;
    @Common.Composition : true
    _AssignedValue : Composition of many VarConfignAssignedValue_Type on _AssignedValue._Characteristic = $self;
    _Instance : Association to one VariantConfigurationInstance_Type;
    _VariantConfiguration : Association to one VariantConfiguration_Type {  };
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Variant Configuration Instance'
  entity VariantConfigurationInstance_Type {
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Object Key'
    @Common.Heading : 'Key of Referencing Object'
    @Common.QuickInfo : 'IB: Key of a Referencing Object'
    key VarConfigurationBusObjectKey : String(50) not null;
    @Core.Computed : true
    @Common.Label : 'SAP Obj Node Type'
    @Common.Heading : 'SAP Object Node Type'
    @Common.QuickInfo : 'SAP Object Node Type'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SBO_NODE_TYPE'
    key VarConfigurationBusObjectType : String(30) not null;
    @Core.Computed : true
    @Common.Label : 'Instance ID'
    key VarConfignInstceInternalID : Integer not null;
    @Common.Label : 'Instance ID'
    VarConfignParInstceInternalID : Integer not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Material'
    @Common.QuickInfo : 'Material Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MATNR'
    Product : String(40);
    @Common.IsUpperCase : true
    @Common.Label : 'Item identification'
    @Common.Heading : 'Item ID'
    @Common.QuickInfo : 'External identification of an item'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=CS_ITMID'
    IdentifierBOMItem : String(8);
    @Common.IsUpperCase : true
    @Common.Label : 'Bill Of Material Item Number'
    BillOfMaterialItemNumber : String(4);
    @Core.Computed : true
    @Measures.Unit : VarConfignQuantityUnit
    @Measures.UNECEUnit : VarConfignQuantityISOUnit
    @Common.Label : 'Amount'
    @Common.QuickInfo : 'Amount of Instance Quantity'
    VariantConfigurationQuantity : Decimal(13, 3);
    @Common.IsUnit : true
    @Core.Computed : true
    @Common.Label : 'Internal Unit'
    @Common.QuickInfo : 'Internal Unit of Measurement w/o Conversion'
    VarConfignQuantityUnit : String(3);
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'ISO Code'
    @Common.Heading : 'ISO'
    @Common.QuickInfo : 'ISO Code for Unit of Measurement'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ISOCD_UNIT'
    VarConfignQuantityISOUnit : String(3);
    @Common.Composition : true
    _Characteristic : Composition of many VarConfignCharacteristic_Type on _Characteristic._Instance = $self;
    _VariantConfiguration : Association to one VariantConfiguration_Type;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Variant Configuration'
  entity VariantConfiguration_Type {
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Object Key'
    @Common.Heading : 'Key of Referencing Object'
    @Common.QuickInfo : 'IB: Key of a Referencing Object'
    key VarConfigurationBusObjectKey : String(50) not null;
    @Core.Computed : true
    @Common.Label : 'SAP Obj Node Type'
    @Common.Heading : 'SAP Object Node Type'
    @Common.QuickInfo : 'SAP Object Node Type'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SBO_NODE_TYPE'
    key VarConfigurationBusObjectType : String(30) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Configuration Status'
    @Common.Heading : 'Possible Configuration Status for SOA to be set'
    @Common.QuickInfo : 'Variant Configuration status'
    VarConfignStatus : String(1) not null;
    @Common.Composition : true
    _Instance : Composition of many VariantConfigurationInstance_Type on _Instance._VariantConfiguration = $self;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Variant Configuration Assigned Value'
  entity VarConfignAssignedValue_Type {
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Object Key'
    @Common.Heading : 'Key of Referencing Object'
    @Common.QuickInfo : 'IB: Key of a Referencing Object'
    key VarConfigurationBusObjectKey : String(50) not null;
    @Core.Computed : true
    @Common.Label : 'SAP Obj Node Type'
    @Common.Heading : 'SAP Object Node Type'
    @Common.QuickInfo : 'SAP Object Node Type'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SBO_NODE_TYPE'
    key VarConfigurationBusObjectType : String(30) not null;
    @Core.Computed : true
    @Common.Label : 'Instance ID'
    key VarConfignInstceInternalID : Integer not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Characteristic Name'
    @Common.Heading : 'Char. Name'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ATNAM'
    key Characteristic : String(30) not null;
    @Core.Computed : true
    @Common.Label : 'Value ID'
    @Common.QuickInfo : 'Value ID for a characteristic value'
    key VariantConfigurationValueID : String(150) not null;
    @Common.Label : 'Characteristic Value'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ATWRT'
    VarCnfCharacteristicValue : String(70);
    @Core.Computed : true
    @Common.Label : 'Value description'
    @Common.Heading : 'Description'
    @Common.QuickInfo : 'Characteristic value description'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ATWTB'
    VarCnfCharcValueDescription : String(70);
    @Measures.Unit : VarCnfCharcFromQuantityUnit
    @Measures.UNECEUnit : VarCnfCharcFromQuantityISOUnit
    @Common.Label : 'Decfloat Value (Min)'
    @Common.Heading : 'Decimal Floating Point Value (Minimum)'
    @Common.QuickInfo : 'Decimal Floating Point Value (Minimum)'
    VarCnfCharcFromQuantity : Decimal(precision: 34);
    @Common.IsUnit : true
    @Core.Computed : true
    @Common.Label : 'Internal UoM'
    @Common.Heading : 'MU'
    @Common.QuickInfo : 'Unit of Measurement'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MSEHI'
    VarCnfCharcFromQuantityUnit : String(3);
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'ISO Code'
    @Common.Heading : 'ISO'
    @Common.QuickInfo : 'ISO Code for Unit of Measurement'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ISOCD_UNIT'
    VarCnfCharcFromQuantityISOUnit : String(3);
    @Core.Computed : true
    @Measures.Unit : VarCnfCharcToQuantityUnit
    @Measures.UNECEUnit : VarCnfCharcToQuantityISOUnit
    @Common.Label : 'Decfloat Value (Min)'
    @Common.Heading : 'Decimal Floating Point Value (Minimum)'
    @Common.QuickInfo : 'Decimal Floating Point Value (Minimum)'
    VarCnfCharcToQuantity : Decimal(precision: 34);
    @Common.IsUnit : true
    @Core.Computed : true
    @Common.Label : 'Internal UoM'
    @Common.Heading : 'MU'
    @Common.QuickInfo : 'Unit of Measurement'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MSEHI'
    VarCnfCharcToQuantityUnit : String(3);
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'ISO Code'
    @Common.Heading : 'ISO'
    @Common.QuickInfo : 'ISO Code for Unit of Measurement'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ISOCD_UNIT'
    VarCnfCharcToQuantityISOUnit : String(3);
    @Common.Label : 'Decfloat Value (Min)'
    @Common.Heading : 'Decimal Floating Point Value (Minimum)'
    @Common.QuickInfo : 'Decimal Floating Point Value (Minimum)'
    VarCnfCharcFromNumericValue : Decimal(precision: 34);
    @Core.Computed : true
    @Common.Label : 'Decfloat Value (Max)'
    @Common.Heading : 'Decimal Floating Point Value (Maximum)'
    @Common.QuickInfo : 'Decimal Floating Point Value (Maximum)'
    VarCnfCharcToNumericValue : Decimal(precision: 34);
    @Common.Label : 'LowrBndry Date'
    @Common.Heading : 'L/B Date'
    @Common.QuickInfo : 'Lower Boundary for Date-Interval'
    VarCnfCharcFromDate : Date;
    @Common.Label : 'LowrBndry Time'
    @Common.Heading : 'L/B Time'
    @Common.QuickInfo : 'Lower Boundary for Time-Interval'
    VarCnfCharcFromTime : Time;
    @Common.Label : 'Decfloat Value (Min)'
    @Common.Heading : 'Decimal Floating Point Value (Minimum)'
    @Common.QuickInfo : 'Decimal Floating Point Value (Minimum)'
    VarCnfCharcFromAmount : Decimal(precision: 34);
    @Core.Computed : true
    @Common.Label : 'Decfloat Value (Min)'
    @Common.Heading : 'Decimal Floating Point Value (Minimum)'
    @Common.QuickInfo : 'Decimal Floating Point Value (Minimum)'
    VarCnfCharcToAmount : Decimal(precision: 34);
    @Common.IsCurrency : true
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS_CURC'
    VarCnfCharcCurrency : String(3);
    @Core.Computed : true
    @Common.Label : 'Assignment Type'
    @Common.QuickInfo : 'Characteristic Value Assignment Type'
    VarConfignValueAssignmentType : Integer not null;
    _Characteristic : Association to one VarConfignCharacteristic_Type;
    _VariantConfiguration : Association to one VariantConfiguration_Type {  };
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
  @Common.Label : 'Sales Order Header'
  @Common.Messages : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties : [
    { NavigationProperty: _Item, InsertRestrictions: { Insertable: true } },
    {
      NavigationProperty: _Partner,
      InsertRestrictions: { Insertable: true }
    },
    {
      NavigationProperty: _PricingElement,
      InsertRestrictions: { Insertable: true },
      FilterRestrictions: { Filterable: false }
    },
    { NavigationProperty: _Text, InsertRestrictions: { Insertable: true } }
  ]
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.InsertRestrictions.RequiredProperties : [ 'SalesOrderType' ]
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported : true
  @Capabilities.UpdateRestrictions.NonUpdatableProperties : [
    'SalesOrderType',
    'ReferenceSDDocument',
    'SlsContrAutoAssgmtIDForSlsOrd'
  ]
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_Item', '_Partner', '_PricingElement', '_Text' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported : true
  @Capabilities.DeleteRestrictions.Deletable : false
  @Core.OptimisticConcurrency : [ 'LastChangeDateTime' ]
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions : [ { Property: TotalNetAmount, AllowedExpressions: 'MultiValue' } ]
  entity SalesOrder {
    @Core.ComputedDefaultValue : true
    @Common.IsUpperCase : true
    @Common.Label : 'Sales Order'
    @Common.Heading : 'SO'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VDM_SALES_ORDER'
    key SalesOrder : String(10) not null;
    @Common.SAPObjectNodeTypeReference : 'SalesOrderType'
    @Core.Immutable : true
    @Common.IsUpperCase : true
    @Common.Label : 'Language key'
    @Common.QuickInfo : 'Language key for sales document type'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AUART_SPR'
    SalesOrderType : String(4) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Processing Type'
    @Common.Heading : 'P'
    @Common.QuickInfo : 'SD Document Processing Type'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VBKLT'
    SalesOrderProcessingType : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Sold-to Party'
    @Common.Heading : 'Sold-to'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KUNAG'
    SoldToParty : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Sales Organization'
    @Common.Heading : 'SOrg.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VKORG'
    SalesOrganization : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Distribution Channel'
    @Common.Heading : 'DChl'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VTWEG'
    DistributionChannel : String(2) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'RefDistCh-Cust/Mat.'
    @Common.Heading : 'DCh-Cust/Mt'
    @Common.QuickInfo : 'Reference distrib.channel for cust.and material masters'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VTWKU'
    ReferenceDistributionChannel : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Division'
    @Common.Heading : 'Dv'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SPART'
    OrganizationDivision : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Sales Office'
    @Common.Heading : 'SOff.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VKBUR'
    SalesOffice : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Sales Group'
    @Common.Heading : 'SGrp'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VKGRP'
    SalesGroup : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Sales District'
    @Common.Heading : 'SDst'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BZIRK'
    SalesDistrict : String(6) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Created By'
    @Common.QuickInfo : 'Name of Person Responsible for Creating the Object'
    CreatedByUser : String(12) not null;
    @Core.Computed : true
    @Common.Label : 'Created On'
    @Common.QuickInfo : 'Record Creation Date'
    CreationDate : Date;
    @Core.Computed : true
    @Common.Label : 'Created At'
    @Common.QuickInfo : 'Time at Which Record Was Created'
    CreationTime : Time not null;
    @odata.Precision : 7
    @odata.Type : 'Edm.DateTimeOffset'
    @Core.Computed : true
    @Common.Label : 'Changed On/At'
    @Common.QuickInfo : 'Date and Time of Last Change'
    LastChangeDateTime : Timestamp;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Last Changed By'
    @Common.Heading : 'Changed By'
    @Common.QuickInfo : 'User Who Last Changed the Business Document'
    LastChangedByUser : String(12) not null;
    @Common.Label : 'Customer Reference'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BSTKD'
    PurchaseOrderByCustomer : String(35) not null;
    @Common.Label : 'Customer Reference (Ship-to Party)'
    @Common.QuickInfo : 'Ship-to Party''s Customer Reference'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SD_PURCHASE_ORDER_BY_SHIPTO'
    PurchaseOrderByShipToParty : String(35) not null;
    @Common.SAPObjectNodeTypeReference : 'PurchaseOrderTypeByCustomer'
    @Common.IsUpperCase : true
    @Common.Label : 'Purchase Order Type'
    @Common.Heading : 'POtyp'
    @Common.QuickInfo : 'Customer Purchase Order Type'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BSARK'
    CustomerPurchaseOrderType : String(4) not null;
    @Common.Label : 'Customer Reference Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VDM_SD_CUSTOMER_REFERENCE_DATE'
    CustomerPurchaseOrderDate : Date;
    @Common.Label : 'Your Reference'
    @Common.Heading : 'Your Ref.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=IHREZ'
    CorrespncExternalReference : String(12) not null;
    @Common.Label : 'Your Reference'
    @Common.Heading : 'Ship-to Char'
    @Common.QuickInfo : 'Ship-to Party Character'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=IHREZ_E'
    CorrespncExtRefByShipToParty : String(12) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Solution Order'
    BusinessSolutionOrder : String(10) not null;
    @Core.Immutable : true
    @Common.IsUpperCase : true
    @Common.Label : 'Reference Document'
    @Common.Heading : 'Ref. Doc.'
    @Common.QuickInfo : 'Document Number of Reference Document'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VGBEL'
    ReferenceSDDocument : String(10);
    @Core.Computed : true
    @Common.Label : 'Reference Document Category'
    ReferenceSDDocumentCategory : String(4);
    @Common.SAPObjectNodeTypeReference : 'SalesDocumentReason'
    @Common.IsUpperCase : true
    @Common.Label : 'Order Reason'
    @Common.Heading : 'OrdRs'
    @Common.QuickInfo : 'Order Reason (Reason for the Business Transaction)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AUGRU'
    SDDocumentReason : String(3) not null;
    @Common.Label : 'Document Date'
    @Common.Heading : 'Doc. Date'
    @Common.QuickInfo : 'Document Date (Date Received/Sent)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AUDAT'
    SalesOrderDate : Date;
    @Common.Label : 'Requested Delivery Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=REQD_DELIVERY_DATE'
    RequestedDeliveryDate : Date;
    @Common.Label : 'Pricing Date'
    @Common.Heading : 'Pricing Dt'
    @Common.QuickInfo : 'Date for Pricing and Exchange Rate'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PRSDT'
    PricingDate : Date;
    @Common.Label : 'Date of Services Rendered'
    @Common.QuickInfo : 'Date on which services are rendered'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VDM_SD_SERVICES_RENDERED_DATE'
    ServicesRenderedDate : Date;
    @Common.Label : 'Billing Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FKDAT'
    BillingDocumentDate : Date;
    @Core.Computed : true
    @Measures.ISOCurrency : TransactionCurrency
    @Common.Label : 'Net Value'
    @Common.QuickInfo : 'Net Value of the Sales Document in Document Currency'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NETWR_AK'
    TotalNetAmount : Decimal(precision: 15) not null;
    @Common.SAPObjectNodeTypeReference : 'Currency'
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Document Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'SD Document Currency'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERK'
    TransactionCurrency : String(3) not null;
    @Common.SAPObjectNodeTypeReference : 'DeliveryDateTypeRule'
    @Common.IsUpperCase : true
    @Common.Label : 'Delivery Date Rule'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VDM_SD_DELIVERY_DATE_TYPE_RULE'
    DeliveryDateTypeRule : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Shipping Conditions'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VSBED'
    ShippingCondition : String(2) not null;
    @Common.Label : 'Complete Delivery'
    @Common.Heading : 'CDl'
    @Common.QuickInfo : 'Complete Delivery Defined for Each Sales Order'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AUTLF'
    CompleteDeliveryIsDefined : Boolean not null;
    @Common.Label : 'Relevant for Proof of Delivery'
    SlsDocIsRlvtForProofOfDeliv : Boolean not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Shipping Type'
    @Common.Heading : 'ST'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VSARTTR'
    ShippingType : String(2) not null;
    @Common.Label : 'Receiving Point'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=EMPST'
    ReceivingPoint : String(25) not null;
    @Common.SAPObjectNodeTypeReference : 'IncotermsClassification'
    @Common.IsUpperCase : true
    @Common.Label : 'Incoterms'
    @Common.Heading : 'IncoT'
    @Common.QuickInfo : 'Incoterms (Part 1)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INCO1'
    IncotermsClassification : String(3) not null;
    @Common.SAPObjectNodeTypeReference : 'IncotermsVersion'
    @Common.IsUpperCase : true
    @Common.Label : 'Incoterms Version'
    @Common.Heading : 'IncoV'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INCOV'
    IncotermsVersion : String(4) not null;
    @Common.Label : 'Incoterms Location 1'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INCO2_L'
    IncotermsLocation1 : String(70) not null;
    @Common.Label : 'Incoterms Location 2'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INCO3_L'
    IncotermsLocation2 : String(70) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Pricing Procedure'
    @Common.Heading : 'PriPr.'
    @Common.QuickInfo : 'Pricing Procedure in Pricing'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KALSMASD'
    SDPricingProcedure : String(6) not null;
    @Common.SAPObjectNodeTypeReference : 'CustomerPriceGroup'
    @Common.IsUpperCase : true
    @Common.Label : 'Customer Price Group'
    @Common.Heading : 'CPG'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KONDA'
    CustomerPriceGroup : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Price List Type'
    @Common.Heading : 'PL'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PLTYP'
    PriceListType : String(2) not null;
    @Common.Label : 'Fixed Value Date'
    @Common.Heading : 'FixValDate'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VALDT'
    FixedValueDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Tax Departure Country/Region'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VDM_SD_TAX_DEPARTURE_COUNTRY'
    TaxDepartureCountry : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Tax Destination Country/Region'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VDM_SD_VAT_REGISTRATION_CNTRY'
    VATRegistrationCountry : String(3) not null;
    @Common.Label : 'EU Triangular Deal'
    @Common.QuickInfo : 'Indicator: Triangular Deal Within the EU'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=XEGDR'
    IsEUTriangularDeal : Boolean not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Terms of Payment'
    @Common.QuickInfo : 'Key for Terms of Payment'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=DZTERM'
    CustomerPaymentTerms : String(4) not null;
    @Common.SAPObjectNodeTypeReference : 'PaymentMethod'
    @Common.IsUpperCase : true
    @Common.Label : 'Payment Method'
    @Common.Heading : 'PM'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SCHZW_BSEG'
    PaymentMethod : String(1) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'CCode to Be Billed'
    @Common.Heading : 'CCdB'
    @Common.QuickInfo : 'Company Code to Be Billed'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BUKRS_VF'
    BillingCompanyCode : String(4) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Controlling Area'
    @Common.Heading : 'COAr'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KOKRS'
    ControllingArea : String(4) not null;
    @Common.SAPObjectNodeTypeReference : 'CustomerAccountAssignmentGroup'
    @Common.IsUpperCase : true
    @Common.Label : 'Account Assignment Group for Customer'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SD_ACCOUNT_ASSGMT_GROUP_CUST'
    CustomerAccountAssignmentGroup : String(2) not null;
    @Common.Label : 'Assignment'
    @Common.QuickInfo : 'Assignment Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ORDNR_V'
    AssignmentReference : String(18) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Reference'
    @Common.QuickInfo : 'Reference Document Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=XBLNR_V1'
    AccountingDocExternalReference : String(16) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Credit Account'
    @Common.Heading : 'Cred. Acct'
    @Common.QuickInfo : 'Customer''s Account Number with Credit Limit Reference'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KNKLI'
    CustomerCreditAccount : String(10) not null;
    @Common.SAPObjectNodeTypeReference : 'BillingBlockReason'
    @Common.IsUpperCase : true
    @Common.Label : 'Billing Block'
    @Common.Heading : 'BB'
    @Common.QuickInfo : 'Billing Block in SD Document'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FAKSK'
    HeaderBillingBlockReason : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Delivery Block'
    @Common.Heading : 'DlBl'
    @Common.QuickInfo : 'Delivery Block (Document Header)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LIFSK'
    DeliveryBlockReason : String(2) not null;
    @Common.SAPObjectNodeTypeReference : 'SalesOrderApprovalReason'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Approval Request Reason'
    @Common.QuickInfo : 'Approval Request Reason ID'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SD_APM_APPROVAL_REASON_VDM'
    SalesOrderApprovalReason : String(4) not null;
    @Core.Immutable : true
    @Common.IsUpperCase : true
    @Common.Label : 'Contract Autom. Asmt'
    @Common.Heading : 'Sales Contract for Automatic Assignments'
    @Common.QuickInfo : 'Sales Contract for Automatic Assignments'
    SlsContrAutoAssgmtIDForSlsOrd : String(10);
    @Common.SAPObjectNodeTypeReference : 'CustomerGroup'
    @Common.IsUpperCase : true
    @Common.Label : 'Customer Group'
    @Common.Heading : 'CGrp'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KDGRP'
    CustomerGroup : String(2) not null;
    @Common.SAPObjectNodeTypeReference : 'AdditionalCustomerGroup1'
    @Common.IsUpperCase : true
    @Common.Label : 'Customer Group 1'
    @Common.Heading : 'Grp1'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KVGR1'
    AdditionalCustomerGroup1 : String(3) not null;
    @Common.SAPObjectNodeTypeReference : 'AdditionalCustomerGroup2'
    @Common.IsUpperCase : true
    @Common.Label : 'Customer Group 2'
    @Common.Heading : 'Grp2'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KVGR2'
    AdditionalCustomerGroup2 : String(3) not null;
    @Common.SAPObjectNodeTypeReference : 'AdditionalCustomerGroup3'
    @Common.IsUpperCase : true
    @Common.Label : 'Customer Group 3'
    @Common.Heading : 'Grp3'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KVGR3'
    AdditionalCustomerGroup3 : String(3) not null;
    @Common.SAPObjectNodeTypeReference : 'AdditionalCustomerGroup4'
    @Common.IsUpperCase : true
    @Common.Label : 'Customer Group 4'
    @Common.Heading : 'Grp4'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KVGR4'
    AdditionalCustomerGroup4 : String(3) not null;
    @Common.SAPObjectNodeTypeReference : 'AdditionalCustomerGroup5'
    @Common.IsUpperCase : true
    @Common.Label : 'Customer Group 5'
    @Common.Heading : 'Grp5'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KVGR5'
    AdditionalCustomerGroup5 : String(3) not null;
    @Common.SAPObjectNodeTypeReference : 'OverallSDProcessStatus'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Overall Status'
    @Common.Heading : 'OS'
    @Common.QuickInfo : 'Overall Processing Status (Header/All Items)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GBSTK'
    OverallSDProcessStatus : String(1) not null;
    @Common.SAPObjectNodeTypeReference : 'SlsDocOvrlPurchaseConfStatus'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Purchasing Confirmation Status'
    @Common.QuickInfo : 'Purchasing Confirmation Status (All Items)'
    OverallPurchaseConfStatus : String(1) not null;
    @Common.SAPObjectNodeTypeReference : 'SlsDocOvrlDeliveryBlockStatus'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Delivery Block Status'
    @Common.QuickInfo : 'Delivery Block Status (Item)'
    OverallDeliveryBlockStatus : String(1) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Billing Block Status'
    @Common.QuickInfo : 'Billing Block Status (All Items)'
    OverallBillingBlockStatus : String(1) not null;
    @Common.SAPObjectNodeTypeReference : 'SalesDocOverallDeliveryStatus'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Delivery Status'
    @Common.Heading : 'DS'
    @Common.QuickInfo : 'Delivery Status (All Items)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LFSTK'
    OverallDeliveryStatus : String(1) not null;
    @Common.SAPObjectNodeTypeReference : 'TotalCreditCheckStatus'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Credit Status'
    @Common.Heading : 'OvCS'
    @Common.QuickInfo : 'Overall Status of Credit Checks'
    TotalCreditCheckStatus : String(1) not null;
    @Common.SAPObjectNodeTypeReference : 'OverallSDDocumentRejectionSts'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Rejection Status'
    @Common.Heading : 'Rj'
    @Common.QuickInfo : 'Rejection Status (All Items)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ABSTK'
    OverallSDDocumentRejectionSts : String(1) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Overall Block Status'
    @Common.Heading : 'OB'
    @Common.QuickInfo : 'Overall Block Status (Header)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SPSTG'
    TotalBlockStatus : String(1) not null;
    @Common.SAPObjectNodeTypeReference : 'SlsDocGenIncompletionStatus'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Incompletion Status (Header)'
    @Common.Heading : 'General Incompletion Status of Header'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=HDR_GENERAL_INCOMPLTN_STATUS'
    HdrGeneralIncompletionStatus : String(1) not null;
    @Common.SAPObjectNodeTypeReference : 'SlsDocOvrlItmGenIncompltnSts'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Incompletion Status (Items)'
    @Common.Heading : 'Incompletion Status for All Items'
    @Common.QuickInfo : 'Incompletion Status (All Items)'
    OvrlItmGeneralIncompletionSts : String(1) not null;
    @Common.SAPObjectNodeTypeReference : 'OverallSDDocReferenceStatus'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Reference Status'
    @Common.Heading : 'RS'
    @Common.QuickInfo : 'Reference Status (All Items)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=RFSTK'
    OverallSDDocReferenceStatus : String(1) not null;
    @Common.SAPObjectNodeTypeReference : 'SalesDocApprovalStatus'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Approval Status'
    @Common.QuickInfo : 'Document Approval Status'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SD_APM_APPROVAL_STATUS'
    SalesDocApprovalStatus : String(1) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Product Marketability Status'
    @Common.QuickInfo : 'Product Marketability Status (All Items)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MON_TDD_TOTAL_PCSTA'
    OverallChmlCmplncStatus : String(1) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Dangerous Goods Status'
    @Common.QuickInfo : 'Dangerous Goods Status (All Items)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MON_TDD_TOTAL_DGSTA'
    OverallDangerousGoodsStatus : String(1) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Safety Data Sheet Status'
    @Common.QuickInfo : 'Safety Data Sheet Status (All Items)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MON_TDD_TOTAL_SDSSTA'
    OverallSafetyDataSheetStatus : String(1) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Embargo Status'
    @Common.QuickInfo : 'Embargo Status (All Items)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TDD_TOTAL_EMCST'
    OverallTrdCmplncEmbargoSts : String(1) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Screening Status'
    @Common.QuickInfo : 'Screening Status (All Items)'
    OvrlTrdCmplncSnctndListChkSts : String(1) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Legal Control Status'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VDM_SD_OVRL_LEGAL_CTRL_STATUS'
    OvrlTrdCmplncLegalCtrlChkSts : String(1) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Down Payment Status'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=DP_CLEAR_STA'
    SalesOrderDownPaymentStatus : String(1) not null;
    @Common.SAPObjectNodeTypeReference : 'OverallOrdReltdBillgStatus'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Order-Related Billing Status'
    @Common.QuickInfo : 'Order-Related Billing Status (All Items)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SDMD_ORDER_RELATED_BILLING_STS'
    OverallOrdReltdBillgStatus : String(1) not null;
    SAP__Messages : many SAP__Message not null;
    @Common.Composition : true
    _Item : Composition of many SalesOrderItem on _Item._SalesOrder = $self;
    @Common.Composition : true
    _Partner : Composition of many SalesOrderPartner on _Partner._SalesOrder = $self;
    @Common.Composition : true
    _PricingElement : Composition of many SalesOrderPricingElement on _PricingElement._SalesOrder = $self;
    @Common.Composition : true
    _Text : Composition of many SalesOrderText on _Text._SalesOrder = $self;
  } actions {
    action UpdatePrices(
      @Common.Label : 'Pricing Type'
      @Common.FieldControl : #Mandatory
      @Common.IsUpperCase : true
      @Common.Heading : 'PrTy'
      @Common.QuickInfo : 'Pricing Type'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KNPRS'
      PricingType : String(1) not null
    );
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Sales Order Item'
  @Common.SemanticKey : [ 'SalesOrderItem', 'SalesOrder' ]
  @Common.Messages : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties : [
    {
      NavigationProperty: _ItemPartner,
      InsertRestrictions: { Insertable: true }
    },
    {
      NavigationProperty: _ItemPricingElement,
      InsertRestrictions: { Insertable: true },
      FilterRestrictions: { Filterable: false }
    },
    {
      NavigationProperty: _ItemText,
      InsertRestrictions: { Insertable: true }
    },
    {
      NavigationProperty: _SalesOrder,
      InsertRestrictions: { Insertable: false },
      DeepUpdateSupport: { Supported: false }
    },
    {
      NavigationProperty: _VariantConfiguration,
      InsertRestrictions: { Insertable: true },
      UpdateRestrictions: { Updatable: false },
      DeleteRestrictions: { Deletable: false },
      SortRestrictions: { Sortable: false },
      FilterRestrictions: { Filterable: false }
    }
  ]
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported : true
  @Capabilities.UpdateRestrictions.NonUpdatableProperties : [
    'ReferenceSDDocument',
    'ReferenceSDDocumentItem',
    'SlsContrAutoAssgmtIDForSlsOrd'
  ]
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [
    '_ItemPartner',
    '_ItemPricingElement',
    '_ItemText',
    '_SalesOrder',
    '_ScheduleLine',
    '_VariantConfiguration'
  ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported : true
  @Capabilities.InsertRestrictions.Insertable : false
  @Core.OptimisticConcurrency : [ '_SalesOrder/LastChangeDateTime' ]
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions : [
    {
      Property: ConfdDelivQtyInOrderQtyUnit,
      AllowedExpressions: 'MultiValue'
    },
    { Property: OrderQuantitySAPUnit, AllowedExpressions: 'MultiValue' },
    { Property: OrderQuantityISOUnit, AllowedExpressions: 'MultiValue' },
    { Property: RequestedQuantity, AllowedExpressions: 'MultiValue' },
    { Property: RequestedQuantitySAPUnit, AllowedExpressions: 'MultiValue' },
    { Property: RequestedQuantityISOUnit, AllowedExpressions: 'MultiValue' },
    { Property: ItemGrossWeight, AllowedExpressions: 'MultiValue' },
    { Property: ItemNetWeight, AllowedExpressions: 'MultiValue' },
    { Property: ItemWeightSAPUnit, AllowedExpressions: 'MultiValue' },
    { Property: ItemWeightISOUnit, AllowedExpressions: 'MultiValue' },
    { Property: ItemVolume, AllowedExpressions: 'MultiValue' },
    { Property: ItemVolumeSAPUnit, AllowedExpressions: 'MultiValue' },
    { Property: ItemVolumeISOUnit, AllowedExpressions: 'MultiValue' },
    { Property: NetAmount, AllowedExpressions: 'MultiValue' },
    { Property: TaxAmount, AllowedExpressions: 'MultiValue' },
    { Property: Subtotal1Amount, AllowedExpressions: 'MultiValue' },
    { Property: Subtotal2Amount, AllowedExpressions: 'MultiValue' },
    { Property: Subtotal3Amount, AllowedExpressions: 'MultiValue' },
    { Property: Subtotal4Amount, AllowedExpressions: 'MultiValue' },
    { Property: Subtotal5Amount, AllowedExpressions: 'MultiValue' },
    { Property: Subtotal6Amount, AllowedExpressions: 'MultiValue' },
    {
      Property: ![_VariantConfiguration/_Instance/VariantConfigurationQuantity],
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: ![_VariantConfiguration/_Instance/VarConfignQuantityUnit],
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: ![_VariantConfiguration/_Instance/VarConfignQuantityISOUnit],
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: ![_VariantConfiguration/_Instance/_Characteristic/_AssignedValue/VarCnfCharcFromQuantity],
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: ![_VariantConfiguration/_Instance/_Characteristic/_AssignedValue/VarCnfCharcFromQuantityUnit],
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: ![_VariantConfiguration/_Instance/_Characteristic/_AssignedValue/VarCnfCharcFromQuantityISOUnit],
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: ![_VariantConfiguration/_Instance/_Characteristic/_AssignedValue/VarCnfCharcToQuantity],
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: ![_VariantConfiguration/_Instance/_Characteristic/_AssignedValue/VarCnfCharcToQuantityUnit],
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: ![_VariantConfiguration/_Instance/_Characteristic/_AssignedValue/VarCnfCharcToQuantityISOUnit],
      AllowedExpressions: 'MultiValue'
    }
  ]
  entity SalesOrderItem {
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Sales Order'
    @Common.Heading : 'SO'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VDM_SALES_ORDER'
    key SalesOrder : String(10) not null;
    @Core.ComputedDefaultValue : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Item'
    @Common.Heading : 'SO Item'
    @Common.QuickInfo : 'Sales Order Item'
    key SalesOrderItem : String(6) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Higher-Level Item'
    @Common.Heading : 'HgLvIt'
    @Common.QuickInfo : 'Higher-Level Item in Bill of Material Structures'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=UEPOS'
    HigherLevelItem : String(6);
    @Common.IsUpperCase : true
    @Common.Label : 'Item Category'
    @Common.Heading : 'ItCa'
    @Common.QuickInfo : 'Sales Document Item Category'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PSTYV'
    SalesOrderItemCategory : String(4) not null;
    @Common.Label : 'Item Description'
    @Common.QuickInfo : 'Short Text for Sales Order Item'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ARKTX'
    SalesOrderItemText : String(40) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Product'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTNUMBER'
    Product : String(40) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Material Entered'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MATWA'
    OriginallyRequestedMaterial : String(40) not null;
    @Common.SAPObjectNodeTypeReference : 'ProductGroup'
    @Common.IsUpperCase : true
    @Common.Label : 'Product Group'
    @Common.Heading : 'Prd Group'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTGROUP'
    ProductGroup : String(9) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Customer Material'
    @Common.Heading : 'Customer Material Number'
    @Common.QuickInfo : 'Material Number Used by Customer'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MATNR_KU'
    MaterialByCustomer : String(35) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'EAN/UPC'
    @Common.QuickInfo : 'International Article Number (EAN/UPC)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=EAN11'
    InternationalArticleNumber : String(18) not null;
    @Common.Label : 'Customer Reference'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BSTKD'
    PurchaseOrderByCustomer : String(35) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Purchase Order Item'
    @Common.Heading : 'POItem'
    @Common.QuickInfo : 'Item Number of the Underlying Purchase Order'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=POSEX'
    UnderlyingPurchaseOrderItem : String(6) not null;
    @Common.Label : 'Your Reference'
    @Common.Heading : 'Your Ref.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=IHREZ'
    CorrespncExternalReference : String(12) not null;
    @Common.Label : 'Customer Reference (Ship-to Party)'
    @Common.QuickInfo : 'Ship-to Party''s Customer Reference'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SD_PURCHASE_ORDER_BY_SHIPTO'
    PurchaseOrderByShipToParty : String(35) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Purchase Order Item'
    @Common.Heading : 'POItem'
    @Common.QuickInfo : 'Item Number of the Underlying Purchase Order'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=POSEX_E'
    UndrlgPurOrdItmByShipToParty : String(6) not null;
    @Common.Label : 'Your Reference'
    @Common.Heading : 'Ship-to Char'
    @Common.QuickInfo : 'Ship-to Party Character'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=IHREZ_E'
    CorrespncExtRefByShipToParty : String(12) not null;
    @Core.Computed : true
    @Measures.Unit : OrderQuantitySAPUnit
    @Measures.UNECEUnit : OrderQuantityISOUnit
    @Common.Label : 'Confirmed Quantity'
    @Common.QuickInfo : 'Cumulative Confirmed Quantity in Sales Unit'
    ConfdDelivQtyInOrderQtyUnit : Decimal(15, 3) not null;
    @Common.IsUnit : true
    @Core.Computed : true
    @Common.Label : 'Sales Unit'
    @Common.Heading : 'SU'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VRKME'
    OrderQuantitySAPUnit : String(3) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'ISO Order Quantity'
    @Common.Heading : 'ISO Unit Code for Order Quantity'
    @Common.QuickInfo : 'ISO Unit Code for Order Quantity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SD_ORD_QTY_ISOUNIT'
    OrderQuantityISOUnit : String(3) not null;
    @Measures.Unit : RequestedQuantitySAPUnit
    @Measures.UNECEUnit : RequestedQuantityISOUnit
    @Validation.Minimum : 0
    @Common.Label : 'Requested Quantity'
    @Common.Heading : 'Reqd Qty'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=REQD_QTY'
    RequestedQuantity : Decimal(15, 3) not null;
    @Common.IsUnit : true
    @Common.Label : 'Requested Qty Unit'
    @Common.Heading : 'RQ Unit'
    @Common.QuickInfo : 'Unit of the Requested Quantity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=REQD_QTY_UNIT'
    RequestedQuantitySAPUnit : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'ISO Code Req. Qty'
    @Common.Heading : 'ISO Unit Code for Requested Quantity'
    @Common.QuickInfo : 'ISO Unit Code for Requested Quantity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SD_REQD_QTY_ISOUNIT'
    RequestedQuantityISOUnit : String(3) not null;
    @Core.Immutable : true
    @Common.IsUpperCase : true
    @Common.Label : 'Reference Document'
    @Common.Heading : 'Ref. Doc.'
    @Common.QuickInfo : 'Document Number of Reference Document'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VGBEL'
    ReferenceSDDocument : String(10);
    @Core.Immutable : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Reference Item'
    @Common.Heading : 'RefItm'
    @Common.QuickInfo : 'Item Number of the Reference Item'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VGPOS'
    ReferenceSDDocumentItem : String(6);
    @Core.Computed : true
    @Common.Label : 'Reference Document Category'
    ReferenceSDDocumentCategory : String(4);
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Solution Order Item'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=CRMS4_SOLO_NUMBER_INT'
    BusinessSolutionOrderItem : String(6);
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Bundle Item No.'
    @Common.Heading : 'Bundle Item Number'
    @Common.QuickInfo : 'Bundle Item Number in Document'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=CRMS4_BUNDLE_ITEM_NUMBER'
    BusSolnOrdItemBundleItem : String(6);
    @Measures.Unit : ItemWeightSAPUnit
    @Measures.UNECEUnit : ItemWeightISOUnit
    @Common.Label : 'Gross Weight'
    @Common.QuickInfo : 'Gross Weight of the Item'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BRGEW_AP'
    ItemGrossWeight : Decimal(15, 3) not null;
    @Measures.Unit : ItemWeightSAPUnit
    @Measures.UNECEUnit : ItemWeightISOUnit
    @Common.Label : 'Net Weight'
    @Common.QuickInfo : 'Net Weight of the Item'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NTGEW_AP'
    ItemNetWeight : Decimal(15, 3) not null;
    @Common.IsUnit : true
    @Common.Label : 'Unit of Weight'
    @Common.Heading : 'WUn'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GEWEI'
    ItemWeightSAPUnit : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'ISO Code Item Weight'
    @Common.Heading : 'ISO Unit Code for Item Weight'
    @Common.QuickInfo : 'ISO Unit Code for Item Weight'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SD_ITM_WGT_ISOUNIT'
    ItemWeightISOUnit : String(3) not null;
    @Measures.Unit : ItemVolumeSAPUnit
    @Measures.UNECEUnit : ItemVolumeISOUnit
    @Common.Label : 'Volume'
    @Common.QuickInfo : 'Volume of the item'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VOLUM_AP'
    ItemVolume : Decimal(15, 3) not null;
    @Common.IsUnit : true
    @Common.Label : 'Volume Unit'
    @Common.Heading : 'VUn'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VOLEH'
    ItemVolumeSAPUnit : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'ISO Unit Item Volume'
    @Common.Heading : 'ISO Unit Code for Item Volume'
    @Common.QuickInfo : 'ISO Unit Code for Item Volume'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SD_ITM_VOL_ISOUNIT'
    ItemVolumeISOUnit : String(3) not null;
    @Common.Label : 'Requested Delivery Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=REQD_DELIVERY_DATE'
    RequestedDeliveryDate : Date;
    @Core.Computed : true
    @Common.Label : 'Confirmed Delivery Date'
    ConfirmedDeliveryDate : Date;
    @Common.Label : 'Pricing Date'
    @Common.Heading : 'Pricing Dt'
    @Common.QuickInfo : 'Date for Pricing and Exchange Rate'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PRSDT'
    PricingDate : Date;
    @Common.Label : 'Date of Services Rendered'
    @Common.QuickInfo : 'Date on which services are rendered'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VDM_SD_SERVICES_RENDERED_DATE'
    ServicesRenderedDate : Date;
    @Common.Label : 'Billing Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FKDAT'
    BillingDocumentDate : Date;
    @Core.Computed : true
    @Measures.ISOCurrency : TransactionCurrency
    @Common.Label : 'Net Value'
    @Common.QuickInfo : 'Net Value of the Document Item in Document Currency'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NETWR_AP'
    NetAmount : Decimal(precision: 15) not null;
    @Common.SAPObjectNodeTypeReference : 'Currency'
    @Common.IsCurrency : true
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Document Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'SD Document Currency'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERK'
    TransactionCurrency : String(3) not null;
    @Core.Computed : true
    @Measures.ISOCurrency : TransactionCurrency
    @Common.Label : 'Tax Amount'
    @Common.QuickInfo : 'Tax Amount in Document Currency'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MWSBP'
    TaxAmount : Decimal(precision: 13) not null;
    @Core.Computed : true
    @Measures.ISOCurrency : TransactionCurrency
    @Common.Label : 'Subtotal 1'
    @Common.QuickInfo : 'Subtotal 1 from Pricing Procedure for Price Element'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KZWI1'
    Subtotal1Amount : Decimal(precision: 13) not null;
    @Core.Computed : true
    @Measures.ISOCurrency : TransactionCurrency
    @Common.Label : 'Subtotal 2'
    @Common.QuickInfo : 'Subtotal 2 from Pricing Procedure for Price Element'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KZWI2'
    Subtotal2Amount : Decimal(precision: 13) not null;
    @Core.Computed : true
    @Measures.ISOCurrency : TransactionCurrency
    @Common.Label : 'Subtotal 3'
    @Common.QuickInfo : 'Subtotal 3 from Pricing Procedure for Price Element'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KZWI3'
    Subtotal3Amount : Decimal(precision: 13) not null;
    @Core.Computed : true
    @Measures.ISOCurrency : TransactionCurrency
    @Common.Label : 'Subtotal 4'
    @Common.QuickInfo : 'Subtotal 4 from Pricing Procedure for Price Element'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KZWI4'
    Subtotal4Amount : Decimal(precision: 13) not null;
    @Core.Computed : true
    @Measures.ISOCurrency : TransactionCurrency
    @Common.Label : 'Subtotal 5'
    @Common.QuickInfo : 'Subtotal 5 from Pricing Procedure for Price Element'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KZWI5'
    Subtotal5Amount : Decimal(precision: 13) not null;
    @Core.Computed : true
    @Measures.ISOCurrency : TransactionCurrency
    @Common.Label : 'Subtotal 6'
    @Common.QuickInfo : 'Subtotal 6 from Pricing Procedure for Price Element'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KZWI6'
    Subtotal6Amount : Decimal(precision: 13) not null;
    @Common.SAPObjectNodeTypeReference : 'CustomerGroup'
    @Common.IsUpperCase : true
    @Common.Label : 'Customer Group'
    @Common.Heading : 'CGrp'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KDGRP'
    CustomerGroup : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Batch'
    @Common.QuickInfo : 'Batch Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=CHARG_D'
    Batch : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Plant'
    @Common.Heading : 'Plnt'
    @Common.QuickInfo : 'Plant (Own or External)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WERKS_EXT'
    Plant : String(4) not null;
    @Common.SAPObjectNodeTypeReference : 'StorageLocation'
    @Common.IsUpperCase : true
    @Common.Label : 'Storage Location'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LGORT_D'
    StorageLocation : String(4) not null;
    @Common.SAPObjectNodeTypeReference : 'ShippingPoint'
    @Common.IsUpperCase : true
    @Common.Label : 'Shipping Point'
    @Common.Heading : 'ShPt'
    @Common.QuickInfo : 'Shipping Point / Receiving Point'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VSTEL'
    ShippingPoint : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Shipping Type'
    @Common.Heading : 'ST'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VSARTTR'
    ShippingType : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Route'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ROUTE'
    Route : String(6) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Delivery Priority'
    @Common.Heading : 'DPrio'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LPRIO'
    DeliveryPriority : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Partial Delivery for Item'
    @Common.Heading : 'Partial Delivery at Item Level'
    @Common.QuickInfo : 'Partial Delivery at Item Level'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PARTIAL_DELIVERY_ALLOWED'
    PartialDeliveryIsAllowed : String(1) not null;
    @Common.Label : 'Number of Partial Deliveries'
    @Common.QuickInfo : 'Number of Allowed Partial Deliveries'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NMBRPARTIALDELIV'
    MaxNmbrOfPartialDelivery : Decimal(precision: 1) not null;
    @Common.SAPObjectNodeTypeReference : 'DeliveryDateTypeRule'
    @Common.IsUpperCase : true
    @Common.Label : 'Deliv Date Rule'
    @Common.Heading : 'DlvDteRule'
    @Common.QuickInfo : 'Delivery Date Rule'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SD_DELIVERY_DATE_TYPE_RULE'
    DeliveryDateTypeRule : String(1) not null;
    @Common.Label : 'Receiving Point'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=EMPST'
    ReceivingPoint : String(25) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Delivery Group'
    @Common.Heading : 'Grp'
    @Common.QuickInfo : 'Delivery Group (Items are delivered together)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GRKOR'
    DeliveryGroup : String(3) not null;
    @Common.SAPObjectNodeTypeReference : 'IncotermsClassification'
    @Common.IsUpperCase : true
    @Common.Label : 'Incoterms'
    @Common.Heading : 'IncoT'
    @Common.QuickInfo : 'Incoterms (Part 1)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INCO1'
    IncotermsClassification : String(3) not null;
    @Common.Label : 'Incoterms Location 1'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INCO2_L'
    IncotermsLocation1 : String(70) not null;
    @Common.Label : 'Incoterms Location 2'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INCO3_L'
    IncotermsLocation2 : String(70) not null;
    @Common.SAPObjectNodeTypeReference : 'IncotermsVersion'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Incoterms Version'
    @Common.Heading : 'IncoV'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=INCOV'
    IncotermsVersion : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Terms of Payment'
    @Common.QuickInfo : 'Key for Terms of Payment'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=DZTERM'
    CustomerPaymentTerms : String(4) not null;
    @Common.Label : 'Fixed Value Date'
    @Common.Heading : 'FixValDate'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VALDT'
    FixedValueDate : Date;
    @Common.SAPObjectNodeTypeReference : 'CustomerPriceGroup'
    @Common.IsUpperCase : true
    @Common.Label : 'Customer Price Group'
    @Common.Heading : 'CPG'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KONDA'
    CustomerPriceGroup : String(2) not null;
    @Common.SAPObjectNodeTypeReference : 'MaterialPricingGroup'
    @Common.IsUpperCase : true
    @Common.Label : 'Product Price Group'
    @Common.Heading : 'PPG'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTPRICINGGROUP'
    MaterialPricingGroup : String(2) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Business Area'
    @Common.Heading : 'BusA'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GSBER'
    BusinessArea : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Profit Center'
    @Common.Heading : 'Profit Ctr'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PRCTR'
    ProfitCenter : String(10) not null;
    @Common.SAPObjectNodeTypeReference : 'MaterialAccountAssignmentGroup'
    @Common.IsUpperCase : true
    @Common.Label : 'Acct Assmt Grp Mat.'
    @Common.Heading : 'AAGM'
    @Common.QuickInfo : 'Account Assignment Group for Material'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KTGRM'
    MatlAccountAssignmentGroup : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'WBS Element'
    @Common.QuickInfo : 'Work Breakdown Structure Element (WBS Element) Edited'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PS_POSID_EDIT'
    WBSElementExternalID : String(24) not null;
    @Common.SAPObjectNodeTypeReference : 'BillingBlockReason'
    @Common.IsUpperCase : true
    @Common.Label : 'Billing Block'
    @Common.Heading : 'BB'
    @Common.QuickInfo : 'Billing Block for Item'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FAKSP_AP'
    ItemBillingBlockReason : String(2) not null;
    @Common.SAPObjectNodeTypeReference : 'SalesDocumentRjcnReason'
    @Common.IsUpperCase : true
    @Common.Label : 'Reason for Rejection'
    @Common.Heading : 'Rj'
    @Common.QuickInfo : 'Reason for Rejection of Sales Documents'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ABGRU_VA'
    SalesDocumentRjcnReason : String(2) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Configuration'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=CUOBJ_VA'
    ProductConfiguration : String(18) not null;
    @Core.Immutable : true
    @Common.IsUpperCase : true
    @Common.Label : 'Contract Autom. Asmt'
    @Common.Heading : 'Sales Contract for Automatic Assignments'
    @Common.QuickInfo : 'Sales Contract for Automatic Assignments'
    SlsContrAutoAssgmtIDForSlsOrd : String(10);
    @Common.SAPObjectNodeTypeReference : 'SDProcessStatus'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Overall Status'
    @Common.Heading : 'OS'
    @Common.QuickInfo : 'Overall Processing Status (Item)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GBSTA'
    SDProcessStatus : String(1) not null;
    @Common.SAPObjectNodeTypeReference : 'SalesDocPurchaseConfStatus'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Purchasing Confirmation Status'
    @Common.QuickInfo : 'Purchasing Confirmation Status (Item)'
    PurchaseConfirmationStatus : String(1) not null;
    @Common.SAPObjectNodeTypeReference : 'SalesDocRejectionStatus'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Rejection Status'
    @Common.QuickInfo : 'Rejection Status (Item)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ABSTA_VB'
    SDDocumentRejectionStatus : String(1) not null;
    @Common.SAPObjectNodeTypeReference : 'SalesDocDeliveryStatus'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Delivery Status'
    @Common.Heading : 'DS'
    @Common.QuickInfo : 'Delivery Status (Item)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LFSTA'
    DeliveryStatus : String(1) not null;
    @Common.SAPObjectNodeTypeReference : 'SalesDocItemBillingBlockStatus'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Billing Block Status'
    @Common.Heading : 'BS'
    @Common.QuickInfo : 'Billing Block Status (Item)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FSSTA'
    BillingBlockStatus : String(1) not null;
    @Common.SAPObjectNodeTypeReference : 'SlsDocItemGenIncompltnStatus'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Incompletion Status'
    @Common.Heading : 'Item General Incompletion Status'
    @Common.QuickInfo : 'Incompletion Status (Item)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ITEM_GENERAL_INCOMPLETION_STS'
    ItemGeneralIncompletionStatus : String(1) not null;
    @Common.SAPObjectNodeTypeReference : 'SalesDocDeliveryBlockStatus'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Delivery Block Status'
    @Common.QuickInfo : 'Delivery Block Status (Item)'
    DeliveryBlockStatus : String(1) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Down Payment Status'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=DP_CLEAR_STA'
    SlsOrderItemDownPaymentStatus : String(1) not null;
    @Common.SAPObjectNodeTypeReference : 'OrderRelatedBillingStatus'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Order-Related Billing Status'
    @Common.QuickInfo : 'Order-Related Billing Status (Item)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SLS_DOC_ORDER_REL_BILLING_STS'
    OrderRelatedBillingStatus : String(1) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Product Marketability Status'
    @Common.QuickInfo : 'Product Marketability Status (Item)'
    ChmlCmplncStatus : String(1) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Dangerous Goods Status'
    @Common.QuickInfo : 'Dangerous Goods Status (Item)'
    DangerousGoodsStatus : String(1) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Safety Data Sheet Status'
    @Common.QuickInfo : 'Safety Data Sheet Status (Item)'
    SafetyDataSheetStatus : String(1) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Embargo Status'
    @Common.QuickInfo : 'Embargo Status (Item)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=EMBARGOCHKSTS'
    TrdCmplncEmbargoSts : String(1) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Screening Status'
    @Common.QuickInfo : 'Screening Status (Item)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WATCHLISTSCRNGCHKSTS'
    TrdCmplncSnctndListChkSts : String(1) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Legal Control Status'
    @Common.QuickInfo : 'Legal Control Status (All Schedule Lines)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LGLCTRLCHKSTS'
    OvrlTrdCmplncLegalCtrlChkSts : String(1) not null;
    SAP__Messages : many SAP__Message not null;
    @Common.Composition : true
    _ItemPartner : Composition of many SalesOrderItemPartner on _ItemPartner._Item = $self;
    @Common.Composition : true
    _ItemPricingElement : Composition of many SalesOrderItemPricingElement on _ItemPricingElement._Item = $self;
    @Common.Composition : true
    _ItemText : Composition of many SalesOrderItemText on _ItemText._Item = $self;
    _SalesOrder : Association to one SalesOrder;
    @Common.Composition : true
    _ScheduleLine : Composition of many SalesOrderScheduleLine on _ScheduleLine._Item = $self;
    _VariantConfiguration : Composition of one VariantConfiguration_Type {  };
  } actions {
    action UpdatePrices(
      @Common.Label : 'Pricing Type'
      @Common.FieldControl : #Mandatory
      @Common.IsUpperCase : true
      @Common.Heading : 'PrTy'
      @Common.QuickInfo : 'Pricing Type'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KNPRS'
      PricingType : String(1) not null
    );
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Item Partner'
  @Common.SemanticKey : [ 'PartnerFunction', 'SalesOrderItem', 'SalesOrder' ]
  @Communication.Contact.email : [ { address: EmailAddress } ]
  @Common.Messages : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties : [
    { NavigationProperty: _Item, DeepUpdateSupport: { Supported: false } },
    {
      NavigationProperty: _SalesOrder,
      InsertRestrictions: { Insertable: false },
      DeepUpdateSupport: { Supported: false }
    }
  ]
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.FilterRestrictions.NonFilterableProperties : [
    'BusinessPartnerName1',
    'BusinessPartnerName2',
    'BusinessPartnerName3',
    'BusinessPartnerName4'
  ]
  @Capabilities.SortRestrictions.NonSortableProperties : [
    'BusinessPartnerName1',
    'BusinessPartnerName2',
    'BusinessPartnerName3',
    'BusinessPartnerName4'
  ]
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported : true
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_Item', '_SalesOrder' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported : true
  @Capabilities.InsertRestrictions.Insertable : false
  @Core.OptimisticConcurrency : [ '_SalesOrder/LastChangeDateTime' ]
  entity SalesOrderItemPartner {
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Sales Order'
    @Common.Heading : 'SO'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VDM_SALES_ORDER'
    key SalesOrder : String(10) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Item'
    @Common.Heading : 'SO Item'
    @Common.QuickInfo : 'Sales Order Item'
    key SalesOrderItem : String(6) not null;
    @Common.SAPObjectNodeTypeReference : 'PartnerFunction'
    @Core.ComputedDefaultValue : true
    @Common.IsUpperCase : true
    @Common.Label : 'Partner Function'
    @Common.Heading : 'PartF'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PARVW_UNV'
    key PartnerFunction : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Customer'
    @Common.QuickInfo : 'Customer Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KUNNR'
    Customer : String(10);
    @Common.IsUpperCase : true
    @Common.Label : 'Supplier'
    @Common.QuickInfo : 'Account Number of Supplier'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LIFNR'
    Supplier : String(10);
    @Common.IsDigitSequence : true
    @Common.Label : 'Personnel Number'
    @Common.Heading : 'Pers.No.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PERNR_D'
    Personnel : String(8);
    @Common.IsDigitSequence : true
    @Common.Label : 'Contact Person'
    @Common.Heading : 'Partner'
    @Common.QuickInfo : 'Number of Contact Person'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PARNR'
    ContactPerson : String(10);
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Business Partner'
    @Common.QuickInfo : 'Business Partner Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BU_PARTNER'
    ReferenceBusinessPartner : String(10) not null;
    @Common.Label : 'Name'
    @Common.QuickInfo : 'Name 1'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_NAME1'
    BusinessPartnerName1 : String(40) not null;
    @Common.Label : 'Name 2'
    BusinessPartnerName2 : String(40) not null;
    @Common.Label : 'Name 3'
    BusinessPartnerName3 : String(40) not null;
    @Common.Label : 'Name 4'
    BusinessPartnerName4 : String(40) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Address Number'
    @Common.Heading : 'Addr. No.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_ADDRNUM'
    AddressID : String(10);
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Person Number'
    @Common.Heading : 'Person'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_PERSNUM'
    AddressPersonID : String(10);
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Address Type'
    @Common.Heading : 'Type'
    @Common.QuickInfo : 'Address type (1=Organization, 2=Person, 3=Contact person)'
    AddressObjectType : String(1) not null;
    @Common.Label : 'Street'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_STREET'
    StreetName : String(60) not null;
    @Common.Label : 'Street 2'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_STRSPP1'
    StreetPrefixName1 : String(40) not null;
    @Common.Label : 'Street 3'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_STRSPP2'
    StreetPrefixName2 : String(40) not null;
    @Common.Label : 'Street 4'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_STRSPP3'
    StreetSuffixName1 : String(40) not null;
    @Common.Label : 'Street 5'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_LCTN'
    StreetSuffixName2 : String(40) not null;
    @Common.Label : 'House Number'
    @Common.Heading : 'House No.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_HSNM1'
    HouseNumber : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Postal Code'
    @Common.Heading : 'Post. Code'
    @Common.QuickInfo : 'City Postal Code'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_PSTCD1'
    PostalCode : String(10) not null;
    @Common.Label : 'City'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_CITY1'
    CityName : String(40) not null;
    @Common.Label : 'District'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_CITY2'
    DistrictName : String(40) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Region'
    @Common.Heading : 'Rg'
    @Common.QuickInfo : 'Region (State, Province, County)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=REGIO'
    Region : String(3) not null;
    @Common.SAPObjectNodeTypeReference : 'Country'
    @Common.IsUpperCase : true
    @Common.Label : 'Country/Region Key'
    @Common.Heading : 'C/R'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LAND1'
    Country : String(3) not null;
    @Common.SAPObjectNodeTypeReference : 'Country'
    @Common.IsUpperCase : true
    @Common.Label : 'Country/Region'
    @Common.Heading : 'Ctry/Reg.'
    @Common.QuickInfo : 'Country/Region for Telephone/Fax Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_COMCTRY'
    PhoneNumberCountry : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Telephone'
    @Common.QuickInfo : 'Telephone No.: Dialing Code and Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_TLNMBR'
    PhoneNumber : String(30) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Extension'
    @Common.QuickInfo : 'Telephone no.: Extension'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_TLXTNS'
    PhoneNumberExtension : String(10) not null;
    @Common.SAPObjectNodeTypeReference : 'Country'
    @Common.IsUpperCase : true
    @Common.Label : 'Country/Region'
    @Common.Heading : 'Ctry/Reg.'
    @Common.QuickInfo : 'Country/Region for Telephone/Fax Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_COMCTRY'
    MobilePhoneCountry : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Telephone'
    @Common.QuickInfo : 'Telephone No.: Dialing Code and Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_TLNMBR'
    MobilePhoneNumber : String(30) not null;
    @Common.SAPObjectNodeTypeReference : 'Country'
    @Common.IsUpperCase : true
    @Common.Label : 'Country/Region'
    @Common.Heading : 'Ctry/Reg.'
    @Common.QuickInfo : 'Country/Region for Telephone/Fax Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_COMCTRY'
    FaxNumberCountry : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Fax'
    @Common.QuickInfo : 'Fax Number: Dialing Code and Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_FXNMBR'
    FaxNumber : String(30) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Extension'
    @Common.QuickInfo : 'Fax no.: Extension'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_FXXTNS'
    FaxNumberExtension : String(10) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Phone'
    @Common.QuickInfo : 'Landline Phone'
    InternationalPhoneNumber : String(30) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Mobile'
    @Common.QuickInfo : 'Cell Phone'
    InternationalMobilePhoneNumber : String(30) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Fax'
    @Common.QuickInfo : 'Fax Number'
    InternationalFaxNumber : String(30) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'PO Box'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_POBX'
    POBox : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'PO Box Postal Code'
    @Common.Heading : 'Postl Code'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_PSTCD2'
    POBoxPostalCode : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Title Key'
    @Common.Heading : 'Key'
    @Common.QuickInfo : 'Form-of-Address Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_TITLE'
    FormOfAddress : String(4) not null;
    @Common.Label : 'Correspondence Language'
    @Common.Heading : 'LG'
    @Common.QuickInfo : 'Business Partner: Correspondence Language'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BU_LANGU_CORR'
    CorrespondenceLanguage : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Email'
    @Common.QuickInfo : 'Email Address'
    EmailAddress : String(241) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Tax Jurisdiction'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_TXJCD'
    TaxJurisdiction : String(15) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Transportation Zone'
    @Common.Heading : 'TranspZone'
    @Common.QuickInfo : 'Transportation zone to or from which the goods are delivered'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LZONE'
    TransportZone : String(10) not null;
    @Common.Label : 'Unloading Point'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ABLAD'
    UnloadingPointName : String(25);
    @Common.IsUpperCase : true
    @Common.Label : 'VAT Registration No.'
    @Common.QuickInfo : 'VAT Registration Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=STCEG'
    VATRegistration : String(20);
    @Core.Computed : true
    @Common.Label : 'Item-Specific Partner'
    @Common.QuickInfo : 'Partner is specific for item'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SD_PARTNER_ITEM_IND'
    PartnerIsSpecificForSDDocItem : Boolean not null;
    @Core.Computed : true
    @Common.Label : 'Doc-Specific Address'
    @Common.Heading : 'Doc. Addr'
    @Common.QuickInfo : 'Document-Specific Address'
    SDDocPartnerAddrIsDocSpecific : Boolean not null;
    SAP__Messages : many SAP__Message not null;
    _Item : Association to one SalesOrderItem;
    _SalesOrder : Association to one SalesOrder {  };
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Item Pricing Element'
  @Common.SemanticKey : [
    'PricingProcedureCounter',
    'PricingProcedureStep',
    'SalesOrderItem',
    'SalesOrder'
  ]
  @Common.Messages : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties : [
    {
      NavigationProperty: _Item,
      DeepUpdateSupport: { Supported: false },
      SortRestrictions: { Sortable: false },
      FilterRestrictions: { Filterable: false }
    },
    {
      NavigationProperty: _SalesOrder,
      InsertRestrictions: { Insertable: false },
      DeepUpdateSupport: { Supported: false },
      SortRestrictions: { Sortable: false },
      FilterRestrictions: { Filterable: false }
    }
  ]
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.InsertRestrictions.RequiredProperties : [ 'ConditionType' ]
  @Capabilities.InsertRestrictions.Insertable : false
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported : true
  @Capabilities.UpdateRestrictions.NonUpdatableProperties : [
    'ConditionType',
    'ConditionRateRatioSAPUnit',
    'ConditionRateRatioISOUnit'
  ]
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_Item', '_SalesOrder' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported : true
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions : [
    { Property: ConditionQuantity, AllowedExpressions: 'MultiValue' },
    { Property: ConditionBaseQuantity, AllowedExpressions: 'MultiValue' },
    { Property: ConditionQuantitySAPUnit, AllowedExpressions: 'MultiValue' },
    { Property: ConditionQuantityISOUnit, AllowedExpressions: 'MultiValue' },
    { Property: ConditionRateRatio, AllowedExpressions: 'MultiValue' },
    { Property: ConditionRateRatioSAPUnit, AllowedExpressions: 'MultiValue' },
    { Property: ConditionRateRatioISOUnit, AllowedExpressions: 'MultiValue' },
    { Property: ConditionAmount, AllowedExpressions: 'MultiValue' },
    { Property: CndnRoundingOffDiffAmount, AllowedExpressions: 'MultiValue' }
  ]
  entity SalesOrderItemPricingElement {
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Sales Order'
    @Common.Heading : 'SO'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VDM_SALES_ORDER'
    key SalesOrder : String(10) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Item'
    @Common.Heading : 'SO Item'
    @Common.QuickInfo : 'Sales Order Item'
    key SalesOrderItem : String(6) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Step Number'
    @Common.Heading : 'Step'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=STUNR'
    key PricingProcedureStep : String(3) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Counter'
    @Common.Heading : 'Cntr'
    @Common.QuickInfo : 'Condition Counter'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VFPRC_COND_COUNT'
    key PricingProcedureCounter : String(3) not null;
    @Common.SAPObjectNodeTypeReference : 'SalesPricingConditionType'
    @Core.Immutable : true
    @Common.IsUpperCase : true
    @Common.Label : 'Condition Type'
    @Common.Heading : 'CnTy'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KSCHA'
    ConditionType : String(4) not null;
    @Core.Computed : true
    @Common.Label : 'Description'
    @Common.QuickInfo : 'Description of a Price Element'
    PriceElementDescription : String(40) not null;
    @Common.SAPObjectNodeTypeReference : 'PriceConditionCalculationType'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Calculation Type'
    @Common.Heading : 'CalTy'
    @Common.QuickInfo : 'Calculation Type for Condition'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KRECH_LONG'
    ConditionCalculationType : String(3) not null;
    @Measures.ISOCurrency : ConditionCurrency
    @Common.Label : 'Condition Amount'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VFPRC_RATE_AMOUNT'
    ConditionRateAmount : Decimal(24, 9);
    @Common.SAPObjectNodeTypeReference : 'Currency'
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    ConditionCurrency : String(3) not null;
    @Measures.Unit : ConditionQuantitySAPUnit
    @Measures.UNECEUnit : ConditionQuantityISOUnit
    @Common.Label : 'Pricing Unit'
    @Common.Heading : 'per'
    @Common.QuickInfo : 'Condition Pricing Unit'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KPEIN'
    ConditionQuantity : Decimal(precision: 5);
    @Core.Computed : true
    @Measures.Unit : ConditionQuantitySAPUnit
    @Measures.UNECEUnit : ConditionQuantityISOUnit
    @Common.Label : 'Quantity'
    @Common.QuickInfo : 'Quantity of the Condition Basis'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VFPRC_ELEMENT_QUANTITY'
    ConditionBaseQuantity : Decimal(24, 9);
    @Common.IsUnit : true
    @Common.Label : 'Condition Unit'
    @Common.Heading : 'UoM'
    @Common.QuickInfo : 'Condition Unit in the Document'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KVMEI'
    ConditionQuantitySAPUnit : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'ISO Condition Qty'
    @Common.Heading : 'ISO Code for Condition Quantity'
    @Common.QuickInfo : 'ISO Unit Code for Condition Quantity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SD_CNDN_QTY_ISOUNIT'
    ConditionQuantityISOUnit : String(3) not null;
    @Measures.Unit : ConditionRateRatioSAPUnit
    @Measures.UNECEUnit : ConditionRateRatioISOUnit
    @Common.Label : 'Ratio'
    @Common.QuickInfo : 'Condition Ratio (in Percent or Per Mille)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VFPRC_ELEMENT_RATIO'
    ConditionRateRatio : Decimal(24, 9);
    @Common.IsUnit : true
    @Core.Immutable : true
    @Common.Label : 'Internal UoM'
    @Common.Heading : 'MU'
    @Common.QuickInfo : 'Unit of Measurement'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MSEHI'
    ConditionRateRatioSAPUnit : String(3) not null;
    @Core.Immutable : true
    @Common.IsUpperCase : true
    @Common.Label : 'ISO Unit Code for Condition Ratio'
    ConditionRateRatioISOUnit : String(3) not null;
    @Measures.ISOCurrency : TransactionCurrency
    @Common.Label : 'Condition Value'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VFPRC_ELEMENT_VALUE'
    ConditionAmount : Decimal(precision: 15);
    @Core.Computed : true
    @Measures.ISOCurrency : TransactionCurrency
    @Common.Label : 'Cndn Bs Amt'
    @Common.Heading : 'Condition Basis Amount'
    @Common.QuickInfo : 'Amount of the Condition Basis'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VFPRC_BASE_AMOUNT'
    ConditionBaseAmount : Decimal(24, 9);
    @Common.SAPObjectNodeTypeReference : 'Currency'
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Document Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'SD Document Currency'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERK'
    TransactionCurrency : String(3) not null;
    @Core.Computed : true
    @Measures.ISOCurrency : TransactionCurrency
    @Common.Label : 'Condition Rounding Difference'
    @Common.QuickInfo : 'Rounding-Off Difference of a Condition'
    CndnRoundingOffDiffAmount : Decimal(precision: 5);
    @Common.SAPObjectNodeTypeReference : 'PriceConditionInactiveReason'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Inactive Condition'
    @Common.Heading : 'Inact'
    @Common.QuickInfo : 'Condition is Inactive'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KINAK'
    ConditionInactiveReason : String(1);
    @Common.SAPObjectNodeTypeReference : 'PriceConditionClass'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Condition Class'
    @Common.Heading : 'CCl'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KOAID'
    ConditionClass : String(1);
    @Common.SAPObjectNodeTypeReference : 'PriceConditionControl'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Condition Control'
    @Common.Heading : 'Ctrl'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KSTEU'
    ConditionControl : String(1);
    @Common.SAPObjectNodeTypeReference : 'PriceConditionOrigin'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Condition Origin'
    @Common.Heading : 'Orig'
    @Common.QuickInfo : 'Origin of the Condition'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KHERK'
    ConditionOrigin : String(1);
    @Core.Computed : true
    @Common.Label : 'Statistical'
    @Common.Heading : 'Stat'
    @Common.QuickInfo : 'Condition is used for statistics'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KSTAT'
    ConditionIsForStatistics : Boolean;
    @Core.Computed : true
    @Common.Label : 'Changed Manually'
    @Common.Heading : 'Man'
    @Common.QuickInfo : 'Condition Changed Manually'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KMPRS'
    ConditionIsManuallyChanged : Boolean;
    @Common.SAPObjectNodeTypeReference : 'SalesTaxCode'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Tax Code'
    @Common.Heading : 'Tx'
    @Common.QuickInfo : 'Tax on Sales/Purchases Code'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MWSKZ'
    TaxCode : String(2);
    @Common.SAPObjectNodeTypeReference : 'PricingVariantCondition'
    @Core.Computed : true
    @Common.Label : 'Variant Key'
    @Common.Heading : 'Variant'
    @Common.QuickInfo : 'Variant Condition Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VARCOND'
    VariantCondition : String(26);
    @Core.Computed : true
    @Common.Label : 'Is Group Condition'
    @Common.QuickInfo : 'Condition Is a Group Condition'
    IsGroupCondition : Boolean;
    SAP__Messages : many SAP__Message not null;
    _Item : Association to one SalesOrderItem;
    _SalesOrder : Association to one SalesOrder {  };
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Item Text'
  @Common.SemanticKey : [ 'LongTextID', 'Language', 'SalesOrderItem', 'SalesOrder' ]
  @Common.Messages : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties : [
    { NavigationProperty: _Item, DeepUpdateSupport: { Supported: false } },
    {
      NavigationProperty: _SalesOrder,
      InsertRestrictions: { Insertable: false },
      DeepUpdateSupport: { Supported: false }
    }
  ]
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.FilterRestrictions.Filterable : true
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions : [ { Property: LongText, AllowedExpressions: 'SearchExpression' } ]
  @Capabilities.FilterRestrictions.NonFilterableProperties : [ 'LongText' ]
  @Capabilities.SortRestrictions.NonSortableProperties : [ 'LongText' ]
  @Capabilities.InsertRestrictions.RequiredProperties : [ 'LongText' ]
  @Capabilities.InsertRestrictions.Insertable : false
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported : true
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_Item', '_SalesOrder' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported : true
  @Core.OptimisticConcurrency : [ '_SalesOrder/LastChangeDateTime' ]
  entity SalesOrderItemText {
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Sales Order'
    @Common.Heading : 'SO'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VDM_SALES_ORDER'
    key SalesOrder : String(10) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Item'
    @Common.Heading : 'SO Item'
    @Common.QuickInfo : 'Sales Order Item'
    key SalesOrderItem : String(6) not null;
    @Core.ComputedDefaultValue : true
    @Common.Label : 'Language Key'
    @Common.Heading : 'Language'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SPRAS'
    key Language : String(2) not null;
    @Core.ComputedDefaultValue : true
    @Common.IsUpperCase : true
    @Common.Label : 'Text ID'
    @Common.Heading : 'ID'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TDID'
    key LongTextID : String(4) not null;
    @Common.Label : 'String'
    LongText : String not null;
    SAP__Messages : many SAP__Message not null;
    _Item : Association to one SalesOrderItem;
    _SalesOrder : Association to one SalesOrder {  };
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Header Partner'
  @Common.SemanticKey : [ 'PartnerFunction', 'SalesOrder' ]
  @Communication.Contact.email : [ { address: EmailAddress } ]
  @Common.Messages : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties : [
    {
      NavigationProperty: _SalesOrder,
      InsertRestrictions: { Insertable: false },
      DeepUpdateSupport: { Supported: false }
    }
  ]
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.FilterRestrictions.NonFilterableProperties : [
    'BusinessPartnerName1',
    'BusinessPartnerName2',
    'BusinessPartnerName3',
    'BusinessPartnerName4'
  ]
  @Capabilities.SortRestrictions.NonSortableProperties : [
    'BusinessPartnerName1',
    'BusinessPartnerName2',
    'BusinessPartnerName3',
    'BusinessPartnerName4'
  ]
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported : true
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_SalesOrder' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported : true
  @Capabilities.InsertRestrictions.Insertable : false
  @Core.OptimisticConcurrency : [ '_SalesOrder/LastChangeDateTime' ]
  entity SalesOrderPartner {
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Sales Order'
    @Common.Heading : 'SO'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VDM_SALES_ORDER'
    key SalesOrder : String(10) not null;
    @Common.SAPObjectNodeTypeReference : 'PartnerFunction'
    @Core.ComputedDefaultValue : true
    @Common.IsUpperCase : true
    @Common.Label : 'Partner Function'
    @Common.Heading : 'PartF'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PARVW_UNV'
    key PartnerFunction : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Customer'
    @Common.QuickInfo : 'Customer Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KUNNR'
    Customer : String(10);
    @Common.IsUpperCase : true
    @Common.Label : 'Supplier'
    @Common.QuickInfo : 'Account Number of Supplier'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LIFNR'
    Supplier : String(10);
    @Common.IsDigitSequence : true
    @Common.Label : 'Personnel Number'
    @Common.Heading : 'Pers.No.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PERNR_D'
    Personnel : String(8);
    @Common.IsDigitSequence : true
    @Common.Label : 'Contact Person'
    @Common.Heading : 'Partner'
    @Common.QuickInfo : 'Number of Contact Person'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PARNR'
    ContactPerson : String(10);
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Business Partner'
    @Common.QuickInfo : 'Business Partner Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BU_PARTNER'
    ReferenceBusinessPartner : String(10) not null;
    @Common.Label : 'Name'
    @Common.QuickInfo : 'Name 1'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_NAME1'
    BusinessPartnerName1 : String(40) not null;
    @Common.Label : 'Name 2'
    BusinessPartnerName2 : String(40) not null;
    @Common.Label : 'Name 3'
    BusinessPartnerName3 : String(40) not null;
    @Common.Label : 'Name 4'
    BusinessPartnerName4 : String(40) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Address Number'
    @Common.Heading : 'Addr. No.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_ADDRNUM'
    AddressID : String(10);
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Person Number'
    @Common.Heading : 'Person'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_PERSNUM'
    AddressPersonID : String(10);
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Address Type'
    @Common.Heading : 'Type'
    @Common.QuickInfo : 'Address type (1=Organization, 2=Person, 3=Contact person)'
    AddressObjectType : String(1) not null;
    @Common.Label : 'Street'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_STREET'
    StreetName : String(60) not null;
    @Common.Label : 'Street 2'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_STRSPP1'
    StreetPrefixName1 : String(40) not null;
    @Common.Label : 'Street 3'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_STRSPP2'
    StreetPrefixName2 : String(40) not null;
    @Common.Label : 'Street 4'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_STRSPP3'
    StreetSuffixName1 : String(40) not null;
    @Common.Label : 'Street 5'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_LCTN'
    StreetSuffixName2 : String(40) not null;
    @Common.Label : 'House Number'
    @Common.Heading : 'House No.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_HSNM1'
    HouseNumber : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Postal Code'
    @Common.Heading : 'Post. Code'
    @Common.QuickInfo : 'City Postal Code'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_PSTCD1'
    PostalCode : String(10) not null;
    @Common.Label : 'City'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_CITY1'
    CityName : String(40) not null;
    @Common.Label : 'District'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_CITY2'
    DistrictName : String(40) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Region'
    @Common.Heading : 'Rg'
    @Common.QuickInfo : 'Region (State, Province, County)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=REGIO'
    Region : String(3) not null;
    @Common.SAPObjectNodeTypeReference : 'Country'
    @Common.IsUpperCase : true
    @Common.Label : 'Country/Region Key'
    @Common.Heading : 'C/R'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LAND1'
    Country : String(3) not null;
    @Common.SAPObjectNodeTypeReference : 'Country'
    @Common.IsUpperCase : true
    @Common.Label : 'Country/Region'
    @Common.Heading : 'Ctry/Reg.'
    @Common.QuickInfo : 'Country/Region for Telephone/Fax Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_COMCTRY'
    PhoneNumberCountry : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Telephone'
    @Common.QuickInfo : 'Telephone No.: Dialing Code and Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_TLNMBR'
    PhoneNumber : String(30) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Extension'
    @Common.QuickInfo : 'Telephone no.: Extension'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_TLXTNS'
    PhoneNumberExtension : String(10) not null;
    @Common.SAPObjectNodeTypeReference : 'Country'
    @Common.IsUpperCase : true
    @Common.Label : 'Country/Region'
    @Common.Heading : 'Ctry/Reg.'
    @Common.QuickInfo : 'Country/Region for Telephone/Fax Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_COMCTRY'
    MobilePhoneCountry : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Telephone'
    @Common.QuickInfo : 'Telephone No.: Dialing Code and Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_TLNMBR'
    MobilePhoneNumber : String(30) not null;
    @Common.SAPObjectNodeTypeReference : 'Country'
    @Common.IsUpperCase : true
    @Common.Label : 'Country/Region'
    @Common.Heading : 'Ctry/Reg.'
    @Common.QuickInfo : 'Country/Region for Telephone/Fax Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_COMCTRY'
    FaxNumberCountry : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Fax'
    @Common.QuickInfo : 'Fax Number: Dialing Code and Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_FXNMBR'
    FaxNumber : String(30) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Extension'
    @Common.QuickInfo : 'Fax no.: Extension'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_FXXTNS'
    FaxNumberExtension : String(10) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Phone'
    @Common.QuickInfo : 'Landline Phone'
    InternationalPhoneNumber : String(30) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Mobile'
    @Common.QuickInfo : 'Cell Phone'
    InternationalMobilePhoneNumber : String(30) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Fax'
    @Common.QuickInfo : 'Fax Number'
    InternationalFaxNumber : String(30) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'PO Box'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_POBX'
    POBox : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'PO Box Postal Code'
    @Common.Heading : 'Postl Code'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_PSTCD2'
    POBoxPostalCode : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Title Key'
    @Common.Heading : 'Key'
    @Common.QuickInfo : 'Form-of-Address Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_TITLE'
    FormOfAddress : String(4) not null;
    @Common.Label : 'Correspondence Language'
    @Common.Heading : 'LG'
    @Common.QuickInfo : 'Business Partner: Correspondence Language'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BU_LANGU_CORR'
    CorrespondenceLanguage : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Email'
    @Common.QuickInfo : 'Email Address'
    EmailAddress : String(241) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Tax Jurisdiction'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_TXJCD'
    TaxJurisdiction : String(15) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Transportation Zone'
    @Common.Heading : 'TranspZone'
    @Common.QuickInfo : 'Transportation zone to or from which the goods are delivered'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LZONE'
    TransportZone : String(10) not null;
    @Common.Label : 'Unloading Point'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ABLAD'
    UnloadingPointName : String(25);
    @Common.IsUpperCase : true
    @Common.Label : 'VAT Registration No.'
    @Common.QuickInfo : 'VAT Registration Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=STCEG'
    VATRegistration : String(20);
    @Core.Computed : true
    @Common.Label : 'Doc-Specific Address'
    @Common.Heading : 'Doc. Addr'
    @Common.QuickInfo : 'Document-Specific Address'
    SDDocPartnerAddrIsDocSpecific : Boolean not null;
    SAP__Messages : many SAP__Message not null;
    _SalesOrder : Association to one SalesOrder;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Header Pricing Element'
  @Common.SemanticKey : [ 'PricingProcedureCounter', 'PricingProcedureStep', 'SalesOrder' ]
  @Common.Messages : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties : [
    {
      NavigationProperty: _SalesOrder,
      InsertRestrictions: { Insertable: false },
      DeepUpdateSupport: { Supported: false },
      SortRestrictions: { Sortable: false },
      FilterRestrictions: { Filterable: false }
    }
  ]
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.InsertRestrictions.RequiredProperties : [ 'ConditionType' ]
  @Capabilities.InsertRestrictions.Insertable : false
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported : true
  @Capabilities.UpdateRestrictions.NonUpdatableProperties : [
    'ConditionType',
    'ConditionRateRatioSAPUnit',
    'ConditionRateRatioISOUnit'
  ]
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_SalesOrder' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported : true
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions : [
    { Property: ConditionQuantity, AllowedExpressions: 'MultiValue' },
    { Property: ConditionBaseQuantity, AllowedExpressions: 'MultiValue' },
    { Property: ConditionQuantitySAPUnit, AllowedExpressions: 'MultiValue' },
    { Property: ConditionQuantityISOUnit, AllowedExpressions: 'MultiValue' },
    { Property: ConditionRateRatio, AllowedExpressions: 'MultiValue' },
    { Property: ConditionRateRatioSAPUnit, AllowedExpressions: 'MultiValue' },
    { Property: ConditionRateRatioISOUnit, AllowedExpressions: 'MultiValue' },
    { Property: ConditionAmount, AllowedExpressions: 'MultiValue' },
    { Property: CndnRoundingOffDiffAmount, AllowedExpressions: 'MultiValue' }
  ]
  entity SalesOrderPricingElement {
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Sales Order'
    @Common.Heading : 'SO'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VDM_SALES_ORDER'
    key SalesOrder : String(10) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Step Number'
    @Common.Heading : 'Step'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=STUNR'
    key PricingProcedureStep : String(3) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Counter'
    @Common.Heading : 'Cntr'
    @Common.QuickInfo : 'Condition Counter'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VFPRC_COND_COUNT'
    key PricingProcedureCounter : String(3) not null;
    @Common.SAPObjectNodeTypeReference : 'SalesPricingConditionType'
    @Core.Immutable : true
    @Common.IsUpperCase : true
    @Common.Label : 'Condition Type'
    @Common.Heading : 'CnTy'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KSCHA'
    ConditionType : String(4) not null;
    @Core.Computed : true
    @Common.Label : 'Description'
    @Common.QuickInfo : 'Description of a Price Element'
    PriceElementDescription : String(40) not null;
    @Common.SAPObjectNodeTypeReference : 'PriceConditionCalculationType'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Calculation Type'
    @Common.Heading : 'CalTy'
    @Common.QuickInfo : 'Calculation Type for Condition'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KRECH_LONG'
    ConditionCalculationType : String(3) not null;
    @Measures.ISOCurrency : ConditionCurrency
    @Common.Label : 'Condition Amount'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VFPRC_RATE_AMOUNT'
    ConditionRateAmount : Decimal(24, 9);
    @Common.SAPObjectNodeTypeReference : 'Currency'
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    ConditionCurrency : String(3) not null;
    @Measures.Unit : ConditionQuantitySAPUnit
    @Measures.UNECEUnit : ConditionQuantityISOUnit
    @Common.Label : 'Pricing Unit'
    @Common.Heading : 'per'
    @Common.QuickInfo : 'Condition Pricing Unit'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KPEIN'
    ConditionQuantity : Decimal(precision: 5);
    @Core.Computed : true
    @Measures.Unit : ConditionQuantitySAPUnit
    @Measures.UNECEUnit : ConditionQuantityISOUnit
    @Common.Label : 'Quantity'
    @Common.QuickInfo : 'Quantity of the Condition Basis'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VFPRC_ELEMENT_QUANTITY'
    ConditionBaseQuantity : Decimal(24, 9);
    @Common.IsUnit : true
    @Common.Label : 'Condition Unit'
    @Common.Heading : 'UoM'
    @Common.QuickInfo : 'Condition Unit in the Document'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KVMEI'
    ConditionQuantitySAPUnit : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'ISO Condition Qty'
    @Common.Heading : 'ISO Code for Condition Quantity'
    @Common.QuickInfo : 'ISO Unit Code for Condition Quantity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SD_CNDN_QTY_ISOUNIT'
    ConditionQuantityISOUnit : String(3) not null;
    @Measures.Unit : ConditionRateRatioSAPUnit
    @Measures.UNECEUnit : ConditionRateRatioISOUnit
    @Common.Label : 'Ratio'
    @Common.QuickInfo : 'Condition Ratio (in Percent or Per Mille)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VFPRC_ELEMENT_RATIO'
    ConditionRateRatio : Decimal(24, 9);
    @Common.IsUnit : true
    @Core.Immutable : true
    @Common.Label : 'Internal UoM'
    @Common.Heading : 'MU'
    @Common.QuickInfo : 'Unit of Measurement'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MSEHI'
    ConditionRateRatioSAPUnit : String(3) not null;
    @Core.Immutable : true
    @Common.IsUpperCase : true
    @Common.Label : 'ISO Unit Code for Condition Ratio'
    ConditionRateRatioISOUnit : String(3) not null;
    @Measures.ISOCurrency : TransactionCurrency
    @Common.Label : 'Condition Value'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VFPRC_ELEMENT_VALUE'
    ConditionAmount : Decimal(precision: 15);
    @Core.Computed : true
    @Measures.ISOCurrency : TransactionCurrency
    @Common.Label : 'Cndn Bs Amt'
    @Common.Heading : 'Condition Basis Amount'
    @Common.QuickInfo : 'Amount of the Condition Basis'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VFPRC_BASE_AMOUNT'
    ConditionBaseAmount : Decimal(24, 9);
    @Common.SAPObjectNodeTypeReference : 'Currency'
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Document Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'SD Document Currency'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERK'
    TransactionCurrency : String(3) not null;
    @Core.Computed : true
    @Measures.ISOCurrency : TransactionCurrency
    @Common.Label : 'Condition Rounding Difference'
    @Common.QuickInfo : 'Rounding-Off Difference of a Condition'
    CndnRoundingOffDiffAmount : Decimal(precision: 5);
    @Common.SAPObjectNodeTypeReference : 'PriceConditionInactiveReason'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Inactive Condition'
    @Common.Heading : 'Inact'
    @Common.QuickInfo : 'Condition is Inactive'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KINAK'
    ConditionInactiveReason : String(1);
    @Common.SAPObjectNodeTypeReference : 'PriceConditionClass'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Condition Class'
    @Common.Heading : 'CCl'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KOAID'
    ConditionClass : String(1);
    @Common.SAPObjectNodeTypeReference : 'PriceConditionControl'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Condition Control'
    @Common.Heading : 'Ctrl'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KSTEU'
    ConditionControl : String(1);
    @Common.SAPObjectNodeTypeReference : 'PriceConditionOrigin'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Condition Origin'
    @Common.Heading : 'Orig'
    @Common.QuickInfo : 'Origin of the Condition'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KHERK'
    ConditionOrigin : String(1);
    @Core.Computed : true
    @Common.Label : 'Statistical'
    @Common.Heading : 'Stat'
    @Common.QuickInfo : 'Condition is used for statistics'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KSTAT'
    ConditionIsForStatistics : Boolean;
    @Core.Computed : true
    @Common.Label : 'Changed Manually'
    @Common.Heading : 'Man'
    @Common.QuickInfo : 'Condition Changed Manually'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KMPRS'
    ConditionIsManuallyChanged : Boolean;
    @Common.SAPObjectNodeTypeReference : 'SalesTaxCode'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Tax Code'
    @Common.Heading : 'Tx'
    @Common.QuickInfo : 'Tax on Sales/Purchases Code'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MWSKZ'
    TaxCode : String(2);
    @Common.SAPObjectNodeTypeReference : 'PricingVariantCondition'
    @Core.Computed : true
    @Common.Label : 'Variant Key'
    @Common.Heading : 'Variant'
    @Common.QuickInfo : 'Variant Condition Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VARCOND'
    VariantCondition : String(26);
    @Core.Computed : true
    @Common.Label : 'Is Group Condition'
    @Common.QuickInfo : 'Condition Is a Group Condition'
    IsGroupCondition : Boolean;
    SAP__Messages : many SAP__Message not null;
    _SalesOrder : Association to one SalesOrder;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Item Schedule Line'
  @Common.SemanticKey : [ 'ScheduleLine', 'SalesOrderItem', 'SalesOrder' ]
  @Capabilities.NavigationRestrictions.RestrictedProperties : [
    { NavigationProperty: _Item, DeepUpdateSupport: { Supported: false } },
    {
      NavigationProperty: _SalesOrder,
      InsertRestrictions: { Insertable: false },
      DeepUpdateSupport: { Supported: false }
    }
  ]
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.InsertRestrictions.Insertable : false
  @Capabilities.DeleteRestrictions.Deletable : false
  @Capabilities.UpdateRestrictions.Updatable : false
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_Item', '_SalesOrder' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Core.OptimisticConcurrency : [ '_SalesOrder/LastChangeDateTime' ]
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions : [
    { Property: ScheduleLineOrderQuantity, AllowedExpressions: 'MultiValue' },
    { Property: OrderQuantitySAPUnit, AllowedExpressions: 'MultiValue' },
    { Property: OrderQuantityISOUnit, AllowedExpressions: 'MultiValue' },
    {
      Property: ConfdOrderQtyByMatlAvailCheck,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: DeliveredQtyInOrderQtyUnit,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: OpenConfdDelivQtyInOrdQtyUnit,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: CorrectedQtyInOrderQtyUnit,
      AllowedExpressions: 'MultiValue'
    }
  ]
  entity SalesOrderScheduleLine {
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Sales Order'
    @Common.Heading : 'SO'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VDM_SALES_ORDER'
    key SalesOrder : String(10) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Item'
    @Common.Heading : 'SO Item'
    @Common.QuickInfo : 'Sales Order Item'
    key SalesOrderItem : String(6) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Schedule Line Number'
    @Common.Heading : 'SLNo'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ETENR'
    key ScheduleLine : String(4) not null;
    @Common.SAPObjectNodeTypeReference : 'SalesDocScheduleLineCategory'
    @Common.IsUpperCase : true
    @Common.Label : 'Schedule Line Category'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VDM_SD_SCHEDULE_LINE_CAT'
    ScheduleLineCategory : String(2) not null;
    @Measures.Unit : OrderQuantitySAPUnit
    @Measures.UNECEUnit : OrderQuantityISOUnit
    @Common.Label : 'Order Quantity'
    @Common.QuickInfo : 'Order Quantity in Sales Units'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WMENG'
    ScheduleLineOrderQuantity : Decimal(13, 3);
    @Common.IsUnit : true
    @Core.Computed : true
    @Common.Label : 'Sales Unit'
    @Common.Heading : 'SU'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VRKME'
    OrderQuantitySAPUnit : String(3) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'ISO Order Quantity'
    @Common.Heading : 'ISO Unit Code for Order Quantity'
    @Common.QuickInfo : 'ISO Unit Code for Order Quantity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SD_ORD_QTY_ISOUNIT'
    OrderQuantityISOUnit : String(3) not null;
    @Common.Label : 'Delivery Date'
    @Common.Heading : 'Deliv.Date'
    @Common.QuickInfo : 'Requested Delivery Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=REQD_DELIV_DATE'
    RequestedDeliveryDate : Date;
    @Core.Computed : true
    @Common.Label : 'Delivery Date'
    @Common.Heading : 'Deliv.Date'
    @Common.QuickInfo : 'Confirmed Delivery Date'
    ConfirmedDeliveryDate : Date;
    @Core.Computed : true
    @Measures.Unit : OrderQuantitySAPUnit
    @Measures.UNECEUnit : OrderQuantityISOUnit
    @Common.Label : 'Confirmed Quantity'
    @Common.Heading : 'Confirmed Qty'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BMENG'
    ConfdOrderQtyByMatlAvailCheck : Decimal(13, 3);
    @Core.Computed : true
    @Measures.Unit : OrderQuantitySAPUnit
    @Measures.UNECEUnit : OrderQuantityISOUnit
    @Common.Label : 'Delivered Quantity'
    @Common.Heading : 'Delivered Qty'
    DeliveredQtyInOrderQtyUnit : Decimal(13, 3) not null;
    @Core.Computed : true
    @Measures.Unit : OrderQuantitySAPUnit
    @Measures.UNECEUnit : OrderQuantityISOUnit
    @Common.Label : 'Open Quantity'
    @Common.QuickInfo : 'Open Confirmed Delivery Quantity'
    OpenConfdDelivQtyInOrdQtyUnit : Decimal(13, 3) not null;
    @Measures.Unit : OrderQuantitySAPUnit
    @Measures.UNECEUnit : OrderQuantityISOUnit
    @Common.Label : 'Corr.qty'
    @Common.QuickInfo : 'Corrected quantity in sales unit'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=CMENG'
    CorrectedQtyInOrderQtyUnit : Decimal(13, 3) not null;
    @Common.SAPObjectNodeTypeReference : 'DeliveryBlockReason'
    @Common.IsUpperCase : true
    @Common.Label : 'Delivery Block'
    @Common.Heading : 'DB'
    @Common.QuickInfo : 'Schedule Line Blocked for Delivery'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LIFSP_EP'
    DelivBlockReasonForSchedLine : String(2) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Purchase Requisition'
    @Common.Heading : 'Purch.Reqn'
    @Common.QuickInfo : 'Purchase Requisition Number'
    PurchaseRequisition : String(10) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Purchase Requisition Item'
    PurchaseRequisitionItem : String(5);
    @Common.SAPObjectNodeTypeReference : 'GoodsMovementType'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Movement Type'
    @Common.Heading : 'MvT'
    @Common.QuickInfo : 'Movement Type (Inventory Management)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BWART'
    GoodsMovementType : String(3) not null;
    _Item : Association to one SalesOrderItem;
    _SalesOrder : Association to one SalesOrder {  };
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Header Text'
  @Common.SemanticKey : [ 'LongTextID', 'Language', 'SalesOrder' ]
  @Common.Messages : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties : [
    {
      NavigationProperty: _SalesOrder,
      InsertRestrictions: { Insertable: false },
      DeepUpdateSupport: { Supported: false }
    }
  ]
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.FilterRestrictions.Filterable : true
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions : [ { Property: LongText, AllowedExpressions: 'SearchExpression' } ]
  @Capabilities.FilterRestrictions.NonFilterableProperties : [ 'LongText' ]
  @Capabilities.SortRestrictions.NonSortableProperties : [ 'LongText' ]
  @Capabilities.InsertRestrictions.RequiredProperties : [ 'LongText' ]
  @Capabilities.InsertRestrictions.Insertable : false
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported : true
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_SalesOrder' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported : true
  @Core.OptimisticConcurrency : [ '_SalesOrder/LastChangeDateTime' ]
  entity SalesOrderText {
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Sales Order'
    @Common.Heading : 'SO'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VDM_SALES_ORDER'
    key SalesOrder : String(10) not null;
    @Core.ComputedDefaultValue : true
    @Common.Label : 'Language Key'
    @Common.Heading : 'Language'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SPRAS'
    key Language : String(2) not null;
    @Core.ComputedDefaultValue : true
    @Common.IsUpperCase : true
    @Common.Label : 'Text ID'
    @Common.Heading : 'ID'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TDID'
    key LongTextID : String(4) not null;
    @Common.Label : 'String'
    LongText : String not null;
    SAP__Messages : many SAP__Message not null;
    _SalesOrder : Association to one SalesOrder;
  };
};

