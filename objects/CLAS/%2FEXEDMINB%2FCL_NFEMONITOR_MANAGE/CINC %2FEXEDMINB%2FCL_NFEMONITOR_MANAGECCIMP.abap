"Crud Tabelas NF-e
class lhc_tabs_operations definition.

  public section.
    types: begin of y_fields_chngs_header,
             id        type /exedminb/t_nfeheader-Id,
             atividade type /exedminb/t_nfeheader-atividade,
             cStat     type /EXEDMINB/T_NFEProtocolo-cStat,
           end of y_fields_chngs_header.

    class-methods: update_header_data   importing i_header     type y_fields_chngs_header
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
                                        returning value(error) type abap_boolean.

    class-methods: delete_item_div      importing is_value     type /exedminb/t_nfeitemdiv
                                        returning value(error) type abap_boolean.
    class-methods: get_data_itens_div exporting et_values       type /exedminb/cl_nfe_inb_processor=>y_data_itens_div.
    class-methods: free_data_itens_div.
    class-methods: save_div_itens.
    class-methods: save_itens_changes.
    class-methods: delete_div_itens.
    class-methods: save_header_activ_changes.

  private section.
    class-data mt_data_header_changes    type standard table of y_fields_chngs_header.
    class-data mt_data_itens_to_change   type /exedminb/cl_nfe_inb_processor=>y_data_itens.
    class-data mt_data_itens_div_to_save type standard table of /exedminb/t_nfeitemdiv.
    class-data mt_data_itens_div_to_dele type standard table of /exedminb/t_nfeitemdiv.

endclass.

class lhc_tabs_operations implementation.
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
    if line_exists( mt_data_itens_div_to_save[ Id = is_value-Id
                                               ItemId = is_value-ItemId
                                               ItemIdDiv = is_value-ItemIdDiv ] ).
      modify table mt_data_itens_div_to_save from is_value.

      if sy-subrc ne 0.
        error = abap_true.
      endif.
    else.
      error = lhc_tabs_operations=>create_item_div( is_value ).
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
        update /exedminb/t_nfeheader set atividade = @ls_chgs-atividade where id = @ls_chgs-id.
        update /EXEDMINB/T_NFEProtocolo set cStat = @ls_chgs-cStat where id = @ls_chgs-id.
      endloop.
    endif.
  endmethod.

  method update_header_data.
    if line_exists( mt_data_header_changes[ id = i_header-Id ] ).
      modify table mt_data_header_changes from i_header.
    else.
      insert i_header into table mt_data_header_changes.
    endif.

    if sy-subrc ne 0.
      error = abap_true.
    endif.
  endmethod.

endclass.

class lhc__nfemonitorh definition inheriting from cl_abap_behavior_handler.
  private section.
    data mr_assist_itens_operation type ref to /exedminb/cl_nfe_inb_processor.

    methods get_instance_authorizations for instance authorization
      importing keys request requested_authorizations for _nfemonitorh result result.

    methods read for read
      importing keys for read _nfemonitorh result result.

    methods lock for lock
      importing keys for lock _nfemonitorh.

    methods rba_item for read
      importing keys_rba for read _nfemonitorh\_item full result_requested result result link association_links.

    methods migo for modify
      importing keys for action _nfemonitorh~migo.

    methods miro for modify
      importing keys for action _nfemonitorh~miro.

    methods executarprocesso for modify
      importing keys for action _nfemonitorh~executarprocesso result result.

    methods get_assist_ref returning value(ref) type ref to /exedminb/cl_nfe_inb_processor.

endclass.

class lhc__nfemonitorh implementation.

  method get_instance_authorizations.
  endmethod.

  method read.
  endmethod.

  method lock.
  endmethod.

  method rba_item.
  endmethod.

  method migo.
    lhc_tabs_operations=>read_header_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                           importing et_header = data(lt_header) ).

    lhc_tabs_operations=>read_item_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                         importing et_itens = data(lt_items) ).


    if lt_header is initial.
      "Error
    endif.

    me->get_assist_ref( )->executar_migo( exporting is_header = lt_header[ 1 ]
                                                    it_items  = lt_items
                                          changing  mapped    = mapped
                                                    failed    = failed
                                                    reported  = reported ).


  endmethod.

  method miro.
    lhc_tabs_operations=>read_header_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                           importing et_header = data(lt_header) ).

    lhc_tabs_operations=>read_item_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                         importing et_itens = data(lt_items) ).


    if lt_header is initial.
      "Error
    endif.

    me->get_assist_ref( )->executar_miro( exporting is_header = lt_header[ 1 ]
                                                    it_items  = lt_items
                                          changing  mapped    = mapped
                                                    failed    = failed
                                                    reported  = reported ).

  endmethod.

  method executarProcesso.
    lhc_tabs_operations=>read_header_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                           importing et_header = data(lt_header) ).

    lhc_tabs_operations=>read_item_data( exporting it_keys  = value #( for key in keys ( corresponding #( key ) ) )
                                         importing et_itens = data(lt_items) ).


    if lt_header is initial.
      "Error
    endif.

    data lt_items_hist type /exedminb/cl_nfe_inb_processor=>y_data_itens.
    lt_items_hist = lt_items.
    data(header_changed) = conv lhc_tabs_operations=>y_fields_chngs_header( me->get_assist_ref( )->executar_processo( exporting is_header = lt_header[ 1 ]
                                                                                                                      changing  it_items  = lt_items
                                                                                                                                mapped    = mapped
                                                                                                                                failed    = failed
                                                                                                                                reported  = reported ) ).

    check failed-_nfemonitorh is initial.

    if header_changed is not initial.
      lhc_tabs_operations=>update_header_data( header_changed ).
    endif.

    loop at lt_items into data(ls_item).
      if line_exists( lt_items_hist[ ChaveNFe = ls_item-ChaveNFe
                                   ItemNFe = ls_item-ItemNFe
                                   ItemIdDiv = ls_item-ItemIdDiv ] ).

        data(hist) = lt_items_hist[ ChaveNFe = ls_item-ChaveNFe
                                     ItemNFe = ls_item-ItemNFe
                                     ItemIdDiv = ls_item-ItemIdDiv ].

        if ls_item-Pedido ne hist-Pedido or ls_item-ItemPedido ne hist-ItemPedido.
          lhc_tabs_operations=>update_item_data( ls_item ).
        endif.
      endif.
    endloop.

  endmethod.

  method get_assist_ref.
    if mr_assist_itens_operation is not bound.
      mr_assist_itens_operation = new /exedminb/cl_nfe_inb_processor( ).
    endif.
    ref = mr_assist_itens_operation.
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
      lhc_tabs_operations=>update_item_div( value #( Id = entitie-ChaveNFe
                                                 ItemId = entitie-ItemNFe
                                              ItemIdDiv = entitie-ItemIdDiv
                                                   qCom = entitie-Quantidade
                                                   Lote = entitie-Lote
                                              ValorICMS = entitie-ValorICMS ) ).
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
                        %action-eliminar = cond #( when key-itemiddiv eq 0 then if_abap_behv=>auth-unauthorized ) ) ).

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
                                              ValorICMS = entitie-ValorICMS  ) ).
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
  endmethod.

  method cleanup.
  endmethod.

  method cleanup_finalize.
  endmethod.

endclass.