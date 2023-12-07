@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vacation Demand'

define view entity ZR_TDK_Vac_Dem as select from ztdk_vac_dem
association to parent ZR_TDK_Employee as _Employee on $projection.EmployeeUuid = _Employee.EmployeeUuid
association [1..1] to ZI_TDK_EmployeeText as _EmployeeText on $projection.EmployeeUuid = _EmployeeText.EmployeeUuid
{
    key dem_uuid as DemUuid,
    @ObjectModel.text.element: [ 'EmployeeName' ]    
    employee_uuid as EmployeeUuid,
    curr_year as CurrYear,
    vac_days as VacDays,
    
    /* Administrative Data */
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    
    /* Transient Data */
    _EmployeeText.Name as EmployeeName,
    
    /* Associations */
    _Employee
}
