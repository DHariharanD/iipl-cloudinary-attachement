//using ResourceServices as service from '../../srv/resource-type-service';
using from '../../srv/projects-primavera-wbs-service';
using from '../../db/projects/project-primavera-wbs-mapping';

annotate ProjectPrimaveraWBSService.PrimaveraProjects with @(
    UI.SelectionFields                  : [
        primaveraProjectCode,
        primaveraProjectName,
    ],
    UI.LineItem                         : [
        {
            $Type: 'UI.DataField',
            Value: primaveraProjectCode,
        },
        {
            $Type: 'UI.DataField',
            Value: primaveraProjectName,
        },
    ],
    UI.Facets                           : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Projects',
            ID    : 'ProjectDetails',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>PrimaveraProject1}',
                    ID    : 'i18nPrimaveraProject1',
                    Target: '@UI.FieldGroup#i18nPrimaveraProject1',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Project Details',
                    ID    : 'ProjectDetails1',
                    Target: '@UI.FieldGroup#ProjectDetails',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Primavera Wbs Elements',
            ID    : 'i18nPrimaveraWbsElements',
            Target: 'prHierarchies/@UI.LineItem#i18nPrimaveraWbsElements',
        },

    ],
    UI.FieldGroup #i18nPrimaveraProject1: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: primaveraProjectCode,
            },
            {
                $Type: 'UI.DataField',
                Value: primaveraProjectName,
            },

        ],
    },
    UI.HeaderInfo                       : {
        TypeName      : '{i18n>ProjectPrimaveraWbsMapping}',
        TypeNamePlural: '{i18n>ProjectPrimaveraWbsMapping}',
        Title         : {
            $Type: 'UI.DataField',
            Value: primaveraProjectName,
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: primaveraProjectCode,
        },
        TypeImageUrl  : 'sap-icon://broken-link',
    },
    UI.FieldGroup #ProjectDetails       : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: prHierarchies.prWbsMapping.project_ID,
                Label: 'Project',
            },
            {
                $Type: 'UI.DataField',
                Value: prHierarchies.prWbsMapping.projectWbs_ID,
                Label: 'Project Wbs',
            },
        ],
    },
);

annotate ProjectPrimaveraWBSService.PrimaveraProjects with {
    primaveraProjectName @(Common.Label: '{i18n>Name}',

    )
};

annotate ProjectPrimaveraWBSService.PrimaveraProjects with {
    primaveraProjectCode @(
        Common.Label                   : '{i18n>Code}',
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'ProjectPrimaveraMapping',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: primaveraProjectCode,
                    ValueListProperty: 'projectCode',
                },
                {
                    $Type            : 'Common.ValueListParameterOut',
                    ValueListProperty: 'projectname',
                    LocalDataProperty: primaveraProjectName,
                },
            ],
            Label         : 'Select Primavera Project',
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate ProjectPrimaveraWBSService.PrimaveraWBS with @(
    UI.LineItem #i18nPrimaveraWbsElements: [
        {
            $Type: 'UI.DataField',
            Value: primaverawbsCode,
            Label: 'Wbs Code',
        },
        {
            $Type: 'UI.DataField',
            Value: primaverawbs,
            Label: 'Wbs Name',
        },

    ],
    UI.Facets                            : [{
        $Type : 'UI.CollectionFacet',
        Label : 'General Information ',
        ID    : 'GeneralInformation',
        Facets: [
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Project Details',
                ID    : 'ProjectDetails',
                Target: '@UI.FieldGroup#ProjectDetails',
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Primavera Project',
                ID    : 'PrimaveraProject',
                Target: '@UI.FieldGroup#PrimaveraProject',
            },
        ],
    }, ],
    UI.FieldGroup #ProjectDetails        : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: prWbsMapping.project_ID,
                Label: 'Project',
            },
            {
                $Type: 'UI.DataField',
                Value: prWbsMapping.projectWbs_ID,
                Label: 'Project Wbs',
            },
        ],
    },
    UI.FieldGroup #PrimaveraProject      : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: prWbsMapping.primavearID,
                Label: 'Primavear ID',
            },
            {
                $Type: 'UI.DataField',
                Value: prWbsMapping.primaveraName,
                Label: 'Primavera Name',
            },
        ],
    },
    UI.HeaderInfo                        : {
        Title         : {
            $Type: 'UI.DataField',
            Value: pjHierarchies.primaveraProjectName,
        },
        TypeName      : '',
        TypeNamePlural: '',
        Description : {
            $Type : 'UI.DataField',
            Value : createdAt,
        },
    },
);

annotate ProjectPrimaveraWBSService.PrimaveraWBSMapping with {
    project @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Projects',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: project_ID,
                ValueListProperty: 'ID',
            }, ],
            Label         : 'Select Project',
        },
        Common.ValueListWithFixedValues: true,
        Common.Text                    : project.projectDescription,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate ProjectPrimaveraWBSService.Projects with {
    ID @(
        Common.Text                    : projectDescription,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};


annotate ProjectPrimaveraWBSService.PrimaveraWBSMapping with {
    projectWbs @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Wbs',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: projectWbs_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterIn',
                    ValueListProperty: 'plshierarchy_ID',
                    LocalDataProperty: project_ID,
                },
            ],
        },
        Common.ValueListWithFixedValues: true,
        Common.Text                    : projectWbs.projectElementDescription,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate ProjectPrimaveraWBSService.Wbs with {
    ID @(
        Common.Text                    : projectElementDescription,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};
