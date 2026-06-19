namespace ec.allocationmanagement;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {ec.masters as ep} from '../projects/enterprise-project';
using {ec.masters as cbsRes} from '../cbs/cbs';
using {ec.masters as bq} from '../billofquantities/bill-of-quantity';


entity Allocations : cuid, managed {

    project             : Association to ep.Projects;
    wbs                 : Association to ep.ProjectPlanning;
    boqItem             : Association to one bq.BillofQuantityItems;
    cbs                 : Association to cbsRes.CostBreakdownStructure;
    boqDetails          : Association to many bq.BillofQuantityItems
                            on boqDetails.ID = boqItem.ID;

    floorZoneReference  : String(100);
    notes               : LargeString;
}

