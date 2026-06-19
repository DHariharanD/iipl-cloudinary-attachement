/* checksum : f8da6332e7553fdf75f0623df9cfb9b2 */
@cds.external : true
@m.IsDefaultEntityContainer : 'true'
@sap.message.scope.supported : 'true'
@sap.supported.formats : 'atom json xlsx'
service API_GLACCOUNTINCHARTOFACCOUNTS_SRV {
  @cds.external : true
  @cds.persistence.skip : true
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  @sap.deletable : 'false'
  @sap.content.version : '1'
  @sap.label : 'G/L Account in Chart of Accounts'
  entity A_GLAccountInChartOfAccounts {
    @sap.display.format : 'UpperCase'
    @sap.label : 'Chart of Accounts'
    key ChartOfAccounts : String(4) not null;
    @sap.display.format : 'UpperCase'
    @sap.label : 'G/L Account'
    @sap.quickinfo : 'G/L Account Number'
    key GLAccount : String(10) not null;
    @sap.label : 'Balance Sheet Acct'
    @sap.quickinfo : 'Is Balance Sheet Account'
    IsBalanceSheetAccount : Boolean;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Account Group'
    @sap.quickinfo : 'G/L Account Group'
    GLAccountGroup : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Group Account Number'
    CorporateGroupAccount : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'P&L state. acct'
    @sap.quickinfo : 'P&L statement account type'
    ProfitLossAccountType : String(2);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Sample Account'
    @sap.quickinfo : 'Number of the Sample Account'
    SampleGLAccount : String(10);
    @sap.label : 'Deletion Flag'
    @sap.quickinfo : 'Indicator: Account Marked for Deletion?'
    AccountIsMarkedForDeletion : Boolean;
    @sap.label : 'Creation Block'
    @sap.quickinfo : 'Indicator: Account Is Blocked for Creation ?'
    AccountIsBlockedForCreation : Boolean;
    @sap.label : 'Posting Block'
    @sap.quickinfo : 'Indicator: Is Account Blocked for Posting?'
    AccountIsBlockedForPosting : Boolean;
    @sap.label : 'Planning Block'
    @sap.quickinfo : 'Indicator: Account Blocked for Planning ?'
    AccountIsBlockedForPlanning : Boolean;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Trading Partner No.'
    @sap.quickinfo : 'Company ID of Trading Partner'
    PartnerCompany : String(6);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Functional Area'
    FunctionalArea : String(16);
    @sap.display.format : 'Date'
    @sap.label : 'Created On'
    @sap.quickinfo : 'Record Created On'
    CreationDate : Date;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Created by'
    @sap.quickinfo : 'Name of Person who Created the Object'
    CreatedByUser : String(12);
    @odata.Type : 'Edm.DateTimeOffset'
    @sap.label : 'Time Stamp'
    @sap.quickinfo : 'UTC Time Stamp in Short Form (YYYYMMDDhhmmss)'
    LastChangeDateTime : DateTime;
    @sap.display.format : 'UpperCase'
    @sap.label : 'G/L Account Type'
    @sap.quickinfo : 'Type of a General Ledger Account'
    GLAccountType : String(1);
    @sap.display.format : 'UpperCase'
    @sap.label : 'G/L Acct External ID'
    @sap.quickinfo : 'G/L Account Number'
    GLAccountExternal : String(10);
    @sap.label : 'Balance sheet acct'
    @sap.quickinfo : 'Indicator: Account is a balance sheet account?'
    IsProfitLossAccount : Boolean;
    to_Text : Association to many A_GLAccountText on to_Text.ChartOfAccounts = ChartOfAccounts and to_Text.GLAccount = GLAccount;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  @sap.deletable : 'false'
  @sap.content.version : '1'
  @sap.label : 'G/L Account in Chart of Accounts Text'
  entity A_GLAccountText {
    @sap.display.format : 'UpperCase'
    @sap.label : 'Chart of Accounts'
    key ChartOfAccounts : String(4) not null;
    @sap.display.format : 'UpperCase'
    @sap.label : 'G/L Account'
    @sap.quickinfo : 'G/L Account Number'
    key GLAccount : String(10) not null;
    @sap.label : 'Language Key'
    key Language : String(2) not null;
    @sap.label : 'G/L Account Name'
    GLAccountName : String(20);
    @sap.label : 'G/L Account Long Name'
    GLAccountLongName : String(50);
    @odata.Type : 'Edm.DateTimeOffset'
    @sap.label : 'Time Stamp'
    @sap.quickinfo : 'UTC Time Stamp in Short Form (YYYYMMDDhhmmss)'
    LastChangeDateTime : DateTime;
    to_GLAccountInChartOfAccounts : Association to A_GLAccountInChartOfAccounts on to_GLAccountInChartOfAccounts.ChartOfAccounts = ChartOfAccounts and to_GLAccountInChartOfAccounts.GLAccount = GLAccount;
  };
};

