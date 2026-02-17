"Crud Tabelas NF-e
class lhc_tabs_operations definition.

  public section.
    constants cc_classe_msg type c length 20 value '/EXEDMINB/NFE_MSGS'.
    constants: begin of cc_status,
                 Erro     type string value 'Erro',
                 Pendente type string value 'Pendente',
                 Sucesso  type string value 'Sucesso',
               end of cc_status.

    types: begin of y_item_div_control,
             pedido     type abp_behv_flag,
             itempedido type abp_behv_flag,
             quantidade type abp_behv_flag,
             lote       type abp_behv_flag,
             valoricms  type abp_behv_flag,
           end of y_item_div_control.

    class-methods: update_header_data   importing i_header     type /EXEDMINB/I_NFeMonitorH
                                        returning value(error) type abap_boolean.
    class-methods: read_header_data     importing it_keys   type /exedminb/cl_nfe_inb_processor=>y_keys_header
                                        exporting et_header type /exedminb/cl_nfe_inb_processor=>y_data_header.
    class-methods: read_item_data       importing it_keys  type /exedminb/cl_nfe_inb_processor=>y_keys_itens
                                        exporting et_itens type /exedminb/cl_nfe_inb_processor=>y_data_itens.
    class-methods: update_item_data     importing is_value     type /EXEDMINB/I_NFeMonitorI
                                        returning value(error) type abap_boolean.
    class-methods: create_item_div      importing is_value     type /exedminb/t_nfeitemdiv
                                        returning value(error) type abap_boolean.
    class-methods: update_item_div      importing is_value     type /exedminb/t_nfeitemdiv
                                                  is_control   type y_item_div_control
                                        returning value(error) type abap_boolean.
    class-methods: register_historico   importing i_historico  type /exedminb/t_historico
                                        returning value(error) type abap_boolean.


    class-methods: delete_item_div      importing is_value     type /exedminb/t_nfeitemdiv
                                        returning value(error) type abap_boolean.
    class-methods: get_data_itens_div exporting et_values       type /exedminb/cl_nfe_inb_processor=>y_data_itens_div.
    class-methods: free_data_itens_div.
    class-methods: delete_div_itens.
    class-methods: save_header_activ_changes.
    class-methods: save_div_itens.
    class-methods: save_itens_changes.
    class-methods: save_historico.
    class-methods: efetiva_delecao.

    class-methods: delete_nfes importing it_keys   type /exedminb/cl_nfe_inb_processor=>y_keys_header.

    class-methods get_assist_ref returning value(ref) type ref to /exedminb/cl_nfe_inb_processor.

  private section.
    class-data mt_data_header_changes    type /exedminb/cl_nfe_inb_processor=>y_data_header.
    class-data mr_assist_itens_operation type ref to /exedminb/cl_nfe_inb_processor.
    class-data mt_keys_to_delete    type /exedminb/cl_nfe_inb_processor=>y_keys_header.
    class-data mt_data_itens_to_change   type /exedminb/cl_nfe_inb_processor=>y_data_itens.
    class-data mt_data_itens_div_to_save type standard table of /exedminb/t_nfeitemdiv.
    class-data mt_data_itens_div_to_dele type standard table of /exedminb/t_nfeitemdiv.
    class-data mt_data_historico         type standard table of /exedminb/t_historico.

endclass.

