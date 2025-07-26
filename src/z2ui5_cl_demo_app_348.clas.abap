CLASS z2ui5_cl_demo_app_348 DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA ms_struc       TYPE z2ui5_t_01.
    DATA mo_layout_obj TYPE REF TO z2ui5_cl_demo_app_333.

    METHODS get_data.

    METHODS ui5_view_display
      IMPORTING
        !client TYPE REF TO z2ui5_if_client.

  PROTECTED SECTION.

  PRIVATE SECTION.
    METHODS xml_form
      IMPORTING
        i_data   type ref to data
        i_page   TYPE REF TO z2ui5_cl_xml_view
        i_client TYPE REF TO z2ui5_if_client.

ENDCLASS.


CLASS z2ui5_cl_demo_app_348 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    IF client->check_on_init( ).

      get_data( ).

      mo_layout_obj = z2ui5_cl_demo_app_333=>factory( i_data   = REF #( ms_struc )
                                                      vis_cols = 5 ).

      ui5_view_display( client ).
    ENDIF.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'GO'.
        DATA(app) = z2ui5_cl_demo_app_336=>factory( ).
        client->nav_app_call( app ).
    ENDCASE.

    IF     client->get( )-check_on_navigated = abap_true
       AND client->check_on_init( )          = abap_false.
      ui5_view_display( client ).
    ENDIF.

    IF mo_layout_obj->mr_data IS NOT BOUND.
      client->message_toast_display( 'ERROR - mo_layout_obj->mr_data is not bound!' ).
    ENDIF.

    IF ms_struc IS INITIAL.
      " TODO: check spelling: inital (typo) -> initial (ABAP cleaner)
      client->message_toast_display( 'ERROR - ms_data is inital!' ).
    ENDIF.

    ASSIGN mo_layout_obj->mr_data->* TO FIELD-SYMBOL(<val>).
    IF <val> <> ms_struc.
      client->message_toast_display( 'ERROR - mo_layout_obj_2->mr_data  <> ms_data!' ).
    ENDIF.

    client->view_model_update( ).

  ENDMETHOD.

  METHOD ui5_view_display.

    DATA(page) = z2ui5_cl_xml_view=>factory( )->shell( )->page( title          = 'RTTI IV'
                                                                navbuttonpress = client->_event( 'BACK' )
                                                                shownavbutton  = client->check_app_prev_stack( ) ).

    page->button( text  = 'CALL Next App'
                  press = client->_event( 'GO' )
                  type  = 'Success' ).

    xml_form( i_data = ref #( ms_struc )
              i_page   = page
              i_client = client ).

    client->view_display( page ).

  ENDMETHOD.

  METHOD get_data.

    SELECT SINGLE id,
                  id_prev,
                  id_prev_app,
                  id_prev_app_stack,
                  timestampl
      FROM z2ui5_t_01
      INTO CORRESPONDING FIELDS OF @ms_struc.

  ENDMETHOD.

  METHOD xml_form.

    DATA(form) = i_page->simple_form( editable        = abap_true
                                      layout          = `ResponsiveGridLayout`
                                      adjustlabelspan = abap_true
                                 )->content( ns = `form` ).

    DATA(index) = 0.

    LOOP AT mo_layout_obj->ms_data-t_layout REFERENCE INTO DATA(layout).

      index = index + 1.

      ASSIGN COMPONENT layout->name OF STRUCTURE i_data->* TO FIELD-SYMBOL(<value>).
      " assign component layout->name of structure ms_struc to field-symbol(<value>).
      IF <value> IS NOT ASSIGNED.
        RETURN.
      ENDIF.

      DATA(line) = form->label( wrapping = abap_false
                                text     = layout->name  ).

      line->input( value   = i_client->_bind( <value> )
                   visible = i_client->_bind( val       = layout->visible
                                              tab       = mo_layout_obj->ms_data-t_layout
                                              tab_index = index )
                   enabled = abap_false ).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
