   method validacao_geral.
     data rg_supplier type tt_rangesupplier.

     "Validações Header

     "Valida Fornecedor XML x Pedido // Busca ID do emissor com base no CNPJ
     data(ls_emissor) = lcl_api_hub_read=>read_supplier( taxnumber1 = conv #( is_header-Emitente ) ).

     if ls_emissor-d-results is initial.
       failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                        %key = value #( chavenfe = is_header-ChaveNFe )
                                        %action-etapa_200 = if_abap_behv=>mk-on ) ).

       reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                          %msg = lcl_tools=>new_message(
                                                     number   = 005
                                                     severity = lcl_tools=>ms-error
                                                           v1 = is_header-Emitente ) ) ).

       return.
     endif.

     "Verifica se Emitente não bloqueados
     if not line_exists( ls_emissor-d-results[ businesspartnerisblocked = abap_false ] ).
       failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                      %key = value #( chavenfe = is_header-ChaveNFe )
                                      %action-etapa_200 = if_abap_behv=>mk-on ) ).

       reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                          %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                   text = 'Fornecedor bloqueado!' ) ) ).

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

     if lt_pedidosabertos is initial.
       failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                        %key = value #( chavenfe = is_header-ChaveNFe )
                                        %action-etapa_200 = if_abap_behv=>mk-on ) ).

       reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                          %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                   text = 'Fornecedor não possui pedidos em aberto!' ) ) ).

       return.
     endif.


     "Validações Itens
     loop at it_items into data(ls_items) where Pedido is not initial
                                            and ItemPedido is not initial.

       "Valida Fornecedor XML = Fornecedor Pedido
       select single from I_PurchaseOrderAPI01
        fields @abap_true
       where PurchaseOrder eq @ls_items-Pedido
         and Supplier in @rg_supplier
       into @data(ls_emissor_valid).

       if ls_emissor_valid is initial.
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                        %key = value #( chavenfe = is_header-ChaveNFe )
                                        %action-etapa_200 = if_abap_behv=>mk-on ) ).

         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                     text = 'Fornecedor divergente do XML!' ) ) ).

         continue.
       endif.

       "Valida Destinatario XML = Destinatario Pedido
       select single from I_PurchaseOrderAPI01 as _po
               inner join I_Supplier as _Emit on _po~Customer eq _Emit~Supplier
        fields @abap_true
       where _po~PurchaseOrder eq @ls_items-Pedido
         and _Emit~TaxNumber1 eq @is_header-Destinatario
       into @data(ls_dest_valid).

       if ls_dest_valid is initial.
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                          %key = value #( chavenfe = is_header-ChaveNFe )
                                          %action-etapa_200 = if_abap_behv=>mk-on ) ).

         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                     text = 'Destinatario divergente do XML!' ) ) ).
         continue.
       endif.

       "Validar se pedido liberado
       "Validar se pedido/item está eliminado/bloqueado
       select single from I_PurchaseOrderAPI01
        fields PurchasingProcessingStatus, PurchasingDocumentDeletionCode
       where PurchaseOrder eq @ls_items-Pedido
       into @data(ls_pedido).

       if ls_pedido-PurchasingDocumentDeletionCode ne abap_false.
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                          %key = value #( chavenfe = is_header-ChaveNFe )
                                          %action-etapa_200 = if_abap_behv=>mk-on ) ).

         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                     text = |Pedido/item { ls_items-Pedido }/{ ls_items-ItemPedido } eliminado/bloqueado!| ) ) ).

         continue.
       endif.

       if ls_pedido-PurchasingProcessingStatus ne '05'.
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                          %key = value #( chavenfe = is_header-ChaveNFe )
                                          %action-etapa_200 = if_abap_behv=>mk-on ) ).

         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                     text = |Pedido { ls_items-Pedido } em aprovação!| ) ) ).

         continue.
       endif.



       data(ls_product_plant) = lcl_api_hub_read=>read_product_plant( Product = conv #( ls_items-Material )
                                                                      Plant   = conv #( ls_items-Plant ) ).

       "Valida NCM
       if ls_product_plant-d-results is initial.
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                        %key = value #( chavenfe = is_header-ChaveNFe )
                                        %action-etapa_200 = if_abap_behv=>mk-on ) ).

         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                     text = |Material ${ ls_items-Material } não encontrado para planta ${ ls_items-Plant }!| ) ) ).

         continue.

       elseif not line_exists( ls_product_plant-d-results[ ConsumptionTaxCtrlCode = ls_items-ncm ] ).
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                        %key = value #( chavenfe = is_header-ChaveNFe )
                                        %action-etapa_200 = if_abap_behv=>mk-on ) ).

         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                     text = 'NCM divergente de XML!' ) ) ).

         continue.
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
                                        %action-etapa_200 = if_abap_behv=>mk-on ) ).

         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                     text = 'Origem divergente do XML!' ) ) ).

         continue.
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
                                          %action-etapa_200 = if_abap_behv=>mk-on ) ).

         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                     text = 'Pedido/Item não possui saldo disponível!' ) ) ).
         continue.
       endif.
     endloop.

     "Se n apresentou erro nos itens com pedido item, verifica se há linhas
     "com pedido ou item vazio para status pendente açao usuario
     if failed-_nfemonitorh is initial.
       loop at it_items transporting no fields where Pedido is initial
                                                  or ItemPedido is initial.
         itens_sem_pedido = abap_true.
         exit.
       endloop.

     endif.
   endmethod.