namespace ec.masters;

using { cuid, managed } from '@sap/cds/common';

entity enterpriseProjects : cuid,managed {
  projectId       : String(50);
  projectname     : String(150);
}
