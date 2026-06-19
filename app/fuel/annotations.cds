using ResourceServices as service from '../../srv/resource-type-service';
using from '../../srv/fuel-management-service';
using from '../../db/vehiclemanagement/fuel-management';


annotate FuelManagementService.fuelRequest with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: vehicle_ID,
                Label: 'Vehicle',
            },
            {
                $Type: 'UI.DataField',
                Label: 'Driver',
                Value: driver,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Status',
                Value: status,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Serial No',
                Value: SerialNo,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Chassis',
                Value: Chassis,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Engine No',
                Value: EngineNo,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Year',
                Value: Year,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Capacity',
                Value: Capacity,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Expected Mileage',
                Value: ExpectedMilage,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Registration No',
                Value: RegNo,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Mileage',
                Value: Mileage,
            },
        ],
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Fuel Indents',
            ID    : 'FuelIndents',
            Target: 'indents/@UI.LineItem#FuelIndents',
        },
    ],
    UI.LineItem                  : [{
        $Type: 'UI.DataField',
        Value: vehicle_ID,
        Label: 'Vehicle',
    },

    ],
    UI.HeaderInfo                : {
        Title         : {
            $Type: 'UI.DataField',
            Value: vehicle_ID,
        },
        TypeName      : 'Fuel Management',
        TypeNamePlural: 'Fuel Management',
    },
);

annotate FuelManagementService.fuelRequest with {
    vehicle @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'assetsVH',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: vehicle_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'assetCtegory',
                },

                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: SerialNo,
                    ValueListProperty: 'SerialNo',
                },
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: Chassis,
                    ValueListProperty: 'Chassis',
                },
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: EngineNo,
                    ValueListProperty: 'EngineNo',
                },
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: Year,
                    ValueListProperty: 'Year',
                },
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: Capacity,
                    ValueListProperty: 'Capacity',
                },
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: ExpectedMilage,
                    ValueListProperty: 'ExpectedMilage',
                },
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: RegNo,
                    ValueListProperty: 'RegNo',
                },
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: Mileage,
                    ValueListProperty: 'Mileage',
                },
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: fuelRequired,
                    ValueListProperty: 'fuelRequired',
                }
            ],
        },
        Common.ValueListWithFixedValues: false,
        Common.Text                    : vehicle.assetCtegory,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate FuelManagementService.assetsVH with @(UI.LineItem: [{
    $Type: 'UI.DataField',
    Value: assetCtegory,
    Label: 'Asset Category'
}]);

annotate FuelManagementService.assets with {
    ID @(
        Common.Text                    : assetCtegory,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate FuelManagementService.fuelIndent with @(UI.LineItem #FuelIndents: [
    {
        $Type: 'UI.DataField',
        Value: indentNo,
        Label: 'Indent No',
    },
    {
        $Type: 'UI.DataField',
        Value: fuelType_code,
        Label: 'Fuel Type',
    },
    {
        $Type: 'UI.DataField',
        Value: requestedQty,
        Label: 'Requested Qty',
    },
    {
        $Type: 'UI.DataField',
        Value: uom,
        Label: 'UOM',
    },
    {
        $Type: 'UI.DataField',
        Value: requestedBy,
        Label: 'Requested By',
    },

]);


annotate FuelManagementService.assetsVH with {
    ID @(
        Common.Text                    : assetCtegory,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate FuelManagementService.fuelIndent with {
    fuelType @(
        Common.ValueListWithFixedValues: true,
        Common.Text : fuelType.name,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate FuelManagementService.fuelRequest with {
    driver         @Core.Computed;
    status        @Core.Computed;
    indents        @Core.Computed;
    SerialNo       @Core.Computed;
    EngineNo       @Core.Computed;
    Year          @Core.Computed;
    Capacity       @Core.Computed;
    ExpectedMilage @Core.Computed;
    RegNo          @Core.Computed;
    Mileage       @Core.Computed;
    fuelRequired  @Core.Computed;
    Chassis  @Core.Computed;
}
