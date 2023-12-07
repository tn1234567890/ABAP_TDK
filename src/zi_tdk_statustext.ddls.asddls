@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Status Text'

define view entity ZI_TDK_StatusText as select from ztdk_vac_req
{
   key request_uuid as RequestUuid,
   status as Status,
   
   
   'Declined' as StatusTextA,
   'Approved' as StatusTextG,
   'Requested' as StatusTextB
   
}
