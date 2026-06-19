/* checksum : c5f929184157ad77466cb414f6d6a132 */
@cds.external : true
@m.IsDefaultEntityContainer : 'true'
@sap.message.scope.supported : 'true'
@sap.supported.formats : 'atom json xlsx'
service YY1_TECHNICAL_OBJECT_CDS_0001 {
  @cds.external : true
  @cds.persistence.skip : true
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  @sap.deletable : 'false'
  @sap.content.version : '1'
  @sap.label : 'Technical_Object'
  entity YY1_Technical_Object {
    @sap.display.format : 'UpperCase'
    @sap.required.in.filter : 'false'
    @sap.label : 'Object Type'
    @sap.quickinfo : 'Type of Technical Object'
    key TechnicalObjectType : String(10) not null;
    @sap.required.in.filter : 'false'
    @sap.label : 'Object Type Text'
    @sap.quickinfo : 'Text for Object Type'
    TechnicalObjectTypeDesc : String(20);
  };
};

