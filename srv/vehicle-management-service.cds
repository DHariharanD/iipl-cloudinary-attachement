using {ec.vehicleManagement as vm} from '../db';
using {CommonService as cmm} from './common-service';

service VehicleManagementService {

  entity AssetMake  as projection on vm.AssetMake;

  entity AssetModel as
    projection on vm.AssetModel {
      *,
      company : Association to cmm.Companies
                  on company.CompanyCode = $self.companyCode
    };

  entity company    as projection on cmm.Companies;

}

annotate VehicleManagementService.AssetMake with @odata.draft.enabled;
annotate VehicleManagementService.AssetModel with @odata.draft.enabled;
