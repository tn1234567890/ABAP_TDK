@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Text'

define view entity ZI_TDK_EmployeeText as select from ztdk_employee
{
    key employee_uuid as EmployeeUuid,
    first_name as FirstName,
    last_name as LastName,
    
    concat_with_space(first_name, last_name, 1) as Name
}
