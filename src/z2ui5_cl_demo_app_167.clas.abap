CLASS z2ui5_cl_demo_app_167 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA mv_value TYPE string.


    DATA client TYPE REF TO z2ui5_if_client.
    METHODS set_view.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS z2ui5_cl_demo_app_167 IMPLEMENTATION.

  METHOD set_view.

    DATA(view) = z2ui5_cl_xml_view=>factory( ).
    DATA(page) = view->shell(
        )->page(
                title          = 'abap2UI5 - Event with add Information and t_arg'
                navbuttonpress = client->_event( 'BACK' )
                shownavbutton  = xsdbool( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ) ).

    page->link( text   = 'More Infos..'
                target = '_blank'
                href   = `https://sapui5.hana.ondemand.com/sdk/#/topic/b0fb4de7364f4bcbb053a99aa645affe` ).

    page->button( text  = `EVENT_FIX_VAL`
                  press = client->_event( val = `EVENT_FIX_VAL` t_arg = VALUE #(
        ( `FIX_VAL` ) ) ) ).

    page->input( client->_bind_edit( mv_value ) ).
    page->button( text  = `EVENT_MODEL_VALUE`
                  press = client->_event( val = `EVENT_MODEL_VALUE` t_arg = VALUE #(
        ( `$` && client->_bind_edit( mv_value ) ) ) ) ).


    page->button( text  = `SOURCE_PROPERTY_TEXT`
                  press = client->_event( val = `SOURCE_PROPERTY_TEXT` t_arg = VALUE #(
        ( `${$source>/text}` ) ) ) ).

    page->input(
        description = `make an input and press enter - `
        submit      = client->_event( val = `EVENT_PROPERTY_VALUE` t_arg = VALUE #(
        ( `${$parameters>/value}` ) ) ) ).

    page->button( text  = `PARENT_PROPERTY_ID`
                  press = client->_event( val = `PARENT_PROPERTY_ID` t_arg = VALUE #(
        ( `$event.oSource.oParent.sId` ) ) ) ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF client->check_on_init( ).
      mv_value = `my value`.
      set_view( ).
    ENDIF.

    DATA(lt_arg) = client->get( )-t_event_arg.
    CASE client->get( )-event.
      WHEN `EVENT_FIX_VAL` OR `EVENT_MODEL_VALUE` OR 'SOURCE_PROPERTY_TEXT' OR 'EVENT_PROPERTY_VALUE' OR 'PARENT_PROPERTY_ID'.
        client->message_box_display( `backend event :` && lt_arg[ 1 ] ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

    client->view_model_update( ).

  ENDMETHOD.
ENDCLASS.
