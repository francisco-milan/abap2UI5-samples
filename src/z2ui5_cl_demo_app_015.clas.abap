CLASS z2ui5_cl_demo_app_015 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA mv_html_text TYPE string.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_015 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    IF client->check_on_init( ).



    ENDIF.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

    DATA(view) = z2ui5_cl_xml_view=>factory( ).
    view->shell(
          )->page(
            title          = 'abap2UI5 - Formatted Text'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = xsdbool( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL )
            )->header_content(
                )->toolbar_spacer(
                )->link(
            )->get_parent(
            )->vbox( 'sapUiSmallMargin'
                )->link(
                    text = 'Control Documentation - SAP UI5 Formatted Text'
                    href = 'https://sapui5.hana.ondemand.com/#/entity/sap.m.FormattedText/sample/sap.m.sample.FormattedText'
                )->get_parent(
            )->vbox( 'sapUiSmallMargin'
                )->formatted_text( mv_html_text ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.
ENDCLASS.
