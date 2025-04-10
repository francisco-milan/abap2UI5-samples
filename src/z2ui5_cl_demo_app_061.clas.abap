CLASS z2ui5_cl_demo_app_061 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA t_tab TYPE REF TO data.


  PROTECTED SECTION.
    DATA client TYPE REF TO z2ui5_if_client.
    METHODS set_view.

  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_061 IMPLEMENTATION.


  METHOD set_view.

    DATA(view) = z2ui5_cl_xml_view=>factory( ).
    DATA(page) = view->shell(
        )->page(
                title          = 'abap2UI5 - RTTI created Table'
                navbuttonpress = client->_event( 'BACK' )
                shownavbutton  = xsdbool( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ) ).


    FIELD-SYMBOLS <tab> TYPE table.
    ASSIGN t_tab->* TO <tab>.

    DATA(tab) = page->table(
            items = client->_bind_edit( <tab> )
            mode  = 'MultiSelect'
        )->header_toolbar(
            )->overflow_toolbar(
                )->title( 'Dynamic typed table'
                )->toolbar_spacer(
                )->button(
                    text  = `server <-> client`
                    press = client->_event( val = 'SEND' )
        )->get_parent( )->get_parent( ).

    tab->columns(
        )->column(
            )->text( 'uuid' )->get_parent(
        )->column(
            )->text( 'time' )->get_parent(
        )->column(
            )->text( 'previous' )->get_parent( ).

    tab->items( )->column_list_item( selected = '{SELKZ}'
      )->cells(
          )->input( value = '{ID}'
          )->input( value = '{TIMESTAMPL}'
          )->input( value = '{ID_PREV}' ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.
    FIELD-SYMBOLS <tab> TYPE table.

    me->client = client.

    IF client->check_on_init( ).

      CREATE DATA t_tab TYPE STANDARD TABLE OF ('Z2UI5_T_01').

      ASSIGN t_tab->* TO <tab>.

      INSERT VALUE z2ui5_t_01( id = 'this is an uuid'  timestampl = '2023234243'  id_prev = 'previous' )
        INTO TABLE <tab>.

      INSERT VALUE z2ui5_t_01( id = 'this is an uuid'  timestampl = '2023234243'  id_prev = 'previous' )
          INTO TABLE <tab>.
      INSERT VALUE z2ui5_t_01( id = 'this is an uuid'  timestampl = '2023234243'  id_prev = 'previous' )
          INTO TABLE <tab>.


    ENDIF.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

    set_view( ).

  ENDMETHOD.
ENDCLASS.
