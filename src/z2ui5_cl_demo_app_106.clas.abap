CLASS z2ui5_cl_demo_app_106 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES z2ui5_if_app .

    DATA check_initialized TYPE abap_bool .
    DATA mv_value TYPE string .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_106 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    IF client->check_on_init( ).

      DATA(view) = z2ui5_cl_xml_view=>factory( ).

      DATA(lo_p) = view->shell(
                  )->page(
                          title          = 'abap2UI5 - Rich Text Editor'
                          navbuttonpress = client->_event( val = 'BACK' )
                          shownavbutton  = xsdbool( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ) ).


      lo_p->rich_text_editor( width            = `100%`
                               height          = `400px`
                               value           = client->_bind_edit( mv_value )
                               customtoolbar   = abap_true
                               showgroupfont   = abap_true
                               showgrouplink   = abap_true
                               showgroupinsert = abap_true
                               wrapping        = abap_false ).

      lo_p->footer(
            )->overflow_toolbar(
                )->button(
                    text  = 'Send To Server'
                    type  = 'Emphasized'
                    icon  = 'sap-icon://paper-plane'
                    press = client->_event( 'SERVER' ) ).

      client->view_display( view->stringify( ) ).

    ENDIF.

    CASE client->get( )-event.

      WHEN 'SERVER'.
        client->message_box_display( mv_value ).

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).

    ENDCASE.

  ENDMETHOD.
ENDCLASS.
