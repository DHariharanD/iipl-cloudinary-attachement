using {ec.fuelmanagement as vm} from '../db/vehiclemanagement/fuel-management';
using {ec.assets as asset} from '../db/assets/assets';
service FuelManagementService {
    entity fuelRequest as projection on vm.FuelRequest;
    entity fuelIndent as projection on vm.FuelIndent;
    @cds.redirection.target
    entity assets as projection on asset.Assets;

    entity assetsVH as select from asset.Assets {
        ID,assetCtegory,code,
        assetType,assetInfo.SerialNo,assetInfo.Chassis,assetInfo.EngineNo,assetInfo.Year,assetInfo.Capacity,
        assetInfo.ExpectedMilage,assetInfo.RegNo,assetInfo.Mileage,assetInfo.fuelRequired
    }
    where assetType.code in ('MC','VH');
}
annotate FuelManagementService.fuelRequest with @odata.draft.enabled;