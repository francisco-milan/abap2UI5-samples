CLASS z2ui5_cl_demo_app_284 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.



  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.

    METHODS display_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS on_event
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS z2ui5_display_popover
      IMPORTING
        id TYPE string.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_284 IMPLEMENTATION.


  METHOD display_view.

    DATA(page_01) = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Flexible sizing - Toolbar'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = xsdbool( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ) ).

    page_01->header_content(
       )->button( id = `button_hint_id`
           icon      = `sap-icon://hint`
           tooltip   = `Sample information`
           press     = client->_event( 'CLICK_HINT_ICON' ) ).

    page_01->header_content(
       )->link(
           text   = 'UI5 Demo Kit'
           target = '_blank'
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.Page/sample/sap.m.sample.PageListReportToolbar' ).

    DATA(page_02) = page_01->page( enablescrolling = abap_true
                                   title           = `Title`
                                   class           = `sapUiResponsivePadding--header sapUiResponsivePadding--footer`
                              )->content(
                                  )->vbox( fitcontainer = abap_true
                                      )->simple_form( id = `SimpleFormDisplay480`
                                          editable       = abap_false
                                          layout         = `ResponsiveGridLayout`
                                          title          = `Address`
                                          labelspanl     = `4`
                                          labelspanm     = `4`
                                          emptyspanl     = `0`
                                          emptyspanm     = `0`
                                          columnsl       = `2`
                                          columnsm       = `2`
                                          )->content( ns = `form`
                                              )->title( ns   = `core`
                                                        text = `Office`
                                              )->label( text = `Name`
                                              )->text( text = `Red Point Stores`
                                              )->label( text = `Street/No.`
                                              )->text( text = `Main St 1618`
                                              )->label( text = `ZIP Code/City`
                                              )->text( text = `31415 Maintown`
                                              )->label( text = `Country`
                                              )->text( text = `Germany`
                                              )->title( ns   = `core`
                                                        text = `Online`
                                              )->label( text = `Web`
                                              )->text( text = `http://www.sap.com`
                                              )->label( text = `Twitter`
                                              )->text( text = `@sap` )->get_parent(
                                          )->layout_data( ns = `form`
                                              )->flex_item_data( shrinkfactor     = `0`
                                                                 backgrounddesign = `Solid`
                                                                 styleclass       = `sapContrastPlus` )->get_parent( )->get_parent(
                                      )->analytical_table( ns            = `table`
                                                           selectionmode = `MultiToggle`
                                          )->rowmode( ns = `table`
                                              )->auto( ns               = `trm`
                                                       rowcontentheight = `32` )->get_parent( )->get_parent(
                                          )->toolbar( ns = `table`
                                            )->overflow_toolbar(
                                              )->title( text = `Title Bar Here`
                                              )->toolbar_spacer(
                                              )->search_field( width = `12rem`
                                              )->segmented_button(
                                                )->items(
                                                  )->segmented_button_item( icon = `sap-icon://table-view`
                                                  )->segmented_button_item( icon = `sap-icon://bar-chart` )->get_parent( )->get_parent(
                                              )->button( icon = `sap-icon://group-2`
                                                         type = `Transparent`
                                              )->button( icon = `sap-icon://action-settings`
                                                         type = `Transparent` )->get_parent( )->get_parent(
                                          )->columns( ns = `table`
                                              )->analytical_column( ns = `table` )->get_parent(
                                              )->analytical_column( ns = `table` )->get_parent(
                                              )->analytical_column( ns = `table` )->get_parent( )->get_parent(
                                          )->layout_data( ns = `table`
                                              )->flex_item_data( growfactor = `1`
                                                                 basesize   = `0%`
                                                                 styleclass = `sapUiResponsiveContentPadding` )->get_parent( )->get_parent( )->get_parent( )->get_parent(
                              )->footer(
                                  )->overflow_toolbar(
                                      )->content(
                                          )->toolbar_spacer(
                                          )->button( text = `Grouped View`
                                          )->button( text = `Classical Table` ).

    client->view_display( page_02->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'CLICK_HINT_ICON'.
        z2ui5_display_popover( `button_hint_id` ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA(view) = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `This page shows flexible sizing with a Toolbar. ` &&
                                                `The upper part extends with its content, but doesn't react to viewport changes. ` &&
                                                `The lower part reacts to the viewport size. The table inside takes the available space. ` &&
                                                `If the minimum size of the table is reached, the page begins to scroll.` ).

    client->popover_display(
      xml   = view->stringify( )
      by_id = id ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF client->check_on_init( ).
      display_view( client ).
    ENDIF.

    on_event( client ).

  ENDMETHOD.
ENDCLASS.
