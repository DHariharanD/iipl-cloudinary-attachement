using {ec.masters as rr} from '../db';
using {CommonService as cm} from './common-service';
using {ec.masters as ep} from '../db/projects/enterprise-project';
using {ec.masters as boq} from '../db/billofquantities/bill-of-quantity';



service RequestResource {
    entity ResourceRequests as projection on rr.RequestResource;
    entity Requestcompany as projection on cm.Companies;
    entity Projects  as projection on ep.Projects;                           // fetching projects
    entity BillofQuantityHeader as projection on boq.BillofQuantityHeader;  //Fetching Boq header
    entity BillofQuantityItems as projection on boq.BillofQuantityItems;
    entity cbs as projection on boq.BoqCbs;
    entity cbsResource as projection on boq.BoqResource;
    entity RequestBoqItems as projection on rr.RequestBoqItems;
}

annotate RequestResource.ResourceRequests with @odata.draft.enabled;