/* checksum : bad82bee0d8c8bc0a72f15a42ff9a4d7 */
@cds.external                                       : true
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
service PRODUCTTYPE_0001 {
  @cds.external                                                    : true
  @cds.persistence.skip                                            : true
  @Common.Label                                                    : 'Product Type'
  @Capabilities.SearchRestrictions.Searchable                      : true
  @Capabilities.SearchRestrictions.UnsupportedExpressions          : #group
  @Capabilities.SearchRestrictions.SearchSyntax                    : 'https://url.sap/odata-search'
  @Capabilities.InsertRestrictions.Insertable                      : false
  @Capabilities.DeleteRestrictions.Deletable                       : false
  @Capabilities.UpdateRestrictions.Updatable                       : false
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: ['_Text']
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
  entity ProductType {
        @Common.SAPObjectNodeTypeReference: 'ProductType'
        @Common.Text                      : ProductTypeName
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Product Type'
        @Common.Heading                   : 'PTyp'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTTYPE'
    key ProductType          : String(4) not null;

        @Common.Label                     : 'Product Type Description'
        @Common.QuickInfo                 : 'Description of product type'
        ProductTypeName      : String(25) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Product Type Group'
        @Common.Heading                   : 'Product Type Grp'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCT_TYPE'
        ProductTypeGroupCode : String(2) not null;
        _Text                : Association to many ProductTypeText
                                 on _Text.ProductType = ProductType;
  };

  @cds.external                                                    : true
  @cds.persistence.skip                                            : true
  @Common.Label                                                    : 'Product Type Text'
  @Capabilities.SearchRestrictions.Searchable                      : true
  @Capabilities.SearchRestrictions.UnsupportedExpressions          : #group
  @Capabilities.SearchRestrictions.SearchSyntax                    : 'https://url.sap/odata-search'
  @Capabilities.InsertRestrictions.Insertable                      : false
  @Capabilities.DeleteRestrictions.Deletable                       : false
  @Capabilities.UpdateRestrictions.Updatable                       : false
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: ['_ProductType']
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
  entity ProductTypeText {
        @Common.SAPObjectNodeTypeReference: 'ProductType'
        @Common.Text                      : ProductTypeName
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Product Type'
        @Common.Heading                   : 'PTyp'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTTYPE'
    key ProductType     : String(4) not null;

        @Common.Label                     : 'Language Key'
        @Common.Heading                   : 'Language'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=SPRAS'
    key Language        : String(2) not null;

        @Common.Label                     : 'Product Type Description'
        @Common.QuickInfo                 : 'Description of product type'
        ProductTypeName : String(25) not null;
        _ProductType    : Association to ProductType
                            on _ProductType.ProductType = ProductType;
  }
};
