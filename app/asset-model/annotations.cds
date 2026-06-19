using VehicleManagementService as service from '../../srv/vehicle-management-service';

annotate service.AssetModel with @(
    UI.HeaderInfo: {
        TypeName      : 'Asset Model',
        TypeNamePlural: 'Asset Models',
        Title         : {
            $Type: 'UI.DataField',
            Value: companyCode,
        },
    },

    UI.LineItem  : [
        {
            $Type: 'UI.DataField',
            Value: companyCode,
            Label: 'Company Code',
        },
        {
            $Type: 'UI.DataField',
            Value: modelMake,
            Label: 'Make',
        },
        {
            $Type: 'UI.DataField',
            Value: modelModel,
            Label: 'Model',
        },
        {
            $Type: 'UI.DataField',
            Value: modelDescr,
            Label: 'Description',
        },
    ]
);

annotate service.AssetModel with {

    modelMake   @Common.Label: 'Make';
    modelModel  @Common.Label: 'Model';
    modelDescr  @Common.Label: 'Description';

    companyCode @(
        Common.Label                   : 'Company Code',
        Common.ValueList               : {
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
                },
            ],
            Label         : 'Company Code',
        },
        Common.ValueListWithFixedValues: true,
        Common.Text                    : company.CompanyCodeName,
        Common.Text.@UI.TextArrangement: #TextLast,
    );

};
