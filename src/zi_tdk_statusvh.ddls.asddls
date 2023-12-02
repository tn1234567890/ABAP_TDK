@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Status'

define view entity ZI_TDK_StatusVH as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name:'ZTDK_STATUS' )
{
    @UI.hidden: true
    key domain_name,
    @UI.hidden: true
    key value_position,
    @UI.hidden: true
    key language,
    @EndUserText:{ label: 'Status', quickInfo: 'Status' }
    @UI.lineItem: [{ position: 10 }]
    value_low as Status,
     @EndUserText:{ label: 'Status Text', quickInfo: 'Status Text' }
    text as StatusText
}
where 
    language = $session.system_language
