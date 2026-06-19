/* checksum : 1e42564486c18ca56a48034c08fdbb79 */
@cds.external : true
@m.IsDefaultEntityContainer : 'true'
@sap.message.scope.supported : 'true'
@sap.supported.formats : 'atom json xlsx'
service API_COSTCNTRACTIVITYTYPE_CRUD_SRV {
  @cds.external : true
  @cds.persistence.skip : true
  @sap.content.version : '1'
  @sap.label : 'Activity Type'
  entity A_CostCenterActivityType {
    @sap.display.format : 'UpperCase'
    @sap.label : 'Controlling Area'
    key ControllingArea : String(4) not null;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Activity Type'
    key CostCtrActivityType : String(6) not null;
    @sap.display.format : 'Date'
    @sap.label : 'Valid To'
    @sap.quickinfo : 'Valid To Date'
    key ValidityEndDate : Date not null;
    @sap.display.format : 'Date'
    @sap.label : 'Valid From'
    @sap.quickinfo : 'Valid-From Date'
    ValidityStartDate : Date;
    @sap.label : 'Activity Unit'
    @sap.semantics : 'unit-of-measure'
    CostCtrActivityTypeQtyUnit : String(3);
    @sap.display.format : 'UpperCase'
    @sap.label : 'ATyp category'
    @sap.quickinfo : 'Activity Type Category'
    CostCtrActivityTypeCategory : String(1);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Allocation cost elem'
    @sap.quickinfo : 'Allocation Cost Element'
    AllocationCostElement : String(10);
    @sap.label : 'Output Unit'
    @sap.semantics : 'unit-of-measure'
    CostCtrActivityTypeOutpQtyUnit : String(3);
    @sap.display.format : 'Date'
    @sap.label : 'Entered On'
    CreationDate : Date;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Created By'
    @sap.quickinfo : 'Entered By'
    EnteredByUser : String(12);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Origin Group'
    @sap.quickinfo : 'Origin Group as Subdivision of Cost Element'
    CostOriginGroup : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Actl Acty Type Cat.'
    @sap.quickinfo : 'Variant Activity Type Category for Actual Postings'
    ActlPostgCostCenterActyTypeCat : String(1);
    @sap.label : 'Output factor'
    OutputQuantityFactor : Decimal(5, 2);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Lock indicator'
    @sap.quickinfo : 'Lock Indicator'
    ActivityTypeIsBlocked : String(1);
    @sap.label : 'PreDistFixCosts'
    @sap.quickinfo : 'Predistribution of fixed costs for acty type/bus. process'
    FixedCostIsPredistributed : Boolean;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Price indicator'
    @sap.quickinfo : 'Price Indicator: Calculate Allocation Price'
    PriceAllocationMethod : String(3);
    @sap.label : 'Average price'
    @sap.quickinfo : 'Price Calculation with Period-Based Average Prices'
    PeriodPriceIsAverage : Boolean;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Act. price indicator'
    @sap.quickinfo : 'Indicator: Actual Allocation Price'
    ActualPriceAllocationMethod : String(3);
    @sap.label : 'Actual qty set'
    @sap.quickinfo : 'Indicator: Confirm quantity manually in actual'
    ActualQuantityIsSetManually : Boolean;
    @sap.label : 'Plan qty set'
    @sap.quickinfo : 'Indicator: Plan quantity manually set.'
    PlanQuantityIsSetManually : Boolean;
    @sap.display.format : 'UpperCase'
    @sap.label : 'CCtr Categories'
    @sap.quickinfo : 'Valid Cost Center Categories'
    CostCtrActivityTypeValidCat : String(8);
    // to_Text : Association to many A_CostCenterActivityTypeText {  };
  };

  @cds.external : true
  @cds.persistence.skip : true
  @sap.content.version : '1'
  @sap.label : 'Activity Type Text'
  entity A_CostCenterActivityTypeText {
    @sap.display.format : 'Date'
    @sap.label : 'Valid To'
    @sap.quickinfo : 'Valid To Date'
    key ValidityEndDate : Date not null;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Controlling Area'
    key ControllingArea : String(4) not null;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Activity Type'
    key CostCtrActivityType : String(6) not null;
    @sap.label : 'Language Key'
    key Language : String(2) not null;
    @sap.label : 'Cost Center Activity Type Name'
    CostCtrActivityTypeName : String(20);
    @sap.label : 'Cost Center Activity Type Description'
    CostCtrActivityTypeDesc : String(40);
    // to_CostCenterActivityType : Association to A_CostCenterActivityType {  };
  };
};

