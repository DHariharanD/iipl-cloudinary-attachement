using { API_ENTERPRISE_PROJECT_SRV } from './external/API_ENTERPRISE_PROJECT_SRV_0002';

service ProjectService {

    // =====================================================
    // ✅ Project Header (List + Object Page)
    // =====================================================
    entity Projectsec as projection on API_ENTERPRISE_PROJECT_SRV.A_EnterpriseProject {
        key ProjectUUID,
        Project,
        ProjectDescription,
        ProjectStartDate,
        ProjectEndDate,
        ProjectCurrency,
        to_EnterpriseProjectElement as to_ProjectElement 
    };

    // =====================================================
    // ✅ Project Element (Tree Structure)
    // =====================================================
    @Aggregation.RecursiveHierarchy #ProjectElement : {
        NodeProperty: 'ProjectElementUUID',
        ParentNodeProperty: 'ParentObjectUUID'
    }
    entity ProjectElement as projection on API_ENTERPRISE_PROJECT_SRV.A_EnterpriseProjectElement {
        key ProjectElementUUID,
        ProjectElement,
        ProjectElementDescription,
        ParentObjectUUID,
        ProjectUUID
    };

}