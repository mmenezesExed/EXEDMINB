   method inicializar_novas_nfs.
     data: failed   type yt_failed,
           reported type yt_resported,
           mapped   type yt_mapped.

     data lt_nfeitem type tt_nfeitem.
     data lt_historico type table of /exedminb/i_historico.

     lt_nfeitem = it_nfeitem.

     me->map_nfei_tables_to_entity(
       exporting
         i_nfeitem    = it_nfeitem
         i_icms00     = it_icms00
         i_icms02     = it_icms02
         i_icms10     = it_icms10
         i_icms15     = it_icms15
         i_icms20     = it_icms20
         i_icms30     = it_icms30
         i_icms40     = it_icms40
         i_icms51     = it_icms51
         i_icms53     = it_icms53
         i_icms60     = it_icms60
         i_icms61     = it_icms61
         i_icms70     = it_icms70
         i_icms90     = it_icms90
         i_icmsst     = it_icmsst
         i_icmspart   = it_icmspart
         i_ipi        = it_ipi
         i_ii         = it_ii
         i_pis        = it_pis
         i_pisst      = it_pisst
         i_cofins     = it_cofins
         i_cofinsst   = it_cofinsst
         i_icmsufdest = it_icmsufdest
       importing
         e_entity     = data(lt_nfemonitori)
     ).

     if it_nfeheader is not initial.
       data lt_final_nfeheader type tt_nfeheader.

       select id from /EXEDMINB/t_nfeheader
         for all entries in @it_nfeheader
         where id eq @it_nfeheader-Id
         into table @data(lt_nfe_ja_registrada).

       loop at it_nfeheader into data(ls_nfeheader).
         if lines( lt_nfe_ja_registrada ) gt 0 and
            line_exists( lt_nfe_ja_registrada[ id = ls_nfeheader-Id ] ).
           delete lt_nfeitem where id = ls_nfeheader-Id.

           continue.
         endif.

         append ls_nfeheader to lt_final_nfeheader assigning field-symbol(<f_nfeheader>).

         append value #( IdNFe = <f_nfeheader>-Id
                         Etapa = 0001
                         Status = 3
                         Descricao = lcl_tools=>new_message(
                                       number   = 100
                                       severity = lcl_tools=>ms-success
                                     )->if_message~get_text( ) ) to lt_historico.

         <f_nfeheader>-processo = 'Compra de Material'.
         <f_nfeheader>-atividade = 100.

         "Valida Status NF
         if line_exists( it_nfeprot[ Id = <f_nfeheader>-Id ] ).
           if it_nfeprot[ Id = <f_nfeheader>-Id ]-cStat = '100'.
             "NF liberada
             <f_nfeheader>-statusProc = 3.
             append value #( IdNFe = <f_nfeheader>-Id
                             Etapa = <f_nfeheader>-atividade
                             Status = <f_nfeheader>-statusProc
                             Descricao = lcl_tools=>new_message(
                                                     number   = 101
                                                     severity = lcl_tools=>ms-success
                                         )->if_message~get_text( ) ) to lt_historico.

           else.
             "NF não está liberada
             <f_nfeheader>-statusProc = 1.
             append value #( IdNFe = <f_nfeheader>-Id
                             Etapa = <f_nfeheader>-atividade
                             Status = <f_nfeheader>-statusProc
                             Descricao = lcl_tools=>new_message(
                                                     number   = 001
                                                     severity = lcl_tools=>ms-error
                                         )->if_message~get_text( ) ) to lt_historico.
           endif.

         else.
           "Não foi possivel determinar o status da NF
           <f_nfeheader>-statusProc = 1.
           append value #( IdNFe = <f_nfeheader>-Id
                           Etapa = <f_nfeheader>-atividade
                           Status = <f_nfeheader>-statusProc
                           Descricao = lcl_tools=>new_message(
                                                   number   = 001
                                                   severity = lcl_tools=>ms-error
                                       )->if_message~get_text( ) ) to lt_historico.
         endif.


         check <f_nfeheader>-statusProc = 3.

         <f_nfeheader>-atividade = 200.
         data(ls_nfemonitorh) = me->map_nfeh_tables_to_entity( i_nfeheader = <f_nfeheader>
                                                               i_nfeissuer = cond #( when line_exists( it_nfeissue[ id = <f_nfeheader>-Id ] ) then it_nfeissue[ id = <f_nfeheader>-Id ] )
                                                               i_nferecipient = cond #( when line_exists( it_nferecip[ id = <f_nfeheader>-Id ] ) then it_nferecip[ id = <f_nfeheader>-Id ] )
                                                               i_nfeicmstaxtot = cond #( when line_exists( it_icmstax_tot[ id = <f_nfeheader>-Id ] ) then it_icmstax_tot[ id = <f_nfeheader>-Id ] )
                                                               i_nfeprotocolo = cond #( when line_exists( it_nfeprot[ id = <f_nfeheader>-Id ] ) then it_nfeprot[ id = <f_nfeheader>-Id ] ) ).


         "Determina Empresa e Local de negocio a partir do destinario
         clear: failed, mapped, reported.
         me->determina_empresa( changing cs_header = ls_nfemonitorh
                                         mapped    = mapped
                                         failed    = failed
                                         reported  = reported ).

         if failed-_nfemonitorh is not initial.
           <f_nfeheader>-statusProc = 1.
           lt_historico = value #( base lt_historico
                                   for line in reported-_nfemonitorh
                                   ( IdNFe = <f_nfeheader>-Id
                                     Etapa = <f_nfeheader>-atividade
                                     Status = <f_nfeheader>-statusProc
                                     Descricao = line-%msg->if_message~get_text( ) ) ).
         endif.


         check <f_nfeheader>-statusProc = 3.


         ""Atribução Pedido/Item (validacao_geral)
         clear: failed, mapped, reported.

         data(itens_sem_pedido) = me->validacao_geral(
           exporting
             is_header = ls_nfemonitorh
             it_items  = value #( for item in lt_nfemonitori where ( ChaveNFe = <f_nfeheader>-Id ) ( item ) )
           changing
             mapped    = mapped
             failed    = failed
             reported  = reported
         ).

         if failed-_nfemonitorh is not initial.
           <f_nfeheader>-statusProc = 1.
           lt_historico = value #( base lt_historico
                                   for line in reported-_nfemonitorh
                                   ( IdNFe = <f_nfeheader>-Id
                                     Etapa = <f_nfeheader>-atividade
                                     Status = <f_nfeheader>-statusProc
                                     Descricao = line-%msg->if_message~get_text( ) ) ).

         elseif itens_sem_pedido eq abap_true.
           <f_nfeheader>-statusProc = 2.
           append value #( IdNFe = <f_nfeheader>-Id
                           Etapa = <f_nfeheader>-atividade
                           Status = <f_nfeheader>-statusProc
                           Descricao = lcl_tools=>new_message(
                                                   number   = 004
                                                   severity = lcl_tools=>ms-warning
                                       )->if_message~get_text( ) ) to lt_historico.
         endif.

         check <f_nfeheader>-statusProc = 3.

         <f_nfeheader>-atividade = 300.
         append value #( IdNFe = <f_nfeheader>-Id
                         Etapa = <f_nfeheader>-atividade
                         Status = <f_nfeheader>-statusProc
                         Descricao = lcl_tools=>new_message(
                                                  number   = 102
                                                  severity = lcl_tools=>ms-success
                                     )->if_message~get_text( ) ) to lt_historico.

         "Validação Impostos

       endloop.

       modify /EXEDMINB/t_nfeheader from table @lt_final_nfeheader.
     endif.

     if it_nfeissue is not initial.
       modify /EXEDMINB/t_nfeissuer from table @it_nfeissue.
     endif.

     if it_nfeissueaddr is not initial.
       modify /EXEDMINB/t_nfeissueraddr from table @it_nfeissueaddr.
     endif.

     if it_nferecip is not initial.
       modify /EXEDMINB/t_nferecipient from table @it_nferecip.
     endif.

     if it_nferecipaddr is not initial.
       modify /EXEDMINB/t_nferecipaddr from table @it_nferecipaddr.
     endif.

     if it_nfeitem is not initial.
       modify /EXEDMINB/t_nfeitem from table @lt_nfeitem.
     endif.

     if it_icms00 is not initial.
       modify /EXEDMINB/t_nfetaxicms00 from table @it_icms00.
     endif.

     if it_icms02 is not initial.
       modify /EXEDMINB/t_nfetaxicms02 from table @it_icms02.
     endif.

     if it_icms10 is not initial.
       modify /EXEDMINB/t_nfetaxicms10 from table @it_icms10.
     endif.

     if it_icms15 is not initial.
       modify /EXEDMINB/t_nfetaxicms15 from table @it_icms15.
     endif.

     if it_icms20 is not initial.
       modify /EXEDMINB/t_nfetaxicms20 from table @it_icms20.
     endif.

     if it_icms30 is not initial.
       modify /EXEDMINB/t_nfetaxicms30 from table @it_icms30.
     endif.

     if it_icms40 is not initial.
       modify /EXEDMINB/t_nfetaxicms40 from table @it_icms40.
     endif.

     if it_icms51 is not initial.
       modify /EXEDMINB/t_nfetaxicms51 from table @it_icms51.
     endif.

     if it_icms53 is not initial.
       modify /EXEDMINB/t_nfetaxicms53 from table @it_icms53.
     endif.

     if it_icms60 is not initial.
       modify /EXEDMINB/t_nfetaxicms60 from table @it_icms60.
     endif.

     if it_icms61 is not initial.
       modify /EXEDMINB/t_nfetaxicms61 from table @it_icms61.
     endif.

     if it_icms70 is not initial.
       modify /EXEDMINB/t_nfetaxicms70 from table @it_icms70.
     endif.

     if it_icms90 is not initial.
       modify /EXEDMINB/t_nfetaxicms90 from table @it_icms90.
     endif.

     if it_icmsst is not initial.
       modify /EXEDMINB/t_nfetaxicmsst from table @it_icmsst.
     endif.

     if it_icmspart is not initial.
       modify /EXEDMINB/t_nfetxicmspart from table @it_icmspart.
     endif.

     if it_ii is not initial.
       modify /EXEDMINB/t_nfetaxii from table @it_ii.
     endif.

     if it_ipi is not initial.
       modify /EXEDMINB/t_nfetaxipi from table @it_ipi.
     endif.

     if it_cofins is not initial.
       modify /EXEDMINB/t_nfetaxcofins from table @it_cofins.
     endif.

     if it_pis is not initial.
       modify /EXEDMINB/t_nfetaxpis from table @it_pis.
     endif.

     if it_pisst is not initial.
       modify /EXEDMINB/t_nfetaxpisst from table @it_pisst.
     endif.

     if it_cofinsst is not initial.
       modify /EXEDMINB/t_nfetxcofinsst from table @it_cofinsst.
     endif.

     if it_icmsufdest is not initial.
       modify /EXEDMINB/t_nfeicmsufdest from table @it_icmsufdest.
     endif.

     if it_icmstax_tot is not initial.
       modify /EXEDMINB/t_nfeicmstaxTot from table @it_icmstax_tot.
     endif.

     if it_transp is not initial.
       modify /EXEDMINB/t_nfetransport from table @it_transp.
     endif.

     if it_carrier is not initial.
       modify /EXEDMINB/t_nfecarrier from table @it_carrier.
     endif.

     if it_rettransp is not initial.
       modify /EXEDMINB/t_nfetranspret from table @it_rettransp.
     endif.

     if it_veh is not initial.
       modify /EXEDMINB/t_nfetranspveh from table @it_veh.
     endif.

     if it_tow is not initial.
       modify /EXEDMINB/t_nfetransptow from table @it_tow.
     endif.

     if it_vol is not initial.
       modify /EXEDMINB/t_nfetranspvol from table @it_vol.
     endif.

     if it_seal is not initial.
       insert /EXEDMINB/t_securityseal from table @it_seal.
     endif.

     if it_invoice is not initial.
       modify /EXEDMINB/t_nfeinvoice from table @it_invoice.
     endif.

     if it_install is not initial.
       modify /EXEDMINB/t_nfeinstallm from table @it_install.
     endif.

     if it_payment is not initial.
       modify /EXEDMINB/t_nfepayment from table @it_payment.
     endif.

     if it_paycard is not initial.
       modify /EXEDMINB/t_paymentcard from table @it_paycard.
     endif.

     if it_addinform is not initial.
       modify /EXEDMINB/t_nfeaddinform from table @it_addinform.
     endif.

     if it_taxinform is not initial.
       modify /EXEDMINB/t_nfetaxinform from table @it_taxinform.
     endif.

     if it_txpayerinf is not initial.
       modify /EXEDMINB/t_nfetxpayerinf from table @it_txpayerinf.
     endif.

     if it_legprocref is not initial.
       modify /EXEDMINB/t_nfelegprocref from table @it_legprocref.
     endif.

     if it_nfeprot is not initial.
       modify /EXEDMINB/T_NFEProtocolo from table @it_nfeprot.
     endif.

     if lt_historico is not initial.
       modify entities of /exedminb/i_historico
          entity Historico
          create fields ( IdNFe Etapa Status Descricao )
          with value #( for line_hist in lt_historico index into lv_idx ( %cid = |Hist_Reg_{ line_hist-IdNfe }_{ lv_idx }|
                                                                          Id = line_hist-Id
                                                                          IdNfe = line_hist-IdNfe
                                                                          IdHistorico = line_hist-IdHistorico
                                                                          Etapa = line_hist-Etapa
                                                                          Status = line_hist-Status
                                                                          Descricao = line_hist-Descricao ) ).
     endif.

   endmethod.