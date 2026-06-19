namespace ec.vehicleManagement;

using {
    cuid,
    managed
} from '@sap/cds/common';
using {CommonService as cm} from '../../srv/common-service';

entity AssetModel : cuid, managed {
    modelMake    : String(256);
    modelModel   : String(256);
    modelDescr   : String(256);
    companyCode : String(11)  @mandatory;
}
