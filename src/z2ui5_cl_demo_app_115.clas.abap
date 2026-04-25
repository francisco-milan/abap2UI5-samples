CLASS z2ui5_cl_demo_app_115 DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS z2ui5_cl_demo_app_115 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    DATA(lv_style) = `<html:style type="text/css">body {` && |\n| &&
                                      `     font-family: Arial;` && |\n| &&
                                      `     font-size: 90%;` && |\n| &&
                                      `}` && |\n| &&
                                      `table {` && |\n| &&
                                      `     font-family: Arial;` && |\n| &&
                                      `     font-size: 90%;` && |\n| &&
                                      `}` && |\n| &&
                                      `caption {` && |\n| &&
                                      `     font-family: Arial;` && |\n| &&
                                      `     font-size: 90%;` && |\n| &&
                                      `     font-weight:bold;` && |\n| &&
                                      `     text-align:left;` && |\n| &&
                                      `}` && |\n| &&
                                      `span.heading1 {` && |\n| &&
                                      `    font-size: 150%;` && |\n| &&
                                      `     color:#000080;` && |\n| &&
                                      `     font-weight:bold;` && |\n| &&
                                      `}` && |\n| &&
                                      `span.heading2 {` && |\n| &&
                                      `    font-size: 135%;` && |\n| &&
                                      `     color:#000080;` && |\n| &&
                                      `     font-weight:bold;` && |\n| &&
                                      `}` && |\n| &&
                                      `span.heading3 {` && |\n| &&
                                      `    font-size: 120%;` && |\n| &&
                                      `     color:#000080;` && |\n| &&
                                      `     font-weight:bold;` && |\n| &&
                                      `}` && |\n| &&
                                      `span.heading4 {` && |\n| &&
                                      `    font-size: 105%;` && |\n| &&
                                      `     color:#000080;` && |\n| &&
                                      `     font-weight:bold;` && |\n| &&
                                      `}` && |\n| &&
                                      `span.normal {` && |\n| &&
                                      `    font-size: 100%;` && |\n| &&
                                      `     color:#000000;` && |\n| &&
                                      `     font-weight:normal;` && |\n| &&
                                      `}` && |\n| &&
                                      `span.nonprop {` && |\n| &&
                                      `    font-family: Courier New;` && |\n| &&
                                      `     font-size: 100%;` && |\n| &&
                                      `     color:#000000;` && |\n| &&
                                      `     font-weight:400;` && |\n| &&
                                      `}` && |\n| &&
                                      `span.nowrap {` && |\n| &&
                                      `    white-space:nowrap;` && |\n| &&
                                      `}` && |\n| &&
                                      `span.nprpnwrp {` && |\n| &&
                                      `    font-family: Courier New;` && |\n| &&
                                      `     font-size: 100%;` && |\n| &&
                                      `     color:#000000;` && |\n| &&
                                      `     font-weight:400;` && |\n| &&
                                      `     white-space:nowrap;` && |\n| &&
                                      `}` && |\n| &&
                                      `tr.header {` && |\n| &&
                                      `    background-color:#D3D3D3;` && |\n| &&
                                      `}` && |\n| &&
                                      `tr.body {` && |\n| &&
                                      `    background-color:#EFEFEF;` && |\n| &&
                                      `}` && |\n| &&
                                      `</html:style>`.

    DATA(lv_html) =  `` && |\n| &&
                    |\n| &&
                    `<h2 title="I'm a header">The title Attribute</h2>` && |\n| &&
                    |\n| &&
                    `<p title="I'm a tooltip">Mouse over this paragraph, to display the title attribute as a tooltip.</p>` && |\n| &&
                    |\n| &&
                    ``.


    DATA(view) = z2ui5_cl_xml_view=>factory( ).
    view->shell(
          )->page(
              title          = `abap2UI5 - CL_DEMO_OUTPUT`
              navbuttonpress = client->_event_nav_app_leave( )
              shownavbutton  = client->check_app_prev_stack( )
          )->_cc_plain_xml( lv_style
          )->html( lv_html ).

    client->view_display( view->stringify( ) ).
