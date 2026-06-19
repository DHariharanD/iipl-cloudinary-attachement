using DocumentService as service from '../../srv/document-def-service';
annotate service.DocumentDefs with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Document Code',
                Value : documentCode,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Name',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Description',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Validity Required',
                Value : validityRequired,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Is Mandatory',
                Value : isMandatory,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Attachment Type',
                Value : attachmentType_code,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Is Attachment Mandatory',
                Value : isAttachmentMandatory,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>DocumentCode}',
            Value : documentCode,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Name',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : description,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Validity Required',
            Value : validityRequired,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Is Mandatory',
            Value : isMandatory,
        },
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
        TypeName : '',
        TypeNamePlural : '',
    },
);

