using RequestResource as service from '../../srv/resource-request-service';

annotate service.ResourceRequests with @(
    UI.LineItem                      : [
        {
            $Type : 'UI.DataField',
            Value : name,
            Label : '{i18n>Name}',
        },{
        $Type: 'UI.DataField',
        Value: company,
        Label: '{i18n>Company}',
    },],
    UI.Facets                        : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General Information',
            ID    : 'GeneralInformation',
            Target: '@UI.FieldGroup#GeneralInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Resources',
            ID : 'CBSResourses',
            Target : 'requestCbsResource/@UI.LineItem#CBSResourses',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Need By Priority',
            ID : 'NeedByPriority',
            Target : '@UI.FieldGroup#NeedByPriority',
        },
       
    ],
    UI.FieldGroup #GeneralInformation: {
        $Type: 'UI.FieldGroupType',
        Data : [
                // COMMON FIELDS (NO CONDITION)

                {
                    $Type : 'UI.DataField',
                    Value : requestType_code,
                    Label : 'Request Type',
                },
                {
                    $Type : 'UI.DataField',
                    Value : name,
                    Label : 'Name',
                },
                {
                    $Type: 'UI.DataField',
                    Value: company,
                    Label: 'Company',
                },
                {
                    $Type: 'UI.DataField',
                    Value: project_ID,
                    Label: 'Project',
                },
                {
                    $Type : 'UI.DataField',
                    Value : approvedBy,
                    Label : 'Approved By',
                },


                {
                    $Type : 'UI.DataField',
                    Value : notes,
                    Label : 'Notes',
                },
                
                {
                    $Type : 'UI.DataField',
                    Value : raisedBy,
                    Label : 'Raised By',
                },
                {
                    $Type : 'UI.DataField',
                    Value : requestId,
                    Label : 'Request Id',
                },

                // MATERIAL REQUEST (MT)
                {
                    $Type : 'UI.DataField',
                    Value : workFront,
                    Label : 'Work Front',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'MT'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : needBy,
                    Label : 'Need By',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'MT'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                // {
                //     $Type : 'UI.DataField',
                //     Value : needByFrom,
                //     Label : 'Need By From',
                //     ![@UI.Hidden] : {
                //         $edmJson : {
                //             $If : [
                //                 {
                //                     $Ne : [
                //                         { $Path : 'requestType_code' },
                //                         'MT'
                //                     ]
                //                 },
                //                 true,
                //                 false
                //             ]
                //         }
                //     }
                // },
                // {
                //     $Type : 'UI.DataField',
                //     Value : needByTo,
                //     Label : 'Need By To',
                //     ![@UI.Hidden] : {
                //         $edmJson : {
                //             $If : [
                //                 {
                //                     $Ne : [
                //                         { $Path : 'requestType_code' },
                //                         'MT'
                //                     ]
                //                 },
                //                 true,
                //                 false
                //             ]
                //         }
                //     }
                // },
                {
                    $Type : 'UI.DataField',
                    Value : storageLocation,
                    Label : 'Storage Location',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'MT'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : storageType,
                    Label : 'Storage Type',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'MT'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                
                {
                    $Type : 'UI.DataField',
                    Value : lineCount,
                    Label : 'Line Count',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'MT'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : materialCount,
                    Label : 'Material Count',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'MT'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
            

                // EQUIPMENT REQUEST (EQ)

                {
                    $Type : 'UI.DataField',
                    Value : mobWindowFrom,
                    Label : 'Mob Window From',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'EQ'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : mobWindowTo,
                    Label : 'Mob Window To',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'EQ'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : demobRemarks,
                    Label : 'Demob Remarks',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'EQ'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : demobWindowFrom,
                    Label : 'Demob Window',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'EQ'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                
                {
                    $Type : 'UI.DataField',
                    Value : defaultShiftPattern,
                    Label : 'Default Shift Pattern',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'EQ'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : custodian,
                    Label : 'Custodian',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'EQ'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : equipmentLineCount,
                    Label : 'Equipment Line Count',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'EQ'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : equipmentInstanceCount,
                    Label : 'Equipment Instance Count',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'EQ'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : equipmentWbsCount,
                    Label : 'Equipment WBS Count',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'EQ'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },

                // MANPOWER REQUEST (MP)

                {
                    $Type : 'UI.DataField',
                    Value : startWindowFrom,
                    Label : 'Start Window',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'MP'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
               
                {
                    $Type : 'UI.DataField',
                    Value : endWindowFrom,
                    Label : 'End Window',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'MP'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                
                {
                    $Type : 'UI.DataField',
                    Value : reportingTo,
                    Label : 'Reporting To',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'MP'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : manpowerShiftPattern,
                    Label : 'Manpower Shift Pattern',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'MP'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : manpowerLineCount,
                    Label : 'Manpower Line Count',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'MP'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : manpowerHeadCount,
                    Label : 'Manpower Head Count',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'MP'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : manpowerCrewCount,
                    Label : 'Manpower Crew Count',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'MP'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : manpowerWbsCount,
                    Label : 'Manpower WBS Count',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'MP'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },

                // SUBCONTRACTOR REQUEST (SC)

                {
                    $Type : 'UI.DataField',
                    Value : tradePackage,
                    Label : 'Trade Package',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'SC'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : wbsCode,
                    Label : 'WBS Code',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'SC'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : cbsCode,
                    Label : 'CBS Code',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'SC'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : periodFrom,
                    Label : 'Period From',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'SC'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : periodTo,
                    Label : 'Period To',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'SC'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : indicativeValue,
                    Label : 'Indicative Value',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'SC'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : currency,
                    Label : 'Currency',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'SC'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : contractsOwner,
                    Label : 'Contracts Owner',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'SC'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : routing,
                    Label : 'Routing',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'SC'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },
                {
                    $Type : 'UI.DataField',
                    Value : sapServicePrTarget,
                    Label : 'SAP Service PR Target',
                    ![@UI.Hidden] : {
                        $edmJson : {
                            $If : [
                                {
                                    $Ne : [
                                        { $Path : 'requestType_code' },
                                        'SC'
                                    ]
                                },
                                true,
                                false
                            ]
                        }
                    }
                },

        ],
    },
    UI.HeaderInfo : {
        TypeName : '{i18n>ResourceRequest}',
        TypeNamePlural : '',
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
    },
    UI.SelectionFields : [
        name,
        company,
    ],
    UI.FieldGroup #NeedByPriority : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : needBy,
                Label : 'Need By',
            },
            {
                $Type : 'UI.DataField',
                Value : uom,
                Label : 'Uom',
            },
            {
                $Type : 'UI.DataField',
                Value : priority_code,
                Label : 'Priority',
            },
            {
                $Type : 'UI.DataField',
                Value : storageLocation,
                Label : 'Storage Location',
            },
            {
                $Type : 'UI.DataField',
                Value : notes,
                Label : 'Notes',
            },
        ],
    },
);

annotate service.ResourceRequests with {
    company @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Requestcompany',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: company,
                ValueListProperty: 'CompanyCode',
            }, ],
        },
        Common.ValueListWithFixedValues: true,
        Common.Label : 'Company',
    )
};



