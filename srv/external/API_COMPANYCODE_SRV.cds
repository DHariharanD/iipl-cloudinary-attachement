/* checksum : b43fb9c8493f7bfde1f4a5e14a80368b */
@cds.external : true
@m.IsDefaultEntityContainer : 'true'
@sap.message.scope.supported : 'true'
@sap.supported.formats : 'atom json xlsx'
service API_COMPANYCODE_SRV {
  @cds.external : true
  @cds.persistence.skip : true
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  @sap.deletable : 'false'
  @sap.content.version : '1'
  @sap.label : 'Company Code'
  entity A_CompanyCode {
    @sap.display.format : 'UpperCase'
    @sap.label : 'Company Code'
    key CompanyCode : String(4) not null;
    @sap.label : 'Company Name'
    @sap.quickinfo : 'Name of Company Code or Company'
    CompanyCodeName : String(25);
    @sap.label : 'City'
    CityName : String(25);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Country/Region Key'
    Country : String(3);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Currency'
    @sap.quickinfo : 'Currency Key'
    @sap.semantics : 'currency-code'
    Currency : String(5);
    @sap.label : 'Language Key'
    Language : String(2);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Chart of Accounts'
    ChartOfAccounts : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Fiscal Year Variant'
    FiscalYearVariant : String(2);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Company'
    Company : String(6);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Credit Control Area'
    CreditControlArea : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Alternative COA'
    @sap.quickinfo : 'Alternative Chart of Accounts'
    CountryChartOfAccounts : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'FM Area'
    @sap.quickinfo : 'Financial Management Area'
    FinancialManagementArea : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Address'
    AddressID : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Taxes on Sls/Purc.'
    @sap.quickinfo : 'Taxes on Sales/Purchases Group'
    TaxableEntity : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'VAT Registration No.'
    @sap.quickinfo : 'VAT Registration Number'
    VATRegistration : String(20);
    @sap.label : 'Extended WTax Active'
    @sap.quickinfo : 'Indicator: Extended Withholding Tax Active'
    ExtendedWhldgTaxIsActive : Boolean;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Controlling Area'
    ControllingArea : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Field Status Variant'
    FieldStatusVariant : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Output Tax Code'
    @sap.quickinfo : 'Output Tax Code for Non-Taxable Transactions'
    NonTaxableTransactionTaxCode : String(2);
    @sap.label : 'Tax Determ.with Doc.Date'
    @sap.quickinfo : 'Indicator: Document Date As the Basis for Tax Determination'
    DocDateIsUsedForTaxDetn : Boolean;
    @sap.label : 'Tax Date'
    @sap.quickinfo : 'Tax Reporting Date Active in Documents'
    TaxRptgDateIsActive : Boolean;
  };
};

