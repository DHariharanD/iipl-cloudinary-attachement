namespace my.assettimesheetdaily;


using {
    cuid,
    managed
} from '@sap/cds/common';
using {ec.masters as ep} from '../projects/enterprise-project';
using { ec.masters as ed } from '../employeedetails/employee-details';



entity TimeSheetHeader : cuid, managed {
    companyCode     : String(4) @mandatory;
    project         : Association to ep.Projects @mandatory;

    timeSheets      : Composition of many AssetTimeSheetDaily
                          on timeSheets.header = $self;
}


entity AssetTimeSheetDaily : cuid, managed {
    header               : Association to TimeSheetHeader;

    assetId              : String(20);
    assetName            : String(100);

    employee             : Association to ed.EmployeeDetails;
    employeeName         : String(200);

    fromTime             : DateTime;
    toTime               : DateTime;

    actualHours          : Decimal(10, 2);
    lunchHours           : Decimal(10, 2);
    breakdownHours       : Decimal(10, 2);

    otHours              : Decimal(10, 2);
    hotHours             : Decimal(10, 2);

    empHours             : Decimal(10, 2);
    empOtHours           : Decimal(10, 2);
    empHotHours          : Decimal(10, 2);
    empBonusHours        : Decimal(10, 2);
    idleHours            : Decimal(10, 2);

    assetNormalHours     : Decimal(10, 2);
    assetTotalBillingHrs : Decimal(10, 2);

    unit                 : String(10);
    billingUnit          : String(10);
    costCode             : String(20);
    costCodeName         : String(100);
    wbs                  : String(100);

    meterStart           : Decimal(15, 2);
    meterEnd             : Decimal(15, 2);

    prodCode             : String(20);
    prodName             : String(100);
    prodUnit             : String(10);

    outputQty            : Decimal(15, 2);
    refNo                : String(30);

    aHrs                 : Decimal(10, 2);
    bHrs                 : Decimal(10, 2);
    lHrs                 : Decimal(10, 2);
    sHrs                 : Decimal(10, 2);

    ot1Hrs               : Decimal(10, 2);
    ot2Hrs               : Decimal(10, 2);

    s1Hrs                : Decimal(10, 2);
    s2Hrs                : Decimal(10, 2);
    s3Hrs                : Decimal(10, 2);

    isQtyEdited          : Boolean;
}
