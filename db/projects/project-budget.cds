namespace ec.masters;

using {
  cuid,
  managed,
  sap.common.CodeList
} from '@sap/cds/common';
using {}
using {ec.masters as pa} from './enterprise-project';
using {ec.masters as bo} from '../billofquantities/bill-of-quantity';

entity ProjectBudget : cuid, managed {
  company     : String(40) @mandatory;
  project     : Association to pa.Projects;
  vrNo        : String(40);
  boq         : Association to bo.BillofQuantityHeader;
  type        : Association to BudgetType;
  refCode     : String(40);
  revision    : String(40);
  description : String(200);

  boqItems    : Association to many bo.BillofQuantityHeader
                  on boqItems.ID = $self.boq.ID;
  WbsItems    : Composition of many ProjectBudgetResources
                  on WbsItems.budget = $self;
}


entity ProjectBudgetResources : cuid, managed {
  budget         : Association to ProjectBudget;
  wbsElement     : String(200);
  description    : String(500);
  cbs            : String(200);
  resource       : String(200);
  quantity       : Decimal(15, 2);
  unitPrice      : Decimal(15, 2);
  actualQuantity : Decimal(15, 2);
  actualAmount   : String(40);
  budgetQuantity : String(40);
  budgetAmount   : String(40);
  UOM            : String(15);
}


entity BudgetType : CodeList {
  key code : BudgetTypeKey;
}

type BudgetTypeKey : String enum {
  vr = 'Variation';
  or = 'Original';
  tr = 'Transfer';
  rr = 'Risk/Reserve Transfer';
}
