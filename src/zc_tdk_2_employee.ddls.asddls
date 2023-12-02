@EndUserText.label: '2 Employee'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_TDK_2_Employee
  provider contract transactional_query as projection on ZR_TDK_Employee
{
    key EmployeeUuid,
    EmployeeNr,
    FirstName,
    LastName,
    EntryDate,
    
    /* Administrative Data */
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    
    /* Transient Data */
    EmployeeName,
    
    /* Associations */
    _Requests : redirected to composition child ZC_TDK_2_Vac_Req
}
