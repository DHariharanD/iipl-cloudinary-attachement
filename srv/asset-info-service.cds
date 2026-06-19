using {ec.hiredInfo as ai} from '../db/assets/asset-info';
using {ec.assets as at} from '../db/assets/assets';
using {CommonService as cm} from './common-service';
using {AssetTypeService as ats} from './asset-type-service';

using {ec.vehicleManagement as make} from '../db/vehiclemanagement/asset-make';
using {ec.vehicleManagement as model} from '../db/vehiclemanagement/asset-model';

// service AssetInfoService {
//     entity HiredAssets    as projection on ai.HiredAssets;
//     entity HiredAssetInfo as projection on ai.HiredAssetInfo;
//     entity Custodian      as projection on ai.Custodian;

//     entity Companies           as projection on cm.Companies;
//     entity AssetTypes          as projection on ats.AssetTypes;

//    // entity AssetInfo           as projection on at.AssetInfo;
//     entity BasicAssets as projection on at.Assets;
//     entity AssetMake           as projection on make.AssetMake;
//     entity AssetModel          as projection on model.AssetModel;

// }

// annotate AssetInfoService.HiredAssets with @odata.draft.enabled;
service AssetInfoService {

    entity Assets         as projection on at.Assets;
    entity HiredAssets    as projection on ai.HiredAssets;

    entity AssetStatusMaster as projection on at.AssetStatus;
    entity HiredAssetStatus  as projection on ai.AssetStatus;

    entity AssetCustodian    as projection on at.Custodian;
    entity HiredCustodian    as projection on ai.Custodian;

    entity AssetInfo     as projection on at.AssetInfo;
    entity AssetMake     as projection on make.AssetMake;
    entity AssetModel    as projection on model.AssetModel;

    entity Companies     as projection on cm.Companies;
    entity AssetTypes    as projection on ats.AssetTypes;
}
 annotate AssetInfoService.HiredAssets with @odata.draft.enabled;