namespace ec.masters;

using {
    cuid,
    managed
} from '@sap/cds/common';
using {ec.masters as ep} from '../projects/enterprise-project';

entity DailyProductivityVoucher : cuid, managed {
    companyCode  : String(40) @mandatory;
    project      : Association to ep.Projects @mandatory;
    vrNo         : String(40);
    vrDate       : Date;
    status       : String(40) default 'Not sent For Approval';
    location     : String(200);
    voucherItems : Composition of many DailyProductivityVoucherItem
                       on voucherItems.voucher = $self;
}

entity DailyProductivityVoucherItem : cuid {
    voucher          : Association to DailyProductivityVoucher;
    companyCode      : String(40);
    chargehand       : String(40);
    chargehandName   : String(200);
    productivityCode : String(40);
    productivityName : String(200);
    wbs              : String(40);
    unit             : String(20);
    gang             : Integer default 1;
    outputAchieved   : Decimal(15, 2) default 0.00;
    locationCode     : String(40);
    costCode         : String(40);
    costCodeName     : String(200);
}
