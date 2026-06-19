using AllocationService as service from '../../srv/allocation-service';

annotate service.Allocations with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [

            {
                $Type : 'UI.DataField',
                Label : 'Project',
                Value : project_ID
            },

            {
                $Type : 'UI.DataField',
                Label : 'WBS',
                Value : wbs_ID
            },

            {
                $Type : 'UI.DataField',
                Label : 'BOQ',
                Value : boqItem_ID
            },

            {
                $Type : 'UI.DataField',
                Label : 'Cost Code',
                Value : cbs_ID
            },

            {
                $Type : 'UI.DataField',
                Label : 'FloorZone Reference',
                Value : floorZoneReference
            },

            {
                $Type : 'UI.DataField',
                Label : 'Notes',
                Value : notes
            }
        ]
    },

    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : 'BOQ Item',
            Target : 'boqDetails/@UI.LineItem'
        }
    ],

    UI.LineItem : [

        {
            $Type : 'UI.DataField',
            Label : 'Project',
            Value : project_ID
        },

        {
            $Type : 'UI.DataField',
            Label : 'WBS',
            Value : wbs_ID
        },

        {
            $Type : 'UI.DataField',
            Label : 'BOQ',
            Value : boqItem_ID
        },

        {
            $Type : 'UI.DataField',
            Label : 'Cost Code',
            Value : cbs_ID
        },
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : project.projectDescription,
        },
        TypeName : '',
        TypeNamePlural : '',
    },
);


annotate service.BoqItem with @(

    UI.LineItem : [

        {
            $Type : 'UI.DataField',
            Label : 'Item',
            Value : item
        },

        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : description
        },

        {
            $Type : 'UI.DataField',
            Label : 'Total Quantity',
            Value : quantity
        },

        {
            $Type : 'UI.DataField',
            Label : 'Actual Quantity',
            Value : actualQuantity
        },

        {
            $Type : 'UI.DataField',
            Label : 'Actual Amount',
            Value : actualAmount
        },

        {
            $Type : 'UI.DataField',
            Label : 'UOM',
            Value : unitOfMeasurement
        }
    ]
);


annotate service.Allocations with {

    project @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Projects',
            Parameters : [

                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : project_ID,
                    ValueListProperty : 'ID'
                },

                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'projectDescription'
                }
            ]
        },

        Common.ValueListWithFixedValues : false,
        Common.Text : project.projectDescription,
        Common.TextArrangement : #TextOnly
    );

    wbs @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Wbs',
            Parameters : [

                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : wbs_ID,
                    ValueListProperty : 'ID'
                },

                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'projectElementDescription'
                },

                {
                    $Type : 'Common.ValueListParameterIn',
                    LocalDataProperty : project_ID,
                    ValueListProperty : 'project_ID'
                }
            ]
        },

        Common.ValueListWithFixedValues : false,
        Common.Text : wbs.projectElementDescription,
        Common.TextArrangement : #TextOnly
    );

    boqItem @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'BoqItem',
            Parameters : [

                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : boqItem_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'item'
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                },
                {
                    $Type : 'Common.ValueListParameterIn',
                    LocalDataProperty : wbs_ID,
                    ValueListProperty : 'wbs_ID'
                }
            ]
        },

        Common.ValueListWithFixedValues : false,
        Common.Text : boqItem.description,
        Common.TextArrangement : #TextOnly
    );


    cbs @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'CostBreakdownStructure',
            Parameters : [

                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : cbs_ID,
                    ValueListProperty : 'ID'
                },

                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },

                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                },

                {
                    $Type : 'Common.ValueListParameterIn',
                    LocalDataProperty : boqItem_ID,
                    ValueListProperty : 'boqitem_ID'
                }
            ]
        },

        Common.ValueListWithFixedValues : false,
        Common.Text : cbs.name,
        Common.TextArrangement : #TextOnly
    );
};

annotate service.Projects with {
    ID @(
        Common.Text : projectDescription,
        UI.Hidden
    );
};

annotate service.Wbs with {
    ID @(
        Common.Text : projectElementDescription,
        UI.Hidden
    );
};

annotate service.CostBreakdownStructure with {
    ID @(
        Common.Text : name,
        UI.Hidden
    );

};

annotate service.BoqItem with {
    ID @(
        Common.Text : description,
        UI.Hidden
    );
};


annotate service.Allocations with @(
    Common.SideEffects : {
        SourceProperties : ['boqItem_ID'],
        TargetEntities   : ['boqDetails']
    }
);