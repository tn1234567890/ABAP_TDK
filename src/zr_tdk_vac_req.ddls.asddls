@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vacation Request'

define view entity ZR_TDK_Vac_Req as select from ztdk_vac_req
association to parent ZR_TDK_Employee as _Employee on $projection.EmployeeUuid = _Employee.EmployeeUuid
association [1..1] to ZI_TDK_EmployeeText as _EmployeeText on $projection.EmployeeUuid = _EmployeeText.EmployeeUuid
association [1..1] to ZI_TDK_ApproverText as _ApproverText on $projection.Approver = _ApproverText.EmployeeUuid
association [1..1] to ZI_TDK_StatusText as _StatusText on $projection.RequestUuid = _StatusText.RequestUuid

{
    key request_uuid as RequestUuid,
    @ObjectModel.text.element: [ 'EmployeeName' ]
    employee_uuid as EmployeeUuid,
    @ObjectModel.text.element: [ 'ApproverName' ]
    approver as Approver,
    start_date as StartDate,
    end_date as EndDate,
    req_comment as ReqComment,
    status as Status,
    vac_days as VacDays,
    
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
                
    case status when 'A' then _StatusText.StatusTextA
                when 'B' then _StatusText.StatusTextB
                when 'G' then _StatusText.StatusTextG
                else null
                end as StatusName,
    
    /* Transient Data */
//    _StatusText.StatusText as StatusName,
    
    _EmployeeText.Name as EmployeeName,
    _ApproverText.Name as ApproverName,
    
    /* Associations */
    _Employee
}
