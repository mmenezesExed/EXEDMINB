  method initialize.

*    DATA: lv_xml_string  TYPE string,
*          lv_xml_xstring TYPE xstring,
*          lv_json_string TYPE string,
*          lv_json        TYPE REF TO if_json_reader,
*          lv_pdf         TYPE string.
*
*    "Buscar Nfe
*    get_nfe( EXPORTING i_accessKey   = '35250944916018000103550550000053431260766507'
*             IMPORTING e_json_string = lv_json_string
*                       e_json        = lv_json ).
*
*    "Buscar Nfe Event
*    get_nfe_event( EXPORTING i_accessKey   = '35250944916018000103550550000053431260766507'
*                   IMPORTING e_json_string = lv_json_string ).
*
*    "Buscar Nfe PDF
*    get_nfe_pdf( EXPORTING i_accessKey   = '35250944916018000103550550000053431260766507'
*                 IMPORTING e_pdf         = lv_pdf ).
*
*    "Buscar Nfe Correction
*    get_nfe_correction( EXPORTING i_correctionId   = '35250944916018000103550550000053431260766507'
*                        IMPORTING e_xml_string     = lv_xml_string
*                                  e_xml_xstring    = lv_xml_xstring ).
*
*
*    "Buscar XML de uma Nfe
*    get_nfe_xml( EXPORTING i_accessKey   = '35250944916018000103550550000053431260766507'
*                 IMPORTING e_xml_string  = lv_xml_string
*                           e_xml_xstring = lv_xml_xstring ).
*
*    "Buscar lista de Nfe/XML
*    get_nfe_xml_list( EXPORTING i_nfeModel       = '55'
*                                i_startEntryDate = '2025-08-16T14:48:27.016Z'
*                                i_endEntryDate   = '2025-09-16T14:48:27.016Z'
*                      IMPORTING e_xml_string  = lv_xml_string
*                                e_xml_xstring = lv_xml_xstring ).
*
*    "Extrair a estrutura do XML e salvar nas tabelas
*    extract_xml_save( EXPORTING i_xml_xstring = lv_xml_xstring ).

  endmethod.