class lhc_tabs_operations implementation.
  method get_assist_ref.
    if mr_assist_itens_operation is not bound.
      mr_assist_itens_operation = new /exedminb/cl_nfe_inb_processor( ).
    endif.
    ref = mr_assist_itens_operation.
  endmethod.

  method register_historico.
    append i_historico to mt_data_historico.
  endmethod.

  method read_header_data.
    data rg_ChaveNFe type range of /EXEDMINB/I_NFeMonitorI-ChaveNFe.

    loop at it_keys into data(ls_keys).
      if ls_keys-ChaveNFe is not initial.
        append value #( sign = 'I' option = 'EQ'
                        low = ls_keys-ChaveNFe ) to rg_ChaveNFe.
      endif.
    endloop.

    select * from /EXEDMINB/I_NFeMonitorH
      where ChaveNFe in @rg_ChaveNFe
      into corresponding fields of table @et_header.
  endmethod.

  method create_item_div.
    insert is_value into table mt_data_itens_div_to_save.
    if sy-subrc ne 0.
      error = abap_true.
    endif.
  endmethod.

  method update_item_div.
    data lv_div_to_modif type /exedminb/t_nfeitemdiv.

    select single * from /EXEDMINB/I_NFeMonitorI
      where ChaveNFe = @is_value-Id
        and ItemNFe = @is_value-ItemId
        and ItemIdDiv = @is_value-ItemIdDiv
        into @data(ls_item_hist).

    if sy-subrc ne 0.
      error = abap_true.
      exit.
    endif.

    lv_div_to_modif-Id = is_value-Id.
    lv_div_to_modif-ItemId = is_value-ItemId.
    lv_div_to_modif-ItemIdDiv = is_value-ItemIdDiv.
    lv_div_to_modif-qCom = cond #( when is_control-quantidade is not initial then is_value-qCom else ls_item_hist-Quantidade ).
    lv_div_to_modif-Lote = cond #( when is_control-Lote is not initial then is_value-Lote else ls_item_hist-Lote ).
    lv_div_to_modif-ValorICMS = cond #( when is_control-ValorICMS is not initial then is_value-ValorICMS else ls_item_hist-ValorICMS ).
    lv_div_to_modif-Pedido = cond #( when is_control-Pedido is not initial then is_value-Pedido else ls_item_hist-Pedido ).
    lv_div_to_modif-ItemPedido = cond #( when is_control-ItemPedido is not initial then is_value-ItemPedido else ls_item_hist-ItemPedido ).


    if line_exists( mt_data_itens_div_to_save[ Id = lv_div_to_modif-Id
                                               ItemId = lv_div_to_modif-ItemId
                                               ItemIdDiv = lv_div_to_modif-ItemIdDiv ] ).
      modify table mt_data_itens_div_to_save from lv_div_to_modif.

      if sy-subrc ne 0.
        error = abap_true.
      endif.
    else.
      error = lhc_tabs_operations=>create_item_div( lv_div_to_modif ).
    endif.
  endmethod.

  method read_item_data.
    data rg_ChaveNFe type range of /EXEDMINB/I_NFeMonitorI-ChaveNFe.
    data rg_ItemNFe type range of /EXEDMINB/I_NFeMonitorI-ItemNFe.
    data rg_ItemIdDiv type range of /EXEDMINB/I_NFeMonitorI-ItemIdDiv.

    loop at it_keys into data(ls_keys).
      if ls_keys-ChaveNFe is not initial.
        append value #( sign = 'I' option = 'EQ'
                        low = ls_keys-ChaveNFe ) to rg_ChaveNFe.
      endif.

      if ls_keys-ItemNFe is not initial.
        append value #( sign = 'I' option = 'EQ'
                        low = ls_keys-ItemNFe ) to rg_ItemNFe.
      endif.

      if ls_keys-ItemIdDiv is not initial.
        append value #( sign = 'I' option = 'EQ'
                        low = ls_keys-ItemIdDiv ) to rg_ItemIdDiv.
      endif.
    endloop.

    select * from /EXEDMINB/I_NFeMonitorI
      where ChaveNFe in @rg_ChaveNFe
        and ItemNFe in @rg_ItemNFe
        and ItemIdDiv in @rg_ItemIdDiv
      into corresponding fields of table @et_itens.
  endmethod.

  method update_item_data.
    modify table mt_data_itens_to_change from is_value.

    if sy-subrc ne 0.
      error = abap_true.
    endif.
  endmethod.

  method delete_item_div.
    insert is_value into table mt_data_itens_div_to_dele.
    if sy-subrc ne 0.
      error = abap_true.
    endif.
  endmethod.

  method get_data_itens_div.
    et_values = mt_data_itens_div_to_save.
  endmethod.

  method free_data_itens_div.
    free mt_data_itens_div_to_save.
  endmethod.

  method save_div_itens.
    if mt_data_itens_div_to_save is not initial.
      modify /exedminb/t_nfeitemdiv from table @mt_data_itens_div_to_save.
    endif.
  endmethod.

  method save_itens_changes.
    loop at mt_data_itens_to_change into data(ls_item).
      update /exedminb/t_nfeitem set xPed = @ls_item-Pedido,
                                 nItemPed = @ls_item-ItemPedido where Id eq @ls_item-ChaveNFe
                                                                  and ItemId eq @ls_item-ChaveNFe.
    endloop.
  endmethod.

  method delete_div_itens.
    if mt_data_itens_div_to_dele is not initial.
      delete /exedminb/t_nfeitemdiv from table @mt_data_itens_div_to_dele.
    endif.
  endmethod.

  method save_header_activ_changes.
    if mt_data_header_changes is not initial.
      loop at mt_data_header_changes into data(ls_chgs).
        lhc_tabs_operations=>get_assist_ref( )->map_entity_to_nfeh_tables(
          exporting
            i_entity        = ls_chgs
          importing
            e_nfeheader     = data(ls_nfeheader)
            e_nfeissuer     = data(ls_nfeissuer)
            e_nferecipient  = data(ls_nferecipient)
            e_nfeicmstaxtot = data(ls_nfeicmstaxtot)
            e_nfeprotocolo  = data(ls_nfeprotocolo)
        ).

        modify /exedminb/t_nfeheader from @ls_nfeheader.
        modify /EXEDMINB/T_NFeIssuer from @ls_nfeissuer.
        modify /EXEDMINB/T_NFeRecipient from @ls_nferecipient.
        modify /EXEDMINB/T_NFeICMSTaxTot from @ls_nfeicmstaxtot.
        modify /EXEDMINB/T_NFEProtocolo from @ls_nfeprotocolo.
      endloop.
    endif.
  endmethod.

  method update_header_data.
    if line_exists( mt_data_header_changes[ ChaveNFe = i_header-ChaveNFe ] ).
      modify table mt_data_header_changes from i_header.
    else.
      insert i_header into table mt_data_header_changes.
    endif.

    if sy-subrc ne 0.
      error = abap_true.
    endif.
  endmethod.

  method delete_nfes.
    append lines of it_keys to mt_keys_to_delete.
  endmethod.

  method efetiva_delecao.
    loop at mt_keys_to_delete into data(ls_keys).
      delete from /exedminb/t_nfeheader where id = @ls_keys-ChaveNFe.
      delete from /exedminb/t_historico where IdNfe = @ls_keys-ChaveNFe.

      delete from /EXEDMINB/t_nfeissuer       where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfeissueraddr   where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nferecipient    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nferecipaddr    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfeitem         where id = @ls_keys-ChaveNFe.
      delete from /exedminb/t_nfeitemdiv      where id = @ls_keys-ChaveNFe.

      delete from /EXEDMINB/t_nfetaxicms00    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetaxicms02    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetaxicms10    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetaxicms15    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetaxicms20    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetaxicms30    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetaxicms40    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetaxicms51    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetaxicms53    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetaxicms60    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetaxicms61    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetaxicms70    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetaxicms90    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetaxicmsst    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetxicmspart   where id = @ls_keys-ChaveNFe.

      delete from /EXEDMINB/t_nfetaxii        where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetaxipi       where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetaxcofins    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetaxpis       where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetaxpisst     where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetxcofinsst   where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfeicmsufdest   where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfeicmstaxTot   where id = @ls_keys-ChaveNFe.

      delete from /EXEDMINB/t_nfetransport    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfecarrier      where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetranspret    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetranspveh    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetransptow    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetranspvol    where id = @ls_keys-ChaveNFe.

      delete from /EXEDMINB/t_securityseal    where id = @ls_keys-ChaveNFe.

      delete from /EXEDMINB/t_nfeinvoice      where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfeinstallm     where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfepayment      where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_paymentcard     where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfeaddinform    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetaxinform    where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfetxpayerinf   where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfelegprocref   where id = @ls_keys-ChaveNFe.
      delete from /EXEDMINB/t_nfeprotocolo    where id = @ls_keys-ChaveNFe.
    endloop.
  endmethod.

  method save_historico.
    modify entities of /exedminb/i_historico
           entity Historico
           create fields ( IdNFe Etapa Status Descricao )
           with value #( for line_hist in mt_data_historico index into idx ( %cid = |Hist_Reg_{ idx }_{ line_hist-IdNfe }|
                                                                             IdNfe = line_hist-IdNfe
                                                                             Etapa = line_hist-Etapa
                                                                             Status = line_hist-Status
                                                                             Descricao = line_hist-Descricao ) )
     failed final(lt_failed)
     reported final(lt_reported).
  endmethod.

