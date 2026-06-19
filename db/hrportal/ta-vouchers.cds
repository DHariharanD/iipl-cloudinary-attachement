using {CommonService as cm } from '../../srv/common-service';
using {ec.masters as pa} from '../projects/enterprise-project';
using {ec.masters as bo} from '../billofquantities/bill-of-quantity';
using {ec.masters as cbs} from '../cbs/cbs';
namespace ec.tavouchers;

using {
    cuid,
    managed
} from '@sap/cds/common';

entity vouchers : cuid, managed {
    company          : Association to cm.Companies @mandatory;
    project     : Association to pa.Projects @mandatory;
    boq         : Association to bo.BillofQuantityHeader;
    vrNo             : String(20);
    vrDate           : Date;
    location         : String(100);
    supervisor       : String(100);
    cot              : String(10);
    eot              : String(10);
    pot              : String(10);
    details        : Composition of many TADetails
                        on details.parent = $self;
}

entity TADetails : cuid, managed {
    parent        : Association to vouchers;
    srNo             : Integer;
    empCode          : String(20);
    oldCode          : String(20);
    employeeName     : String(100);
    workingAs        : String(100);
    shift            : String(20);
    shiftInTime      : Time;
    inTime           : Time;
    outTime          : Time;
    actualHours      : Decimal(5, 2);
    workHours        : Decimal(5, 2);
    punchOTHours     : Decimal(5, 2);
    stdHours         : Decimal(5, 2);

    wbs              : Association to pa.ProjectPlanning;
    gang             : String(50);
    outputQty        : Decimal(10, 2);
    earnedOT         : Decimal(5, 2);
    cotHours         : Decimal(5, 2);
    holidayHours     : Decimal(5, 2);
    productivityCode : String(50);
    productivityName : String(100);
    unit             : String(20);
    empRate          : Decimal(10, 2);
    rate             : Decimal(10, 2);
    toBeAchieved     : Decimal(10, 2);
    costCode         : Association to cbs.CostBreakdownStructure;
    costCodeName     : String(100);
}