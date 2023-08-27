CLASS z2ui5_cl_app_demo_101 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    TYPES:
      BEGIN OF ty_feed,
        author    TYPE string,
        authorpic TYPE string,
        type      TYPE string,
        date      TYPE string,
        text      TYPE string,
      END OF ty_feed.

    DATA mt_feed TYPE TABLE OF ty_feed.

  PROTECTED SECTION.
    DATA client TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.

    METHODS z2ui5_on_event.
    METHODS z2ui5_set_data.
    METHODS z2ui5_view_display.

  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_APP_DEMO_101 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      z2ui5_set_data( ).
      z2ui5_view_display( ).
      RETURN.
    ENDIF.

    z2ui5_on_event( ).

  ENDMETHOD.


  METHOD z2ui5_on_event.
    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).

    ENDCASE.
  ENDMETHOD.


  METHOD z2ui5_set_data.

    mt_feed = VALUE #(
                      ( author = `choper725` authorpic = `employee` type = `Request` date = `August 26 2023`
                        text = `Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.` &&
                          `Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.` &&
                          `Lorem ipsum dolor sit amet, consetetur sadipscing elitr, seddiamnonumyeirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.` &&
                          `Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.` &&
                          `Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.` &&
                          `Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna` &&
                          `aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.` )

                      ( author = `choper725` authorpic = `sap-icon://employee` type = `Reply` date = `August 26 2023` text = `this is feed input` )
                    ).

  ENDMETHOD.


  METHOD z2ui5_view_display.
    DATA(lo_view) = z2ui5_cl_xml_view=>factory( client ).

    DATA(page) = lo_view->shell( )->page(
             title          = 'Feed Input'
             navbuttonpress = client->_event( 'BACK' )
             shownavbutton  = abap_true
         ).

    DATA(fi) = page->feed_input( post = client->_event( 'POST' )
*                             icon = `http://upload.wikimedia.org/wikipedia/commons/a/aa/Dronning_victoria.jpg`
                             growing = abap_true
                             icondensityaware = abap_false
                             class = `sapUiSmallMarginTopBottom`
      )->get_parent(
      )->list(
        items = client->_bind_edit( mt_feed )
          )->feed_list_item(
            sender = `{AUTHOR}`
*            icon   = `http://upload.wikimedia.org/wikipedia/commons/a/aa/Dronning_victoria.jpg`
            senderpress   = client->_event( 'SENDER_PRESS' )
            iconpress   = client->_event( 'ICON_PRESS' )
            icondensityaware   = abap_false
            showicon = abap_false
            info = `Reply`
*            timestamp = `{DATE}`
            text = `{TEXT}`
            convertlinkstoanchortags = `All`
).

    client->view_display( lo_view->stringify( ) ).

  ENDMETHOD.
ENDCLASS.