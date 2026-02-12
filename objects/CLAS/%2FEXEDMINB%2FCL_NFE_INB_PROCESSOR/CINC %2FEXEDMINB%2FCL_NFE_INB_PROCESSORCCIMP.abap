*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

class lcl_abap_behv_msg implementation.

  method constructor.
    call method super->constructor exporting previous = previous.
    me->msgty = msgty .
    me->msgv1 = msgv1 .
    me->msgv2 = msgv2 .
    me->msgv3 = msgv3 .
    me->msgv4 = msgv4 .
    clear me->textid.
    if textid is initial.
      if_t100_message~t100key = if_t100_message=>default_textid.
    else.
      if_t100_message~t100key = textid.
    endif.
  endmethod.

endclass.

class lcl_api_hub_read definition.
  public section.
    types: begin of y_messages,
             msg type ref to if_abap_behv_message,
           end of y_messages.

    types tt_messages type table of y_messages.

    types: begin of ty_product_plant,
             Product                type string,
             Plant                  type string,
             ProfileCode            type string,
             ConsumptionTaxCtrlCode type string,
           end of ty_product_plant.

    types: tt_product_plant type standard table of ty_product_plant with empty key.

    types: begin of ty_d_product_plant,
             results type tt_product_plant,
           end of ty_d_product_plant.

    types: begin of ty_root_product_plant,
             d type ty_d_product_plant,
           end of ty_root_product_plant.

    types: begin of y_supplier,
             taxnumber1 type string,
           end of y_supplier.

    types: begin of ty_businesspartner,
             Supplier                 type string,
             BusinessPartnerIsBlocked type abap_boolean,
             to_Supplier              type y_supplier,
           end of ty_businesspartner.

    types: tt_businesspartner type standard table of ty_businesspartner with empty key.

    types: begin of ty_d_businesspartner,
             results type tt_businesspartner,
           end of ty_d_businesspartner.

    types: begin of ty_root_businesspartner,
             d type ty_d_businesspartner,
           end of ty_root_businesspartner.


    class-methods read_product_plant importing Product           type string
                                               Plant             type string
                                     returning value(es_results) type ty_root_product_plant.


    class-methods read_supplier importing TaxNumber1        type string
                                returning value(es_results) type ty_root_businesspartner.

    class-methods post_material_doc importing iv_data            type data
                                    returning value(rv_response) type if_web_http_response=>http_status.

    class-methods post_supplier_invoice importing iv_data            type data
                                        returning value(rv_response) type if_web_http_response=>http_status.

    class-methods get_messages exporting t_message type tt_messages.


  private section.
    class-data mt_log_messages type tt_messages.

    class-methods instance_http_client returning value(r_client) type ref to if_web_http_client.
    class-methods post importing url                type string
                                 data               type data
                       returning value(rv_response) type if_web_http_response=>http_status.
    class-methods ajust_expands importing i_payload        type string
                                returning value(r_payload) type string.

    class-methods register_message importing msg type ref to if_abap_behv_message.

endclass.

