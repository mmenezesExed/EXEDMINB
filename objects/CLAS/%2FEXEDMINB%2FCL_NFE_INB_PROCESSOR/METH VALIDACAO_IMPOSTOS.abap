  method validacao_impostos.
    select from I_PurchaseOrderAPI01 as _Po
           join i_slsprcgconditionrecord as _Prc on _Prc~ConditionRecord = _Po~PricingDocument
      fields _Po~Purchaseorder, _Prc~ConditionType, _Prc~ConditionRateValue
      for all entries in @it_items
      where _Po~Purchaseorder eq @it_items-Pedido
        and ( _Prc~ConditionType eq 'ICM0' or _Prc~ConditionType eq 'ICM1' or _Prc~ConditionType eq 'ICM2' or
              _Prc~ConditionType eq 'IPI0' or _Prc~ConditionType eq 'IPI1' or _Prc~ConditionType eq 'IPI2' )
      into table @data(lt_PricingDocs).

    if sy-subrc ne 0.
      failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                         %key = value #( chavenfe = is_header-ChaveNFe )
                                         %action-executarProcesso = if_abap_behv=>mk-on ) ).

      reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                         %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                      text = 'Dados dos impostos não encontrado!' ) ) ).
    endif.

    sort lt_PricingDocs by Purchaseorder ConditionType.

    data lt_prc_tot like lt_PricingDocs.
    field-symbols <f_prc_tot> like line of lt_prc_tot.

    loop at lt_PricingDocs into data(ls_pricingdocs).
      data(ls_values) = ls_pricingdocs.

      if <f_prc_tot> is not assigned or ls_values-ConditionType(3) ne <f_prc_tot>-ConditionType.
        append initial line to lt_prc_tot assigning <f_prc_tot>.
        <f_prc_tot>-ConditionType = ls_values-ConditionType(3).
      endif.

      <f_prc_tot>-ConditionRateValue += ls_pricingdocs-ConditionRateValue.

    endloop.

    if lt_prc_tot is initial.
      failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                           %key = value #( chavenfe = is_header-ChaveNFe )
                                           %action-executarProcesso = if_abap_behv=>mk-on ) ).

      reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                         %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                      text = 'Dados dos impostos não encontrado!' ) ) ).
    endif.

    if ( ( is_header-ValorTotalICMS gt 0 and not line_exists( lt_prc_tot[ ConditionType = 'ICM' ] ) ) or
         ( is_header-ValorTotalICMS gt 0 and line_exists( lt_prc_tot[ ConditionType = 'ICM' ] ) and lt_prc_tot[ ConditionType = 'ICM' ]-ConditionRateValue ne is_header-ValorTotalICMS ) or
         ( is_header-ValorTotalIPI gt 0 and not line_exists( lt_prc_tot[ ConditionType = 'IPI' ] ) ) or
         ( is_header-ValorTotalIPI gt 0 and line_exists( lt_prc_tot[ ConditionType = 'IPI' ] ) and lt_prc_tot[ ConditionType = 'IPI' ]-ConditionRateValue ne is_header-ValorTotalIPI ) ).
      failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                         %key = value #( chavenfe = is_header-ChaveNFe )
                                         %action-executarProcesso = if_abap_behv=>mk-on ) ).

      reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                         %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                      text = 'Dados de impostos do pedido divergentes com XML!' ) ) ).

    endif.
  endmethod.