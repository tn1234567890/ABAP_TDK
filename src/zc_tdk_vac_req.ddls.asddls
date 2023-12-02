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
    @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_TDK_StatusVH', element: 'Status' } }]
    Status,
    
    /*Administrative Data*/
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    
    /* Transient Data */
    StatusName,
    EmployeeName,
    StatusCriticality,
    
    /* Associations */
    _Employee : redirected to parent ZC_TDK_Employee
}
