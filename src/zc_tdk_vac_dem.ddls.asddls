@EndUserText.label: 'Vacation Demand'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_TDK_Vac_Dem as projection on ZR_TDK_Vac_Dem
{
    key DemUuid,
    EmployeeUuid,
    CurrYear,
    VacDays,
    
    /*Administrative Data*/
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    
    /* Transient Data */
    EmployeeName,
    
    /* Associations */
    _Employee : redirected to parent ZC_TDK_Employee
}
