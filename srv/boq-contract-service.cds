using { ec.assetinfo as db } from '../db/billofquantities/boqcontract';

service BOQContractService {

    @odata.draft.enabled
    entity BOQContract    as projection on db.BOQContract;

    entity ContractItems  as projection on db.ContractItems;

    entity ContractTypes  as projection on db.ContractType;
}
