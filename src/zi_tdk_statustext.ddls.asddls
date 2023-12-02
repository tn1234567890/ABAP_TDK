@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Status Text'

define view entity ZI_TDK_StatusText as select from ZI_TDK_StatusVH
{
    key domain_name,
    key value_position,
    key language,
    Status,
    StatusText,
    
    concat_with_space(StatusText, Status, 1) as StatusName
}
