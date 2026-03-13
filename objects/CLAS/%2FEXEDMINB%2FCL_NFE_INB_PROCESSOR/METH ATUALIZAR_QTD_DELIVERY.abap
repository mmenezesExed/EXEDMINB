   method atualizar_qtd_delivery.

     loop at it_delivery into data(ls_delivery).


       data:
         ls_business_data type /exedminb/sc_api_delivery=>tys_a_inb_delivery_item_type,
         ls_entity_key    type /exedminb/sc_api_delivery=>tys_a_inb_delivery_item_type,
         lo_http_client   type ref to if_web_http_client,
         lo_client_proxy  type ref to /iwbep/if_cp_client_proxy,
         lo_resource      type ref to /iwbep/if_cp_resource_entity,
         lo_request       type ref to /iwbep/if_cp_request_update,
         lo_response      type ref to /iwbep/if_cp_response_update.


       try.

           " Create http client
           data(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement( comm_scenario = '/EXEDMINB/SCN_API_DELIVERY' ).
           lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

*        " Create http client
           lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
             exporting
                is_proxy_model_key       = value #( repository_id       = 'DEFAULT'
                                                    proxy_model_id      = '/EXEDMINB/SC_API_DELIVERY'
                                                    proxy_model_version = '0001' )
               io_http_client             = lo_http_client
               iv_relative_service_root   = '' ).

           assert lo_http_client is bound.


           " Set entity key
           ls_entity_key = value #(
                     delivery_document       = ls_delivery-Delivery
                     delivery_document_item  = ls_delivery-DeliveryDocumentItem ).

           " Prepare the business data
           ls_business_data = value #(
                     actual_delivery_quantity    = ls_delivery-ActualDeliveryQuantity ).

           " Navigate to the resource and create a request for the update operation
           lo_resource = lo_client_proxy->create_resource_for_entity_set( 'A_INB_DELIVERY_ITEM' )->navigate_with_key( ls_entity_key ).

           data(lo_read_request) = lo_resource->create_request_for_read( ).
           data(lo_read_response) = lo_read_request->execute( ).
           data(lv_etag) = lo_read_response->get_etag( ).

           lo_request = lo_resource->create_request_for_update( /iwbep/if_cp_request_update=>gcs_update_semantic-patch ).

           " ETag is needed
           lo_request->set_if_match( lv_etag ).
           lo_request->set_business_data( exporting is_business_data     = ls_business_data
                                                    it_provided_property = value #( ( |ACTUAL_DELIVERY_QUANTITY| ) ) ).

           " Execute the request and retrieve the business data
           lo_response = lo_request->execute( ).

         catch cx_http_dest_provider_error cx_web_http_client_error into data(lx_http_error).
           failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                            %key = value #( chavenfe = ls_delivery-ChaveNFe )
                                            %action-etapa_400 = if_abap_behv=>mk-on ) ).

           append value #( %key = value #( chavenfe = ls_delivery-ChaveNFe )
                                             %msg = lcl_tools=>new_message(
                                                        number   = 993
                                                        severity = lcl_tools=>ms-information ) ) to reported-_nfemonitorh.

         catch /iwbep/cx_cp_remote into data(lx_remote_error).
           failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                            %key = value #( chavenfe = ls_delivery-ChaveNFe )
                                            %action-etapa_400 = if_abap_behv=>mk-on ) ).

           append value #( %key = value #( chavenfe = ls_delivery-ChaveNFe )
                                             %msg = lcl_tools=>new_message(
                                                        number   = 993
                                                        severity = lcl_tools=>ms-information ) ) to reported-_nfemonitorh.

           data(body) = lx_remote_error->http_error_body.
           lcl_tools=>extracs_json_messages( exporting json        = body
                                             importing et_messages = data(ls_reported) ).

           append lines of ls_reported-_nfemonitorh to reported-_nfemonitorh.


         catch /iwbep/cx_gateway into data(lx_error).
           failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                            %key = value #( chavenfe = ls_delivery-ChaveNFe )
                                            %action-etapa_400 = if_abap_behv=>mk-on ) ).

           append value #( %key = value #( chavenfe = ls_delivery-ChaveNFe )
                                             %msg = lcl_tools=>new_message(
                                                        number   = 993
                                                        severity = lcl_tools=>ms-information ) ) to reported-_nfemonitorh.


           append value #( %key = value #( chavenfe = ls_delivery-ChaveNFe )
                                             %msg = lcl_tools=>new_message(
                                                        number   = 900
                                                        severity = lcl_tools=>ms-information
                                                        v1 = lx_error->get_longtext( ) ) ) to reported-_nfemonitorh.


       endtry.
     endloop.

   endmethod.