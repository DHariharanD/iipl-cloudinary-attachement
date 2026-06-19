namespace ec.masters;

using {
    cuid,
    managed
} from '@sap/cds/common';
using {CommonService as cm} from '../../srv/common-service';
using { ec.masters as pa } from '../projects/enterprise-project';
using { ec.masters as bo } from '../billofquantities/bill-of-quantity';

entity AssetRequest : cuid, managed {
    // --- Header ---
   
    company             : Association to cm.Companies   @mandatory;
    boq          : Association to bo.BillofQuantityHeader;
    project      : Association to pa.Projects;
    wbs          : Association to pa.ProjectPlanning;

    reqstatus    : String(40);
    fromlocation : String(40);
    tolocation   : String(200);

    items        : Composition of many RequestAssetItem
                       on items.request = $self;

  
    processRequests : Composition of many ProcessRequest
                          on processRequests.request = $self;
}

entity RequestAssetItem : cuid, managed {
    request    : Association to AssetRequest;

    cbsID      : String(40);
    resourceID : String(40);
    quantity   : Decimal(15, 2);

    fromDate   : Date;
    toDate     : Date;

    note       : String(500);
}


entity ProcessRequest : cuid, managed {
    request      : Association to AssetRequest;

    assetID      : String(40);
    note         : String(500);

    fromLocation : String(100);
    toLocation   : String(100);

    status       : String(40);
}
