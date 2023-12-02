@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Employee'

define view entity ZI_TDK_EmployeeVH as select from zmlb_employee
{
    key employee_uuid as EmployeeUuid,
    first_name as FirstName,
    last_name as LastName,
    entry_date as EntryDate
}
