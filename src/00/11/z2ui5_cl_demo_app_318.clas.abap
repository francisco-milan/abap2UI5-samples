CLASS z2ui5_cl_demo_app_318 DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA mv_type           TYPE string.
    DATA mv_path           TYPE string.
    DATA mv_editor         TYPE string.
    DATA mv_check_editable TYPE abap_bool.

    DATA lt_types TYPE z2ui5_if_types=>ty_t_name_value.

    DATA lt_types2 TYPE z2ui5_if_types=>ty_t_name_value.

    METHODS view_display.

  PROTECTED SECTION.
    DATA client TYPE REF TO z2ui5_if_client.

  PRIVATE SECTION.
ENDCLASS.


CLASS z2ui5_cl_demo_app_318 IMPLEMENTATION.
  METHOD view_display.

    mv_editor = `<html> ` && |\n| &&
                `    <body> ` && |\n| &&
                `        <h1> Hi there 👋</h1>` && |\n| &&
                `        <p>This example was rendered by providing HTML code to the API. You can also tell the API to convert from a URL. Just remove the html parameter and add the url parameter.</p>` && |\n| &&
                `    </body> ` && |\n| &&
                `</html>`.

    DATA(view) = z2ui5_cl_xml_view=>factory( ).

    DATA(page) = view->shell( )->page( title          = `abap2UI5 - File Editor`
                                       navbuttonpress = client->_event_nav_app_leave( )
                                       shownavbutton  = client->check_app_prev_stack( ) ).

    DATA(temp) = page->simple_form( title    = `File`
                                    editable = abap_true )->content( `form`
         )->label( `path`
         )->input( client->_bind_edit( mv_path )
         )->label( `Option` ).

    DATA(lv_types) = |abap, abc, actionscript, ada, apache_conf, applescript, asciidoc, assembly_x86, autohotkey, batchfile, bro, c9search, c_cpp, cirru, clojure, cobol, coffee, coldfusion, csharp, css, curly, d, dart, diff, django, dockerfile, | &&
|dot, drools, eiffel, yaml, ejs, elixir, elm, erlang, forth, fortran, ftl, gcode, gherkin, gitignore, glsl, gobstones, golang, groovy, haml, handlebars, haskell, haskell_cabal, haxe, hjson, html, html_elixir, html_ruby, ini, io, jack, jade, java, ja| &&
      |vascri| &&
|pt, json, jsoniq, jsp, jsx, julia, kotlin, latex, lean, less, liquid, lisp, live_script, livescript, logiql, lsl, lua, luapage, lucene, makefile, markdown, mask, matlab, mavens_mate_log, maze, mel, mips_assembler, mipsassembler, mushcode, mysql, ni| &&
|x, nsis, objectivec, ocaml, pascal, perl, pgsql, php, plain_text, powershell, praat, prolog, properties, protobuf, python, r, razor, rdoc, rhtml, rst, ruby, rust, sass, scad, scala, scheme, scss, sh, sjs, smarty, snippets, soy_template, space, sql,| &&
      | sqlserver, stylus, svg, swift, swig, tcl, tex, text, textile, toml, tsx, twig, typescript, vala, vbscript, velocity, verilog, vhdl, wollok, xml, xquery, terraform, slim, redshift, red, puppet, php_laravel_blade, mixal, jssm, fsharp, edifact,| &&
      | csp, cssound_score, cssound_orchestra, cssound_document| ##NO_TEXT.
    SPLIT lv_types AT `,` INTO TABLE data(lt_types).

    lt_types2 = VALUE #( FOR row IN lt_types  (
            n = shift_right( shift_left( row ) )
            v = shift_right( shift_left( row ) ) ) ).

    DATA(temp3) = temp->input( value = client->_bind_edit( mv_type )
                   suggestionitems   = client->_bind( lt_types )
                    )->get( ).

    temp3->suggestion_items(
                )->list_item( text           = `{N}`
                              additionaltext = `{V}` ).

    temp->label( `` )->button( text = `Download`
                    press           = client->_event( `DB_LOAD` )
                    icon            = `sap-icon://download-from-cloud` ).

    page->code_editor( type     = `html`
                       editable = abap_true
                       value    = client->_bind( mv_editor ) ).

    page->footer( )->overflow_toolbar(
        )->toolbar_spacer(
        )->button( text    = `PDF`
                   press   = client->_event( `PDF` )
                   type    = `Emphasized`
                   enabled = xsdbool( mv_editor IS NOT INITIAL ) ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF client->check_on_init( ).

      mv_path = `../../demo/text`.
      mv_type = `plain_text`.
      view_display( ).
    ENDIF.

    CASE client->get( )-event.

      WHEN `PDF`.

      WHEN `DB_SAVE`.
        client->message_box_display( text = `Upload successful. File saved!`
                                     type = `success` ).
      WHEN `EDIT`.
        mv_check_editable = xsdbool( mv_check_editable = abap_false ).
        client->view_model_update( ).

      WHEN `CLEAR`.
        mv_editor = ``.
    ENDCASE.

  ENDMETHOD.

ENDCLASS.