annotate service.Requestcompany with {
    CompanyCode @(
        Common.Text                    : CompanyCodeName,
        Common.Text.@UI.TextArrangement: #TextFirst,
    )
};



annotate service.ResourceRequests with {
    project @(

        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Projects',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: project_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'projectDescription',
                },
                {
                    $Type            : 'Common.ValueListParameterIn',
                    ValueListProperty: 'companyCode',
                    LocalDataProperty: company,
                },
            ],
        },
        Common.ValueListWithFixedValues: false,
        Common.Text                    : project.projectDescription,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate service.Projects with {
    ID @(
        Common.Text                    : projectDescription,
        Common.Text.@UI.TextArrangement: #TextOnly,
    );
};
annotate service.ResourceRequests with {
    boq @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'BillofQuantityHeader',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : boq_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterIn',
                    ValueListProperty : 'project_ID',
                    LocalDataProperty : project_ID,
                },
            ],
        },
        Common.ValueListWithFixedValues : false,
        Common.Text : boq.vrNo,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate service.BillofQuantityHeader with {
    ID @(
        Common.Text : vrNo,
        Common.Text.@UI.TextArrangement : #TextOnly,
    )
};

annotate service.RequestBoqItems with @(
    UI.LineItem #BOQItems : [
        {
            $Type : 'UI.DataField',
            Value : item,
            Label : 'Item',
        },
         {
            $Type : 'UI.DataField',
            Value : description,
            Label : 'Description',
        },
        {
            $Type : 'UI.DataField',
            Value : unitOfMeasurement,
            Label : 'UOM',
        },
        {
            $Type : 'UI.DataField',
            Value : quantity,
            Label : 'Available Quantity',
        },
    ],
    UI.CreateHidden :true,
);



annotate service.RequestCbs with @(
    UI.LineItem #CBS : [
        {
            $Type : 'UI.DataField',
            Value : code,
            Label : 'Code',
        },
        {
            $Type : 'UI.DataField',
            Value : name,
            Label : 'Name',
        },
    ],
    UI.CreateHidden :true

);

annotate service.RequestCbsResource with @(
    UI.LineItem #CBSResourses : [
        {
            $Type : 'UI.DataField',
            Value : code,
            Label : 'Code',
        },
        {
            $Type : 'UI.DataField',
            Value : name,
            Label : 'Name',
        },
        {
            $Type : 'UI.DataField',
            Value : descr,
            Label : 'Description',
        },
        {
            $Type : 'UI.DataField',
            Value : availableQuantity,
            Label : 'Available Quantity',
        },
        {
            $Type : 'UI.DataField',
            Value : requestedQuantity,
            Label : 'Requested Quantity',
        },
    ],
    UI.CreateHidden :true
);

annotate service.ResourceRequests with {
    name @Common.Label : 'Name'
};

annotate service.ResourceRequests with {
    priority @Common.ValueListWithFixedValues : true
};

annotate service.PriorityType with {
    code @(
        Common.Text : name,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate service.ResourceRequests with {
    requestType @(
        Common.Text : requestType.name,
        Common.ValueListWithFixedValues : false,
    )
};

annotate service.RequestType with {
    code @(
        Common.Text : name,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

