   method entrada_mercadoria.

     types ty_return type standard table of /exedminb/sc_api_delivery=>tys_putaway_report.

     data:
       ls_parameter         type /exedminb/sc_api_delivery=>tys_parameters_11,
       la_business_data     type ty_return,
       lo_http_client       type ref to if_web_http_client,
       lo_client_proxy      type ref to /iwbep/if_cp_client_proxy,
       lo_function_request  type ref to /iwbep/if_cp_request_function,
       lo_function          type ref to /iwbep/if_cp_resource_function,
       lo_function_response type ref to /iwbep/if_cp_response_function.


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


*        Prepare parameter
         ls_parameter = value #(
                   delivery_document           = iv_delivery
                   actual_goods_movement_date  = |{ cl_abap_context_info=>get_system_date( ) }{ cl_abap_context_info=>get_system_time( ) }| ).

         " Navigate to the resource and create a request for the create operation
         lo_function = lo_client_proxy->create_resource_for_function( 'POST_GOODS_RECEIPT' ).
         lo_function->set_parameter( is_parameter = ls_parameter ).
         lo_function_request = lo_function->create_request( ).

         " Execute the request
         lo_function_response = lo_function_request->execute( /iwbep/if_cp_request_function=>gcs_http_method-post ).

         " Get the after image
         lo_function_response->get_business_data( importing ea_response_data = la_business_data ).

       catch cx_http_dest_provider_error cx_web_http_client_error into data(lx_http_error).
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                          %action-etapa_700 = if_abap_behv=>mk-on ) ).

         append value #( %msg = lcl_tools=>new_message( number   = 990
                                                        severity = lcl_tools=>ms-information ) ) to reported-_nfemonitorh.

       catch /iwbep/cx_cp_remote into data(lx_remote_error).
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                          %action-etapa_700 = if_abap_behv=>mk-on ) ).

         append value #( %msg = lcl_tools=>new_message( number   = 990
                                                        severity = lcl_tools=>ms-information ) ) to reported-_nfemonitorh.

         data(body) = lx_remote_error->http_error_body.
         lcl_tools=>extracs_json_messages( exporting json        = body
                                           importing et_messages = data(ls_reported) ).

         append lines of ls_reported-_nfemonitorh to reported-_nfemonitorh.


       catch /iwbep/cx_gateway into data(lx_error).
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                          %action-etapa_700 = if_abap_behv=>mk-on ) ).

         append value #( %msg = lcl_tools=>new_message( number   = 990
                                                        severity = lcl_tools=>ms-information ) ) to reported-_nfemonitorh.


         append value #( %msg = lcl_tools=>new_message( number   = 900
                                                        severity = lcl_tools=>ms-information
                                                        v1 = lx_error->get_longtext( ) ) ) to reported-_nfemonitorh.

     endtry.

   endmethod.