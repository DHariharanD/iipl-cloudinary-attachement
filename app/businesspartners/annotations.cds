using BusinessPartnerServices as service from '../../srv/business-partner-service';
annotate service.BusinessPartners with @(
    UI.SelectionFields : [
        BusinessPartner,
        BusinessPartnerFullName,
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : BusinessPartner,
        },
        {
            $Type : 'UI.DataField',
            Value : BusinessPartnerFullName,
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>BasicDetails}',
            ID : 'i18nBasicDetails',
            Target : '@UI.FieldGroup#i18nBasicDetails',
        },
    ],
    UI.FieldGroup #i18nBasicDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : BusinessPartner,
            },
            {
                $Type : 'UI.DataField',
                Value : BusinessPartnerFullName,
            },
            {
                $Type : 'UI.DataField',
                Value : BusinessPartnerType,
                Label : '{i18n>BusinessPartnerType}',
            },
            {
                $Type : 'UI.DataField',
                Value : BusinessPartnerCategory,
                Label : '{i18n>BusinessPartnerCategory}',
            },
        ],
    },
);

annotate service.BusinessPartners with {
    BusinessPartner @Common.Label : '{i18n>BusinessPartner}'
};

annotate service.BusinessPartners with {
    BusinessPartnerFullName @Common.Label : '{i18n>BusinessPartnerName}'
};

