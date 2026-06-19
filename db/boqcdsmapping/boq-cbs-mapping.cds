namespace ec.masters;

using {
    cuid,
    managed
} from '@sap/cds/common';
using {ec.masters as cb} from '../cbs/cbs';

entity BOQCBSMapping : cuid, managed {
    cbs : Association to cb.CostBreakdownStructure @mandatory;
    items   : Composition of many CBSBOQResourceItem
                  on items.header = $self;
}

entity CBSBOQResourceItem : cuid, managed {
    header            : Association to BOQCBSMapping;
    boq               : Association to cb.CBSBOQResourceItem;
}