*    RETURN.



    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " TODO
    " (1) split style and html
    " (2) add html namespace to style
    " (3) display


*SELECT *
*       FROM scarr
*       INTO TABLE @DATA(carriers).
*
*CALL TRANSFORMATION id SOURCE carriers = carriers
*                       RESULT XML DATA(xml).
*
*data(html) = cl_demo_output=>new(
*  )->begin_section( `Some Text`
*  )->write_text( |blah blah blah \n| &&
*                 |blah blah blah|
*  )->next_section( `Some Data`
*  )->begin_section( `Elementary Object`
*  )->write_data( carriers[ 1 ]-carrid
*  )->next_section( `Internal Table`
*  )->write_data( carriers
*  )->end_section(
*  )->next_section( `XML`
*  )->write_xml( xml
*  )->get( ).



    DATA(lv_style2) =  `    <html:style type="text/css">` && |\n|  &&
                        `    body {` && |\n|  &&
                        `        font-family: Arial;` && |\n|  &&
                        `        font-size: 90%;` && |\n|  &&
                        `    }` && |\n|  &&
                        |\n|  &&
                        `    table {` && |\n|  &&
                        `        font-family: Arial;` && |\n|  &&
                        `        font-size: 90%;` && |\n|  &&
                        `    }` && |\n|  &&
                        |\n|  &&
                        `    caption {` && |\n|  &&
                        `        font-family: Arial;` && |\n|  &&
                        `        font-size: 90%;` && |\n|  &&
                        `        font-weight:bold;` && |\n|  &&
                        `        text-align:left;` && |\n|  &&
                        `    }` && |\n|  &&
                        `    span.heading1 {` && |\n|  &&
                        `        font-size: 150%;` && |\n|  &&
                        `        color:#000080;` && |\n|  &&
                        `        font-weight:bold;` && |\n|  &&
                        `    }` && |\n|  &&
                        `    span.heading2 {` && |\n|  &&
                        `        font-size: 135%;` && |\n|  &&
                        `        color:#000080;` && |\n|  &&
                        `        font-weight:bold;` && |\n|  &&
                        `    }` && |\n|  &&
                        `    span.heading3 {` && |\n|  &&
                        `        font-size: 120%;` && |\n|  &&
                        `        color:#000080;` && |\n|  &&
                        `        font-weight:bold;` && |\n|  &&
                        `    }` && |\n|  &&
                        `    span.heading4 {` && |\n|  &&
                        `        font-size: 105%;` && |\n|  &&
                        `        color:#000080;` && |\n|  &&
                        `        font-weight:bold;` && |\n|  &&
                        `    }` && |\n|  &&
                        `    span.normal {` && |\n|  &&
                        `        font-family: Arial;` && |\n|  &&
                        `        font-size: 100%;` && |\n|  &&
                        `        color:#000000;` && |\n|  &&
                        `        font-weight:normal;` && |\n|  &&
                        `        white-space:pre;` && |\n|  &&
                        `    }` && |\n|  &&
                        `    span.nonprop {` && |\n|  &&
                        `        font-family: Courier New;` && |\n|  &&
                        `        font-size: 100%;` && |\n|  &&
                        `        color:#000000;` && |\n|  &&
                        `        font-weight:400;` && |\n|  &&
                        `        white-space:pre;` && |\n|  &&
                        `    }` && |\n|  &&
                        `    span.nowrap {` && |\n|  &&
                        `        white-space:nowrap;` && |\n|  &&
                        `    }` && |\n|  &&
                        `    span.nprpnwrp {` && |\n|  &&
                        `        font-family: Courier New;` && |\n|  &&
                        `        font-size: 100%;` && |\n|  &&
                        `        color:#000000;` && |\n|  &&
                        `        font-weight:400;` && |\n|  &&
                        `        white-space:pre;` && |\n|  &&
                        `    }` && |\n|  &&
                        `    tr.header {` && |\n|  &&
                        `        background-color:#D1D1D1;` && |\n|  &&
                        `        /font-weight:bold;/` && |\n|  &&
                        `    }` && |\n|  &&
                        `    tr.body {` && |\n|  &&
                        `        background-color:#F4F4F4;` && |\n|  &&
                        `    }` && |\n|  &&
                        `    th {` && |\n|  &&
                        `        text-align:left;` && |\n|  &&
                        `    }` && |\n|  &&
                        |\n|  &&
                        `    table.nested_table {` && |\n|  &&
                        `        border: 1px solid #D1D1D1;` && |\n|  &&
                        `        border-collapse: collapse;` && |\n|  &&
                        `        padding: 4px;` && |\n|  &&
                        `        text-align:center;` && |\n|  &&
                        `    }` && |\n|  &&
                        `    .nested_table td {` && |\n|  &&
                        `        border: 1px solid #D1D1D1;` && |\n|  &&
                        `        border-collapse: collapse;` && |\n|  &&
                        `        padding: 4px;` && |\n|  &&
                        `        text-align:left;` && |\n|  &&
                        `    }` && |\n|  &&
                        `    .nested_table th {` && |\n|  &&
                        `        border: 1px solid #D1D1D1;` && |\n|  &&
                        `        border-collapse: collapse;` && |\n|  &&
                        `        background-color: #D1D1D1;` && |\n|  &&
                        `        padding: 4px;` && |\n|  &&
                        `    }` && |\n|  &&
                        |\n|  &&
                        `    @media (prefers-color-scheme: dark) {` && |\n|  &&
                        `      /*tr.header {` && |\n|  &&
                        `        color: #000000;` && |\n|  &&
                        `      }*/` && |\n|  &&
                        `    }` && |\n|  &&
                        `  </html:style>`.

    DATA(lv_html2) = `<!DOCTYPE html PUBLIC "XSLT-compat">` && |\n|  &&
                    `<html lang="EN">` && |\n|  &&
                    `  <head>` && |\n|  &&
                    `    <META http-equiv="Content-Type" content="text/html; charset=utf-16">` && |\n|  &&
                    `    <meta name="Output" content="Data">` && |\n|  &&

                    `  </head>` && |\n|  &&
                    `  <body>` && |\n|  &&
                    `    <p>` && |\n|  &&
                    `      <span class="heading1">Some Text</span>` && |\n|  &&
                    `    </p>` && |\n|  &&
                    `    <p>` && |\n|  &&
                    `      <span class="normal">blah blah blah ` && |\n|  &&
                    `blah blah blah</span>` && |\n|  &&
                    `    </p>` && |\n|  &&
                    `    <p>` && |\n|  &&
                    `      <span class="heading1">Some Data</span>` && |\n|  &&
                    `    </p>` && |\n|  &&
                    `    <p>` && |\n|  &&
                    `      <span class="heading2">Elementary Object</span>` && |\n|  &&
                    `    </p>` && |\n|  &&
                    `    <table border="0" summary="data display" title="ABAP Data">` && |\n|  &&
                    `      <caption>` && |\n|  &&
                    `        <span class="nowrap">Operand</span>` && |\n|  &&
                    `      </caption>` && |\n|  &&
                    `      <tr class="header"></tr>` && |\n|  &&
                    `      <tr class="body">` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">AA</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `    </table>` && |\n|  &&
                    `    <br>` && |\n|  &&
                    `    <p>` && |\n|  &&
                    `      <span class="heading2">Internal Table</span>` && |\n|  &&
                    `    </p>` && |\n|  &&
                    `    <table border="0" summary="data display" title="ABAP Data">` && |\n|  &&
                    `      <caption>` && |\n|  &&
                    `        <span class="nowrap">CARRIERS</span>` && |\n|  &&
                    `      </caption>` && |\n|  &&
                    `      <tr class="header">` && |\n|  &&
                    `        <th>MANDT</th>` && |\n|  &&
                    `        <th>CARRID</th>` && |\n|  &&
                    `        <th>CARRNAME</th>` && |\n|  &&
                    `        <th>CURRCODE</th>` && |\n|  &&
                    `        <th>URL</th>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `      <tr class="body">` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">100</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">AA</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">American Airlines</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">USD</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">http://www.aa.com</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `      <tr class="body">` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">100</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">AC</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">Air Canada</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">CAD</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">http://www.aircanada.ca</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `      <tr class="body">` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">100</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">AF</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">Air France</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">EUR</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">http://www.airfrance.fr</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `      <tr class="body">` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">100</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">AZ</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">Alitalia</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">EUR</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">http://www.alitalia.it</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `      <tr class="body">` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">100</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">BA</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">British Airways</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">GBP</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">http://www.british-airways.com</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `      <tr class="body">` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">100</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">FJ</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">Air Pacific</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">USD</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">http://www.airpacific.com</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `      <tr class="body">` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">100</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">CO</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">Continental Airlines</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">USD</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">http://www.continental.com</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `      <tr class="body">` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">100</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">DL</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">Delta Airlines</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">USD</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">http://www.delta-air.com</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `      <tr class="body">` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">100</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">AB</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">Air Berlin</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">EUR</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">http://www.airberlin.de</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `      <tr class="body">` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">100</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">LH</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">Lufthansa</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">EUR</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">http://www.lufthansa.com</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `      <tr class="body">` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">100</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">NG</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">Lauda Air</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">EUR</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">http://www.laudaair.com</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `      <tr class="body">` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">100</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">JL</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">Japan Airlines</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">JPY</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">http://www.jal.co.jp</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `      <tr class="body">` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">100</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">NW</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">Northwest Airlines</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">USD</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">http://www.nwa.com</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `      <tr class="body">` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">100</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">QF</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">Qantas Airways</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">AUD</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">http://www.qantas.com.au</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `      <tr class="body">` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">100</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">SA</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">South African Air.</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">ZAR</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">http://www.saa.co.za</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `      <tr class="body">` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">100</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">SQ</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">Singapore Airlines</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">SGD</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">http://www.singaporeair.com</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `      <tr class="body">` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">100</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">SR</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">Swiss</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">CHF</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">http://www.swiss.com</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `      <tr class="body">` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">100</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">UA</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">United Airlines</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">USD</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `        <td>` && |\n|  &&
                    `          <span class="nprpnwrp">http://www.ual.com</span>` && |\n|  &&
                    `        </td>` && |\n|  &&
                    `      </tr>` && |\n|  &&
                    `    </table>` && |\n|  &&
                    `    <br>` && |\n|  &&
                    `    <p>` && |\n|  &&
                    `      <span class="heading1">XML</span>` && |\n|  &&
                    `    </p>` && |\n|  &&
                    `    <p>` && |\n|  &&
                    `      <span class="nonprop">&lt;asx:abap version="1.0" xmlns:asx="http://www.sap.com/abapxml"&gt;` && |\n|  &&
                    ` &lt;asx:values&gt;` && |\n|  &&
                    `  &lt;CARRIERS&gt;` && |\n|  &&
                    `   &lt;SCARR&gt;` && |\n|  &&
                    `    &lt;MANDT&gt;100&lt;/MANDT&gt;` && |\n|  &&
                    `    &lt;CARRID&gt;AA&lt;/CARRID&gt;` && |\n|  &&
                    `    &lt;CARRNAME&gt;American Airlines&lt;/CARRNAME&gt;` && |\n|  &&
                    `    &lt;CURRCODE&gt;USD&lt;/CURRCODE&gt;` && |\n|  &&
                    `    &lt;URL&gt;http://www.aa.com&lt;/URL&gt;` && |\n|  &&
                    `   &lt;/SCARR&gt;` && |\n|  &&
                    `   &lt;SCARR&gt;` && |\n|  &&
                    `    &lt;MANDT&gt;100&lt;/MANDT&gt;` && |\n|  &&
                    `    &lt;CARRID&gt;AC&lt;/CARRID&gt;` && |\n|  &&
                    `    &lt;CARRNAME&gt;Air Canada&lt;/CARRNAME&gt;` && |\n|  &&
                    `    &lt;CURRCODE&gt;CAD&lt;/CURRCODE&gt;` && |\n|  &&
                    `    &lt;URL&gt;http://www.aircanada.ca&lt;/URL&gt;` && |\n|  &&
                    `   &lt;/SCARR&gt;` && |\n|  &&
                    `   &lt;SCARR&gt;` && |\n|  &&
                    `    &lt;MANDT&gt;100&lt;/MANDT&gt;` && |\n|  &&
                    `    &lt;CARRID&gt;AF&lt;/CARRID&gt;` && |\n|  &&
                    `    &lt;CARRNAME&gt;Air France&lt;/CARRNAME&gt;` && |\n|  &&
                    `    &lt;CURRCODE&gt;EUR&lt;/CURRCODE&gt;` && |\n|  &&
                    `    &lt;URL&gt;http://www.airfrance.fr&lt;/URL&gt;` && |\n|  &&
                    `   &lt;/SCARR&gt;` && |\n|  &&
                    `   &lt;SCARR&gt;` && |\n|  &&
                    `    &lt;MANDT&gt;100&lt;/MANDT&gt;` && |\n|  &&
                    `    &lt;CARRID&gt;AZ&lt;/CARRID&gt;` && |\n|  &&
                    `    &lt;CARRNAME&gt;Alitalia&lt;/CARRNAME&gt;` && |\n|  &&
                    `    &lt;CURRCODE&gt;EUR&lt;/CURRCODE&gt;` && |\n|  &&
                    `    &lt;URL&gt;http://www.alitalia.it&lt;/URL&gt;` && |\n|  &&
                    `   &lt;/SCARR&gt;` && |\n|  &&
                    `   &lt;SCARR&gt;` && |\n|  &&
                    `    &lt;MANDT&gt;100&lt;/MANDT&gt;` && |\n|  &&
                    `    &lt;CARRID&gt;BA&lt;/CARRID&gt;` && |\n|  &&
                    `    &lt;CARRNAME&gt;British Airways&lt;/CARRNAME&gt;` && |\n|  &&
                    `    &lt;CURRCODE&gt;GBP&lt;/CURRCODE&gt;` && |\n|  &&
                    `    &lt;URL&gt;http://www.british-airways.com&lt;/URL&gt;` && |\n|  &&
                    `   &lt;/SCARR&gt;` && |\n|  &&
                    `   &lt;SCARR&gt;` && |\n|  &&
                    `    &lt;MANDT&gt;100&lt;/MANDT&gt;` && |\n|  &&
                    `    &lt;CARRID&gt;FJ&lt;/CARRID&gt;` && |\n|  &&
                    `    &lt;CARRNAME&gt;Air Pacific&lt;/CARRNAME&gt;` && |\n|  &&
                    `    &lt;CURRCODE&gt;USD&lt;/CURRCODE&gt;` && |\n|  &&
                    `    &lt;URL&gt;http://www.airpacific.com&lt;/URL&gt;` && |\n|  &&
                    `   &lt;/SCARR&gt;` && |\n|  &&
                    `   &lt;SCARR&gt;` && |\n|  &&
                    `    &lt;MANDT&gt;100&lt;/MANDT&gt;` && |\n|  &&
                    `    &lt;CARRID&gt;CO&lt;/CARRID&gt;` && |\n|  &&
                    `    &lt;CARRNAME&gt;Continental Airlines&lt;/CARRNAME&gt;` && |\n|  &&
                    `    &lt;CURRCODE&gt;USD&lt;/CURRCODE&gt;` && |\n|  &&
                    `    &lt;URL&gt;http://www.continental.com&lt;/URL&gt;` && |\n|  &&
                    `   &lt;/SCARR&gt;` && |\n|  &&
                    `   &lt;SCARR&gt;` && |\n|  &&
                    `    &lt;MANDT&gt;100&lt;/MANDT&gt;` && |\n|  &&
                    `    &lt;CARRID&gt;DL&lt;/CARRID&gt;` && |\n|  &&
                    `    &lt;CARRNAME&gt;Delta Airlines&lt;/CARRNAME&gt;` && |\n|  &&
                    `    &lt;CURRCODE&gt;USD&lt;/CURRCODE&gt;` && |\n|  &&
                    `    &lt;URL&gt;http://www.delta-air.com&lt;/URL&gt;` && |\n|  &&
                    `   &lt;/SCARR&gt;` && |\n|  &&
                    `   &lt;SCARR&gt;` && |\n|  &&
                    `    &lt;MANDT&gt;100&lt;/MANDT&gt;` && |\n|  &&
                    `    &lt;CARRID&gt;AB&lt;/CARRID&gt;` && |\n|  &&
                    `    &lt;CARRNAME&gt;Air Berlin&lt;/CARRNAME&gt;` && |\n|  &&
                    `    &lt;CURRCODE&gt;EUR&lt;/CURRCODE&gt;` && |\n|  &&
                    `    &lt;URL&gt;http://www.airberlin.de&lt;/URL&gt;` && |\n|  &&
                    `   &lt;/SCARR&gt;` && |\n|  &&
                    `   &lt;SCARR&gt;` && |\n|  &&
                    `    &lt;MANDT&gt;100&lt;/MANDT&gt;` && |\n|  &&
                    `    &lt;CARRID&gt;LH&lt;/CARRID&gt;` && |\n|  &&
                    `    &lt;CARRNAME&gt;Lufthansa&lt;/CARRNAME&gt;` && |\n|  &&
                    `    &lt;CURRCODE&gt;EUR&lt;/CURRCODE&gt;` && |\n|  &&
                    `    &lt;URL&gt;http://www.lufthansa.com&lt;/URL&gt;` && |\n|  &&
                    `   &lt;/SCARR&gt;` && |\n|  &&
                    `   &lt;SCARR&gt;` && |\n|  &&
                    `    &lt;MANDT&gt;100&lt;/MANDT&gt;` && |\n|  &&
                    `    &lt;CARRID&gt;NG&lt;/CARRID&gt;` && |\n|  &&
                    `    &lt;CARRNAME&gt;Lauda Air&lt;/CARRNAME&gt;` && |\n|  &&
                    `    &lt;CURRCODE&gt;EUR&lt;/CURRCODE&gt;` && |\n|  &&
                    `    &lt;URL&gt;http://www.laudaair.com&lt;/URL&gt;` && |\n|  &&
                    `   &lt;/SCARR&gt;` && |\n|  &&
                    `   &lt;SCARR&gt;` && |\n|  &&
                    `    &lt;MANDT&gt;100&lt;/MANDT&gt;` && |\n|  &&
                    `    &lt;CARRID&gt;JL&lt;/CARRID&gt;` && |\n|  &&
                    `    &lt;CARRNAME&gt;Japan Airlines&lt;/CARRNAME&gt;` && |\n|  &&
                    `    &lt;CURRCODE&gt;JPY&lt;/CURRCODE&gt;` && |\n|  &&
                    `    &lt;URL&gt;http://www.jal.co.jp&lt;/URL&gt;` && |\n|  &&
                    `   &lt;/SCARR&gt;` && |\n|  &&
                    `   &lt;SCARR&gt;` && |\n|  &&
                    `    &lt;MANDT&gt;100&lt;/MANDT&gt;` && |\n|  &&
                    `    &lt;CARRID&gt;NW&lt;/CARRID&gt;` && |\n|  &&
                    `    &lt;CARRNAME&gt;Northwest Airlines&lt;/CARRNAME&gt;` && |\n|  &&
                    `    &lt;CURRCODE&gt;USD&lt;/CURRCODE&gt;` && |\n|  &&
                    `    &lt;URL&gt;http://www.nwa.com&lt;/URL&gt;` && |\n|  &&
                    `   &lt;/SCARR&gt;` && |\n|  &&
                    `   &lt;SCARR&gt;` && |\n|  &&
                    `    &lt;MANDT&gt;100&lt;/MANDT&gt;` && |\n|  &&
                    `    &lt;CARRID&gt;QF&lt;/CARRID&gt;` && |\n|  &&
                    `    &lt;CARRNAME&gt;Qantas Airways&lt;/CARRNAME&gt;` && |\n|  &&
                    `    &lt;CURRCODE&gt;AUD&lt;/CURRCODE&gt;` && |\n|  &&
                    `    &lt;URL&gt;http://www.qantas.com.au&lt;/URL&gt;` && |\n|  &&
                    `   &lt;/SCARR&gt;` && |\n|  &&
                    `   &lt;SCARR&gt;` && |\n|  &&
                    `    &lt;MANDT&gt;100&lt;/MANDT&gt;` && |\n|  &&
                    `    &lt;CARRID&gt;SA&lt;/CARRID&gt;` && |\n|  &&
                    `    &lt;CARRNAME&gt;South African Air.&lt;/CARRNAME&gt;` && |\n|  &&
                    `    &lt;CURRCODE&gt;ZAR&lt;/CURRCODE&gt;` && |\n|  &&
                    `    &lt;URL&gt;http://www.saa.co.za&lt;/URL&gt;` && |\n|  &&
                    `   &lt;/SCARR&gt;` && |\n|  &&
                    `   &lt;SCARR&gt;` && |\n|  &&
                    `    &lt;MANDT&gt;100&lt;/MANDT&gt;` && |\n|  &&
                    `    &lt;CARRID&gt;SQ&lt;/CARRID&gt;` && |\n|  &&
                    `    &lt;CARRNAME&gt;Singapore Airlines&lt;/CARRNAME&gt;` && |\n|  &&
                    `    &lt;CURRCODE&gt;SGD&lt;/CURRCODE&gt;` && |\n|  &&
                    `    &lt;URL&gt;http://www.singaporeair.com&lt;/URL&gt;` && |\n|  &&
                    `   &lt;/SCARR&gt;` && |\n|  &&
                    `   &lt;SCARR&gt;` && |\n|  &&
                    `    &lt;MANDT&gt;100&lt;/MANDT&gt;` && |\n|  &&
                    `    &lt;CARRID&gt;SR&lt;/CARRID&gt;` && |\n|  &&
                    `    &lt;CARRNAME&gt;Swiss&lt;/CARRNAME&gt;` && |\n|  &&
                    `    &lt;CURRCODE&gt;CHF&lt;/CURRCODE&gt;` && |\n|  &&
                    `    &lt;URL&gt;http://www.swiss.com&lt;/URL&gt;` && |\n|  &&
                    `   &lt;/SCARR&gt;` && |\n|  &&
                    `   &lt;SCARR&gt;` && |\n|  &&
                    `    &lt;MANDT&gt;100&lt;/MANDT&gt;` && |\n|  &&
                    `    &lt;CARRID&gt;UA&lt;/CARRID&gt;` && |\n|  &&
                    `    &lt;CARRNAME&gt;United Airlines&lt;/CARRNAME&gt;` && |\n|  &&
                    `    &lt;CURRCODE&gt;USD&lt;/CURRCODE&gt;` && |\n|  &&
                    `    &lt;URL&gt;http://www.ual.com&lt;/URL&gt;` && |\n|  &&
                    `   &lt;/SCARR&gt;` && |\n|  &&
                    `  &lt;/CARRIERS&gt;` && |\n|  &&
                    ` &lt;/asx:values&gt;` && |\n|  &&
                    `&lt;/asx:abap&gt;</span>` && |\n|  &&
                    `    </p>` && |\n|  &&
                    `  </body>` && |\n|  &&
                    `</html>`.



    DATA(view2) = z2ui5_cl_xml_view=>factory( ).
    view2->shell(
          )->page(
              title          = `abap2UI5 - CL_DEMO_OUTPUT`
              navbuttonpress = client->_event_nav_app_leave( )
              shownavbutton  = client->check_app_prev_stack( )
          )->_cc_plain_xml( lv_style2
          )->html( lv_html2 ).

    client->view_display( view2->stringify( ) ).

  ENDMETHOD.

ENDCLASS.
