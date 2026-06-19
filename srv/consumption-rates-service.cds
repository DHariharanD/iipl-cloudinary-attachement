using {ec.masters as cr} from '../db/consumptionrates/consumption-rates';
using {ec.masters as cbsRes} from '../db';
using {CommonService as cm} from './common-service';
using {CE_PRODUCT_0002 as prod} from './external/CE_PRODUCT_0002';

service ConsumptionRateService {
    @odata.draft.enabled
    entity ConsumptionRates              as projection on cr.ConsumptionRate;
    entity Companies                     as projection on cm.Companies;
    entity CBS_CostBreakdownStructure    as
        select from cbsRes.CostBreakdownStructure {
            key ID,
                code,
                name,
                descr,
                parent,
                parent.code as parentCode,
                cbshierarchy,
                resourceMaterials : redirected to CBSResourceMaterial
        };
    entity CBSResourceMaterial           as
        select from cbsRes.CBSResourceMaterial {
            key ID,
                productId,
                productName,
                productType,
                unitofMeasure,
                cbsNode
        };
    entity Products                      as projection on prod.Product;
    entity ProductDescriptions           as projection on prod.ProductDescription;
    entity ProductUnitsOfMeasures        as projection on prod.ProductUnitOfMeasure;
    entity ProductValuationLedgerAccount as projection on prod.ProductValuationLedgerAccount;
    entity ProductsVH                    as
        select from prod.Product as P
        left outer join prod.ProductDescription as D
            on  P.Product  = D.Product
            and D.Language = 'EN'
        {
            key P.Product            as Product,
                P.ProductType        as ProductType,
                P.BaseUnit           as BaseUnit,
                D.ProductDescription as ProductDescription
        };

    entity CBS_Materials                 as
        select from cbsRes.CBSResourceMaterial as rm
        inner join cbsRes.CostBreakdownStructure as cbs
            on rm.cbsNode.ID = cbs.ID
        {
            key rm.ID,
                rm.productId,
                rm.productName,
                rm.productType,
                rm.unitofMeasure,
                cbs.name as cbsName
        }
        where
            rm.productType = 'Material';
}
