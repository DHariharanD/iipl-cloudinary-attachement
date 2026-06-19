using {
        cuid,
        managed
} from '@sap/cds/common';
using {ec.masters as pj} from '../projects/enterprise-project';

namespace ec.masters;

entity PrimaveraProjects : cuid, managed {
        key ID                  : UUID @Core.Computed;
            primaveraProjectCode : String(40);
            primaveraProjectName : String(150);
            prHierarchies        : Composition of many PrimaveraWBS
                                           on prHierarchies.pjHierarchies = $self;
}

entity PrimaveraWBS : cuid, managed {
        key ID                     : String;
            primaverawbs           : String(40);
            primaverawbsCode       : String(40);
            parent                 : Association to PrimaveraWBS;
            pjHierarchies          : Association to one PrimaveraProjects;
            prWbsMapping           : Composition of one PrimaveraWBSMapping
                                             on prWbsMapping.prWbshierarchy = $self;

            @Core.Computed: true
            LimitedDescendantCount : Integer64;

            @Core.Computed: true
            DistanceFromRoot       : Integer64;

            @Core.Computed: true
            DrillState             : String;

            @Core.Computed: true
            Matched                : Boolean;

            @Core.Computed: true
            MatchedDescendantCount : Integer64;
}

entity PrimaveraWBSMapping @(Common: {SemanticKey: [ID]}) : cuid, managed {
        // key ID           : String;
        company        : String(40);
        project        : Association to pj.Projects;
        projectWbs     :Association to pj.ProjectPlanning;
        boq            : String(40);
        cbs            : String(40);
        amount         : String(111);
        primavearID    : String(50);
        primaveraName  : String(150);
        prWbshierarchy : Association to PrimaveraWBS;
        
}
