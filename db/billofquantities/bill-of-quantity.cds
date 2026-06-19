namespace ec.masters;

using {
  cuid,
  sap.common.CodeList,
  managed
} from '@sap/cds/common';
using {ec.masters as pj} from '../projects/enterprise-project';
using {sap.attachments.Attachments} from 'com.sap.cds/cds-feature-attachments';
using {API_COMPANYCODE_SRV as CO} from '../../srv/external/API_COMPANYCODE_SRV';
using {ec.masters.CostBreakdownStructure} from '../cbs/cbs';
using {ec.masters.Customer} from '../payment/customer-payment-application';

entity BillofQuantityHeader : cuid, managed {
  vrNo                : String(50);
  boqType             : Association to boqtype @mandatory;
  project             : Association to pj.Projects;
  projectName         : String(100);
  startSrNo           : String(50);
  bqHeaderHierarchies : Composition of many BillofQuantityItems
                          on bqHeaderHierarchies.bqitemsHierarchy = $self;
  company             : Association to CO.A_CompanyCode
                          on company.CompanyCode = company_CompanyCode;
  company_CompanyCode : String(4) @mandatory;
  attachments         : Composition of many Attachments;
}

entity BillofQuantityItems : cuid, managed {
  item                : String(40);
  description         : String(1111);
  unitOfMeasurement   : String(10);
  quantity            : Decimal(15, 7);
  bill                : Integer;
  section             : String(10);
  page                : Integer;
  revision            : Integer;
  retention           : Decimal(15, 7);
  advance             : Decimal(15, 7);
  peformanceBond      : Decimal(15, 7);
  bankGuarantee       : Decimal(15, 7);
  sumBack             : Boolean;
  boqNo               : String(10);
  pcRate              : Boolean;
  nonClient           : Boolean;
  excludeActiveBudget : Boolean;
  bqitemsHierarchy    : Association to one BillofQuantityHeader;
  wbsElement          : Association to one pj.ProjectPlanning;
  cbs                 : Association to many CostBreakdownStructure
                          on cbs.boqitem = $self;
  itemMapping         : Composition of many boqCbsMapping
                          on itemMapping.parentItem = $self;
  boqcbs              : Composition of many BoqCbs
                          on boqcbs.parent = $self;
  boqResource         : Composition of many BoqResource
                          on boqResource.parent = $self;
  //fields for projectBudget
  unitPrice : Decimal(15,2);
  actualQuantity:Integer;
  actualAmount:Decimal(15,2);
  budgetQuantity:Integer;
  budgetAmount:Decimal(15,2);
  addPayments : Composition of many addPayments on addPayments.parentBoq =$self;
  customerPayment : Association to Customer;
}

entity addPayments : cuid, managed {
  srNo : String(10);
  itemDecr : String(255);
  unit:String(10);
  q1: String(10);
  q2: String(10);
  q3: String(10);
  q4: String(10);
  q5: String(10);
  parentBoq : Association to BillofQuantityItems;
  
}


entity BoqCbs : cuid, managed {
  code   : String(40);
  name   : String(255);
  descr  : String(1000);
  parent : Association to BillofQuantityItems;
  cbsId  : String(40);
}

entity BoqResource : cuid, managed {
  code       : String(40);
  name       : String(255);
  descr      : String(1000);
  parent     : Association to BillofQuantityItems;
  cbsNode_ID : UUID;     //Storing the cbs dtructure id for filtering in request screen
  quantity:Integer;
  outPutQuantity:String(25);
  rate:String(25);
}

entity boqCbsMapping : cuid, managed {
  productId     : String(40);
  productName   : String(1111);
  productType   : String(25);
  unitofMeasure : String(10);
  quantity      : String(10) default '1';
  parentItem    : Association to BillofQuantityItems;

}

entity boqtype : CodeList {
  key code : BOQTypeKey;
}

type BOQTypeKey : String enum {
  ORG = 'Original';
  PS = 'Pro Sum';
  UV = 'Provisional Variation Order';
  PSPVO = 'Provisional Sum -Provisional Variation Order';
  UAPC = 'Unapproved PC Rate Adjustment';
  AV = 'Variation Order';
  APC = 'PC Rate Adjustment';
}