endclass.

class lhc__nfemonitorh definition inheriting from cl_abap_behavior_handler.
  private section.

    methods get_instance_authorizations for instance authorization
      importing keys request requested_authorizations for _nfemonitorh result result.

    methods read for read
      importing keys for read _nfemonitorh result result.

    methods lock for lock
      importing keys for lock _nfemonitorh.

    methods rba_item for read
      importing keys_rba for read _nfemonitorh\_item full result_requested result result link association_links.

    methods etapa_100 for modify
      importing keys for action _nfemonitorh~etapa_100.

    methods etapa_200 for modify
      importing keys for action _nfemonitorh~etapa_200.

    methods etapa_300 for modify
      importing keys for action _nfemonitorh~etapa_300.

    methods etapa_400 for modify
      importing keys for action _nfemonitorh~etapa_400.

    methods etapa_500 for modify
      importing keys for action _nfemonitorh~etapa_500.

    methods etapa_600 for modify
      importing keys for action _nfemonitorh~etapa_600.

    methods etapa_700 for modify
      importing keys for action _nfemonitorh~etapa_700.

    methods etapa_800 for modify
      importing keys for action _nfemonitorh~etapa_800.

    methods etapa_900 for modify
      importing keys for action _nfemonitorh~etapa_900.

    methods delete for modify
      importing keys for delete _nfemonitorh.

    methods processar for modify
      importing keys for action _nfemonitorh~processar result result.

    methods reprocessar for modify
      importing keys for action _nfemonitorh~reprocessar result result.

