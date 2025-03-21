CLASS z2ui5_cl_demo_app_152 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA client TYPE REF TO z2ui5_if_client.

    TYPES:
      BEGIN OF ty_row,
        zzselkz TYPE abap_bool,
        title   TYPE string,
        value   TYPE string,
        descr   TYPE string,
      END OF ty_row.
    DATA mt_tab TYPE STANDARD TABLE OF ty_row WITH EMPTY KEY.

    DATA mv_check_initialized TYPE abap_bool.
    DATA mv_multiselect TYPE abap_bool.
    DATA mv_preselect TYPE abap_bool.
    METHODS ui5_display.
    METHODS ui5_event.
    METHODS ui5_callback.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS z2ui5_cl_demo_app_152 IMPLEMENTATION.


  METHOD ui5_event.

    CASE client->get( )-event.

      WHEN 'POPUP'.

        mt_tab = VALUE #( descr = 'this is a description'
             ( zzselkz = mv_preselect title = 'title_01'  value = 'value_01' )
             ( zzselkz = mv_preselect title = 'title_02'  value = 'value_02' )
             ( zzselkz = mv_preselect title = 'title_03'  value = 'value_03' )
             ( zzselkz = mv_preselect title = 'title_04'  value = 'value_04' )
             ( zzselkz = mv_preselect title = 'title_05'  value = 'value_05' ) ).

        DATA(lo_app) = z2ui5_cl_pop_to_select=>factory(
                           i_tab         = mt_tab
                           i_multiselect = mv_multiselect
                           i_title       = COND #(
                                             WHEN mv_multiselect = abap_true
                                             THEN `Multi select`
                                             ELSE `Single select` ) ).
        client->nav_app_call( lo_app ).


      WHEN 'MULTISELECT_TOGGLE'.

        mv_preselect = COND #( WHEN mv_multiselect = abap_false
                               THEN abap_false
                               ELSE mv_preselect ).

        client->view_model_update( ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.


  METHOD ui5_display.

    DATA(view) = z2ui5_cl_xml_view=>factory( ).
    view->shell(
        )->page(
                title          = 'abap2UI5 - Popup To Select'
                navbuttonpress = client->_event( val = 'BACK' )
                shownavbutton  = xsdbool( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL )
           )->hbox(
           )->text( text  = 'Multiselect: '
                    class = 'sapUiTinyMargin'
           )->switch( state  = client->_bind_edit( mv_multiselect )
                      change = client->_event( `MULTISELECT_TOGGLE` )
           )->get_parent(
           )->hbox(
           )->text( text  = 'Preselect all entries: '
                    class = 'sapUiTinyMargin'
           )->switch( state   = client->_bind_edit( mv_preselect )
                      enabled = client->_bind_edit( mv_multiselect )
           )->get_parent(
           )->button(
            text  = 'Open Popup...'
            press = client->_event( 'POPUP' ) ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF client->get( )-check_on_navigated = abap_true.
      IF mv_check_initialized = abap_false.
        mv_check_initialized = abap_true.
        ui5_display( ).
      ELSE.
        ui5_callback( ).
      ENDIF.
      RETURN.
    ENDIF.

    ui5_event( ).

  ENDMETHOD.

  METHOD ui5_callback.
    FIELD-SYMBOLS <row> TYPE ty_row.

    TRY.
        DATA(lo_prev) = client->get_app( client->get( )-s_draft-id_prev_app ).
        DATA(ls_result) = CAST z2ui5_cl_pop_to_select( lo_prev )->result( ).

        IF ls_result-check_confirmed = abap_false.
          client->message_box_display( `Popup was cancelled` ).
          RETURN.
        ENDIF.

        IF mv_multiselect = abap_false.


          ASSIGN ls_result-row->* TO <row>.
          client->message_box_display( `callback after popup to select: ` && <row>-title ).

        ELSE.

          ASSIGN ls_result-table->* TO FIELD-SYMBOL(<table>).
          client->nav_app_call( z2ui5_cl_pop_table=>factory(
                                    i_tab   = <table>
                                    i_title = 'Selected rows' ) ).

        ENDIF.

      CATCH cx_root.
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
