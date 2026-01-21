class /exedminb/cl_nfe_inb_processor definition
  public
  for behavior of /exedminb/i_nfemonitorh.

  public section.
    types: begin of y_fields_chngs_header,
             id        type /exedminb/t_nfeheader-Id,
             atividade type /exedminb/t_nfeheader-atividade,
             cStat     type /EXEDMINB/T_NFEProtocolo-cStat,
           end of y_fields_chngs_header.

    types: y_data_itens_div type table of /exedminb/i_nfeitemdiv.
    types: y_data_itens type table of /EXEDMINB/I_NFeMonitorI.
    types: y_data_header type table of /EXEDMINB/I_NFeMonitorH.
    types: y_keys_header type table for read import /exedminb/i_nfemonitorh.
    types: y_keys_itens type table for read import /exedminb/i_nfemonitori.
    types: y_dividir_itens_key type table for action import /exedminb/i_nfemonitori~dividir.
    types: y_eliminar_itens_key type table for action import /exedminb/i_nfemonitori~eliminar.
    types: yt_failed type response for failed early /exedminb/i_nfemonitorh.
    types: yt_resported type response for reported early /exedminb/i_nfemonitorh.
    types: yt_mapped type response for mapped early /exedminb/i_nfemonitorh.


    methods dividir_item importing it_keys  type y_dividir_itens_key
                         changing  mapped   type yt_mapped
                                   failed   type yt_failed
                                   reported type yt_resported .
    methods eliminar_item importing it_keys type y_eliminar_itens_key.
    methods executar_migo importing is_header type /exedminb/i_nfemonitorh
                                    it_items  type y_data_itens
                          changing  mapped    type yt_mapped
                                    failed    type yt_failed
                                    reported  type yt_resported.
    methods executar_miro importing is_header type /exedminb/i_nfemonitorh
                                    it_items  type y_data_itens
                          changing  mapped    type yt_mapped
                                    failed    type yt_failed
                                    reported  type yt_resported.

    methods executar_processo importing is_header             type /exedminb/i_nfemonitorh
                              changing  it_items              type y_data_itens
                                        mapped                type yt_mapped
                                        failed                type yt_failed
                                        reported              type yt_resported
                              returning value(header_changed) type y_fields_chngs_header.
