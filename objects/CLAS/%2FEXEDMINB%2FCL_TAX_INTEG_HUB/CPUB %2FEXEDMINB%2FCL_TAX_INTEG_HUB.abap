class /exedminb/cl_tax_integ_hub definition
  public
  final
  create public .

  public section.

    interfaces if_oo_adt_classrun .
    interfaces if_apj_dt_exec_object .
    interfaces if_apj_rt_exec_object .

    types: ty_nfe_model type c length 2,
           ty_iso8601_z type c length 24.

    constants:
      cc_comm_scenario         type if_com_management=>ty_cscn_id            value '/EXEDMINB/TAX_INTEGRATION_HUB',
      cc_comm_system           type if_com_management=>ty_cs_id              value 'CS_CLOUD_INTEGRATION',
      cc_srv_id_nfe_xml_list   type if_com_management=>ty_cscn_outb_srv_id   value '/EXEDMINB/GET_NFE_XML_LIST_REST',
      cc_srv_id_nfe_xml        type if_com_management=>ty_cscn_outb_srv_id   value '/EXEDMINB/GET_NFE_XML_REST',
      cc_srv_id_nfe_event      type if_com_management=>ty_cscn_outb_srv_id   value '/EXEDMINB/GET_NFE_EVENT_REST',
      cc_srv_id_nfe            type if_com_management=>ty_cscn_outb_srv_id   value '/EXEDMINB/GET_NFE_REST',
      cc_srv_id_nfe_pdf        type if_com_management=>ty_cscn_outb_srv_id   value '/EXEDMINB/GET_NFE_PDF_REST',
      cc_srv_id_nfe_correction type if_com_management=>ty_cscn_outb_srv_id   value '/EXEDMINB/GET_NFE_CORRECTION_REST'.

    "Buscar XML de uma Nfe
    class-methods get_nfe_xml importing i_accessKey   type string
                              exporting e_xml_string  type string
                                        e_xml_xstring type xstring.

    "Buscar lista de Nfe/XML
    class-methods get_nfe_xml_list importing i_nfeModel       type ty_nfe_model optional
                                             i_startEntryDate type ty_iso8601_z optional
                                             i_endEntryDate   type ty_iso8601_z optional
                                   exporting e_xml_string     type string
                                             e_xml_xstring    type xstring
                                             e_status         type i.

    "Buscar Nfe
    class-methods get_nfe     importing i_accessKey   type string
                              exporting e_json_string type string
                                        e_json        type ref to if_json_reader.

    "Buscar Nfe PDF
    class-methods get_nfe_pdf importing i_accessKey type string
                              exporting e_pdf       type string.

    "Buscar Nfe Correction
    class-methods get_nfe_correction importing i_correctionId type string
                                     exporting e_xml_string   type string
                                               e_xml_xstring  type xstring.

    "Buscar Nfe Event
    class-methods get_nfe_event importing i_accessKey   type string
                                exporting e_json_string type string.

    "Extrair a estrutura do XML e salvar nas tabelas
    class-methods extract_xml_save importing i_xml_xstring type xstring.

    "Busca status nfe
    class-methods extract_status_xml importing i_xml_xstring type xstring
                                     returning value(cstat)  type /EXEDMINB/T_NFEProtocolo-cStat.
