CLASS z2ui5_cl_demo_app_125 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA title  TYPE string.
    DATA favicon  TYPE string.


  PROTECTED SECTION.
    DATA client TYPE REF TO z2ui5_if_client.
    METHODS display_view.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_125 IMPLEMENTATION.


  METHOD display_view.

    DATA(view) = z2ui5_cl_xml_view=>factory( ).

    DATA(tmp) = view->_z2ui5( )->title( client->_bind_edit( title )
         )->shell(
         )->page(
                 title          = 'abap2UI5 - Change Browser Title'
                 navbuttonpress = client->_event( val = 'BACK' )
                 shownavbutton  = xsdbool( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL )
             )->simple_form( title    = 'Form Title'
                             editable = abap_true
                 )->content( 'form'
                     )->title( 'Input'
                     )->label( 'title'
                     )->input( client->_bind_edit( title ) ).

    client->view_display( tmp->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF client->check_on_init( ).
      title = `my title`.

      display_view( ).

    ENDIF.

    CASE client->get( )-event.

      WHEN 'SET_VIEW'.
        display_view( ).
        client->message_toast_display( |{ title } - title changed| ).

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).

    ENDCASE.

  ENDMETHOD.
ENDCLASS.
