using {ec.assets as at} from '../db/assets/assets';
using {CommonService as cm} from './common-service';
using {AssetTypeService as ats} from './asset-type-service';
using {ec.vehicleManagement as make} from '../db/vehiclemanagement/asset-make';
using {ec.vehicleManagement as model} from '../db/vehiclemanagement/asset-model';
using {ec.masters as emp} from '../db/employeedetails/employee-details';
using {S4FixedAsset as CO} from './external/S4FixedAsset';
using {ec.masters as masters} from '../db/designations/designations';

service AssetService @(requires: 'any') {
    @odata.draft.enabled
    entity Asset           as projection on at.Assets;

    entity Companies       as projection on cm.Companies;
    entity AssetStatus     as projection on at.AssetStatus;

    @cds.redirection.target
    entity Custodian       as projection on at.Custodian;

    entity Pricelist       as projection on at.Pricelist;
    entity AssetInfo       as projection on at.AssetInfo;
    entity AssetMake       as projection on make.AssetMake;
    entity AssetModel      as projection on model.AssetModel;
    entity AssetType       as projection on at.AssetType;
    entity fixedassetec    as projection on CO.FixedAsset;

entity EmployeeDetails as
    select from emp.EmployeeDetails as e
    left join masters.Designations as d
        on d.code = e.designation_code
    {
        key e.ID,
        e.firstName,
        e.lastName,
        e.gender,
        e.dateOfBirth,
        e.designation_code,
        d.name                           as designation_name,  
        e.firstName || ' ' || e.lastName as fullName : String
    };
}
