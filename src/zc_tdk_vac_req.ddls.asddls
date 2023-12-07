@EndUserText.label: 'Vacation Request'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_TDK_Vac_Req as projection on ZR_TDK_Vac_Req
{
    key RequestUuid,
    EmployeeUuid,
    @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_TDK_ApproverVH', element: 'EmployeeUuid' } }]
    Approver,
    StartDate,
    EndDate,
    ReqComment,
    @ObjectModel.text.element: [ 'StatusName' ]
    Status,
    VacDays,
    
    /*Administrative Data*/
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    
    /* Transient Data */
    StatusName,
    EmployeeName,
    ApproverName,
    StatusCriticality,
    
    /* Associations */
    _Employee : redirected to parent ZC_TDK_Employee
}