class lcl_api_hub_read implementation.
  method get_messages.
    t_message = mt_log_messages.
  endmethod.

  method register_message.
    append value #( msg = msg ) to mt_log_messages.
  endmethod.

  method read_product_plant.
    try.
        data(lo_client) = lcl_api_hub_read=>instance_http_client( ).
        lo_client->get_http_request( )->set_uri_path( |/sap/opu/odata/sap/API_PRODUCT_SRV/A_ProductPlant(Product=`{ Product }`,Plant=`{ Plant }`)?$format=json| ).
        data(lo_response) = lo_client->execute( if_web_http_client=>get ).

        if lo_response->get_status( )-code eq 200.
          /ui2/cl_json=>deserialize(
            exporting
              json = lo_response->get_text( )
            changing
              data = es_results
          ).
        endif.
      catch  cx_web_http_client_error  into data(lx_error).
        register_message( msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                      text = lx_error->get_text( ) ) ).
        return.
    endtry.
  endmethod.

  method read_supplier.
    try.
        data(lo_client) = lcl_api_hub_read=>instance_http_client( ).
        lo_client->get_http_request( )->set_uri_path(
          |/sap/opu/odata/sap/API_BUSINESS_PARTNER/A_BusinessPartner| &&
          |?$select=Supplier,BusinessPartnerIsBlocked,to_Supplier/TaxNumber1&| &&
          |$expand=to_Supplier&$filter=to_Supplier/TaxNumber1 eq '{ taxnumber1 }'&$format=json| ).

        data(lo_response) = lo_client->execute( if_web_http_client=>get ).

        if lo_response->get_status( )-code eq 200.
          /ui2/cl_json=>deserialize(
            exporting
              json = lo_response->get_text( )
            changing
              data = es_results
          ).
        endif.
      catch  cx_web_http_client_error  into data(lx_error).
        register_message( msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                      text = lx_error->get_text( ) ) ).
        return.
    endtry.

  endmethod.

  method instance_http_client.
    try.
        return new /exedminb/ct_api_product( )->create_web_http_client( ).
      catch cx_communication_target_error cx_appdestination cx_web_http_client_error into data(lx_error).
        register_message( msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                      text = lx_error->get_text( ) ) ).
        return.
    endtry.
  endmethod.

  method post_material_doc.
    try.
        return post( url = |/sap/opu/odata/sap/API_MATERIAL_DOCUMENT_SRV/A_MaterialDocumentHeader| data = iv_data ).
      catch  cx_web_http_client_error  into data(lx_error).
        register_message( msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                      text = lx_error->get_text( ) ) ).
        return value #( code = 500 ).
    endtry.
  endmethod.

  method post_supplier_invoice.
    try.
        return post( url = |/sap/opu/odata/sap/API_SUPPLIERINVOICE_PROCESS_SRV/A_SupplierInvoice| data = iv_data ).
      catch  cx_web_http_client_error  into data(lx_error).
        register_message( msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                      text = lx_error->get_text( ) ) ).
        return value #( code = 500 ).
    endtry.
  endmethod.

  method post.
    try.
        data(lo_client) = lcl_api_hub_read=>instance_http_client( ).
        lo_client->get_http_request( )->set_uri_path( url ).
        lo_client->set_csrf_token( ).

        lo_client->get_http_request( )->set_content_type( 'application/json' ).
        lo_client->get_http_request( )->append_text( data = ajust_expands( /ui2/cl_json=>serialize( data = data pretty_name = /ui2/cl_json=>pretty_mode-pascal_case ) ) ).

        data(response) = lo_client->execute( if_web_http_client=>post ).
        data(msg) = lcl_tools=>trata_html_text( response->get_text( ) ).

        if strlen( msg ) gt 49.
          data v1 type c length 49.
          data v2 type c length 49.
          data v3 type c length 49.
          data v4 type c length 49.

          v1 = msg.
          msg = msg+49.
          if strlen( msg ) gt 49.
            v2 = msg.
            msg = msg+49.

            if strlen( msg ) gt 49.
              v3 = msg.
              msg = msg+49.

              if strlen( msg ) gt 49.
                v4 = msg.
                msg = msg+49.
              else.
                v4 = msg.
              endif.
            else.
              v3 = msg.
            endif.
          else.
            v2 = msg.
          endif.

          register_message( msg = lcl_tools=>new_message( id = '/EXEDMINB/NFE_MSGS'
                                                          number = 000
                                                          severity = cond #( when response->get_status( )-code eq 200 then lcl_tools=>ms-success
                                                                             else lcl_tools=>ms-error )
                                                          v1 = v1
                                                          v2 = v2
                                                          v3 = v3
                                                          v4 = v4 ) ).
        else.
          register_message( msg = lcl_tools=>new_message_with_text( severity = cond #( when response->get_status( )-code eq 200 then lcl_tools=>ms-success
                                                                                       else lcl_tools=>ms-error )
                                                                        text = msg ) ).
        endif.



        return response->get_status( ).
      catch  cx_web_http_client_error  into data(lx_error).
        register_message( msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                      text = lx_error->get_text( ) ) ).
        return value #( code = 500 ).
    endtry.

  endmethod.

  method ajust_expands.
    r_payload = i_payload.
    replace `ToMaterialDocumentItem` in r_payload with `to_MaterialDocumentItem`.
    replace `ToBrSupplierInvoiceNfd` in r_payload with `to_BR_SupplierInvoiceNFDocument`.
    replace `ToSuplrInvcItemPurOrd`  in r_payload with `to_SuplrInvcItemPurOrdRef`.

    replace all occurrences of `SupplierInvoiceIdbyInvc`  in r_payload with `SupplierInvoiceIDByInvcgParty`.
    replace all occurrences of `TaxIsCalculatedAutomati`  in r_payload with `TaxIsCalculatedAutomatically`.
    replace all occurrences of `DirectQuotedExchangeRat`  in r_payload with `DirectQuotedExchangeRate`.
    replace all occurrences of `UnplannedDeliveryCostTa`  in r_payload with `UnplannedDeliveryCostTaxCode`.
    replace all occurrences of `UnplndDelivCostTaxJuri`   in r_payload with `UnplndDelivCostTaxJurisdiction`.
    replace all occurrences of `BrNfauthznProtocolNumbe`  in r_payload with `BR_NFAuthznProtocolNumber`.
    replace all occurrences of `BrNfauthznProtocolNum_2`  in r_payload with `BR_NFAuthznProtocolNumber16`.
    replace all occurrences of `QuantityInPurchaseOrder`  in r_payload with `QuantityInPurchaseOrderUnit`.
    replace all occurrences of `SupplierInvoiceItemAmou`  in r_payload with `SupplierInvoiceItemAmount`.
    replace all occurrences of `PurchaseOrderQtyUnitIs`   in r_payload with `PurchaseOrderQtyUnitISOCode`.
    replace all occurrences of `PurchaseOrderQtyUnitSa`   in r_payload with `PurchaseOrderQtyUnitSAPCode`.

  endmethod.

