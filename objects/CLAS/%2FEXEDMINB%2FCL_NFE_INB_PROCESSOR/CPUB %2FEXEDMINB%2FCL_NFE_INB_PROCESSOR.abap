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

     types: tt_nfeheader    type standard table of /EXEDMINB/t_nfeheader,
            tt_nfeissue     type standard table of /EXEDMINB/t_nfeissuer,
            tt_nfeissueaddr type standard table of /EXEDMINB/t_nfeissueraddr,
            tt_nferecip     type standard table of /EXEDMINB/t_nferecipient,
            tt_nferecipaddr type standard table of /EXEDMINB/t_nferecipaddr,
            tt_nfeitem      type standard table of /EXEDMINB/t_nfeitem,
            tt_icms00       type standard table of /EXEDMINB/t_nfetaxicms00,
            tt_icms02       type standard table of /EXEDMINB/t_nfetaxicms02,
            tt_icms10       type standard table of /EXEDMINB/t_nfetaxicms10,
            tt_icms15       type standard table of /EXEDMINB/t_nfetaxicms15,
            tt_icms20       type standard table of /EXEDMINB/t_nfetaxicms20,
            tt_icms30       type standard table of /EXEDMINB/t_nfetaxicms30,
            tt_icms40       type standard table of /EXEDMINB/t_nfetaxicms40,
            tt_icms51       type standard table of /EXEDMINB/t_nfetaxicms51,
            tt_icms53       type standard table of /EXEDMINB/t_nfetaxicms53,
            tt_icms60       type standard table of /EXEDMINB/t_nfetaxicms60,
            tt_icms61       type standard table of /EXEDMINB/t_nfetaxicms61,
            tt_icms70       type standard table of /EXEDMINB/t_nfetaxicms70,
            tt_icms90       type standard table of /EXEDMINB/t_nfetaxicms90,
            tt_icmsst       type standard table of /EXEDMINB/t_nfetaxicmsst,
            tt_icmspart     type standard table of /EXEDMINB/t_nfetxicmspart,
            tt_ii           type standard table of /EXEDMINB/t_nfetaxii,
            tt_ipi          type standard table of /EXEDMINB/t_nfetaxipi,
            tt_cofins       type standard table of /EXEDMINB/t_nfetaxcofins,
            tt_pis          type standard table of /EXEDMINB/t_nfetaxpis,
            tt_pisst        type standard table of /EXEDMINB/t_nfetaxpisst,
            tt_cofinsst     type standard table of /EXEDMINB/t_nfetxcofinsst,
            tt_icmsufdest   type standard table of /EXEDMINB/t_nfeicmsufdest,
            tt_icmstax_tot  type standard table of /EXEDMINB/t_nfeicmstaxTot,
            tt_transp       type standard table of /EXEDMINB/t_nfetransport,
            tt_carrier      type standard table of /EXEDMINB/t_nfecarrier,
            tt_rettransp    type standard table of /EXEDMINB/t_nfetranspret,
            tt_veh          type standard table of /EXEDMINB/t_nfetranspveh,
            tt_tow          type standard table of /EXEDMINB/t_nfetransptow,
            tt_vol          type standard table of /EXEDMINB/t_nfetranspvol,
            tt_seal         type standard table of /EXEDMINB/t_securityseal,
            tt_invoice      type standard table of /EXEDMINB/t_nfeinvoice,
            tt_install      type standard table of /EXEDMINB/t_nfeinstallm,
            tt_payment      type standard table of /EXEDMINB/t_nfepayment,
            tt_paycard      type standard table of /EXEDMINB/t_paymentcard,
            tt_addinform    type standard table of /EXEDMINB/t_nfeaddinform,
            tt_taxinform    type standard table of /EXEDMINB/t_nfetaxinform,
            tt_txpayerinf   type standard table of /EXEDMINB/t_nfetxpayerinf,
            tt_legprocref   type standard table of /EXEDMINB/t_nfelegprocref,
            tt_nfeprot      type standard table of /EXEDMINB/t_nfeprotocolo.


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

     methods revalida_autorizacao importing iv_chave        type /exedminb/i_nfemonitorh-ChaveNFe
                                            is_busca_status type abap_boolean
                                  changing  cv_cStatus      type /EXEDMINB/T_NFEProtocolo-cStat
                                            mapped          type yt_mapped
                                            failed          type yt_failed
                                            reported        type yt_resported.

     methods Validacao_Geral importing is_header               type /exedminb/i_nfemonitorh
                                       it_items                type y_data_itens
                             changing  mapped                  type yt_mapped
                                       failed                  type yt_failed
                                       reported                type yt_resported
                             returning value(itens_sem_pedido) type abap_boolean.

     methods determina_empresa changing cs_header type /exedminb/i_nfemonitorh
                                        mapped    type yt_mapped
                                        failed    type yt_failed
                                        reported  type yt_resported.

     methods cria_delivery.

     methods inicializar_novas_nfs
       importing
         it_nfeheader    type tt_nfeheader
         it_nfeissue     type tt_nfeissue
         it_nfeissueaddr type tt_nfeissueaddr
         it_nferecip     type tt_nferecip
         it_nferecipaddr type tt_nferecipaddr
         it_nfeitem      type tt_nfeitem
         it_icms00       type tt_icms00
         it_icms02       type tt_icms02
         it_icms10       type tt_icms10
         it_icms15       type tt_icms15
         it_icms20       type tt_icms20
         it_icms30       type tt_icms30
         it_icms40       type tt_icms40
         it_icms51       type tt_icms51
         it_icms53       type tt_icms53
         it_icms60       type tt_icms60
         it_icms61       type tt_icms61
         it_icms70       type tt_icms70
         it_icms90       type tt_icms90
         it_icmsst       type tt_icmsst
         it_icmspart     type tt_icmspart
         it_ii           type tt_ii
         it_ipi          type tt_ipi
         it_cofins       type tt_cofins
         it_pis          type tt_pis
         it_pisst        type tt_pisst
         it_cofinsst     type tt_cofinsst
         it_icmsufdest   type tt_icmsufdest
         it_icmstax_tot  type tt_icmstax_tot
         it_transp       type tt_transp
         it_carrier      type tt_carrier
         it_rettransp    type tt_rettransp
         it_veh          type tt_veh
         it_tow          type tt_tow
         it_vol          type tt_vol
         it_seal         type tt_seal
         it_invoice      type tt_invoice
         it_install      type tt_install
         it_payment      type tt_payment
         it_paycard      type tt_paycard
         it_addinform    type tt_addinform
         it_taxinform    type tt_taxinform
         it_txpayerinf   type tt_txpayerinf
         it_legprocref   type tt_legprocref
         it_nfeprot      type tt_nfeprot.


     methods map_nfeh_tables_to_entity importing i_nfeheader     type /exedminb/t_nfeheader
                                                 i_nfeissuer     type /EXEDMINB/t_NFEISSUER
                                                 i_nferecipient  type /exedminb/t_nferecipient
                                                 i_nfeicmstaxtot type /EXEDMINB/t_NFEICMSTAXTOT
                                                 i_NFEProtocolo  type /EXEDMINB/T_NFEProtocolo
                                       returning value(r_entity) type /exedminb/i_nfemonitorh.

     methods map_entity_to_nfeh_tables
       importing
         i_entity        type /exedminb/i_nfemonitorh
       exporting
         e_nfeheader     type /exedminb/t_nfeheader
         e_nfeissuer     type /EXEDMINB/t_NFEISSUER
         e_nferecipient  type /exedminb/t_nferecipient
         e_nfeicmstaxtot type /EXEDMINB/t_NFEICMSTAXTOT
         e_NFEProtocolo  type /EXEDMINB/T_NFEProtocolo.

     methods map_nfei_tables_to_entity importing i_nfeitem    type tt_nfeitem
                                                 i_icms00     type tt_icms00
                                                 i_icms02     type tt_icms02
                                                 i_icms10     type tt_icms10
                                                 i_icms15     type tt_icms15
                                                 i_icms20     type tt_icms20
                                                 i_icms30     type tt_icms30
                                                 i_icms40     type tt_icms40
                                                 i_icms51     type tt_icms51
                                                 i_icms53     type tt_icms53
                                                 i_icms60     type tt_icms60
                                                 i_icms61     type tt_icms61
                                                 i_icms70     type tt_icms70
                                                 i_icms90     type tt_icms90
                                                 i_icmsst     type tt_icmsst
                                                 i_icmspart   type tt_icmspart
                                                 i_ipi        type tt_ipi
                                                 i_ii         type tt_ii
                                                 i_pis        type tt_pis
                                                 i_pisst      type tt_pisst
                                                 i_cofins     type tt_cofins
                                                 i_cofinsst   type tt_cofinsst
                                                 i_icmsufdest type tt_icmsufdest
                                       exporting e_entity     type y_data_itens.
