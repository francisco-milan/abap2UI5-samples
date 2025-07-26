CLASS z2ui5_cl_demo_app_035 DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA mv_type           TYPE string.
    DATA mv_path           TYPE string.
    DATA mv_editor         TYPE string.
    DATA mv_check_editable TYPE abap_bool.


    DATA client            TYPE REF TO z2ui5_if_client.
    DATA lt_types TYPE z2ui5_if_types=>ty_t_name_value.
    METHODS view_display.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.


CLASS z2ui5_cl_demo_app_035 IMPLEMENTATION.
  METHOD view_display.

    DATA(view) = z2ui5_cl_xml_view=>factory( ).

    DATA(page) = view->shell( )->page( title          = 'abap2UI5 - File Editor'
                                       navbuttonpress = client->_event( 'BACK' )
                                       shownavbutton  = xsdbool( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ) ).

    DATA(temp) = page->simple_form( title    = 'File'
                                    editable = abap_true )->content( `form`
         )->label( 'path'
         )->input( client->_bind_edit( mv_path )
         )->label( 'Option' ).

    lt_types = VALUE z2ui5_if_types=>ty_t_name_value( ).
    lt_types = VALUE #( FOR row IN z2ui5_cl_util=>source_get_file_types( )  (
            n = shift_right( shift_left( row ) )
            v = shift_right( shift_left( row ) ) ) ).

    DATA(temp3) = temp->input( value = client->_bind_edit( mv_type )
                   suggestionitems   = client->_bind( lt_types )
                    )->get( ).

    temp3->suggestion_items(
                )->list_item( text           = '{N}'
                              additionaltext = '{V}' ).

    temp->label( '' )->button( text = 'Download'
                    press           = client->_event( 'DB_LOAD' )
                    icon            = 'sap-icon://download-from-cloud' ).

    page->code_editor( type     = client->_bind_edit( mv_type )
                       editable = client->_bind( mv_check_editable )
                       value    = client->_bind( mv_editor ) ).

    page->footer( )->overflow_toolbar(
        )->button( text  = 'Clear'
                   press = client->_event( 'CLEAR' )
                   icon  = 'sap-icon://delete'
        )->toolbar_spacer(
        )->button( text  = 'Edit'
                   press = client->_event( 'EDIT' )
                   icon  = 'sap-icon://edit'
        )->button( text    = 'Upload'
                   press   = client->_event( 'DB_SAVE' )
                   type    = 'Emphasized'
                   icon    = 'sap-icon://upload-to-cloud'
                   enabled = xsdbool( mv_editor IS NOT INITIAL ) ).

    client->view_display( page->stringify( ) ).
  ENDMETHOD.

  METHOD z2ui5_if_app~main.
    me->client = client.

    IF client->check_on_init( ).
      mv_path = '../../demo/text'.
      mv_type = 'plain_text'.
      view_display( ).
    ENDIF.

    CASE client->get( )-event.

      WHEN 'DB_LOAD'.

        mv_editor = COND #(
            WHEN mv_path CS 'abap' THEN lcl_file_api=>read_abap( )
            WHEN mv_path CS 'json' THEN lcl_file_api=>read_json( )
            WHEN mv_path CS 'yaml' THEN lcl_file_api=>read_yaml( )
            WHEN mv_path CS 'text' THEN lcl_file_api=>read_text( )
            WHEN mv_path CS 'js'   THEN lcl_file_api=>read_js( ) ).

        client->message_toast_display( 'Download successfull' ).

        client->view_model_update( ).

      WHEN 'DB_SAVE'.
        client->message_box_display( text = 'Upload successfull. File saved!'
                                     type = 'success' ).
      WHEN 'EDIT'.
        mv_check_editable = xsdbool( mv_check_editable = abap_false ).
        client->view_model_update( ).

      WHEN 'CLEAR'.
        mv_editor = ``.
      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
