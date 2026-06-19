using {ec.masters as ams} from '../db/documents/document-def';

service DocumentService {

  @odata.draft.enabled
  @Capabilities: {
    Insertable: true,
    Updateable: true,
    Deletable : true
  }

  entity DocumentDefs as projection on ams.DocumentDef;

 

}