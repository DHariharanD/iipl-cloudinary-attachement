namespace ec.masters;

using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';

entity DocumentDef : cuid, managed {

    documentCode           : String(50) @mandatory;
    name                   : String(100) @mandatory;
    description            : String(500);

    validityRequired       : Boolean @mandatory;       
    isMandatory            : Boolean @mandatory;         

    attachmentType         :Association to AttachmentMode;      
    isAttachmentMandatory  : Boolean @mandatory;          
}
entity AttachmentMode : CodeList {
  key code : AttachmentModeKey;
}
type AttachmentModeKey : String enum {
  single   = 'Single';
  multiple = 'Multiple';
}