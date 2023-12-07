@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Test Value Help for Status'

define view entity ZI_TDK_StatusVHTest as select from ZI_TDK_StatusText
{
    key RequestUuid,
    Status
    
}
