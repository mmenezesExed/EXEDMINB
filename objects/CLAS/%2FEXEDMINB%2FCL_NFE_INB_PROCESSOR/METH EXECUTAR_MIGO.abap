   method executar_migo.
     types: begin of y_Material_Document_Item,
              goods_movement_type    type /exedminb/cl_api_material_doc=>tys_a_material_document_item_t-goods_movement_type,
              material               type /exedminb/cl_api_material_doc=>tys_a_material_document_item_t-material,
              plant                  type /exedminb/cl_api_material_doc=>tys_a_material_document_item_t-plant,
              storage_location       type /exedminb/cl_api_material_doc=>tys_a_material_document_item_t-storage_location,
              supplier               type /exedminb/cl_api_material_doc=>tys_a_material_document_item_t-supplier,
              purchase_order         type /exedminb/cl_api_material_doc=>tys_a_material_document_item_t-purchase_order,
              purchase_order_item    type /exedminb/cl_api_material_doc=>tys_a_material_document_item_t-purchase_order_item,
              quantity_in_base_unit  type string,
              "shelf_life_expiration_date  = '20170101'
              "manufacture_date            = '20170101'
              material_document_line type /exedminb/cl_api_material_doc=>tys_a_material_document_item_t-material_document_line,
            end of y_Material_Document_Item.

     types tt_Material_Document_Item type table of y_Material_Document_Item with empty key.

     types: begin of y_bisiness_data,
              document_date             type /exedminb/cl_api_material_doc=>tys_a_material_document_head_2-document_date,
              posting_date              type /exedminb/cl_api_material_doc=>tys_a_material_document_head_2-posting_date,
              reference_document        type /exedminb/cl_api_material_doc=>tys_a_material_document_head_2-reference_document,
              goods_movement_code       type /exedminb/cl_api_material_doc=>tys_a_material_document_head_2-goods_movement_code,
              to_Material_Document_Item type tt_Material_Document_Item,
            end of y_bisiness_data.


     data:
       ls_business_data        type y_bisiness_data,
       ls_business_data_result type y_bisiness_data,
       lo_http_client          type ref to if_web_http_client,
       lo_client_proxy         type ref to /iwbep/if_cp_client_proxy,
       lo_request              type ref to /iwbep/if_cp_request_create,
       lo_response             type ref to /iwbep/if_cp_response_create.


     try.
         cl_abap_tstmp=>systemtstmp_utc2syst(
           exporting
             utc_tstmp = cl_abap_tstmp=>utclong2tstmp_short( is_header-DataEmissao )
           importing
             syst_date = data(lv_document_date)
             syst_time = data(lv_document_time)
         ).

         select from I_PurchaseOrderItemAPI01
           fields PurchaseOrder,
                  PurchaseOrderItem,
                  material,
                  plant,
                  StorageLocation,
                  SupplierMaterialNumber
           for all entries in @it_items
           where PurchaseOrder = @it_items-Pedido
             and PurchaseOrderItem = @it_items-ItemPedido
           into table @data(lt_PurchaseOrderItemsDatas).


*       Prepare business data
         ls_business_data = value #(
           document_date               = lcl_tools=>convert_abap_timestamp_2_epoch( iv_date = lv_document_date )
           posting_date                = lcl_tools=>convert_abap_timestamp_2_epoch( iv_date = cl_abap_context_info=>get_system_date( ) )
           reference_document          = |{ is_header-NumeroNFe }{ is_header-Serie }|
           goods_movement_code         = '01'
           to_Material_Document_Item     = value #( for item in it_items index into idx (
              goods_movement_type         = '101'
              material                    = cond #( when line_exists( lt_PurchaseOrderItemsDatas[ PurchaseOrder = item-Pedido
                                                                                                  PurchaseOrderItem = item-ItemPedido ] ) then lt_PurchaseOrderItemsDatas[ PurchaseOrder = item-Pedido
                                                                                                                                                                           PurchaseOrderItem = item-ItemPedido ]-Material )
              plant                       = cond #( when line_exists( lt_PurchaseOrderItemsDatas[ PurchaseOrder = item-Pedido
                                                                                                  PurchaseOrderItem = item-ItemPedido ] ) then lt_PurchaseOrderItemsDatas[ PurchaseOrder = item-Pedido
                                                                                                                                                                           PurchaseOrderItem = item-ItemPedido ]-Plant )
              storage_location            = cond #( when line_exists( lt_PurchaseOrderItemsDatas[ PurchaseOrder = item-Pedido
                                                                                                  PurchaseOrderItem = item-ItemPedido ] ) then lt_PurchaseOrderItemsDatas[ PurchaseOrder = item-Pedido
                                                                                                                                                                           PurchaseOrderItem = item-ItemPedido ]-StorageLocation )
              supplier                    = cond #( when line_exists( lt_PurchaseOrderItemsDatas[ PurchaseOrder = item-Pedido
                                                                                                  PurchaseOrderItem = item-ItemPedido ] ) then lt_PurchaseOrderItemsDatas[ PurchaseOrder = item-Pedido
                                                                                                                                                                           PurchaseOrderItem = item-ItemPedido ]-SupplierMaterialNumber )
              purchase_order              = cond #( when line_exists( lt_PurchaseOrderItemsDatas[ PurchaseOrder = item-Pedido
                                                                                                  PurchaseOrderItem = item-ItemPedido ] ) then lt_PurchaseOrderItemsDatas[ PurchaseOrder = item-Pedido
                                                                                                                                                                           PurchaseOrderItem = item-ItemPedido ]-PurchaseOrder )
              purchase_order_item         = cond #( when line_exists( lt_PurchaseOrderItemsDatas[ PurchaseOrder = item-Pedido
                                                                                                  PurchaseOrderItem = item-ItemPedido ] ) then lt_PurchaseOrderItemsDatas[ PurchaseOrder = item-Pedido
                                                                                                                                                                           PurchaseOrderItem = item-ItemPedido ]-PurchaseOrderItem )
              quantity_in_base_unit       = '0'
              "shelf_life_expiration_date  = '20170101'
              "manufacture_date            = '20170101'
              material_document_line      = idx ) ) ).



         data(lv_response) = lcl_api_hub_read=>post_material_doc( ls_business_data ).

         if lv_response-code ne 200.
           failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                            %key = value #( chavenfe = is_header-ChaveNFe )
                                            %action-etapa_700 = if_abap_behv=>mk-on ) ).
         endif.

         lcl_api_hub_read=>get_messages( importing t_message = data(lt_message) ).

         loop at lt_message into data(ls_message).
           append value #( %key = value #( chavenfe = is_header-ChaveNFe )
                           %msg = ls_message-msg ) to reported-_nfemonitorh.
         endloop.

       catch cx_http_dest_provider_error cx_web_http_client_error /iwbep/cx_cp_remote /iwbep/cx_gateway into data(lx_ERROR).
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                          %key = value #( chavenfe = is_header-ChaveNFe )
                                          %action-etapa_700 = if_abap_behv=>mk-on ) ).
         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                         text = lx_ERROR->get_text( ) ) ) ).

     endtry.
   endmethod.