endclass.

class lhc__nfemonitorh implementation.

  method get_instance_authorizations.
    select chavenfe, atividade, Status,
           empresa, LocalDeNegocio
      from /EXEDMINB/I_NFeMonitorH
      for all entries in @keys
      where ChaveNFe eq @keys-ChaveNFe
      into table @data(lt_monitor_etapa).

    result = value #( for line in lt_monitor_etapa ( ChaveNFe = line-ChaveNFe
                                                     %update = cond #( when line-Atividade eq 200 and line-Empresa is not initial and line-LocalDeNegocio is not initial
                                                                       then if_abap_behv=>auth-allowed else if_abap_behv=>auth-unauthorized )
                                                     %action = value #( processar = cond #( when line-Status ne lhc_tabs_operations=>cc_status-erro then if_abap_behv=>auth-allowed else if_abap_behv=>auth-unauthorized )
                                                                        reprocessar = cond #( when line-Status eq lhc_tabs_operations=>cc_status-erro then if_abap_behv=>auth-allowed else if_abap_behv=>auth-unauthorized ) ) ) ).

  endmethod.

  method read.
  endmethod.

  method lock.
  endmethod.

  method rba_item.
  endmethod.

  method etapa_100.
    lhc_tabs_operations=>read_header_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                           importing et_header = data(lt_header) ).

    lhc_tabs_operations=>read_item_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                         importing et_itens = data(lt_items) ).

    if lt_header is initial.
      "Error
    endif.

    loop at lt_header into data(ls_header).

      lhc_tabs_operations=>get_assist_ref( )->revalida_autorizacao(
        exporting
          iv_chave        = ls_header-ChaveNFe
          is_busca_status = abap_true
        changing
          cv_cStatus      = ls_header-StatusNFe
          mapped          = mapped
          failed          = failed
          reported        = reported
      ).

      "Valida Status NF
      if failed-_nfemonitorh is initial.
        if ls_header-StatusNFe eq '100'.
          "NF liberada
          ls_header-Status = 3. condense ls_header-Status no-gaps.
          ls_header-Atividade = 200.
          lhc_tabs_operations=>register_historico(
            exporting
              i_historico = value #( IdNFe = ls_header-ChaveNFe
                                     Etapa = ls_header-atividade
                                     Status = ls_header-Status
                                     Descricao = me->new_message( id = lhc_tabs_operations=>cc_classe_msg
                                                                  number   = 101
                                                                  severity = if_abap_behv_message=>severity-success )->if_message~get_text( ) ) ).
        else.
          "NF não está liberada
          ls_header-Status = 1. condense ls_header-Status no-gaps.
          lhc_tabs_operations=>register_historico(
            exporting
              i_historico = value #( IdNFe = ls_header-ChaveNFe
                                     Etapa = ls_header-atividade
                                     Status = ls_header-Status
                                     Descricao = me->new_message( id = lhc_tabs_operations=>cc_classe_msg
                                                                  number   = 001
                                                                  severity = if_abap_behv_message=>severity-success )->if_message~get_text( ) ) ).
        endif.

      else.
        "Não foi possivel determinar o status da NF
        ls_header-Status = 1. condense ls_header-Status no-gaps.
        lhc_tabs_operations=>register_historico(
            exporting
              i_historico = value #( IdNFe = ls_header-ChaveNFe
                                     Etapa = ls_header-atividade
                                     Status = ls_header-Status
                                     Descricao = me->new_message( id = lhc_tabs_operations=>cc_classe_msg
                                                                  number   = 001
                                                                  severity = if_abap_behv_message=>severity-success )->if_message~get_text( ) ) ).
      endif.

      lhc_tabs_operations=>update_header_data( ls_header ).

    endloop.

    clear: failed, reported, mapped.
    reported-_nfemonitorh = value #( for l in lt_header ( ChaveNFe = l-ChaveNFe
                                                          %msg = me->new_message(
                                                                      id       = lhc_tabs_operations=>cc_classe_msg
                                                                      number   = 999
                                                                      severity = if_abap_behv_message=>severity-information
                                                                    ) ) ).

    lhc_tabs_operations=>save_historico(  ).

  endmethod.

  method etapa_200.
    data final_failed type /exedminb/cl_nfe_inb_processor=>yt_failed.
    data final_reported type /exedminb/cl_nfe_inb_processor=>yt_resported.

    lhc_tabs_operations=>read_header_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                           importing et_header = data(lt_header) ).

    lhc_tabs_operations=>read_item_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                         importing et_itens = data(lt_items) ).

    if lt_header is initial.
      "Error
      failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized ) ) ).
      reported-_nfemonitorh = value #( ( %msg = me->new_message(
                                                    id       = lhc_tabs_operations=>cc_classe_msg
                                                    number   = 998
                                                    severity = if_abap_behv_message=>severity-error ) ) ).
      exit.
    endif.

    data line like line of reported-_nfemonitorh.

    loop at lt_header into data(ls_header).
      "Determina Empresa e Local de negocio a partir do destinario
      if ls_header-Empresa is initial or ls_header-LocalDeNegocio is initial.
        clear: failed, mapped, reported.
        lhc_tabs_operations=>get_assist_ref( )->determina_empresa( changing cs_header = ls_header
                                                                            mapped    = mapped
                                                                            failed    = failed
                                                                            reported  = reported ).

        if failed-_nfemonitorh is not initial.
          ls_header-Status = 1. condense ls_header-Status no-gaps.
          loop at reported-_nfemonitorh into line.
            lhc_tabs_operations=>register_historico(
              exporting
                i_historico = value #( IdNFe = ls_header-ChaveNFe
                                       Etapa = ls_header-atividade
                                       Status = ls_header-Status
                                       Descricao = line-%msg->if_message~get_text( ) ) ).
          endloop.
          append lines of reported-_nfemonitorh to final_reported-_nfemonitorh.
        endif.
      endif.

      if ls_header-Status ne 3.
        lhc_tabs_operations=>update_header_data( ls_header ).
        continue.
      endif.


      ""Atribução Pedido/Item (validacao_geral)
      clear: failed, mapped, reported.

      data(itens_sem_pedido) = lhc_tabs_operations=>get_assist_ref( )->validacao_geral(
        exporting
          is_header = ls_header
          it_items  = value #( for item in lt_items where ( ChaveNFe = ls_header-ChaveNFe ) ( item ) )
        changing
          mapped    = mapped
          failed    = failed
          reported  = reported
      ).

      if failed-_nfemonitorh is not initial.
        ls_header-Status = 1. condense ls_header-Status no-gaps.
        loop at reported-_nfemonitorh into line.
          lhc_tabs_operations=>register_historico(
            exporting
              i_historico = value #( IdNFe = ls_header-ChaveNFe
                                     Etapa = ls_header-atividade
                                     Status = ls_header-Status
                                     Descricao = line-%msg->if_message~get_text( ) ) ).
        endloop.
        append lines of reported-_nfemonitorh to final_reported-_nfemonitorh.

      elseif itens_sem_pedido eq abap_true.
        ls_header-Status = 2. condense ls_header-Status no-gaps.
        lhc_tabs_operations=>register_historico(
            exporting
              i_historico = value #( IdNFe = ls_header-ChaveNFe
                                     Etapa = ls_header-atividade
                                     Status = ls_header-Status
                                     Descricao = me->new_message( id = lhc_tabs_operations=>cc_classe_msg
                                                                  number   = 004
                                                                  severity = if_abap_behv_message=>severity-success )->if_message~get_text( ) ) ).
      endif.


      if ls_header-Status ne 3.
        lhc_tabs_operations=>update_header_data( ls_header ).
        continue.
      endif.

      ls_header-atividade = 300.
      lhc_tabs_operations=>register_historico(
            exporting
              i_historico = value #( IdNFe = ls_header-ChaveNFe
                                     Etapa = ls_header-atividade
                                     Status = ls_header-Status
                                     Descricao = me->new_message( id = lhc_tabs_operations=>cc_classe_msg
                                                                  number   = 102
                                                                  severity = if_abap_behv_message=>severity-success )->if_message~get_text( ) ) ).

      lhc_tabs_operations=>update_header_data( ls_header ).

    endloop.

    clear: failed, reported, mapped.

    lhc_tabs_operations=>save_historico(  ).
  endmethod.

  method etapa_300.
    lhc_tabs_operations=>read_header_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                           importing et_header = data(lt_header) ).

    lhc_tabs_operations=>read_item_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                         importing et_itens = data(lt_items) ).

    if lt_header is initial.
      "Error
    endif.

    clear: failed, reported, mapped.
    reported-_nfemonitorh = value #( for l in lt_header ( ChaveNFe = l-ChaveNFe
                                                          %msg = me->new_message(
                                                                      id       = lhc_tabs_operations=>cc_classe_msg
                                                                      number   = 999
                                                                      severity = if_abap_behv_message=>severity-information
                                                                    ) ) ).

  endmethod.

  method etapa_400.
  endmethod.

  method etapa_500.
  endmethod.

  method etapa_600.
    lhc_tabs_operations=>read_header_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                           importing et_header = data(lt_header) ).

    lhc_tabs_operations=>read_item_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                         importing et_itens = data(lt_items) ).

    if lt_header is initial.
      "Error
    endif.

    loop at lt_header into data(ls_header).

      lhc_tabs_operations=>get_assist_ref( )->revalida_autorizacao(
        exporting
          iv_chave        = ls_header-ChaveNFe
          is_busca_status = abap_true
        changing
          cv_cStatus      = ls_header-StatusNFe
          mapped          = mapped
          failed          = failed
          reported        = reported
      ).

    endloop.

    clear: failed, reported, mapped.
    reported-_nfemonitorh = value #( for l in lt_header ( ChaveNFe = l-ChaveNFe
                                                          %msg = me->new_message(
                                                                      id       = lhc_tabs_operations=>cc_classe_msg
                                                                      number   = 999
                                                                      severity = if_abap_behv_message=>severity-success
                                                                    ) ) ).

  endmethod.

  method etapa_700.
    lhc_tabs_operations=>read_header_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                           importing et_header = data(lt_header) ).

    lhc_tabs_operations=>read_item_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                         importing et_itens = data(lt_items) ).


    if lt_header is initial.
      "Error
    endif.

    loop at lt_header into data(ls_header).

      lhc_tabs_operations=>get_assist_ref( )->executar_migo( exporting is_header = ls_header
                                                      it_items  = value #( for item in lt_items where ( ChaveNFe = ls_header-ChaveNFe ) ( item ) )
                                            changing  mapped    = mapped
                                                      failed    = failed
                                                      reported  = reported ).

    endloop.


  endmethod.

  method etapa_800.
    lhc_tabs_operations=>read_header_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                           importing et_header = data(lt_header) ).

    lhc_tabs_operations=>read_item_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                         importing et_itens = data(lt_items) ).


    if lt_header is initial.
      "Error
    endif.

    loop at lt_header into data(ls_header).

      lhc_tabs_operations=>get_assist_ref( )->executar_miro( exporting is_header = ls_header
                                                      it_items  = value #( for item in lt_items where ( ChaveNFe = ls_header-ChaveNFe ) ( item ) )
                                            changing  mapped    = mapped
                                                      failed    = failed
                                                      reported  = reported ).

    endloop.

  endmethod.

  method etapa_900.
  endmethod.

  method delete.
    check keys is not initial.
    lhc_tabs_operations=>delete_nfes( value #( for key in keys ( corresponding #( key ) ) ) ).
    reported-_nfemonitorh = value #( ( %key = value #( chavenfe = keys[ 1 ]-ChaveNFe )
                                       %msg = me->new_message_with_text( severity = if_abap_behv_message=>severity-success
                                                                                    text = 'NFe deletada do monitor!' ) ) ).
  endmethod.

  method processar.
    lhc_tabs_operations=>read_header_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                           importing et_header = data(lt_header) ).

    loop at lt_header assigning field-symbol(<f_header>).
      case <f_header>-Atividade.
        when 100.
          modify entities of /EXEDMINB/I_NFeMonitorH
              in local mode
              entity _NFeMonitorH
              execute etapa_200
              from value #( for line in keys where ( ChaveNFe = <f_header>-ChaveNFe )
                                                   ( corresponding #( line ) ) ).

        when 200.
          modify entities of /EXEDMINB/I_NFeMonitorH
              in local mode
              entity _NFeMonitorH
              execute etapa_300
              from value #( for line in keys where ( ChaveNFe = <f_header>-ChaveNFe )
                                                   ( corresponding #( line ) ) ).

        when 300.
          modify entities of /EXEDMINB/I_NFeMonitorH
              in local mode
              entity _NFeMonitorH
              execute etapa_400
              from value #( for line in keys where ( ChaveNFe = <f_header>-ChaveNFe )
                                                   ( corresponding #( line ) ) ).

        when 400.
          modify entities of /EXEDMINB/I_NFeMonitorH
              in local mode
              entity _NFeMonitorH
              execute etapa_500
              from value #( for line in keys where ( ChaveNFe = <f_header>-ChaveNFe )
                                                   ( corresponding #( line ) ) ).

        when 500.
          modify entities of /EXEDMINB/I_NFeMonitorH
              in local mode
              entity _NFeMonitorH
              execute etapa_600
              from value #( for line in keys where ( ChaveNFe = <f_header>-ChaveNFe )
                                                   ( corresponding #( line ) ) ).

        when 600.
          modify entities of /EXEDMINB/I_NFeMonitorH
              in local mode
              entity _NFeMonitorH
              execute etapa_700
              from value #( for line in keys where ( ChaveNFe = <f_header>-ChaveNFe )
                                                   ( corresponding #( line ) ) ).

        when 700.
          modify entities of /EXEDMINB/I_NFeMonitorH
              in local mode
              entity _NFeMonitorH
              execute etapa_800
              from value #( for line in keys where ( ChaveNFe = <f_header>-ChaveNFe )
                                                   ( corresponding #( line ) ) ).

        when 800.
          modify entities of /EXEDMINB/I_NFeMonitorH
              in local mode
              entity _NFeMonitorH
              execute etapa_900
              from value #( for line in keys where ( ChaveNFe = <f_header>-ChaveNFe )
                                                   ( corresponding #( line ) ) ).

      endcase.
    endloop.

    result = value #( for key in keys ( %tky = key-%tky
                                        %param-ChaveNFe = key-ChaveNFe ) ).
    reported-_nfemonitorh = value #( ( %msg = me->new_message( id       = lhc_tabs_operations=>cc_classe_msg
                                                               number   = 997
                                                               severity = if_abap_behv_message=>severity-warning ) ) ).
  endmethod.


  method reprocessar.
    lhc_tabs_operations=>read_header_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                           importing et_header = data(lt_header) ).

    loop at lt_header assigning field-symbol(<f_header>).
      case <f_header>-Atividade.
        when 100.
          modify entities of /EXEDMINB/I_NFeMonitorH
              in local mode
              entity _NFeMonitorH
              execute etapa_100
              from value #( for line in keys where ( ChaveNFe = <f_header>-ChaveNFe )
                                                   ( corresponding #( line ) ) ).

        when 200.
          modify entities of /EXEDMINB/I_NFeMonitorH
              in local mode
              entity _NFeMonitorH
              execute etapa_200
              from value #( for line in keys where ( ChaveNFe = <f_header>-ChaveNFe )
                                                   ( corresponding #( line ) ) ).

        when 300.
          modify entities of /EXEDMINB/I_NFeMonitorH
              in local mode
              entity _NFeMonitorH
              execute etapa_300
              from value #( for line in keys where ( ChaveNFe = <f_header>-ChaveNFe )
                                                   ( corresponding #( line ) ) ).

        when 400.
          modify entities of /EXEDMINB/I_NFeMonitorH
              in local mode
              entity _NFeMonitorH
              execute etapa_400
              from value #( for line in keys where ( ChaveNFe = <f_header>-ChaveNFe )
                                                   ( corresponding #( line ) ) ).

        when 500.
          modify entities of /EXEDMINB/I_NFeMonitorH
              in local mode
              entity _NFeMonitorH
              execute etapa_500
              from value #( for line in keys where ( ChaveNFe = <f_header>-ChaveNFe )
                                                   ( corresponding #( line ) ) ).

        when 600.
          modify entities of /EXEDMINB/I_NFeMonitorH
              in local mode
              entity _NFeMonitorH
              execute etapa_600
              from value #( for line in keys where ( ChaveNFe = <f_header>-ChaveNFe )
                                                   ( corresponding #( line ) ) ).

        when 700.
          modify entities of /EXEDMINB/I_NFeMonitorH
              in local mode
              entity _NFeMonitorH
              execute etapa_700
              from value #( for line in keys where ( ChaveNFe = <f_header>-ChaveNFe )
                                                   ( corresponding #( line ) ) ).

        when 800.
          modify entities of /EXEDMINB/I_NFeMonitorH
              in local mode
              entity _NFeMonitorH
              execute etapa_800
              from value #( for line in keys where ( ChaveNFe = <f_header>-ChaveNFe )
                                                   ( corresponding #( line ) ) ).

        when 900.
          modify entities of /EXEDMINB/I_NFeMonitorH
              in local mode
              entity _NFeMonitorH
              execute etapa_900
              from value #( for line in keys where ( ChaveNFe = <f_header>-ChaveNFe )
                                                   ( corresponding #( line ) ) ).

      endcase.
    endloop.

    result = value #( for key in keys ( %tky = key-%tky
                                        %param-ChaveNFe = key-ChaveNFe ) ).
    reported-_nfemonitorh = value #( ( %msg = me->new_message( id       = lhc_tabs_operations=>cc_classe_msg
                                                               number   = 997
                                                               severity = if_abap_behv_message=>severity-warning ) ) ).
  endmethod.

endclass.

class lhc__nfemonitori definition inheriting from cl_abap_behavior_handler.
  public section.
    class-data mr_assist_itens_operation type ref to /exedminb/cl_nfe_inb_processor.

  private section.
    methods update for modify
      importing entities for update _nfemonitori.

    methods read for read
      importing keys for read _nfemonitori result result.

    methods rba_header for read
      importing keys_rba for read _nfemonitori\_header full result_requested result result link association_links.

    methods get_instance_authorizations for instance authorization
      importing keys request requested_authorizations for _nfemonitori result result.

    methods dividir for modify
      importing keys for action _nfemonitori~dividir.

    methods eliminar for modify
      importing keys for action _nfemonitori~eliminar.

    methods create for modify
      importing entities for create _nfemonitori.

    methods get_global_authorizations for global authorization
      importing request requested_authorizations for _nfemonitori result result.

    methods delete for modify
      importing keys for delete _nfemonitori.

endclass.

class lhc__nfemonitori implementation.

  method update.
    loop at entities into data(entitie).
      if lhc_tabs_operations=>update_item_div( is_value   = value #( Id = entitie-ChaveNFe
                                                                  ItemId = entitie-ItemNFe
                                                               ItemIdDiv = entitie-ItemIdDiv
                                                                    qCom = entitie-Quantidade
                                                                    Lote = entitie-Lote
                                                               ValorICMS = entitie-ValorICMS
                                                                  Pedido = entitie-Pedido
                                                              ItemPedido = entitie-ItemPedido )
                                            is_control = value #( Quantidade = entitie-%control-Quantidade
                                                                        Lote = entitie-%control-Lote
                                                                   ValorICMS = entitie-%control-ValorICMS
                                                                      Pedido = entitie-%control-Pedido
                                                                  ItemPedido = entitie-%control-ItemPedido ) ) eq abap_true.
        failed-_nfemonitori = value #( ( %key = value #( chavenfe = entitie-ChaveNFe
                                                          itemnfe = entitie-ItemNFe
                                                          itemiddiv = entitie-ItemIdDiv )
                                         %update = if_abap_behv=>mk-on ) ).
        reported-_nfemonitori = value #( ( %key = value #( chavenfe = entitie-ChaveNFe
                                                           itemnfe = entitie-ItemNFe
                                                           itemiddiv = entitie-ItemIdDiv )
                                           %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                             text = 'Erro ao atualizar Item.' ) ) ).
        exit.
      endif.
    endloop.
  endmethod.

  method read.
    lhc_tabs_operations=>read_item_data( exporting it_keys  = keys
                                         importing et_itens = data(lt_values) ).

    result = value #( for value in lt_values ( corresponding #( value ) ) ).
  endmethod.

  method rba_header.
  endmethod.

  method get_instance_authorizations.
    result = value #( for key in keys
                      ( chavenfe = key-chavenfe
                        itemnfe = key-itemnfe
                        itemiddiv = key-itemiddiv
                        %action-eliminar = cond #( when key-itemiddiv eq 0 then if_abap_behv=>auth-unauthorized )
                         ) ).

  endmethod.

  method dividir.
    if mr_assist_itens_operation is not bound.
      mr_assist_itens_operation = new /exedminb/cl_nfe_inb_processor( ).
    endif.

    mr_assist_itens_operation->dividir_item( exporting it_keys  = keys
                                             changing  mapped   = mapped
                                                       failed   = failed
                                                       reported = reported ).
  endmethod.

  method eliminar.
    if mr_assist_itens_operation is not bound.
      mr_assist_itens_operation = new /exedminb/cl_nfe_inb_processor( ).
    endif.

    mr_assist_itens_operation->eliminar_item( keys ).
  endmethod.

  method create.
    loop at entities into data(entitie).
      lhc_tabs_operations=>create_item_div( value #( Id = entitie-ChaveNFe
                                                 ItemId = entitie-ItemNFe
                                              ItemIdDiv = entitie-ItemIdDiv
                                                   qCom = entitie-Quantidade
                                                   Lote = entitie-Lote
                                              ValorICMS = entitie-ValorICMS
                                                 Pedido = entitie-Pedido
                                             ItemPedido = entitie-ItemPedido  ) ).
    endloop.
  endmethod.

  method get_global_authorizations.
  endmethod.

  method delete.
    loop at keys into data(key).
      lhc_tabs_operations=>delete_item_div( value #(     Id = key-ChaveNFe
                                                     ItemId = key-ItemNFe
                                                  ItemIdDiv = key-ItemIdDiv ) ).
    endloop.
  endmethod.

endclass.

class lsc_i_nfemonitorh definition inheriting from cl_abap_behavior_saver.
  protected section.

    methods finalize redefinition.

    methods check_before_save redefinition.

    methods save redefinition.

    methods cleanup redefinition.

    methods cleanup_finalize redefinition.

endclass.

class lsc_i_nfemonitorh implementation.

  method finalize.
  endmethod.

  method check_before_save.
  endmethod.

  method save.
    lhc_tabs_operations=>save_header_activ_changes( ).
    lhc_tabs_operations=>delete_div_itens( ).
    lhc_tabs_operations=>save_div_itens( ).
    lhc_tabs_operations=>efetiva_delecao( ).

    reported-%other = value #( ( me->new_message( id       = lhc_tabs_operations=>cc_classe_msg
                                                  number   = 999
                                                  severity = if_abap_behv_message=>severity-success ) ) ).
  endmethod.

  method cleanup.
  endmethod.

  method cleanup_finalize.
  endmethod.

endclass.