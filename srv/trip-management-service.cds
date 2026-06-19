using {ec.tripmanagement as tm} from '../db/vehiclemanagement/trip-management';
using {ec.assets as assets}  from '../db/assets/assets';
service TripManagementService {
    entity Trips              as projection on tm.Trips;
    entity VehicleInformation as projection on tm.VehicleInformation;
    entity Route              as projection on tm.Route;
    entity FuelExp            as projection on tm.FuelExp;
    entity AdditionalInfo     as projection on tm.AdditionalInfo;
    entity TripAttachments    as projection on tm.TripAttachments;
    entity Assets as projection on assets.Assets;
}

annotate TripManagementService.Trips with @odata.draft.enabled;