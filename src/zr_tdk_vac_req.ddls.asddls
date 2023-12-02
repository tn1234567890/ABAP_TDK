@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vacation Request'

define view entity ZR_TDK_Vac_Req as select from ztdk_vac_req
association to parent ZR_TDK_Employee as _Employee on $projection.EmployeeUuid = _Employee.EmployeeUuid
association [1..1] to ZI_TDK_EmployeeText as _EmployeeText on $projection.EmployeeUuid = _EmployeeText.EmployeeUuid
association [1..1] to ZI_TDK_StatusText as _StatusText on $projection.Status = _StatusText.Status

{
    key request_uuid as RequestUuid,
    @ObjectModel.text.element: [ 'EmployeeName' ]
    employee_uuid as EmployeeUuid,
    approver as Approver,
    start_date as StartDate,
    end_date as EndDate,
    req_comment as ReqComment,
    @ObjectModel.text.element: [ 'StatusName' ]
    status as Status,
    
    /* Administrative Data */
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    created_at as CreatedAt,
    @Semantics.user.lastChangedBy: true
    last_changed_by as LastChangedBy,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at as LastChangedAt,
    
    case status when 'A' then 1
                when 'G' then 3
                when 'B' then 0
                else 0
                end as StatusCriticality,
    
    /* Transient Data */
    _StatusText.StatusName as StatusName,
    _EmployeeText.Name as EmployeeName,
    
    /* Associations */
    _Employee
}
