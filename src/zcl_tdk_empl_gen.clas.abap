CLASS zcl_tdk_empl_gen DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tdk_empl_gen IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "Hilfsvariablen für einzelne Namen angeben

    DATA employees TYPE TABLE OF ztdk_employee.
    DATA employee TYPE ztdk_employee.
    DATA requests TYPE TABLE OF ztdk_vac_req.
    DATA request TYPE ztdk_vac_req.
    DATA demands TYPE TABLE OF ztdk_vac_dem.
    DATA demand TYPE ztdk_vac_dem.

    "DBT löschen
    DELETE FROM ztdk_employee.
    DELETE FROM ztdk_vac_req.
    DELETE FROM ztdk_vac_dem.

    "DBT Draft löschen
    "    DELETE FROM ztdk_employe_d.
    "    DELETE FROM ztdk_vac_req_d.
    "    DELETE FROM ztdk_vac_dem_d.

    "Admin Data für Employees
    employee-client = sy-mandt.
    employee-created_by = 'GENERATOR'.
    employee-last_changed_by = 'GENERATOR'.
    GET TIME STAMP FIELD employee-created_at.
    GET TIME STAMP FIELD employee-last_changed_at.

    "Admin Data für Requests
    request-client = sy-mandt.
    request-created_by = 'GENERATOR'.
    request-last_changed_by = 'GENERATOR'.
    GET TIME STAMP FIELD request-created_at.
    GET TIME STAMP FIELD request-last_changed_at.

    "Admin Data für Demands
    demand-client = sy-mandt.
    demand-created_by = 'GENERATOR'.
    demand-last_changed_by = 'GENERATOR'.
    GET TIME STAMP FIELD demand-created_at.
    GET TIME STAMP FIELD demand-last_changed_at.

    "Temp-Variable
    DATA hans TYPE String.
    DATA lisa TYPE String.
    DATA petra TYPE String.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Create Employee: Hans Maier(1)
    employee-employee_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    hans = employee-employee_uuid.
    employee-employee_nr = '000001'.
    employee-first_name = 'Hans'.
    employee-last_name = 'Maier'.
    employee-entry_date = '20000501'.
    APPEND employee TO employees.

    "Create Employee: Lisa Müller(2)
    employee-employee_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    lisa = employee-employee_uuid.
    employee-employee_nr = '000002'.
    employee-first_name = 'Lisa'.
    employee-last_name = 'Müller'.
    employee-entry_date = '20100701'.
    APPEND employee TO employees.

    "Create Employee: Petra Schmid(3)
    employee-employee_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    petra = employee-employee_uuid.
    employee-employee_nr = '000003'.
    employee-first_name = 'Petra'.
    employee-last_name = 'Schmid'.
    employee-entry_date = '20221001'.
    APPEND employee TO employees.

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Vacation Requests for Hans
    request-request_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    request-employee_uuid = hans.
    request-approver = lisa.
    request-start_date = '20220701'.
    request-end_date = '20220710'.
    request-req_comment = 'Sommerurlaub'.
    request-status = 'G'.
    APPEND request TO requests.

    request-request_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    request-employee_uuid = hans.
    request-approver = lisa.
    request-start_date = '20221227'.
    request-end_date = '20221230'.
    request-req_comment = 'Weihnachtsurlaub'.
    request-status = 'A'.
    APPEND request TO requests.

    request-request_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    request-employee_uuid = hans.
    request-approver = lisa.
    request-start_date = '20221228'.
    request-end_date = '20221230'.
    request-req_comment = 'Weihnachtsurlaub (2.Versuch)'.
    request-status = 'G'.
    APPEND request TO requests.

    request-request_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    request-employee_uuid = hans.
    request-approver = lisa.
    request-start_date = '20230527'.
    request-end_date = '20230614'.
    request-req_comment = ''.
    request-status = 'G'.
    APPEND request TO requests.

    request-request_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    request-employee_uuid = hans.
    request-approver = lisa.
    request-start_date = '20231220'.
    request-end_date = '20231231'.
    request-req_comment = 'Winterurlaub'.
    request-status = 'B'.
    APPEND request TO requests.

    "Vacation Demands for Hans
    demand-employee_uuid = hans.
    demand-dem_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    demand-curr_year = '2022'.
    demand-vac_days = '30'.
    APPEND demand TO demands.

    demand-employee_uuid = hans.
    demand-dem_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    demand-curr_year = '2023'.
    demand-vac_days = '30'.
    APPEND demand TO demands.

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Vacation Demand for Lisa
    demand-employee_uuid = lisa.
    demand-dem_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    demand-curr_year = '2023'.
    demand-vac_days = '30'.
    APPEND demand TO demands.

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Vacation Request for Petra
    request-approver = hans.
    request-start_date = '20231227'.
    request-end_date = '20231231'.
    request-request_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    request-employee_uuid = petra.
    request-req_comment = 'Weihnachtsurlaub'.
    request-status = 'B'.
    APPEND request TO requests.

    "Vacation Demand for Petra
    demand-employee_uuid = petra.
    demand-dem_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    demand-curr_year = '2023'.
    demand-vac_days = '7'.
    APPEND demand TO demands.

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    INSERT ztdk_employee FROM TABLE @employees.
    INSERT ztdk_vac_req FROM TABLE @requests.
    INSERT ztdk_vac_dem FROM TABLE @demands.

  ENDMETHOD.
ENDCLASS.
