using { ec.masters as res } from '../db/assets/asset-request';
using { ec.masters as ep }  from '../db/projects/enterprise-project';
using { ec.masters as boq } from '../db/billofquantities/bill-of-quantity';
using { API_COMPANYCODE_SRV as CO } from './external/API_COMPANYCODE_SRV';
using { CommonService as cm } from './../srv/common-service';

service AssetRequestService {

  entity AssetRequest as
    projection on res.AssetRequest {
      *,
      company
    }
    excluding {
      company
    };

  @readonly
  entity company                  as projection on cm.Companies{
    *

  };

  entity RequestAssetItems as
    projection on res.RequestAssetItem {
      *
    };

  entity ProcessRequests as
    projection on res.ProcessRequest {
      *
    };

  entity BillofQuantityHeader as
    projection on boq.BillofQuantityHeader {
      *
      
    };
entity BillofQuantityItems as projection on boq.BillofQuantityItems {
      *
      
    };
  @readonly
  entity Projects as
    projection on ep.Projects {
      *
    };

  @readonly
  entity ProjectPlanning as
    projection on ep.ProjectPlanning {
      *,
      projectId
    };

}
annotate AssetRequestService.AssetRequest with @odata.draft.enabled;