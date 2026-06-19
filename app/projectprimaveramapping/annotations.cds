using ProjectPrimaveraService as service from '../../srv/project-primavera-service';

annotate service.ProjectPrimaveraMapping with @(

    UI.SelectionFields             : [
        company,
        projectCode,
        projectname,
        primavearID,
        primaveraName
    ],

    UI.LineItem                    : [
        {
            $Type: 'UI.DataField',
            Value: company,
            Label: '{i18n>CompanyCode}'
        },
        {
            $Type: 'UI.DataField',
            Value: projectCode,
            Label: 'Project Code'
        },
        {
            $Type: 'UI.DataField',
            Value: projectname,
            Label: 'Project Name'
        },
        {
            $Type: 'UI.DataField',
            Value: primavearID,
            Label: 'Primavera ID'
        },
        {
            $Type: 'UI.DataField',
            Value: primaveraName,
            Label: 'Primavera Name'
        }
    ],

    UI.HeaderInfo                  : {
        TypeName      : 'Project Primavera Mapping',
        TypeNamePlural: 'Project Primavera Mapping',
        Title         : {
            $Type: 'UI.DataField',
            Value: projectname
        }
    },

    UI.Facets                      : [{
        $Type : 'UI.CollectionFacet',
        Label : 'Overview',
        ID    : 'Overview',
        Facets: [
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Project Details',
                Target: '@UI.FieldGroup#ProjectDetails'
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Primavera Details',
                Target: '@UI.FieldGroup#PrimaveraDetails'
            }
        ]
    }],

    UI.FieldGroup #ProjectDetails  : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: company,
                Label: '{i18n>CompanyCode}'
            },
            {
                $Type: 'UI.DataField',
                Value: projectCode,
                Label: 'Project Code'
            },
            {
                $Type                  : 'UI.DataField',
                Value                  : projectname,
                Label                  : 'Project Name',
                ![@Common.FieldControl]: #ReadOnly 
            }
        ]
    },

    UI.FieldGroup #PrimaveraDetails: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: primavearID,
                Label: 'Primavera ID'
            },
            {
                $Type: 'UI.DataField',
                Value: primaveraName,
                Label: 'Primavera Name'
            }
        ]
    }
);

annotate service.ProjectPrimaveraMapping with {
    primavearID   @Common.Label: 'Primavera ID';
    primaveraName @Common.Label: 'Primavera Name';
    projectCode   @Common.Label: 'Project Code';
    projectname   @(
        Common.Label   : 'Project Name',
        UI.CreateHidden: true,
        UI.UpdateHidden: false
    );
};

annotate service.ProjectPrimaveraMapping with {
    company @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'company',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: company,
                ValueListProperty: 'CompanyCode'
            }],
            Label         : '{i18n>SelectCompanyCode}'
        },
        Common.ValueListWithFixedValues: true
    )
};

annotate service.company with {
    CompanyCode @Common.Text: CompanyCodeName
};

annotate service.ProjectPrimaveraMapping with {
    projectCode @(Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Projects',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: projectCode,
                ValueListProperty: 'project'
            },
            {
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: projectname, // auto-fills projectname
                ValueListProperty: 'projectDescription'
            },
            {
                $Type            : 'Common.ValueListParameterIn',
                LocalDataProperty: company,
                ValueListProperty: 'companyCode'
            }
        ],
        Label         : 'Project'
    })
};

annotate service.Projects with {
    ID @UI.Hidden;
};


annotate service.Projects with {
    project @Common.Text: projectDescription
};
