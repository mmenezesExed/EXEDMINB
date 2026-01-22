  method get_nfe_xml_list.

    data: lo_http_client  type ref to if_web_http_client.

    try.

        data(lo_dest) = cl_http_destination_provider=>create_by_comm_arrangement(
          comm_scenario  = cc_comm_scenario
          service_id     = cc_srv_id_nfe_xml_list
          comm_system_id = cc_comm_system ).

        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).

        assert lo_http_client is bound.

        " execute the request
        data(lo_request) = lo_http_client->get_http_request( ).
        lo_request->set_uri_path( '' ).

        lo_request->set_query( 'startEntryDate=' && i_startEntryDate && 'endEntryDate=' && i_endEntryDate && '?nfeModel=' && i_nfeModel ).

        data(lo_response) = lo_http_client->execute( if_web_http_client=>get ).

        data(ls_http_status) = lo_response->get_status( ).

        e_xml_string  = lo_response->get_text( ).
        e_xml_xstring = lo_response->get_binary( ).
        e_status      = ls_http_status-code.

      catch cx_web_http_client_error into data(oref_web_http_client_error).
        " handle exception here
        raise shortdump oref_web_http_client_error.

      catch cx_http_dest_provider_error into data(oref_http_dest_provider_error).
        " handle exception here
        raise shortdump oref_http_dest_provider_error.

      catch cx_sy_conversion_codepage into data(lx_error).

        raise shortdump lx_error.

    endtry.

  endmethod.