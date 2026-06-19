namespace ec.masters;

using {
    cuid,
    managed
} from '@sap/cds/common';
using {ec.masters as pj} from '../projects/enterprise-project';
using {ec.masters as bo} from '../billofquantities/bill-of-quantity';

entity ProjectBOQMapping : cuid, managed {
    project : Association to pj.Projects @mandatory;

    wbsList : Association to many pj.ProjectPlanning
                  on wbsList.plshierarchy = project;

    items   : Composition of many ProjectBOQMappingItem
                  on items.header = $self;
}

entity ProjectBOQMappingItem : cuid, managed {
    header            : Association to ProjectBOQMapping;
    wbs               : Association to pj.ProjectPlanning;
    boq               : Association to bo.BillofQuantityHeader;
    description       : String(1111);
    unitOfMeasurement : String(10);
    quantity          : Decimal(15, 7);
}
