using ProjectService as service from '../../srv/projects-service';

/* =====================================================
   PROJECT HEADER (LIST REPORT + OBJECT PAGE)
===================================================== */

annotate service.Projectsec with @(
    
    // List Report Columns
    UI.LineItem : [
        { $Type : 'UI.DataField', Value : Project },
        { $Type : 'UI.DataField', Value : ProjectDescription },
        { $Type : 'UI.DataField', Value : ProjectStartDate },
        { $Type : 'UI.DataField', Value : ProjectEndDate },
        { $Type : 'UI.DataField', Value : ProjectCurrency }
    ],

    // Filters at the top
    UI.SelectionFields : [
        Project,
        ProjectStartDate,
        ProjectEndDate,
        ProjectCurrency
    ],

    // Object Page Header Information
    UI.HeaderInfo : {
        TypeName       : 'Project',
        TypeNamePlural : 'Projects',
        Title          : { Value : Project },
        Description    : { Value : ProjectDescription }
    },

    // Object Page Sections (Facets)
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'ProjectPlanningFacet',
            Label : 'Project Planning Hierarchy',
            // 🔥 FIXED TARGET: Must match the navigation name in your .cds service file
            Target : 'to_ProjectElement/@UI.LineItem#Hierarchy'
        }
    ]
);


/* =====================================================
   PROJECT ELEMENTS (TREE TABLE HIERARCHY)
===================================================== */

annotate service.ProjectElement with @(
    
    // Define the Tree Structure for OData V4
    Aggregation.RecursiveHierarchy #ProjectHierarchy : {
        NodeProperty : ProjectElementUUID,
        ParentNodeProperty : ParentObjectUUID
    },

    // Force the UI to render as a TreeTable
    UI.PresentationVariant : {
        Visualizations : ['@UI.LineItem#Hierarchy']
    },

    // Columns displayed in the Tree/Hierarchy section
    UI.LineItem #Hierarchy : [
        { 
            $Type : 'UI.DataField', 
            Value : ProjectElement,
            Label : 'Element ID'
        },
        { 
            $Type : 'UI.DataField', 
            Value : ProjectElementDescription,
            Label : 'Description'
        }
    ]
);
