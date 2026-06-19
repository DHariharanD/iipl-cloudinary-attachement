/* checksum : ea48ac79cf362f55cc304155ea9b9c3f */
@cds.external : true
@m.IsDefaultEntityContainer : 'true'
@sap.message.scope.supported : 'true'
@sap.supported.formats : 'atom json xlsx'
service YY1_WORKFORCE_SERVICE_LINE_CDS_0001 {
  @cds.external : true
  @cds.persistence.skip : true
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  @sap.deletable : 'false'
  @sap.content.version : '1'
  @sap.label : 'Workforce_service_line_cost'
  entity YY1_Workforce_service_line {
    @sap.required.in.filter : 'false'
    @sap.label : 'WFA Ext. ID'
    @sap.quickinfo : 'Workforce Assignment External ID'
    key WorkAssignmentExternalID : String(100) not null;
    @sap.display.format : 'UpperCase'
    @sap.required.in.filter : 'false'
    @sap.label : 'Country/Region'
    @sap.quickinfo : 'Workforce Country ISO Code'
    key Country2DigitISOCode : String(2) not null;
    @sap.display.format : 'Date'
    @sap.required.in.filter : 'false'
    @sap.label : 'Start Date'
    key StartDate : Date not null;
    @sap.display.format : 'NonNegative'
    @sap.required.in.filter : 'false'
    @sap.label : 'Service Cost Level'
    ServiceCostLevel : String(4);
  };
};

