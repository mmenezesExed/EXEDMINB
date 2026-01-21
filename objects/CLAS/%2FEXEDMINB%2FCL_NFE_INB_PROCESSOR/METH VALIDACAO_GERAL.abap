  method validacao_geral.
    data rg_supplier type tt_rangesupplier.

    "Validações Header

    "Valida Fornecedor XML x Pedido // Busca ID do emissor com base no CNPJ
    data(ls_emissor) = lcl_api_hub_read=>read_supplier( taxnumber1 = conv #( is_header-Emitente ) ).

    if ls_emissor-d-results is initial.
      failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                       %key = value #( chavenfe = is_header-ChaveNFe )
                                       %action-executarProcesso = if_abap_behv=>mk-on ) ).

      reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                         %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                  text = |Fornecedor não encontrado para CNPJ { is_header-Emitente }!| ) ) ).

      return.
    endif.


    "Valida Destinatario XML x Pedido
    "Valida Emissor x Fornecedor // Busca ID do emissor com base no CNPJ
    data(ls_destinatario) = lcl_api_hub_read=>read_supplier( taxnumber1 = conv #( is_header-Destinatario ) ).

    if ls_destinatario-d-results is initial.
      failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                       %key = value #( chavenfe = is_header-ChaveNFe )
                                       %action-executarProcesso = if_abap_behv=>mk-on ) ).

      reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                         %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                  text = |Fornecedor não encontrado para CNPJ { is_header-Destinatario }!| ) ) ).

      return.
    endif.

    free rg_supplier.
    rg_supplier = value tt_rangesupplier( for line in ls_emissor-d-results ( option = 'EQ' sign = 'I' low = line-supplier ) ).
    select * from /exedminb/i_ped_abertos as _PedAbertos
      for all entries in @it_items
            where _Pedabertos~Supplier in @rg_supplier
              and _Pedabertos~Material eq @it_items-Material
              and _Pedabertos~QtdEmAberto > 0
            into table @data(lt_pedidosabertos).

    "Validações Itens
    loop at it_items into data(ls_items).
      "Validar se pedido liberado
      "Validar se pedido/item está eliminado/bloqueado
      select single from I_PurchaseOrderAPI01
       fields PurchasingProcessingStatus, PurchasingDocumentDeletionCode
      where PurchaseOrder eq @ls_items-Pedido
      into @data(ls_pedido).

      if ls_pedido-PurchasingDocumentDeletionCode ne abap_false.
        failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                         %key = value #( chavenfe = is_header-ChaveNFe )
                                         %action-executarProcesso = if_abap_behv=>mk-on ) ).

        reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                           %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                    text = |Pedido/item { ls_items-Pedido }/{ ls_items-ItemPedido } eliminado/bloqueado!| ) ) ).

        return.
      endif.

      if ls_pedido-PurchasingProcessingStatus ne '05'.
        failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                         %key = value #( chavenfe = is_header-ChaveNFe )
                                         %action-executarProcesso = if_abap_behv=>mk-on ) ).

        reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                           %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                    text = |Pedido { ls_items-Pedido } em aprovação!| ) ) ).

        return.
      endif.



      data(ls_product_plant) = lcl_api_hub_read=>read_product_plant( Product = conv #( ls_items-Material )
                                                                     Plant   = conv #( ls_items-Plant ) ).

      "Valida NCM
      if ls_product_plant-d-results is initial.
        failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                       %key = value #( chavenfe = is_header-ChaveNFe )
                                       %action-executarProcesso = if_abap_behv=>mk-on ) ).

        reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                           %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                    text = |Material ${ ls_items-Material } não encontrado para planta ${ ls_items-Plant }!| ) ) ).

        return.

      elseif not line_exists( ls_product_plant-d-results[ ConsumptionTaxCtrlCode = ls_items-ncm ] ).
        failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                       %key = value #( chavenfe = is_header-ChaveNFe )
                                       %action-executarProcesso = if_abap_behv=>mk-on ) ).

        reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                           %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                    text = 'NCM divergente de XML!' ) ) ).

        return.
      endif.


      "Valida Origem
      select single from I_ProductValuationBasic
        fields @abap_true
      where Product eq @ls_items-Material
        and ValuationArea eq @ls_items-Plant
        and ProductOriginType eq @ls_items-Origem
      into @data(ls_origin_valid).

      if ls_origin_valid is initial.
        failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                       %key = value #( chavenfe = is_header-ChaveNFe )
                                       %action-executarProcesso = if_abap_behv=>mk-on ) ).

        reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                           %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                    text = 'Origem divergente do XML!' ) ) ).

        return.
      endif.


      "Valida fornecedor fornecedor XML = Fornecedor Pedido

      select single from I_PurchaseOrderAPI01
       fields @abap_true
      where PurchaseOrder eq @ls_items-Pedido
        and Supplier in @rg_supplier
      into @data(ls_emissor_valid).

      if ls_emissor_valid is initial.
        failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                       %key = value #( chavenfe = is_header-ChaveNFe )
                                       %action-executarProcesso = if_abap_behv=>mk-on ) ).

        reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                           %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                    text = 'Fornecedor divergente do XML!' ) ) ).

        return.
      endif.

      "Verifica se existe algum dos fornecedores não bloqueados
      "Essa validaçao é do Header, porem só deve ocorrer apos validar fornecedor XML = Fornecedor Pedido
      if not line_exists( ls_emissor-d-results[ businesspartnerisblocked = abap_false ] ).
        failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                       %key = value #( chavenfe = is_header-ChaveNFe )
                                       %action-executarProcesso = if_abap_behv=>mk-on ) ).

        reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                           %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                    text = 'Fornecedor bloqueado!' ) ) ).

        return.
      endif.


      "Valida fornecedor emitente XML = emitente Pedido
      free rg_supplier.
      rg_supplier = value tt_rangesupplier( for line in ls_destinatario-d-results ( option = 'EQ' sign = 'I' low = line-supplier ) ).

      select single from I_PurchaseOrderAPI01
       fields @abap_true
      where PurchaseOrder eq @ls_items-Pedido
        and Customer in @rg_supplier
      into @data(ls_dest_valid).

      if ls_dest_valid is initial.
        failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                         %key = value #( chavenfe = is_header-ChaveNFe )
                                         %action-executarProcesso = if_abap_behv=>mk-on ) ).

        reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                           %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                    text = 'Emitente divergente do XML!' ) ) ).
        return.
      endif.


      "Validar saldo quantidade disponivel
      loop at lt_pedidosabertos assigning field-symbol(<f_ped_aberto>) where Pedido eq ls_items-Pedido
                                                                         and ItemPedido eq ls_items-ItemPedido
                                                                         and Qtdemaberto ge ls_items-Quantidade.
        <f_ped_aberto>-QtdEmAberto -= ls_items-Quantidade.
      endloop.

      if sy-subrc ne 0.
        failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                         %key = value #( chavenfe = is_header-ChaveNFe )
                                         %action-executarProcesso = if_abap_behv=>mk-on ) ).

        reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                           %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                    text = 'Pedido/Item não possui saldo disponível!' ) ) ).
        return.
      endif.

    endloop.
  endmethod.