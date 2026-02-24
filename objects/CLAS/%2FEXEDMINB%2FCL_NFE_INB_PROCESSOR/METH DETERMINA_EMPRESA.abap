   method determina_empresa.
     "Valida Destinatario XML x Pedido
     "Valida Emissor // Busca ID do destinatario com base no CNPJ
     data(ls_destinatario) = lcl_api_hub_read=>read_supplier( taxnumber1 = conv #( cs_header-Destinatario ) ).

     if ls_destinatario-d-results is initial.
       failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                        %key = value #( chavenfe = cs_header-ChaveNFe )
                                        %action-etapa_200 = if_abap_behv=>mk-on ) ).

       reported-_nfemonitorh = value #( ( %key = value #( chavenfe = cs_header-ChaveNFe )
                                          %msg = lcl_tools=>new_message(
                                                     number   = 006
                                                     severity = lcl_tools=>ms-error
                                                           v1 = lcl_tools=>format_cnpj( cs_header-Destinatario ) ) ) ).

       return.
     endif.

     read table ls_destinatario-d-results index 1 into data(ls_supplier).

     ls_supplier-supplier = |{ ls_supplier-supplier width = 10 align = right pad = '0' }|.

     select single companycode
       from I_SupplierCompany
       where Supplier eq @ls_supplier-supplier
       into @cs_header-Empresa.

     if sy-subrc ne 0.
       failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                        %key = value #( chavenfe = cs_header-ChaveNFe )
                                        %action-etapa_200 = if_abap_behv=>mk-on ) ).

       reported-_nfemonitorh = value #( ( %key = value #( chavenfe = cs_header-ChaveNFe )
                                          %msg = lcl_tools=>new_message(
                                                     number   = 003
                                                     severity = lcl_tools=>ms-error
                                                           v1 = lcl_tools=>format_cnpj( cs_header-Destinatario ) ) ) ).

       return.
     endif.

     cs_header-LocalDeNegocio = cs_header-Destinatario+8(4).

   endmethod.