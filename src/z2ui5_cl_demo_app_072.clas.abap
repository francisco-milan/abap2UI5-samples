CLASS z2ui5_cl_demo_app_072 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_s_tab,
        productid     TYPE string,
        productname   TYPE string,
        suppliername  TYPE string,
        measure       TYPE p LENGTH 10 DECIMALS 2,
        unit          TYPE string, "meins,
        price         TYPE p LENGTH 14 DECIMALS 3, "p LENGTH 10 DECIMALS 2,
        waers         TYPE waers,
        width         TYPE string,
        depth         TYPE string,
        height        TYPE string,
        dimunit       TYPE meins,
        state_price   TYPE string,
        state_measure TYPE string,
        rating        TYPE string,
      END OF ty_s_tab .
    TYPES
      ty_t_table TYPE STANDARD TABLE OF ty_s_tab WITH EMPTY KEY .

    DATA mt_table TYPE ty_t_table .
    DATA lv_cnt_total TYPE i .
    DATA lv_cnt_pos TYPE i .
    DATA lv_cnt_heavy TYPE i .
    DATA lv_cnt_neg TYPE i .
    DATA lv_selectedkey TYPE string .
    CONSTANTS c_lcb TYPE string VALUE '{' ##NO_TEXT.
    CONSTANTS c_rcb TYPE string VALUE '}' ##NO_TEXT.
  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client .
    DATA check_initialized TYPE abap_bool .

    METHODS z2ui5_on_init .
    METHODS z2ui5_on_event .
    METHODS z2ui5_set_data .
  PRIVATE SECTION.

    METHODS set_filter .
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_072 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.
    me->client     = client.

    IF client->check_on_init( ).
      z2ui5_set_data( ).
      z2ui5_on_init( ).
      RETURN.
    ENDIF.

    z2ui5_on_event( ).

  ENDMETHOD.


  METHOD z2ui5_on_event.

    CASE client->get( )-event.
      WHEN 'OnSelectIconTabBar'.
        client->message_toast_display( |Event SelectedTabBar Key { lv_selectedkey  } | ).
        set_filter( ).
        client->view_model_update( ).
      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_on_init.


    DATA(view) = z2ui5_cl_xml_view=>factory( ).

    DATA(page) = view->shell( )->page( id = `page_main`
           showheader                     = xsdbool( abap_false = client->get( )-check_launchpad_active )
            title                         = 'abap2UI5 - IconTabBar'
            navbuttonpress                = client->_event( 'BACK' )
            shownavbutton                 = xsdbool( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL )
            class                         = 'sapUiContentPadding' ).

    DATA(lo_items) = page->icon_tab_bar( class       = 'sapUiResponsiveContentPadding'
                                         selectedkey = client->_bind_edit( lv_selectedkey )
                                         select      = client->_event( val = 'OnSelectIconTabBar' t_arg = VALUE #( ( `${LV_SELECTEDKEY}` ) ) ) )->items( ).
    lo_items->icon_tab_filter( count   = client->_bind_edit( lv_cnt_total )
                               text    = 'Products'
                               key     = 'ALL'
                               showall = abap_true ).
    lo_items->icon_tab_separator( ).
    lo_items->icon_tab_filter( icon      = 'sap-icon://begin'
                               iconcolor = 'Positive'
                               count     = client->_bind_edit( lv_cnt_pos )
                               text      = 'OK'
                               key       = 'OK' ).
    lo_items->icon_tab_filter( icon      = 'sap-icon://compare'
                               iconcolor = 'Critical'
                               count     = client->_bind_edit( lv_cnt_heavy )
                               text      = 'Heavy'
                               key       = 'HEAVY' ).
    lo_items->icon_tab_filter( icon      = 'sap-icon://inventory'
                               iconcolor = 'Negative'
                               count     = client->_bind_edit( lv_cnt_neg )
                               text      = 'Overweight'
                               key       = 'OVERWEIGHT' ).

    DATA(tab) = page->scroll_container( height   = '70%'
                                        vertical = abap_true
       )->table(
           inset          = abap_false
           showseparators = 'Inner'
           headertext     = 'Products'
           items          = client->_bind( mt_table ) ).

    tab->columns(
        )->column( width = '12em'
            )->text( 'Product' )->get_parent(
        )->column( minscreenwidth = 'Tablet'
                   demandpopin    = abap_true
            )->text( 'Supplier' )->get_parent(
        )->column( minscreenwidth = 'Desktop'
                   demandpopin    = abap_true
                   halign         = 'End'
            )->text( 'Dimensions' )->get_parent(
        )->column( minscreenwidth = 'Desktop'
                   demandpopin    = abap_true
                   halign         = 'Center'
            )->text( 'Weight' )->get_parent(
         )->column( halign = 'End'
            )->text( 'Price' )->get_parent(
         )->column( halign = 'End'
             )->text( 'Rating' ).

    tab->items(
        )->column_list_item(
           )->cells(
             )->object_identifier( text  = '{PRODUCTNAME}'
                                   title = '{PRODUCTID}' )->get_parent(
             )->text( text = '{SUPPLIERNAME}' )->get_parent(
             )->text( text = '{WIDTH} x {DEPTH} x {HEIGHT} {DIMUNIT}'
             )->object_number( number = '{MEASURE}'
                               unit   = '{UNIT}'
                               state  = '{STATE_MEASURE}'
             )->object_number(
                   state  = '{STATE_PRICE}'
                   number = `{ parts: [ { path : 'PRICE' } , { path : 'WAERS' } ] } ` ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_set_data.
    mt_table = VALUE #(
        ( productid = '1' productname = 'table' suppliername = 'Company 1' width = '10' depth = '20' height = '30' dimunit = 'CM' measure = 100  unit = 'ST' price = '1000.50' waers = 'EUR'  state_price = `Success` rating = '0' state_measure = `Warning` )
        ( productid = '2' productname = 'chair' suppliername = 'Company 2'  width = '10' depth = '20' height = '30' dimunit = 'CM' measure = 123   unit = 'ST' price = '2000.55' waers = 'USD' state_price = `Error` rating = '1'  state_measure = `Warning` )
        ( productid = '3' productname = 'sofa'  suppliername = 'Company 3'  width = '10' depth = '20' height = '30' dimunit = 'CM' measure  = 700   unit = 'ST' price = '3000.11' waers = 'CNY' state_price = `Success` rating = '2'  state_measure =
      `Warning` )
        ( productid = '4' productname = 'computer' suppliername = 'Company 4'  width = '10' depth = '20' height = '30' dimunit = 'CM' measure  = 200  unit = 'ST' price = '4000.88' waers = 'USD' state_price = `Success` rating = '3'  state_measure =
      `Success` )
        ( productid = '5' productname = 'printer' suppliername = 'Company 5'  width = '10' depth = '20' height = '30' dimunit = 'CM' measure  = 90   unit = 'ST' price = '5000.47' waers = 'EUR' state_price = `Error` rating = '4'  state_measure =
      `Warning` )
        ( productid = '6' productname = 'table2'  suppliername = 'Company 6'  width = '10' depth = '20' height = '30' dimunit = 'CM' measure = 600  unit = 'ST' price = '6000.33' waers = 'GBP' state_price = `Success` rating = '5' state_measure =
      `Information` ) ).

    lv_cnt_total = lines( mt_table ).
    lv_cnt_pos = REDUCE i( INIT i = 0 FOR wa IN mt_table WHERE ( measure > 0 AND measure <= 100 ) NEXT i = i + 1 ).
    lv_cnt_heavy = REDUCE i( INIT j = 0 FOR wa IN mt_table WHERE ( measure > 100 AND measure <= 500 ) NEXT j = j + 1 ).
    lv_cnt_neg = REDUCE i( INIT k = 0 FOR wa IN mt_table WHERE ( measure > 500 ) NEXT k = k + 1 ).

  ENDMETHOD.


  METHOD set_filter.
    z2ui5_set_data( ).
    CASE lv_selectedkey.
      WHEN 'ALL'.
      WHEN 'OK'.
        DELETE mt_table WHERE NOT measure BETWEEN 0 AND 100.
      WHEN 'HEAVY'.
        DELETE mt_table WHERE NOT measure BETWEEN 101 AND 500.
      WHEN 'OVERWEIGHT'.
        DELETE mt_table WHERE NOT measure > 500.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
