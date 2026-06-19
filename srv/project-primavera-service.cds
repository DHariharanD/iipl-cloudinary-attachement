using {ec.masters as res} from '../db/projects/project-primavera-mapping';
using {API_COMPANYCODE_SRV as CO} from './external/API_COMPANYCODE_SRV';
using {CommonService as cmm} from './common-service';

service ProjectPrimaveraService {

  @odata.draft.enabled
  @Capabilities.Insertable: true
  @Capabilities.Updateable: true
  @Capabilities.Deletable : true

  entity ProjectPrimaveraMapping as projection on res.ProjectPrimaveraMapping;

  entity company                 as projection on cmm.Companies;

  @readonly
  entity Projects                as projection on res.Projects;

}
