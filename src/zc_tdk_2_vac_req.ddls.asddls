@EndUserText.label: '2 Vacation Request'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity ZC_TDK_2_Vac_Req as projection on ZR_TDK_Vac_Req
{
    key RequestUuid,
    @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_TDK_EmployeeVH', element: 'EmployeeUuid' } }]
    EmployeeUuid,
    Approver,
    StartDate,
    EndDate,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    ReqComment,
    @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_TDK_StatusVH', element: 'StatusText' } }]
    Status,
    
    /* Administrative Data*/
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    
    /* Transient Data */
    StatusCriticality,
    StatusName,
    EmployeeName,
    
    /* Associations */
    _Employee : redirected to parent ZC_TDK_2_Employee
}
