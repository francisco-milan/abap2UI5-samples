CLASS z2ui5_cl_demo_app_318 DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA mv_type           TYPE string.
    DATA mv_path           TYPE string.
    DATA mv_editor         TYPE string.
    DATA mv_check_editable TYPE abap_bool.


    DATA client            TYPE REF TO z2ui5_if_client.
    DATA: lt_types TYPE z2ui5_if_types=>ty_t_name_value.
    METHODS view_display.
    DATA: lt_types2 TYPE z2ui5_if_types=>ty_t_name_value.
  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.


CLASS z2ui5_cl_demo_app_318 IMPLEMENTATION.
  METHOD view_display.

    mv_editor = `<html> ` && |\n| &&
                `    <body> ` && |\n| &&
                `        <h1> Hi there 👋</h1>` && |\n| &&
                `        <p>This example was rendered by providing HTML code to the API. You can also tell the API to convert from a URL. Just remove the html parameter and add the url paramter.</p>` && |\n| &&
                `    </body> ` && |\n| &&
                `</html>`.

    DATA(view) = z2ui5_cl_xml_view=>factory( ).

    DATA(page) = view->shell( )->page( title          = 'abap2UI5 - File Editor'
                                       navbuttonpress = client->_event( 'BACK' )
                                       shownavbutton  = xsdbool( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ) ).

    DATA(temp) = page->simple_form( title    = 'File'
                                    editable = abap_true )->content( `form`
         )->label( 'path'
         )->input( client->_bind_edit( mv_path )
         )->label( 'Option' ).


    lt_types2 = VALUE #( FOR row IN z2ui5_cl_util=>source_get_file_types( )  (
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

    page->code_editor( type     = `html`
                       editable = abap_true
                       value    = client->_bind( mv_editor ) ).

    page->footer( )->overflow_toolbar(
        )->toolbar_spacer(
        )->button( text    = 'PDF'
                   press   = client->_event( 'PDF' )
                   type    = 'Emphasized'
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

      WHEN 'PDF'.

*        TRY.
** URL
*    DATA(lv_url) = |https://api.pdfcrowd.com/convert/24.04/|.
*    DATA: o_client TYPE REF TO if_http_client.
*
** Client-Objekt erzeugen
*    cl_http_client=>create_by_url( EXPORTING
*                                     url     = lv_url
*                                   IMPORTING
*                                     client  = o_client ).
*
*    IF o_client IS BOUND.
** Anmeldedaten übermitteln
*      o_client->authenticate( username = 'demo'
*                              password = 'ce544b6ea52a5621fb9d55f8b542d14d' ).
*
** Logon-Popup ein- bzw. ausschalten
**      o_client->propertytype_logon_popup = o_client->co_enabled.
*
** HTTP-Prtotokoll-Version
**      o_client->request->set_version( version = if_http_request=>co_protocol_version_1_1 ).
** HTTP-Method
*      o_client->request->set_method( if_http_request=>co_request_method_post ).
*      o_client->request->set_header_field( name  = 'Content-Type' value = 'application/json' ).
*
*  o_client->request->set_form_field(
*    name  = 'content_viewport_width'
*    value = 'balanced'
*  ).
*
*    o_client->request->set_form_field(
*    name  = 'text'
*    value = mv_editor
*  ).
* Header-Felder explizit setzen
*      o_client->request->set_header_field( name  = '~request_method'
*                                           value = 'GET' ).
*
*      o_client->request->set_header_field( name  = 'Content-Type'
*                                           value = 'text/xml; charset=utf-8' ).
*
*      o_client->request->set_header_field( name  = 'Accept'
*                                           value = 'text/xml, text/html' ).

* Cookies akzeptieren
*      o_client->propertytype_accept_cookie = if_http_client=>co_enabled.
* Kompression akzeptieren
*      o_client->propertytype_accept_compress = if_http_client=>co_enabled.

* HTTP GET senden, evtl. Timeout angeben
*      o_client->send( timeout = if_http_client=>co_timeout_default ).
*
** Response lesen
*      o_client->receive( ).
*
*      DATA: lv_http_status TYPE i.
*      DATA: lv_status_text TYPE string.
*
** HTTP Return Code holen
*      o_client->response->get_status( IMPORTING
*                                        code   = lv_http_status
*                                        reason = lv_status_text ).
*
**      WRITE: / 'HTTP_STATUS_CODE:', lv_http_status.
**      WRITE: / 'STATUS_TEXT:', lv_status_text.
**
*** Header-Daten der Übertragung
**      WRITE: / 'HEADER_FIELDS:'.
**      DATA(it_header_fields) = VALUE tihttpnvp( ).
**      o_client->response->get_header_fields( CHANGING fields = it_header_fields ).
**
**      LOOP AT it_header_fields ASSIGNING FIELD-SYMBOL(<f>).
**        WRITE: / '[', <f>-name, ']', <f>-value.
**      ENDLOOP.
*
** Cookies holen
**      WRITE: / 'COOKIES:'.
**      DATA(it_cookies) = VALUE tihttpcki( ).
**      o_client->response->get_cookies( CHANGING cookies = it_cookies ).
**
**      LOOP AT it_cookies ASSIGNING FIELD-SYMBOL(<c>).
**        WRITE: / '[', <c>-name, ']', <c>-value, <c>-xdomain, <c>-path, <c>-secure, <c>-expires.
**      ENDLOOP.
*
** vollständige HTTP Nachricht lesen
*      DATA(lv_raw_message) = o_client->response->get_raw_message( ).
*      DATA: lv_str_msg TYPE string.
*
** xstring -> string
*      DATA(o_conv_r) = cl_abap_conv_in_ce=>create( input    = lv_raw_message
*                                                   encoding = 'UTF-8' ).
*
*      o_conv_r->read( IMPORTING data = lv_str_msg ).
*
*      WRITE: / 'RAW MESSAGE:', lv_str_msg.
*
** Wenn Status 200 (Ok)
*      IF lv_http_status = 200.
** HTTP Body als Character-Daten
*        DATA(lv_result) = o_client->response->get_cdata( ).
*
*        WRITE: / 'CDATA:'.
*        WRITE: / lv_result.
*      ENDIF.
*
** HTTP Connection schließen
*      o_client->close( ).
*    ENDIF.
*  CATCH cx_root INTO DATA(e_txt).
*    WRITE: / e_txt->get_text( ).
*ENDTRY.


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
