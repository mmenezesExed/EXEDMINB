  method executar_processo.
    data(cstat) = is_header-Status.

    "Valida se nota foi cancelada
    if cstat eq '101'.
      failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                       %key = value #( chavenfe = is_header-ChaveNFe )
                                       %action-executarProcesso = if_abap_behv=>mk-on ) ).
      reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                         %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                               text = 'Nota fiscal cancelada pelo fornecedor!' ) ) ).

      return.
    endif.

    "Valida se ja foi escriturada
    "Não existe a tabela J_1BNFE_ACTIVE, como validar?

    case is_header-Atividade.
      when '100'.
        me->atribuir_pedido_item( exporting is_header = is_header
                                  changing  it_items  = it_items
                                            mapped    = mapped
                                            failed    = failed
                                            reported  = reported ).

        if failed-_nfemonitorh is initial.
          header_changed-id = is_header-ChaveNFe.
          header_changed-atividade = '200'.
          header_changed-cstat = cstat.

          reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                             %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-success
                                                                                   text = 'Processado para Validação Geral!' ) ) ).

        endif.

      when '200'.
        me->validacao_geral( exporting is_header = is_header
                                       it_items  = it_items
                             changing  mapped    = mapped
                                       failed    = failed
                                       reported  = reported ).

        if failed-_nfemonitorh is initial.
          header_changed-id = is_header-ChaveNFe.
          header_changed-atividade = '300'.
          header_changed-cstat = cstat.

          reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                             %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-success
                                                                                   text = 'Processado para Validação de impostos!' ) ) ).

        endif.

      when '300'.
        "Validação Imposto
        me->validacao_impostos( exporting is_header = is_header
                                          it_items  = it_items
                                changing  mapped    = mapped
                                          failed    = failed
                                          reported  = reported ).

        if failed-_nfemonitorh is initial.
          header_changed-id = is_header-ChaveNFe.
          header_changed-atividade = '400'.
          header_changed-cstat = cstat.

          reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                             %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-success
                                                                                   text = 'Processado para Aguardando AR!' ) ) ).

        endif.

      when '400'.
        "Falta definição


        if failed-_nfemonitorh is initial.
          header_changed-id = is_header-ChaveNFe.
          header_changed-atividade = '500'.
          header_changed-cstat = cstat.

          reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                             %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-success
                                                                                   text = 'Processado para Aguardando MIGO!' ) ) ).

        endif.

      when '500'.
        me->executar_migo( exporting is_header = is_header
                                     it_items  = it_items
                           changing  mapped    = mapped
                                     failed    = failed
                                     reported  = reported ).

        if failed-_nfemonitorh is initial.
          header_changed-id = is_header-ChaveNFe.
          header_changed-atividade = '600'.
          header_changed-cstat = cstat.

          reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                             %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-success
                                                                                   text = 'Processado para Aguardando MIRO!' ) ) ).
        endif.

      when '600'.
        me->executar_miro( exporting is_header = is_header
                                     it_items  = it_items
                           changing  mapped    = mapped
                                     failed    = failed
                                     reported  = reported ).

        if failed-_nfemonitorh is initial.
          header_changed-id = is_header-ChaveNFe.
          header_changed-atividade = '700'.
          header_changed-cstat = cstat.

          reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                             %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-success
                                                                                   text = 'Processado para Processo finalizado!' ) ) ).
        endif.

      when '700'.
        reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                           %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-warning
                                                                                 text = 'Processo já finalizado!' ) ) ).

      when others.
        "Set initial atividade
        header_changed-id = is_header-ChaveNFe.
        header_changed-atividade = '100'.
        header_changed-cstat = cstat.

        reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                           %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-success
                                                                                 text = 'Processado para atividade inicial!' ) ) ).
    endcase.

  endmethod.