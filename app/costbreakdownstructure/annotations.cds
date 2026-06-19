// using ResourceServices as service from '../../srv/resource-type-service';
// using from '../../srv/cbs-service';

// annotate CostBreakdownStructureService.CBSResourceMaterial with @(Common.SideEffects #AmountChange: {
//     SourceProperties: [
//         quantity,
//         rate
//     ],
//     TargetProperties: ['amount'],
//     TargetEntities  : ['']
// });

// annotate CostBreakdownStructureService.CostBreakdownStructure with @(
//     UI.SelectionFields               : [
//         name,
//         code,
//         descr,
//     ],
//     UI.LineItem                      : [
//         {
//             $Type: 'UI.DataField',
//             Value: name,
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: code,
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: descr,
//         },
//         {
//             $Type  : 'UI.DataFieldForAction',
//             Action : 'CostBreakdownStructureService.addNode',
//             IconUrl: 'sap-icon://add',
//             Inline : true,
//         },

//     ],
//     UI.Facets                        : [
//         {
//             $Type : 'UI.ReferenceFacet',
//             Label : 'General Information',
//             ID    : 'GeneralInformation',
//             Target: '@UI.FieldGroup#GeneralInformation',
//         },
//         {
//             $Type     : 'UI.ReferenceFacet',
//             Label     : 'Productivity Code',
//             ID        : 'ProductivityCode',
//             Target    : 'resourceMaterials/@UI.LineItem#ProductivityCode',
//             @UI.Hidden: {$edmJson: {$Ne: [
//                 {$Path: 'children/$count'},
//                 0
//             ]}}
//         },
//     ],
//     UI.FieldGroup #GeneralInformation: {
//         $Type: 'UI.FieldGroupType',
//         Data : [
//             {
//                 $Type: 'UI.DataField',
//                 Value: name,
//             },
//             {
//                 $Type: 'UI.DataField',
//                 Value: code,
//             },
//             {
//                 $Type: 'UI.DataField',
//                 Value: descr,
//             },
//         ],
//     },
//     UI.HeaderInfo                    : {
//         TypeName      : '{i18n>CostBreakdownStructure}',
//         TypeNamePlural: 'Cost Breakdown Structure',
//         Description   : {
//             $Type: 'UI.DataField',
//             Value: descr,
//         },
//         Title         : {
//             $Type: 'UI.DataField',
//             Value: name,
//         },
//     },
//     UI.LineItem #ChildCategories     : [
//         {
//             $Type: 'UI.DataField',
//             Value: code,
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: name,
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: descr,
//         },
//     ],
// );

// annotate CostBreakdownStructureService.CostBreakdownStructure with {
//     name @Common.Label: '{i18n>Name}'
// };

// annotate CostBreakdownStructureService.CostBreakdownStructure with {
//     code @Common.Label: '{i18n>Code}'
// };

// annotate CostBreakdownStructureService.CostBreakdownStructure with {
//     descr @Common.Label: '{i18n>Description}'
// };

// annotate CostBreakdownStructureService.CBSResourceMaterial with @(
//     UI.LineItem #ProductivityCode: [
//         {
//             $Type: 'UI.DataField',
//             Value: productId,
//             Label: 'Product Id'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: productName,
//             Label: 'Product Name'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: productType,
//             Label: 'Product Type'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: unitofMeasure,
//             Label: 'Unit Of Measure'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: labRate,
//             Label: 'Lab.Rate'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: EqpRate,
//             Label: 'Eqp.Rate'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: outputQTY,
//             Label: 'Output QTY'
//         },

//         {
//             $Type: 'UI.DataField',
//             Value: quantity,
//             Label: 'Qty'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: rate,
//             Label: 'Rate'
//         },
//         {
//             $Type: 'UI.DataField',
//             Value: amount,
//             Label: 'Amount'
//         }
//     ],
//     UI.CreateHidden              : true
// );


// annotate CostBreakdownStructureService.CBSResourceMaterial with {

//     amount @Aggregation.default: #SUM;

//     amount @Common.FieldControl: #ReadOnly;

//     amount @UI.DataPoint       : {ValueFormat: {NumberOfFractionalDigits: 2}};

// };

// annotate CostBreakdownStructureService.CBSResourceMaterial with @(Aggregation.ApplySupported: {
//     Transformations: [
//         'aggregate',
//         'groupby'
//     ],
//     Rollup         : #None
// });
