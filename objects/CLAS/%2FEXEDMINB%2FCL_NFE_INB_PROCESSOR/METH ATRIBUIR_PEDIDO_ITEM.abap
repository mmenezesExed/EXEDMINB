  method atribuir_pedido_item.
    if line_exists( it_items[ Pedido = '' ] ) or line_exists( it_items[ ItemPedido = '' ] ).
      "Busca pedidos do fornecedor
      select from /EXEDMINB/T_Mat_Fornc_SAP as _MatForn
        fields
            'I' as sign,
            'EQ' as option,
            _MatForn~Material_SAP as low,
            _MatForn~Material_SAP as high
        where cnpj eq @is_header-Emitente
          and Material_SAP is not initial
        into table @data(rg_Forn_mat).

      "Busca Id do fornecedor e monta range com eles
      data(rg_supplier) = value tt_rangesupplier( for line in lcl_api_hub_read=>read_supplier( taxnumber1 = conv #( is_header-Emitente ) )-d-results ( sign = 'I'
                                                                                                                                                       option = 'EQ'
                                                                                                                                                       low = line-supplier
                                                                                                                                                       high = line-supplier ) ).

      if rg_Forn_mat is not initial and rg_supplier is not initial.
        field-symbols <f_pedido_aberto> type /exedminb/i_ped_abertos.

        select * from /exedminb/i_ped_abertos as _PedAbertos
            where _Pedabertos~Supplier in @rg_supplier
              and _Pedabertos~Material in @rg_Forn_mat
              and _Pedabertos~QtdEmAberto > 0
            into table @data(lt_PedidosAbertos).

        loop at it_items assigning field-symbol(<f_item>) where Pedido is initial or ItemPedido is initial.
          if <f_item>-Pedido is not initial.
            loop at lt_PedidosAbertos assigning <f_pedido_aberto> where Pedido eq <f_item>-Pedido
                                                                    and QtdEmAberto ge <f_item>-Quantidade.
              <f_item>-ItemPedido = <f_pedido_aberto>-ItemPedido.
              <f_pedido_aberto>-QtdEmAberto -= <f_item>-Quantidade.
              exit.
            endloop.
          endif.

          if <f_item>-Pedido is initial and <f_item>-ItemPedido is initial.
            loop at lt_PedidosAbertos assigning <f_pedido_aberto> where QtdEmAberto ge <f_item>-Quantidade.
              <f_item>-Pedido = <f_pedido_aberto>-Pedido.
              <f_item>-ItemPedido = <f_pedido_aberto>-ItemPedido.
              <f_pedido_aberto>-QtdEmAberto -= <f_item>-Quantidade.
              exit.
            endloop.
          endif.
        endloop.
      endif.

      "Se apos busca dos pedidos abertos ainda houver item sem pedido/item, da erro
      if line_exists( it_items[ Pedido = '' ] ) or line_exists( it_items[ ItemPedido = '' ] ).
        failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                         %key = value #( chavenfe = is_header-ChaveNFe )
                                         %action-executarProcesso = if_abap_behv=>mk-on ) ).

        reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                           %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                    text = 'Preencher pedido/item!' ) ) ).
      endif.
    endif.
  endmethod.