endclass.


class lcl_tools implementation.
  method convert_abap_timestamp_2_epoch.

    data:
      lv_date           type sydate,
      lv_days_timestamp type timestampl,
      lv_secs_timestamp type timestampl,
      lv_days_i         type i,
      lv_sec_i          type i,
      lv_timestamp      type timestampl,
      lv_dummy          type string.                        "#EC NEEDED

    constants:
       lc_day_in_sec type i value 86400.

* Milliseconds for the days since January 1, 1970, 00:00:00 GMT
* one day has 86400 seconds
    lv_date            = '19700101'.
    lv_days_i          = iv_date - lv_date.
* Timestamp for passed days until today in seconds
    lv_days_timestamp  = lv_days_i * lc_day_in_sec.

    lv_sec_i          = iv_time.
* Timestamp for time at present day
    lv_secs_timestamp = lv_sec_i.

    lv_timestamp = ( lv_days_timestamp + lv_secs_timestamp ) * 1000.
    ev_timestamp = lv_timestamp.

    split ev_timestamp at '.' into ev_timestamp lv_dummy.
    ev_timestamp = ev_timestamp + iv_msec.

    shift ev_timestamp right deleting trailing space.
    shift ev_timestamp left  deleting leading space.

    return |/Date({ ev_timestamp })/|.

  endmethod.

  method new_message.

    obj = new lcl_abap_behv_msg(
      textid = value #(
                 msgid = cond #( when id is initial then '/EXEDMINB/NFE_MSGS' else id )
                 msgno = number
                 attr1 = cond #( when v1 is not initial then 'IF_T100_DYN_MSG~MSGV1' )
                 attr2 = cond #( when v2 is not initial then 'IF_T100_DYN_MSG~MSGV2' )
                 attr3 = cond #( when v3 is not initial then 'IF_T100_DYN_MSG~MSGV3' )
                 attr4 = cond #( when v4 is not initial then 'IF_T100_DYN_MSG~MSGV4' )
      )
      msgty = switch #( severity
                when ms-error       then 'E'
                when ms-warning     then 'W'
                when ms-information then 'I'
                when ms-success     then 'S' )
      msgv1 = |{ v1 }|
      msgv2 = |{ v2 }|
      msgv3 = |{ v3 }|
      msgv4 = |{ v4 }|
    ).

    obj->m_severity = severity.

  endmethod.


  method new_message_with_text.

    obj = new_message(
      id       = 'SABP_BEHV'
      number   = 100
      severity = severity
      v1       = text
    ).

  endmethod.

  method trata_html_text.
    r_text = text.

    split r_text at '<message>' into data(trash) data(msg).
    if msg is not initial.
      split msg at '</message>' into msg trash.
      if msg is not initial.
        r_text = msg.
      endif.
    endif.
  endmethod.

endclass.