CLASS z2ui5_cl_demo_app_138 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA:
      BEGIN OF ms_data,
        BEGIN OF ms_data2,
          BEGIN OF ms_data2,
            BEGIN OF ms_data2,
              BEGIN OF ms_data2,
                BEGIN OF ms_data2,
                  val TYPE string,
                  BEGIN OF ms_data2,
                    val TYPE string,
                  END OF ms_data2,
                END OF ms_data2,
                val TYPE string,
              END OF ms_data2,
              val TYPE string,
            END OF ms_data2,
            val TYPE string,
          END OF ms_data2,
          val TYPE string,
        END OF ms_data2,
        val2 TYPE string,
      END OF ms_data.


    DATA quantity TYPE string.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_138 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    IF client->check_on_init( ).

      ms_data-ms_data2-ms_data2-ms_data2-ms_data2-ms_data2-ms_data2-val  = 'tomato'.
      quantity = '500'.

      DATA(view) = z2ui5_cl_xml_view=>factory( ).
      client->view_display( view->shell(
            )->page(
                    title          = 'abap2UI5 - First Example'
                    navbuttonpress = client->_event( val = 'BACK' )
                    shownavbutton  = xsdbool( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL )
                )->simple_form( title    = 'Form Title'
                                editable = abap_true
                    )->content( 'form'
                        )->title( 'Input'
                        )->label( 'quantity'
                        )->input( client->_bind_edit( quantity )
                        )->label( `product`
                        )->input( client->_bind_edit( ms_data-ms_data2-ms_data2-ms_data2-ms_data2-ms_data2-ms_data2-val )
                        )->button(
                            text  = 'post'
                            press = client->_event( val = 'BUTTON_POST' )
             )->stringify( ) ).

    ENDIF.

    CASE client->get( )-event.

      WHEN 'BUTTON_POST'.
        client->message_toast_display( |{ quantity } - send to the server| ).

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).

    ENDCASE.

  ENDMETHOD.
ENDCLASS.
