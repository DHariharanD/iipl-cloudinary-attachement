namespace ec.vehicleManagement;

using {
    cuid,
    managed
} from '@sap/cds/common';
using {CommonService as cm} from '../../srv/common-service';

entity AssetMake : cuid, managed {
    assetCode   : String(20);
    assetName   : String(25);
    assetDescr  : String(1111);
    companyCode : String(5);
}
 