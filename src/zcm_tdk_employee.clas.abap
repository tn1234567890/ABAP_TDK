CLASS zcm_tdk_employee DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    CONSTANTS:
      BEGIN OF request_successfully_approved,
        msgid TYPE symsgid VALUE 'ZMLB_EMLOYEE',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'REQ_COMMENT',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF request_successfully_approved.

    CONSTANTS:
      BEGIN OF request_successfully_declined,
        msgid TYPE symsgid VALUE 'ZMLB_EMLOYEE',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'REQ_COMMENT',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF request_successfully_declined.

    CONSTANTS:
      BEGIN OF request_already_approved,
        msgid TYPE symsgid VALUE 'ZMLB_EMLOYEE',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'REQ_COMMENT',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF request_already_approved.

    CONSTANTS:
      BEGIN OF request_already_declined,
        msgid TYPE symsgid VALUE 'ZMLB_EMLOYEE',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE 'REQ_COMMENT',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF request_already_declined.

    CONSTANTS:
      BEGIN OF invalid_dates,
        msgid TYPE symsgid VALUE 'ZMLB_EMLOYEE',
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF invalid_dates.

    "Attributes
    DATA req_comment TYPE zmlb_req_comment.
    METHODS constructor
      IMPORTING
        severity    TYPE if_abap_behv_message=>t_severity DEFAULT
          if_abap_behv_message=>severity-error
        !textid     LIKE if_t100_message=>t100key DEFAULT
          if_t100_message=>default_textid
        !previous   LIKE previous OPTIONAL
        req_comment TYPE zmlb_req_comment OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcm_tdk_employee IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).
    if_t100_message~t100key = textid.
    if_abap_behv_message~m_severity = severity.
    me->req_comment = req_comment.


  ENDMETHOD.
ENDCLASS.
