using ProjectBOQMappingService as service from '../../srv/projectBOQMapping-service';
using from '../../db/projects/enterprise-project';

annotate service.ProjectBOQMapping with @(Common.SideEffects: {
    SourceProperties: [project_ID],
    TargetEntities: [wbsList]
});
annotate service.ProjectBOQMapping with @(
    UI.SelectionFields : [
        project_ID,
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : project_ID,
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Overview}',
            ID : 'i18nOverview',
            Target : '@UI.FieldGroup#i18nOverview',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>WbsElements}',
            ID : 'i18nWbsElements',
            Target : 'wbsList/@UI.LineItem#i18nWbsElements1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'BOQ',
            ID : 'BOQ',
            Target : 'items/@UI.LineItem#BOQ',
        },
    ],
    UI.FieldGroup #i18nOverview : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : project_ID,
            },
        ],
    },
    UI.HeaderInfo : {
        TypeName : '{i18n>ProjectBoqMapping}',
        TypeNamePlural : '{i18n>ProjectBoqMapping}',
    },
);

annotate service.ProjectBOQMapping with {
    project @(
        Common.Label : '{i18n>Project}',

        Common.Text : project.projectDescription,
        Common.TextArrangement : #TextOnly,

        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Projects',
            Parameters : [
                // {
                //     $Type : 'Common.ValueListParameterInOut',
                //     LocalDataProperty : project_ID,
                //     ValueListProperty : 'ID'
                // },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'projectDescription'
                }
            ],
            Label : 'Project'
        },
        Common.ValueListWithFixedValues : false,
    );
};

annotate service.ProjectBOQMappingItem with @(
    UI.LineItem #i18nWbsElements : [
        {
            $Type : 'UI.DataField',
            Value : description,
            Label : '{i18n>Description}',
        },
        {
            $Type : 'UI.DataField',
            Value : quantity,
            Label : '{i18n>Quantity}',
        },
        {
            $Type : 'UI.DataField',
            Value : unitOfMeasurement,
            Label : '{i18n>UnitOfMeasurement}',
        },
        {
            $Type : 'UI.DataField',
            Value : wbs_ID,
            Label : '{i18n>Wbs}',
        },
        {
            $Type : 'UI.DataField',
            Value : boq_ID,
            Label : '{i18n>Boq}',
        },
    ],
    UI.LineItem #i18nWbsElements1 : [
        {
            $Type : 'UI.DataField',
            Value : wbs.projectElementDescription,
            Label : '{i18n>ProjectElementDescription}',
        },
        {
            $Type : 'UI.DataField',
            Value : wbs.plannedStartDate,
            Label : '{i18n>PlannedStartDate}',
        },
        {
            $Type : 'UI.DataField',
            Value : wbs.plannedEndDate,
            Label : '{i18n>PlannedEndDate}',
        },
        {
            $Type : 'UI.DataField',
            Value : wbs.costCenter,
            Label : '{i18n>CostCenter}',
        },
        {
            $Type : 'UI.DataField',
            Value : wbs.profitCenter,
            Label : '{i18n>ProfitCenter}',
        },
    ],
    UI.LineItem #BOQ : [
        {
            $Type : 'UI.DataField',
            Value : wbs_ID,
            Label : '{i18n>Boq}',
        },
    ],
);

annotate service.Projects with {
    ID @Common.Text : projectDescription
};

annotate service.ProjectBOQMappingItem with {
    wbs @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'ProjectBOQMappingItem',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : wbs_ID,
                    ValueListProperty : 'ID',
                },
            ],
            Label : '{i18n>WbsElements}',
            Text : 'projectElementDescription',
            FilterExpression : 'plshierarchy_ID eq :project_ID'
        },
        Common.ValueListWithFixedValues : true,
)};
annotate service.ProjectPlanning with @(
    UI.LineItem #i18nWbsElements1 : [
        { $Type: 'UI.DataField', Value: projectElementDescription },
        { $Type: 'UI.DataField', Value: plannedStartDate },
        { $Type: 'UI.DataField', Value: plannedEndDate },
        { $Type: 'UI.DataField', Value: costCenter },
        { $Type: 'UI.DataField', Value: profitCenter }
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'BOQ',
            ID : 'BOQ',
            Target : 'WbsBoq/@UI.LineItem#BOQ',
        },
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : projectElementDescription,
        },
        TypeName : '',
        TypeNamePlural : '',
    },
);

annotate service.ProjectPlanning with {
    plshierarchy @Common.Text : projectElementDescription
};
annotate service.ProjectBOQMappingItem with {
    ID @Common.Text : description
};

annotate service.WbsBillOfQuantities with @(
  UI.LineItem #BOQ : [
    {
      $Type : 'UI.DataField',
      Value : item,
      Label : 'Item'
    },
    {
      $Type : 'UI.DataField',
      Value : description,
      Label : 'Description'
    },
    {
      $Type : 'UI.DataField',
      Value : quantity,
      Label : 'Quantity'
    },
    {
      $Type : 'UI.DataField',
      Value : unitOfMeasurement,
      Label : 'Unit Of Measurement'
    }
  ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Resources',
            ID : 'Resources',
            Target : 'boqResources/@UI.LineItem#Resources',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'CBS',
            ID : 'CBS',
            Target : 'boqCBS/@UI.LineItem#CBS',
        },
    ],
);
annotate service.BoqResources with @(
    UI.LineItem #Resources : [
        {
            $Type : 'UI.DataField',
            Value : parent.boqResources.productId,
            Label : 'productId',
        },
        {
            $Type : 'UI.DataField',
            Value : parent.boqResources.productName,
            Label : 'productName',
        },
        {
            $Type : 'UI.DataField',
            Value : parent.boqResources.unitofMeasure,
            Label : 'unitofMeasure',
        },
    ]
);

annotate service.BoqCbs with @(
    UI.LineItem #CBS : [
        {
            $Type : 'UI.DataField',
            Value : parent.boqCBS.productId,
            Label : 'productId',
        },
        {
            $Type : 'UI.DataField',
            Value : parent.boqCBS.productName,
            Label : 'productName',
        },
        {
            $Type : 'UI.DataField',
            Value : parent.boqCBS.quantity,
            Label : 'quantity',
        },
        {
            $Type : 'UI.DataField',
            Value : parent.boqCBS.unitofMeasure,
            Label : 'unitofMeasure',
        },
    ]
);

