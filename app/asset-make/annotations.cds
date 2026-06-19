using VehicleManagementService as service from '../../srv/vehicle-management-service';

annotate service.AssetMake with @(

    UI.LineItem: [
        {
            $Type: 'UI.DataField',
            Value: assetCode,
            Label: 'Code',
        },
        {
            $Type: 'UI.DataField',
            Value: assetName,
            Label: 'Name',
        },
        {
            $Type: 'UI.DataField',
            Value: companyCode,
            Label: 'Company',
        },
        {
            $Type: 'UI.DataField',
            Value: assetDescr,
            Label: 'Description',
        }
    ]

);

annotate service.AssetMake with {

    assetCode   @Common.Label: 'Code';
    assetName   @Common.Label: 'Name';
    assetDescr  @Common.Label: 'Description';

    companyCode @(
        Common.Label : 'Company Code',

        Common.ValueList : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'company',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: companyCode,
                    ValueListProperty: 'CompanyCode',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'CompanyCodeName',
                }
            ]
        },

        Common.ValueListWithFixedValues: true
    );
};

annotate service.company with {
    CompanyCode @Common.Text : CompanyCodeName
};