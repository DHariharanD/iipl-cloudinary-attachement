/* checksum : 34620757ae8121c56cad3b51557618dd */
@cds.external : true
@m.IsDefaultEntityContainer : 'true'
@sap.message.scope.supported : 'true'
@sap.supported.formats : 'atom json xlsx'
service YY1_WORKFORCE_CDS {
  @cds.external : true
  @cds.persistence.skip : true
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  @sap.deletable : 'false'
  @sap.content.version : '1'
  @sap.label : 'Workforce'
  entity YY1_Workforce {
    @sap.display.format : 'UpperCase'
    @sap.required.in.filter : 'false'
    @sap.text : 'PersonFullName'
    @sap.label : 'Business Partner'
    @sap.quickinfo : 'Business Partner Number'
    key Person : String(10) not null;
    @sap.required.in.filter : 'false'
    @sap.label : 'Full Name'
    PersonFullName : String(80);
    @sap.display.format : 'UpperCase'
    @sap.required.in.filter : 'false'
    @sap.label : 'ID Number'
    @sap.quickinfo : 'Identification Number'
    PersonExternalID : String(60);
    @sap.required.in.filter : 'false'
    @sap.label : 'First Name'
    @sap.quickinfo : 'First Name of Business Partner (Person)'
    FirstName : String(40);
    @sap.required.in.filter : 'false'
    @sap.label : 'Last Name'
    @sap.quickinfo : 'Last Name of Business Partner (Person)'
    LastName : String(40);
    @sap.display.format : 'NonNegative'
    @sap.required.in.filter : 'false'
    @sap.text : 'PersonFullName'
    @sap.label : 'Personnel Number'
    PersonWorkAgreement : String(8);
    @sap.display.format : 'UpperCase'
    @sap.required.in.filter : 'false'
    @sap.label : 'Company Code'
    CompanyCode : String(4);
    @sap.display.format : 'UpperCase'
    @sap.required.in.filter : 'false'
    @sap.label : 'Cost Center'
    CostCenter : String(10);
    @sap.display.format : 'UpperCase'
    @sap.required.in.filter : 'false'
    @sap.label : 'Work Agrmnt Ext ID'
    @sap.quickinfo : 'Work Agreement External ID'
    PersonWorkAgreementExternalID : String(20);
    @sap.required.in.filter : 'false'
    @sap.label : 'Job Code'
    Job : String(128);
    @sap.required.in.filter : 'false'
    @sap.label : 'Job Code'
    JobShortName : String(128);
    @sap.required.in.filter : 'false'
    @sap.label : 'Description'
    ServiceCostLevelName : String(30);
    @sap.required.in.filter : 'false'
    @sap.label : 'Language Key'
    Language : String(2);
    @sap.required.in.filter : 'false'
    @sap.label : 'Email Address'
    DefaultEmailAddress : String(241);
    @sap.display.format : 'UpperCase'
    @sap.required.in.filter : 'false'
    @sap.text : 'BusinessPartnerName'
    @sap.label : 'Business Partner'
    @sap.quickinfo : 'Business Partner Number'
    BusinessPartner : String(10);
    @sap.display.format : 'UpperCase'
    @sap.required.in.filter : 'false'
    @sap.label : 'Address Number'
    IndependentAddressID : String(10);
    @sap.required.in.filter : 'false'
    @sap.label : 'Business Partner Name'
    BusinessPartnerName : String(81);
  };
};

