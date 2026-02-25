   method validacao_geral.
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
                                                           v1 = lcl_tools=>format_cnpj( is_header-Emitente ) ) ) ).

       return.
     endif.

     read table ls_emissor-d-results index 1 into data(ls_supplier).

     ls_supplier-supplier = |{ ls_supplier-supplier width = 10 align = right pad = '0' }|.

     "Verifica se Emitente não bloqueados
     if ls_supplier-businesspartnerisblocked ne abap_false.
       failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                      %key = value #( chavenfe = is_header-ChaveNFe )
                                      %action-etapa_200 = if_abap_behv=>mk-on ) ).

       reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                          %msg = lcl_tools=>new_message(
                                                     number   = 007
                                                     severity = lcl_tools=>ms-error
                                                           v1 = lcl_tools=>format_cnpj( is_header-Emitente ) ) ) ).

       return.
     endif.

     select * from /exedminb/i_ped_abertos as _PedAbertos
             where _Pedabertos~Supplier eq @ls_supplier-supplier
               and _Pedabertos~QtdEmAberto > 0
             into table @data(lt_pedidosabertos).

     if lt_pedidosabertos is initial.
       failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                        %key = value #( chavenfe = is_header-ChaveNFe )
                                        %action-etapa_200 = if_abap_behv=>mk-on ) ).

       reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                          %msg = lcl_tools=>new_message(
                                                     number   = 008
                                                     severity = lcl_tools=>ms-error
                                                           v1 = lcl_tools=>format_cnpj( is_header-Emitente ) ) ) ).

       return.
     endif.


     "Validações Itens
     loop at it_items into data(ls_items) where Pedido is not initial
                                            and ItemPedido is not initial.

       "Busca dados pedido/item
       select single from I_PurchaseOrderAPI01      as _PO
               inner join I_PurchaseOrderItemAPI01  as _POItem on _PO~PurchaseOrder = _POItem~PurchaseOrder
               inner join /exedminb/i_ped_abertos   as _POIAberto on _POItem~PurchaseOrder = _POIAberto~Pedido
                                                                 and _POItem~PurchaseOrderItem = _POIAberto~ItemPedido
          left outer join I_Plant                   as _Centro on _Centro~Plant = _POItem~Plant

          left outer join I_ProductValuationBasic   as _PVB    on _PVB~Product = _POItem~Material
                                                              and _PVB~ValuationArea = _POItem~Plant

        fields _PO~PurchaseOrder, _POItem~PurchaseOrderItem, _PO~PurchasingProcessingStatus, _PVB~ProductOriginType, _PO~CompanyCode, _Centro~BusinessPlace,
               _PO~PurchasingDocumentDeletionCode, _PO~Supplier, _PO~Customer, _POItem~Material, _POItem~Plant, _POIAberto~QtdConsumida, _POIAberto~QtdEmAberto

       where _PO~PurchaseOrder eq @ls_items-Pedido
         and _POItem~PurchaseOrderItem eq @ls_items-ItemPedido
       into @data(ls_pedido).

       "Pedido existe?
       if ls_pedido is initial.
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                          %key = value #( chavenfe = is_header-ChaveNFe )
                                          %action-etapa_200 = if_abap_behv=>mk-on ) ).

         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message(
                                                     number   = 010
                                                     severity = lcl_tools=>ms-error
                                                           v1 = ls_items-Pedido
                                                           v2 = ls_items-ItemPedido ) ) ).
       endif.

       "Valida Fornecedor XML = Fornecedor Pedido
       if ls_pedido-Supplier ne ls_supplier-supplier.
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                          %key = value #( chavenfe = is_header-ChaveNFe )
                                          %action-etapa_200 = if_abap_behv=>mk-on ) ).

         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message(
                                                     number   = 009
                                                     severity = lcl_tools=>ms-error
                                                           v1 = ls_items-Pedido ) ) ).

         continue.
       endif.

       "Valida Local Negocio Destinatario X Centro Pedido
       if ls_pedido-BusinessPlace ne is_header-LocalDeNegocio or
          ls_pedido-CompanyCode ne is_header-Empresa.
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                          %key = value #( chavenfe = is_header-ChaveNFe )
                                          %action-etapa_200 = if_abap_behv=>mk-on ) ).

         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message(
                                                     number   = 002
                                                     severity = lcl_tools=>ms-error
                                                           v1 = ls_items-Pedido ) ) ).
         continue.
       endif.

       "Validar se pedido liberado
       "Validar se pedido/item está eliminado/bloqueado
       if ls_pedido-PurchasingDocumentDeletionCode ne abap_false.
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                          %key = value #( chavenfe = is_header-ChaveNFe )
                                          %action-etapa_200 = if_abap_behv=>mk-on ) ).

         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message(
                                                     number   = 011
                                                     severity = lcl_tools=>ms-error
                                                           v1 = ls_items-Pedido
                                                           v2 = ls_items-ItemPedido ) ) ).

         continue.
       endif.

       if ls_pedido-PurchasingProcessingStatus ne '05'.
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                          %key = value #( chavenfe = is_header-ChaveNFe )
                                          %action-etapa_200 = if_abap_behv=>mk-on ) ).

         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message(
                                                     number   = 012
                                                     severity = lcl_tools=>ms-error
                                                           v1 = ls_items-Pedido ) ) ).

         continue.
       endif.

       "Possui material?
       if ls_pedido-Material is initial.
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                          %key = value #( chavenfe = is_header-ChaveNFe )
                                          %action-etapa_200 = if_abap_behv=>mk-on ) ).

         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message(
                                                     number   = 014
                                                     severity = lcl_tools=>ms-error
                                                           v1 = ls_items-Pedido
                                                           v2 = ls_items-ItemPedido ) ) ).
       endif.


       data(ls_product_plant) = lcl_api_hub_read=>read_product_plant( Product = conv #( ls_pedido-Material )
                                                                      Plant   = conv #( ls_pedido-Plant ) ).

       "Valida NCM
       ls_items-ncm = replace( val = ls_items-ncm sub = '.' with = '' occ = 0 ).
       if ls_product_plant-d-results is initial.
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                          %key = value #( chavenfe = is_header-ChaveNFe )
                                          %action-etapa_200 = if_abap_behv=>mk-on ) ).

         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message(
                                                     number   = 013
                                                     severity = lcl_tools=>ms-error
                                                           v1 = ls_pedido-Material
                                                           v2 = ls_pedido-Plant ) ) ).

         continue.

       elseif not line_exists( ls_product_plant-d-results[ ConsumptionTaxCtrlCode = ls_items-ncm ] ).
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                          %key = value #( chavenfe = is_header-ChaveNFe )
                                          %action-etapa_200 = if_abap_behv=>mk-on ) ).

         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message(
                                                     number   = 015
                                                     severity = lcl_tools=>ms-error
                                                           v1 = ls_items-Pedido
                                                           v2 = ls_items-ItemPedido
                                                           v3 = ls_pedido-Material  ) ) ).

         continue.
       endif.


       "Valida Origem
       if ls_items-Origem ne ls_pedido-ProductOriginType.
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                          %key = value #( chavenfe = is_header-ChaveNFe )
                                          %action-etapa_200 = if_abap_behv=>mk-on ) ).

         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message(
                                                     number   = 016
                                                     severity = lcl_tools=>ms-error
                                                           v1 = ls_items-Pedido
                                                           v2 = ls_items-ItemPedido
                                                           v3 = ls_pedido-Material
                                                           v4 = ls_pedido-Plant   ) ) ).

         continue.
       endif.


       "Validar saldo quantidade disponivel
       if ls_pedido-QtdEmAberto ge ls_items-Quantidade.
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                          %key = value #( chavenfe = is_header-ChaveNFe )
                                          %action-etapa_200 = if_abap_behv=>mk-on ) ).

         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message(
                                                     number   = 017
                                                     severity = lcl_tools=>ms-error
                                                           v1 = ls_items-Pedido
                                                           v2 = ls_items-ItemPedido ) ) ).
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