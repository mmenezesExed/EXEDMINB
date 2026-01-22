  method if_oo_adt_classrun~main.

    data: lv_xml_string     type string,
          lv_xml_xstring    type xstring,
          lv_time           type t,
          lv_startTime      type t,
          lv_startEntryDate type ty_iso8601_z,
          lv_endEntryDate   type ty_iso8601_z,
          lv_status         type i.

    data(lv_date) = cl_abap_context_info=>get_system_date( ).
    lv_time = cl_abap_context_info=>get_system_time( ) - 10800.

    lv_startTime = lv_time - 3600.

    lv_startEntryDate = |{ lv_date(4) }-{ lv_date+4(2) }-{ lv_date+6(2) }T{ lv_startTime(2) }:{ lv_startTime+2(2) }:{ lv_startTime+4(2) }.000Z|.
    lv_endEntryDate = |{ lv_date(4) }-{ lv_date+4(2) }-{ lv_date+6(2) }T{ lv_time(2) }:{ lv_time+2(2) }:{ lv_time+4(2) }.000Z|.

    "Buscar lista de Nfe/XML
    get_nfe_xml_list( exporting i_nfeModel       = '55'
                                i_startEntryDate = lv_startEntryDate
                                i_endEntryDate   = lv_endEntryDate
                      importing e_xml_string     = lv_xml_string
                                e_xml_xstring    = lv_xml_xstring
                                e_status         = lv_status ).

    "Extrair a estrutura do XML e salvar nas tabelas
    if lv_xml_xstring is not initial AND lv_status EQ 200.
      extract_xml_save( exporting i_xml_xstring = lv_xml_xstring ).
    endif.

  endmethod.