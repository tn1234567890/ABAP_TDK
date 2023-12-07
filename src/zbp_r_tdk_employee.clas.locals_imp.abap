CLASS lhc_Employee DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Employee RESULT result.
    METHODS get_instance_authorizations_1 FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Request RESULT result.
    METHODS approverequest FOR MODIFY
      IMPORTING keys FOR ACTION request~ApproveRequest RESULT result.
    METHODS declinerequest FOR MODIFY
      IMPORTING keys FOR ACTION request~DeclineRequest RESULT result.
    METHODS determinestatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR request~DetermineStatus.
    METHODS determinestatusreqcomment FOR DETERMINE ON MODIFY
      IMPORTING keys FOR request~DetermineStatusReqComment.
    METHODS determinevacdays FOR DETERMINE ON MODIFY
      IMPORTING keys FOR request~DetermineVacDays.
    METHODS validatedates FOR VALIDATE ON SAVE
      IMPORTING keys FOR request~ValidateDates.
ENDCLASS.
CLASS lhc_Employee IMPLEMENTATION.

  METHOD approverequest.
    DATA message TYPE REF TO zcm_tdk_employee.

    " Read Travels
    READ ENTITY IN LOCAL MODE zr_tdk_vac_req
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(requests).

    " Process Travels
    LOOP AT requests REFERENCE INTO DATA(request).

      " Validate Status and Create Error Message
      IF request->Status = 'G'.
        message = NEW zcm_tdk_employee(
        textid = zcm_tdk_employee=>request_already_approved
        req_comment = request->ReqComment ) .
        APPEND VALUE #( %tky = request->%tky
        %element = VALUE #( Status = if_abap_behv=>mk-on )
        %msg = message ) TO reported-request.
        APPEND VALUE #( %tky = request->%tky ) TO failed-request.
        DELETE requests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      IF request->Status = 'A'.
        message = NEW zcm_tdk_employee(
        severity = if_abap_behv_message=>severity-error
          textid = zcm_tdk_employee=>request_already_declined
          req_comment = request->ReqComment ) .
        APPEND VALUE #( %tky = request->%tky
        %element = VALUE #( Status = if_abap_behv=>mk-on )
        %msg = message ) TO reported-request.
        APPEND VALUE #( %tky = request->%tky ) TO failed-request.
        DELETE requests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      " Set Status to Approved and Create Success Message
      request->Status = 'G'.
      message = NEW zcm_tdk_employee( severity = if_abap_behv_message=>severity-success
      textid = zcm_tdk_employee=>request_successfully_approved
      req_comment = request->ReqComment ).
      APPEND VALUE #( %tky = request->%tky
      %element = VALUE #( Status = if_abap_behv=>mk-on )
      %msg = message ) TO reported-request.
    ENDLOOP.

    " Modify Requests
    MODIFY ENTITY IN LOCAL MODE zr_tdk_vac_req
    UPDATE FIELDS ( Status )
    WITH VALUE #( FOR r IN requests
    ( %tky = r-%tky Status = r-Status ) ).
    " Set Result
    result = VALUE #( FOR r IN requests
    ( %tky = r-%tky
    %param = r ) ).
  ENDMETHOD.


  METHOD declinerequest.
    DATA message TYPE REF TO zcm_tdk_employee.

    " Read Travels
    READ ENTITY IN LOCAL MODE zr_tdk_vac_req
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(requests).

    " Process Travels
    LOOP AT requests REFERENCE INTO DATA(request).

      " Validate Status and Create Error Message
      IF request->Status = 'A'.
        message = NEW zcm_tdk_employee( textid =
        zcm_tdk_employee=>request_already_declined
        req_comment = request->ReqComment ).
        APPEND VALUE #( %tky = request->%tky
        %element = VALUE #( Status = if_abap_behv=>mk-on )
        %msg = message ) TO reported-request.
        APPEND VALUE #( %tky = request->%tky ) TO failed-request.
        DELETE requests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      IF request->Status = 'G'.
        message = NEW zcm_tdk_employee(
        severity = if_abap_behv_message=>severity-error
          textid = zcm_tdk_employee=>request_already_approved
          req_comment = request->ReqComment ) .
        APPEND VALUE #( %tky = request->%tky
        %element = VALUE #( Status = if_abap_behv=>mk-on )
        %msg = message ) TO reported-request.
        APPEND VALUE #( %tky = request->%tky ) TO failed-request.
        DELETE requests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      " Set Status to Approved and Create Success Message
      request->Status = 'A'.
      message = NEW zcm_tdk_employee( severity = if_abap_behv_message=>severity-success
      textid = zcm_tdk_employee=>request_successfully_declined
      req_comment = request->ReqComment ).
      APPEND VALUE #( %tky = request->%tky
      %element = VALUE #( Status = if_abap_behv=>mk-on )
      %msg = message ) TO reported-request.
    ENDLOOP.

    " Modify Travels
    MODIFY ENTITY IN LOCAL MODE zr_tdk_vac_req
    UPDATE FIELDS ( Status )
    WITH VALUE #( FOR r IN requests
    ( %tky = r-%tky Status = r-Status ) ).

    " Set Result
    result = VALUE #( FOR r IN requests
    ( %tky = r-%tky
    %param = r ) ).
  ENDMETHOD.


  METHOD determinestatus.
    "Read Requests
    READ ENTITY IN LOCAL MODE zr_tdk_vac_req
    FIELDS ( Status )
    WITH CORRESPONDING #( keys )
    RESULT DATA(requests).

    "Modify Requests
    MODIFY ENTITY IN LOCAL MODE zr_tdk_vac_req
    UPDATE FIELDS ( Status )
    WITH VALUE #( FOR r IN requests
    ( %tky = r-%tky
    Status = 'B' ) ).
  ENDMETHOD.


  METHOD determinestatusreqcomment.
    "Read Requests
    READ ENTITY IN LOCAL MODE zr_tdk_vac_req
    FIELDS ( Status )
    WITH CORRESPONDING #( keys )
    RESULT DATA(requests).
    "Modify Requests
    MODIFY ENTITY IN LOCAL MODE zr_tdk_vac_req
    UPDATE FIELDS ( Status )
    WITH VALUE #( FOR r IN requests
    ( %tky = r-%tky
    Status = 'B' ) ).
  ENDMETHOD.

  METHOD determinevacdays.

    "Read Requests
    READ ENTITY IN LOCAL MODE zr_tdk_vac_req
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(requests).

    LOOP AT requests INTO DATA(request).

      "Calculation of Vacation Days
      TRY.
          DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
        CATCH cx_fhc_runtime.
          RETURN.
      ENDTRY.

      TRY.
          DATA(working_days) = calendar->calc_workingdays_between_dates( iv_start = request-StartDate iv_end = request-EndDate ).
        CATCH cx_fhc_runtime.
          RETURN.
      ENDTRY.

      "Modify Requests
      MODIFY ENTITY IN LOCAL MODE zr_tdk_vac_req
      UPDATE FIELDS ( VacDays )
      WITH VALUE #( FOR r IN requests
      ( %tky = r-%tky
      VacDays = working_days + 1 ) ).

    ENDLOOP.

  ENDMETHOD.

  METHOD validatedates.
    DATA message TYPE REF TO zcm_tdk_employee.

    "Read Requests
    READ ENTITY IN LOCAL MODE zr_tdk_vac_req
    FIELDS ( Startdate EndDate )
    WITH CORRESPONDING #( keys )
    RESULT DATA(requests).

    "Process Requests
    LOOP AT requests INTO DATA(request).

      "Validate Dates and Create Error Message
      IF request-EndDate < request-StartDate.
        message = NEW zcm_tdk_employee( textid = zcm_tdk_employee=>invalid_dates ).
        APPEND VALUE #( %tky = request-%tky
        %msg = message ) TO reported-request.
        APPEND VALUE #( %tky = request-%tky ) TO failed-request.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_instance_authorizations.
  ENDMETHOD.
  METHOD get_instance_authorizations_1.
  ENDMETHOD.
ENDCLASS.
