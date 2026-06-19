namespace ec.masters;

using {
  cuid,
  managed
} from '@sap/cds/common';

using {ec.masters as pj} from '../projects/enterprise-project';
// using {API_COMPANYCODE_SRV as CO} from '../../srv/external/API_COMPANYCODE_SRV';

entity ProjectPrimaveraMapping : cuid, managed {

  company       : String(40) @mandatory;
  project       : Association to pj.Projects;
  projectCode   : String(20);
  projectname   : String(150);
  primavearID   : String(50);
  primaveraName : String(150);

}
