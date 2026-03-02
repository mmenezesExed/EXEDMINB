   method cria_delivery.
     types:
       begin of ty_deep.
         include type zscm_inbound_delivery=>tys_a_inb_delivery_header_type.
     types:
         to_delivery_document_item type zscm_inbound_delivery=>tyt_a_inb_delivery_item_type,
       end of ty_deep.

     data:
       ls_business_data type ty_deep,
       lo_http_client   type ref to if_web_http_client,
       lo_client_proxy  type ref to /iwbep/if_cp_client_proxy,
       lo_request       type ref to /iwbep/if_cp_request_create,
       lo_response      type ref to /iwbep/if_cp_response_create.


     try.
         " Create http client
*DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
*                                             comm_scenario  = '<Comm Scenario>'
*                                             comm_system_id = '<Comm System Id>'
*                                             service_id     = '<Service Id>' ).
*lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

         " Create http client
         data(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
           comm_scenario = 'ZSCN_API_INBOUND_DELIVERY' ).
*                                                     comm_system_id = 'ZOUT_API_INBOUND_DELIVERY_REST' ) .
*                                             service_id     = '<Service Id>' ).
         lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

*          " Create http client
         lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
           exporting
              is_proxy_model_key       = value #( repository_id       = 'DEFAULT'
                                                  proxy_model_id      = 'ZSCM_INBOUND_DELIVERY'
                                                  proxy_model_version = '0001' )
             io_http_client             = lo_http_client
             iv_relative_service_root   = '' ).

         assert lo_http_client is bound.


* Prepare business data
         ls_business_data = value #(
             delivery_document = ''
             to_delivery_document_item = value #( ( delivery_document = '' reference_sddocument = '123455' ) )
         ).

         " Navigate to the resource and create a request for the create operation
         lo_request = lo_client_proxy->create_resource_for_entity_set( 'A_INB_DELIVERY_HEADER' )->create_request_for_create( ).

         " Return a data description node for the deep inboud delivery
         data(lo_data_desc_node_so) = lo_request->create_data_descripton_node( ).
*    " Set the properties of the Header node
         lo_data_desc_node_so->set_properties( value #( ( |DELIVERY_DOCUMENT| )  )  ).

         " Add a child node Item for a navigation property
         data(lo_data_desc_node_so_item) = lo_data_desc_node_so->add_child( 'TO_DELIVERY_DOCUMENT_ITEM' ).
         " Set the properties of the Item node
         lo_data_desc_node_so_item->set_properties( value #( ( |DELIVERY_DOCUMENT| )
                                                                 ( |REFERENCE_SDDOCUMENT| )
                                                                 ( |REFERENCE_SDDOCUMENT_ITEM| )
                                                                   ) ).


         lo_request->set_deep_business_data( is_business_data    = ls_business_data
                                             io_data_description = lo_data_desc_node_so ).

         " Execute the request
         lo_response = lo_request->execute( ).
         " Get the after image
*lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

       catch /iwbep/cx_cp_remote into data(lx_remote).
         " Handle remote Exception
         " It contains details about the problems of your http(s) connection


       catch /iwbep/cx_gateway into data(lx_gateway).
         " Handle Exception

       catch cx_web_http_client_error into data(lx_web_http_client_error).
         " Handle Exception
         raise shortdump lx_web_http_client_error.

     endtry.
   endmethod.