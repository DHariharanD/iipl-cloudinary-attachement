using {
    cuid,
    managed
} from '@sap/cds/common';

namespace ec.masters;

entity AssetCategory : cuid, managed {
    key ID         : UUID @Core.Computed;
        assets      : String(40);
        grouplevel : String(1111);
        groups     : Composition of many AssetGroup on groups.assethierarchy = $self;
}

entity AssetGroup : cuid, managed {

    key ID                     : UUID;
        assethierarchy         : Association to AssetCategory;
        parent                 : Association to AssetGroup;
        assetName              : String(40);
        groupName              : String(40);

        @Core.Computed: true
        LimitedDescendantCount : Integer64;

        @Core.Computed: true
        DistanceFromRoot       : Integer64;

        @Core.Computed: true
        DrillState             : String;

        @Core.Computed: true
        Matched                : Boolean;

        @Core.Computed: true
        MatchedDescendantCount : Integer64;
}
