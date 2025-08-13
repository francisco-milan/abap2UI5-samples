CLASS z2ui5_cl_demo_app_350 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.
    DATA check_initialized TYPE abap_bool.
    DATA: view_id TYPE i.
    DATA text TYPE string VALUE 'call booking mask'.
    DATA varkey TYPE char120.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS initialize_view2
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS set_session_stateful
      IMPORTING
        client   TYPE REF TO z2ui5_if_client
        stateful TYPE abap_bool.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_350 IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z2UI5_CL_DEMO_APP_350->Z2UI5_IF_APP~MAIN
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT                         TYPE REF TO Z2UI5_IF_CLIENT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD z2ui5_if_app~main.
    IF view_id IS INITIAL OR view_id = 1.
      view_id = 1.
      TRY.
          IF client->check_on_init( ).
            DATA(view) = z2ui5_cl_xml_view=>factory( ).
            DATA(page) = view->shell( )->page(
              title          = `Startview` ).
            page->simple_form(
                  )->content( 'form'
                               )->button(
                                   text  = client->_bind_edit( text )
                                   width = '20%'
                                   press = client->_event( val = 'CALL_BOOKING_MASK' ) ).
            client->view_display( view->stringify( ) ).
            client->set_app_state_active( ).
            RETURN.
          ENDIF.
          IF client->check_on_navigated( ).
            client->view_model_update( ).
            RETURN.
          ENDIF.
          CASE client->get( )-event.
            WHEN `CALL_BOOKING_MASK`.
              DATA: lf_key TYPE n LENGTH 4.
              DATA(lr_view2) = NEW z2ui5_cl_demo_app_350( ).
              lr_view2->view_id = 2.
              lr_view2->varkey = '001'.
              client->nav_app_call( lr_view2 ).
            WHEN `BACK`.
              client->nav_app_leave( ).
          ENDCASE.
          client->view_model_update( ).
        CATCH cx_root INTO DATA(lx).
          client->message_box_display( lx ).
      ENDTRY.
    ELSEIF view_id = 2.
      TRY.
          IF check_initialized = abap_false.
            check_initialized = abap_true.
            set_session_stateful( client = client stateful = abap_true ).
            DATA(lv_fm) = 'ENQUEUE_E_TABLE'.
            CALL FUNCTION lv_fm
              EXPORTING
                tabname        = 'ZTEST'
                varkey         = varkey
              EXCEPTIONS
                foreign_lock   = 1
                system_failure = 2
                OTHERS         = 3.
            IF sy-subrc <> 0.
              DATA(lo_prev_stack_app) = client->get_app( client->get( )-s_draft-id_prev_app_stack ).
              set_session_stateful( client = client stateful = abap_false ).
              client->nav_app_leave( lo_prev_stack_app ).
            ELSE.
              initialize_view2( client ).
            ENDIF.
            RETURN.
          ENDIF.
          IF client->check_on_navigated( ).
            set_session_stateful( client = client stateful = abap_false ).
            TRY.
                DATA(lo_prev_view) = CAST z2ui5_cl_demo_app_350( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).
                client->nav_app_leave( lo_prev_view ).
                RETURN.
              CATCH cx_sy_move_cast_error ##NO_HANDLER ##CATCH_ALL.
            ENDTRY.
          ENDIF.
          CASE client->get( )-event.
            WHEN `NEXT_LOCK`.
              set_session_stateful( client = client stateful = abap_false ).
              lr_view2 = NEW z2ui5_cl_demo_app_350( ).
              lr_view2->view_id = 2.
              DATA: lf_new_varkey TYPE n LENGTH 4.
              lf_new_varkey = varkey+0(4).
              lf_new_varkey = lf_new_varkey + 1.
              lr_view2->varkey = lf_new_varkey+0(4).
              client->nav_app_call( lr_view2 ).
            WHEN `BACK`.
              lo_prev_stack_app = client->get_app( client->get( )-s_draft-id_prev_app_stack ).
              set_session_stateful( client = client stateful = abap_false ).
              client->nav_app_leave( lo_prev_stack_app ).
          ENDCASE.
          client->view_model_update( ).
        CATCH cx_root INTO lx.
          client->message_box_display( lx->get_text( ) ).
      ENDTRY.
    ENDIF.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method Z2UI5_CL_DEMO_APP_350->INITIALIZE_VIEW2
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT                         TYPE REF TO Z2UI5_IF_CLIENT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD initialize_view2.
    DATA(view) = z2ui5_cl_xml_view=>factory( ).
    DATA(page) = view->shell( )->page(
      title          = `Stateful Application with lock`
      navbuttonpress = client->_event( 'BACK' )
      shownavbutton  = xsdbool( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ) ).
    DATA(vbox) = page->vbox( ).
    DATA(hbox) = vbox->hbox( alignitems = 'Center' ).
    hbox->title(
      text  = 'Current Lock Value in Table ZTEST' ).
    hbox->input(
      editable = abap_false
      value  = client->_bind_edit( varkey ) ).
    hbox->button(
      text = 'Next Lock View'
      press = client->_event( 'NEXT_LOCK' ) ).
    client->view_display( view->stringify( ) ).
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method Z2UI5_CL_DEMO_APP_350->SET_SESSION_STATEFUL
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT                         TYPE REF TO Z2UI5_IF_CLIENT
* | [--->] STATEFUL                       TYPE        ABAP_BOOL
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD set_session_stateful.
    client->set_session_stateful( stateful ).
    client->view_model_update( ).
  ENDMETHOD.
ENDCLASS.