using ResourceServices as service from '../../srv/resource-type-service';
using from '../../srv/trip-management-service';
using from '../../db/vehiclemanagement/trip-management';

annotate TripManagementService.Trips with @(
    UI.LineItem                         : [
        {
            $Type: 'UI.DataField',
            Value: tripName,
            Label: 'Trip Name',
        },
        {
            $Type: 'UI.DataField',
            Value: tripType_code,
            Label: 'Trip Type',
        },
        {
            $Type: 'UI.DataField',
            Value: status_code,
            Label: 'Status',
        },
    ],
    UI.Facets                           : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Trip Details',
            ID    : 'TripDetails',
            Target: '@UI.FieldGroup#TripDetails',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Vehicle Information',
            ID    : 'VehicleInformation',
            Target: '@UI.FieldGroup#VehicleInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Route',
            ID    : 'Route',
            Target: '@UI.FieldGroup#Route',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Fuel Expense',
            ID    : 'FuelExpense',
            Target: '@UI.FieldGroup#FuelExpense',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Additional Information',
            ID    : 'AdditionalInformation',
            Target: '@UI.FieldGroup#AdditionalInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Attachments',
            ID    : 'Attachments',
            Target: '@UI.FieldGroup#Attachments',
        },
    ],
    UI.FieldGroup #TripDetails          : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: tripName,
                Label: 'Trip Name',
            },
            {
                $Type: 'UI.DataField',
                Value: tripType_code,
                Label: 'Trip Type',
            },
            {
                $Type: 'UI.DataField',
                Value: status_code,
                Label: 'Status',
            },
            {
                $Type: 'UI.DataField',
                Value: startDate,
                Label: 'Start Date',
            },
            {
                $Type: 'UI.DataField',
                Value: endDate,
                Label: 'End Date',
            },
        // {
        //     $Type : 'UI.DataField',
        //     Value : route,
        //     Label : 'Route',
        // },
        ],
    },
    UI.FieldGroup #VehicleInformation   : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: VehicleInfo.vehicle_ID,
                Label: 'Vehicle',
            },
            {
                $Type: 'UI.DataField',
                Value: VehicleInfo.vehicleNumber,
                Label: 'Vehicle Number',
            },
            {
                $Type: 'UI.DataField',
                Value: VehicleInfo.vehicleType,
                Label: 'Vehicle Type',
            },
            {
                $Type: 'UI.DataField',
                Value: VehicleInfo.driverName,
                Label: 'Driver Name',
            },
            {
                $Type: 'UI.DataField',
                Value: VehicleInfo.driverContact,
                Label: 'Driver Contact',
            },
            {
                $Type: 'UI.DataField',
                Value: VehicleInfo.licenseNumber,
                Label: 'License Number',
            },
        ],
    },
    UI.FieldGroup #Route                : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: RouteInfo.sourceLocation,
                Label: 'Source Location',
            },
            {
                $Type: 'UI.DataField',
                Value: RouteInfo.destinationLocation,
                Label: 'Destination Location',
            },
            {
                $Type: 'UI.DataField',
                Value: RouteInfo.departureTime,
                Label: 'Departure Time',
            },
            {
                $Type: 'UI.DataField',
                Value: RouteInfo.expectedArrival,
                Label: 'Expected Arrival',
            },
        ],
    },
    UI.FieldGroup #FuelExpense          : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: FuelExpInfo.fuelIssued,
                Label: 'Fuel Issued',
            },
            {
                $Type: 'UI.DataField',
                Value: FuelExpInfo.fuelConsumed,
                Label: 'Fuel Consumed',
            },
            {
                $Type: 'UI.DataField',
                Value: FuelExpInfo.fuelCost,
                Label: 'Fuel Cost',
            },
            {
                $Type: 'UI.DataField',
                Value: FuelExpInfo.tollCharges,
                Label: 'Toll Charges',
            },
            {
                $Type: 'UI.DataField',
                Value: FuelExpInfo.driverAllowance,
                Label: 'Driver Allowance',
            },
            {
                $Type: 'UI.DataField',
                Value: FuelExpInfo.otherExpenses,
                Label: 'Other Expenses',
            },
        ],
    },
    UI.FieldGroup #AdditionalInformation: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: stops.currentStatus,
                Label: 'Current Status',
            },
            {
                $Type: 'UI.DataField',
                Value: stops.delayReason,
                Label: 'Delay Reason',
            },
            {
                $Type: 'UI.DataField',
                Value: stops.remarks,
                Label: 'Remarks',
            },
        ],
    },
    UI.FieldGroup #Attachments          : {
        $Type: 'UI.FieldGroupType',
        Data : [],
    },
    UI.HeaderInfo                       : {
        Title         : {
            $Type: 'UI.DataField',
            Value: tripName,
        },
        TypeName      : 'Trip Management',
        TypeNamePlural: 'Trip Management',
        Description   : {
            $Type: 'UI.DataField',
            Value: tripType_code,
        },
    },
);

annotate TripManagementService.Trips with {
    tripType @(
        Common.ValueListWithFixedValues: true,
        Common.Text                    : tripType.name,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate TripManagementService.tripType with {
    code @(
        Common.Text                    : name,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate TripManagementService.Trips with {
    status @(
        Common.ValueListWithFixedValues: true,
        Common.Text                    : status.name,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate TripManagementService.tripStatus with {
    code @(
        Common.Text                    : name,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate TripManagementService.VehicleInformation with {
    vehicle @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Assets',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: vehicle_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterConstant',
                    ValueListProperty: 'assetType_code',
                    Constant         : 'VH'
                }
            ],
        },
        Common.ValueListWithFixedValues: false,
        Common.Text                    : assetCtegory,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate TripManagementService.Assets with {
    ID @(
        Common.Text                    : assetCtegory,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};
