using {ec.masters as res} from '../db/billofquantities/bill-of-quantity';
using {API_COMPANYCODE_SRV as CO} from './external/API_COMPANYCODE_SRV';
using {ec.masters as cbs} from '../db/cbs/cbs';


service BillofQuantityService {
  //   @odata.draft.enabled
  //   @Capabilities.Insertable: true
  //   @Capabilities.Updateable: true
  //   @Capabilities.Deletable : true
  entity BillofQuantityHeader   as
    projection on res.BillofQuantityHeader {
      *,
      company_CompanyCode
    }
    excluding {
      company
    };

  @readonly
  entity Companies              as projection on CO.A_CompanyCode;

  entity BillofQuantityItem     as
    projection on res.BillofQuantityItems {
      *,
    };

  entity Projects               as projection on res.Projects;
  entity ProjectPlanning        as projection on res.ProjectPlanning;
  entity CostBreakdownStructure as projection on cbs.CostBreakdownStructure;

  entity BoqCbs                 as
    projection on res.BoqCbs {
      *,
      parent
    };

  entity BoqResource            as
    projection on res.BoqResource {
      *,
      parent
    };

  entity CBSResourceMaterial    as projection on cbs.CBSResourceMaterial;
  entity addPayments            as projection on res.addPayments;
  action UploadBoq(file: LargeBinary);

}

annotate BillofQuantityService.BillofQuantityHeader with @odata.draft.enabled;
