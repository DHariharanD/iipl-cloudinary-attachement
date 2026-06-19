namespace ec.masters;

using {
  cuid,
  sap.common.CodeList,
  managed
} from '@sap/cds/common';


entity RTProductTypes : cuid, managed {
  prodType        : String(4);
  parent          : Association to ResourceTypes;
  productTypeName : String(25);
}

entity RTGlAccounts : cuid, managed {
  glAccount     : String(10);
  parent        : Association to ResourceTypes;
  glAccountName : String(20);
}

entity RTAssets : cuid, managed {
  type   : String(50);
  parent : Association to ResourceTypes;
  name   : String(20);
  Asset  : String(20);
}

entity RTWorkforce : cuid, managed {
  type   : String(50);
  parent : Association to ResourceTypes;
  name   : String(20);
  Asset  : String(20);
}


entity ResourceTypes : cuid, managed {
  resourceType     : String(50)          @mandatory;
  resourceTypeDesc : String(200);
  typeOfResource   : Association to type @mandatory;
  isGlAccount      : Boolean default false;
  itemType         : Composition of many RTProductTypes
                       on itemType.parent = $self;
  assettype        : Composition of many RTAssets
                       on assettype.parent = $self;
  workforce        : Composition of many RTWorkforce
                       on workforce.parent = $self;
  timeSheetReq     : Boolean;
  glAccount        : Composition of many RTGlAccounts
                       on glAccount.parent = $self;
}

entity type : CodeList {
  key code : ResourceTypeKey;
}


type ResourceTypeKey : String enum {
  gl = 'GL Account';
  pt = 'Product Type';
  at = 'Asset Type';
  mn = 'Manpower';
};
