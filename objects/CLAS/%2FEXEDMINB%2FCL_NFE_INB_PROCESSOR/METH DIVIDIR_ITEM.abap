  method dividir_item.
    if it_keys is initial.
      "Raise Error
      exit.
    endif.

    read entities of /exedminb/i_nfemonitorh
      in local mode
      entity _nfemonitori
      all fields
      with value #( ( %tky = it_keys[ 1 ]-%tky ) )
      result data(lt_nfe_item_data).

    if lt_nfe_item_data is initial.
      "Raise Error
      exit.
    endif.

    data(ls_nfe_item_data) = lt_nfe_item_data[ 1 ].



    if it_keys[ 1 ]-%param-qCom = 0.
      failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                     %key = value #( chavenfe = ls_nfe_item_data-ChaveNFe )
                                     %action-executarProcesso = if_abap_behv=>mk-on ) ).
      reported-_nfemonitorh = value #( ( %key = value #( chavenfe = ls_nfe_item_data-ChaveNFe )
                                         %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                               text = 'Quantidade não pode ser 0!' ) ) ).
      exit.

    elseif ls_nfe_item_data-Quantidade - it_keys[ 1 ]-%param-qCom <= 0.
      failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                       %key = value #( chavenfe = ls_nfe_item_data-ChaveNFe )
                                       %action-executarProcesso = if_abap_behv=>mk-on ) ).
      reported-_nfemonitorh = value #( ( %key = value #( chavenfe = ls_nfe_item_data-ChaveNFe )
                                         %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                               text = 'Quant. do item inferior a quant. pretendida!' ) ) ).
      exit.
    endif.



    if it_keys[ 1 ]-%param-ValorICMS = 0.
      failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                     %key = value #( chavenfe = ls_nfe_item_data-ChaveNFe )
                                     %action-executarProcesso = if_abap_behv=>mk-on ) ).
      reported-_nfemonitorh = value #( ( %key = value #( chavenfe = ls_nfe_item_data-ChaveNFe )
                                         %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                               text = 'Valor ICMS não pode ser 0!' ) ) ).
      exit.

    elseif ls_nfe_item_data-ValorICMS - it_keys[ 1 ]-%param-ValorICMS <= 0.
      failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                       %key = value #( chavenfe = ls_nfe_item_data-ChaveNFe )
                                       %action-executarProcesso = if_abap_behv=>mk-on ) ).
      reported-_nfemonitorh = value #( ( %key = value #( chavenfe = ls_nfe_item_data-ChaveNFe )
                                         %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                               text = 'Valor ICMS inferior ao valor pretendido!' ) ) ).
      exit.
    endif.

    select max( ItemIdDiv ) from /exedminb/t_nfeitemdiv
      where Id eq @ls_nfe_item_data-ChaveNFe
        and ItemId eq @ls_nfe_item_data-ItemNFe
      into @data(lv_maxItemIdDiv).


    if ls_nfe_item_data-ItemIdDiv is initial.
      "Primeira divisão? Cria linha inicial
      lv_maxItemIdDiv += 10.

      modify entity in local mode /exedminb/i_nfemonitori
        create from value #( (  %cid = 'DIVIDIR'
                                ChaveNFe = ls_nfe_item_data-ChaveNFe
                                ItemNFe = ls_nfe_item_data-ItemNFe
                              ItemIdDiv = lv_maxItemIdDiv
                             Quantidade = ls_nfe_item_data-Quantidade - it_keys[ 1 ]-%param-qCom
                             ValorICMS  = ls_nfe_item_data-ValorICMS - it_keys[ 1 ]-%param-ValorICMS
                                   Lote = ls_nfe_item_data-Lote
                                 Pedido = ls_nfe_item_data-Pedido
                             ItemPedido = ls_nfe_item_data-ItemPedido ) ).

    else.
      "Já foi dividido? Edita quantidade da linha referencia
      modify entity in local mode /exedminb/i_nfemonitori
        update from value #( (  ChaveNFe = ls_nfe_item_data-ChaveNFe
                                 ItemNFe = ls_nfe_item_data-ItemNFe
                               ItemIdDiv = ls_nfe_item_data-ItemIdDiv
                              Quantidade = ls_nfe_item_data-Quantidade - it_keys[ 1 ]-%param-qCom
                               ValorICMS = ls_nfe_item_data-ValorICMS - it_keys[ 1 ]-%param-ValorICMS
                                    Lote = ls_nfe_item_data-Lote
                                %control = value #( Quantidade = if_abap_behv=>mk-on
                                                    Lote = if_abap_behv=>mk-on
                                                    ValorICMS = if_abap_behv=>mk-on ) ) ).

    endif.

    "Cria linha nova
    lv_maxItemIdDiv += 10.

    modify entity in local mode /exedminb/i_nfemonitori
        create from value #( ( %cid = 'DIVIDIR'
                               ChaveNFe = ls_nfe_item_data-ChaveNFe
                                ItemNFe = ls_nfe_item_data-ItemNFe
                              ItemIdDiv = lv_maxItemIdDiv
                             Quantidade = it_keys[ 1 ]-%param-qCom
                              ValorICMS = it_keys[ 1 ]-%param-ValorICMS
                                   Lote = it_keys[ 1 ]-%param-Lote ) ).
  endmethod.