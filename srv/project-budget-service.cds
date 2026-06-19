using { ec.masters as res } from '../db/projects/project-budget';
using { CommonService as cm } from './common-service';
using { ec.masters as ep } from '../db/projects/enterprise-project';
using { ec.masters as wbs } from '../db/projects/enterprise-project';
using { ec.masters as boq } from '../db/billofquantities/bill-of-quantity';

service ProjectBudgetService {

    @odata.draft.enabled
    entity ProjectBudget          as projection on res.ProjectBudget;

    // entity ProjectBudgetWbsItems  as projection on res.ProjectBudgetWbsItems;
    entity ProjectBudgetResources as projection on res.ProjectBudgetResources;

    entity BillofQuantityHeader   as projection on boq.BillofQuantityHeader;
    entity company                as projection on cm.Companies;
    entity Projects               as projection on ep.Projects;
    entity Wbs                    as projection on wbs.ProjectPlanning;
}

annotate ProjectBudgetService.Projects with {
    ID @UI.Hidden
};
