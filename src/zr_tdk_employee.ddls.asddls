@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee'
define root view entity ZR_TDK_Employee as select from ztdk_employee
composition [0..*] of ZR_TDK_Vac_Req as _Requests
composition [0..*] of ZR_TDK_Vac_Dem as _Demands
association [1..1] to ZI_TDK_EmployeeText as _EmployeeText on $projection.EmployeeUuid = _EmployeeText.EmployeeUuid
{   
    @ObjectModel.text.element: [ 'EmployeeName' ]
    key employee_uuid as EmployeeUuid,
    employee_nr as EmployeeNr,
    first_name as FirstName,
    last_name as LastName,
    entry_date as EntryDate,
    
     /*Administrative Data */
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    created_at as CreatedAt,
    @Semantics.user.lastChangedBy: true
    last_changed_by as LastChangedBy,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at as LastChangedAt,
    
    /* Transient Data */
    _EmployeeText.Name as EmployeeName,
    
    /*Association */
    _Requests,
    _Demands // Make association public
}
