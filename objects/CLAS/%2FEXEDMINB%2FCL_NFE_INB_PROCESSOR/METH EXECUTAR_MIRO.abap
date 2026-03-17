   method executar_miro.
     types:
       " Estrutura para os dados de Nota Fiscal Brasil
       begin of ty_br_nfe,
         br_nfauthentication_date   type /exedminb/sc_api_supplinv_proc=>tys_a_br_supplier_invoice_nf_2-br_nfauthentication_date,
         br_nfauthentication_time   type /exedminb/sc_api_supplinv_proc=>tys_a_br_supplier_invoice_nf_2-br_nfauthentication_time,
         br_nfauthzn_protocol_numbe type /exedminb/sc_api_supplinv_proc=>tys_a_br_supplier_invoice_nf_2-br_nfauthzn_protocol_numbe,
         br_nfauthzn_protocol_num_2 type /exedminb/sc_api_supplinv_proc=>tys_a_br_supplier_invoice_nf_2-br_nfauthzn_protocol_num_2,
         br_nfe_random_number       type /exedminb/sc_api_supplinv_proc=>tys_a_br_supplier_invoice_nf_2-br_nfe_random_number,
         br_nftype                  type /exedminb/sc_api_supplinv_proc=>tys_a_br_supplier_invoice_nf_2-br_nftype,
         br_nota_fiscal             type /exedminb/sc_api_supplinv_proc=>tys_a_br_supplier_invoice_nf_2-br_nota_fiscal,
       end of ty_br_nfe,

       " Estrutura para os Itens do Pedido (Purchase Order Items)
       begin of ty_po_item,
         supplier_invoice_item      type /exedminb/sc_api_supplinv_proc=>tys_a_suplr_invc_item_pur_or_2-supplier_invoice_item,
         purchase_order             type /exedminb/sc_api_supplinv_proc=>tys_a_suplr_invc_item_pur_or_2-purchase_order,
         purchase_order_item        type /exedminb/sc_api_supplinv_proc=>tys_a_suplr_invc_item_pur_or_2-purchase_order_item,
         reference_document         type /exedminb/sc_api_supplinv_proc=>tys_a_suplr_invc_item_pur_or_2-reference_document,
         reference_document_fiscal  type /exedminb/sc_api_supplinv_proc=>tys_a_suplr_invc_item_pur_or_2-reference_document_fiscal,
         reference_document_item    type /exedminb/sc_api_supplinv_proc=>tys_a_suplr_invc_item_pur_or_2-reference_document_item,
         tax_code                   type /exedminb/sc_api_supplinv_proc=>tys_a_suplr_invc_item_pur_or_2-tax_code,
         quantity_in_purchase_order type string,
         supplier_invoice_item_amou type string,
         document_currency          type /exedminb/sc_api_supplinv_proc=>tys_a_suplr_invc_item_pur_or_2-document_currency,
         purchase_order_qty_unit_is type /exedminb/sc_api_supplinv_proc=>tys_a_suplr_invc_item_pur_or_2-purchase_order_qty_unit_is,
         purchase_order_qty_unit_sa type /exedminb/sc_api_supplinv_proc=>tys_a_suplr_invc_item_pur_or_2-purchase_order_qty_unit_sa,
       end of ty_po_item,
       tt_po_items type standard table of ty_po_item with empty key,

       " Estrutura Principal (Header)
       begin of ty_business_data,
         company_code               type /exedminb/sc_api_supplinv_proc=>tys_a_supplier_invoice_type-company_code,
         document_currency          type /exedminb/sc_api_supplinv_proc=>tys_a_supplier_invoice_type-document_currency,
         document_date              type /exedminb/sc_api_supplinv_proc=>tys_a_supplier_invoice_type-document_date,
         invoice_gross_amount       type /exedminb/sc_api_supplinv_proc=>tys_a_supplier_invoice_type-invoice_gross_amount,
         invoicing_party            type /exedminb/sc_api_supplinv_proc=>tys_a_supplier_invoice_type-invoicing_party,
         posting_date               type /exedminb/sc_api_supplinv_proc=>tys_a_supplier_invoice_type-posting_date,
         supplier_invoice_idby_invc type /exedminb/sc_api_supplinv_proc=>tys_a_supplier_invoice_type-supplier_invoice_idby_invc,
         accounting_document_type   type /exedminb/sc_api_supplinv_proc=>tys_a_supplier_invoice_type-accounting_document_type,
         tax_is_calculated_automati type /exedminb/sc_api_supplinv_proc=>tys_a_supplier_invoice_type-tax_is_calculated_automati,
         direct_quoted_exchange_rat type /exedminb/sc_api_supplinv_proc=>tys_a_supplier_invoice_type-direct_quoted_exchange_rat,
         document_header_text       type /exedminb/sc_api_supplinv_proc=>tys_a_supplier_invoice_type-document_header_text,
         payment_terms              type /exedminb/sc_api_supplinv_proc=>tys_a_supplier_invoice_type-payment_terms,
         unplanned_delivery_cost_ta type /exedminb/sc_api_supplinv_proc=>tys_a_supplier_invoice_type-unplanned_delivery_cost_ta,
         unplnd_deliv_cost_tax_juri type /exedminb/sc_api_supplinv_proc=>tys_a_supplier_invoice_type-unplnd_deliv_cost_tax_juri,
         to_br_supplier_invoice_nfd type ty_br_nfe,
         to_suplr_invc_item_pur_ord type tt_po_items,
       end of ty_business_data.


     data:
       ls_business_data        type ty_business_data,
       ls_business_data_result type ty_business_data,
       lo_http_client          type ref to if_web_http_client,
       lo_client_proxy         type ref to /iwbep/if_cp_client_proxy,
       lo_request              type ref to /iwbep/if_cp_request_create,
       lo_response             type ref to /iwbep/if_cp_response_create.


     try.
         data(fiscal_year) = cl_abap_context_info=>get_system_date( ).
         fiscal_year = fiscal_year(4).

         data(lv_timestamp) = cl_abap_tstmp=>utclong2tstmp_short( is_header-DataEmissao ).

         cl_abap_tstmp=>systemtstmp_utc2syst(
           exporting
             utc_tstmp = lv_timestamp
           importing
             syst_date = data(lv_DataEmissao_date)
             syst_time = data(lv_DataEmissao_time)
         ).

         select single from /EXEDMINB/I_NFEProtocolo
             fields dhRecbto, nProt
             where id eq @is_header-ChaveNFe
             into @data(ls_protocolo).

         if ls_protocolo-dhRecbto is not initial.
           lv_timestamp = cl_abap_tstmp=>utclong2tstmp_short( ls_protocolo-dhRecbto ).

           cl_abap_tstmp=>systemtstmp_utc2syst(
             exporting
               utc_tstmp = lv_timestamp
             importing
               syst_date = data(lv_dhRecbto_date)
               syst_time = data(lv_dhRecbto_time)
           ).
         endif.

         select from  I_PurchaseOrderAPI01 as _po
           inner join I_PurchaseOrderItemAPI01 as _poi on _po~PurchaseOrder eq _poi~PurchaseOrder
            left join I_PurchaseOrderHistoryAPI01 as _poih on _poi~PurchaseOrder eq _poih~PurchaseOrder
                                                         and _poi~PurchaseOrderItem eq _poih~PurchaseOrderItem
                                                         and _poih~PurchasingHistoryCategory eq 'E'
           fields _po~PurchaseOrder,
                  _po~CompanyCode,
                  _po~DocumentCurrency,
                  _po~Supplier,
                  _po~ExchangeRate,
                  _po~PaymentTerms,

                  _poi~PurchaseOrderItem,
                  _poi~TaxCode,
                  _poi~NetPriceAmount,

                  _poih~PurchasingHistoryDocument,
                  _poih~PurchasingHistoryDocumentYear,
                  _poih~PurchasingHistoryDocumentItem,
                  _poih~Quantity,
                  _poih~Currency,
                  _poih~PurchaseOrderQuantityUnit
           for all entries in @it_items
           where _poi~PurchaseOrder = @it_items-Pedido
             and _poi~PurchaseOrderItem = @it_items-ItemPedido
           into table @data(lt_PurchaseOrderItemsDatas).

         if lt_PurchaseOrderItemsDatas is initial.
           failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                            %key = value #( chavenfe = is_header-ChaveNFe )
                                            %action-etapa_800 = if_abap_behv=>mk-on ) ).
           reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                              %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                           text = 'Nenhuma informação do pedido encontrado!' ) ) ).

           return.
         endif.

*       Prepare business data
         ls_business_data = value #(
             Company_code                = lt_PurchaseOrderItemsDatas[ 1 ]-Companycode
             document_currency           = lt_PurchaseOrderItemsDatas[ 1 ]-DocumentCurrency
             document_date               = lcl_tools=>convert_abap_timestamp_2_epoch( iv_date = lv_DataEmissao_date )
             invoice_gross_amount        = is_header-ValorTotalNFe
             invoicing_party             = lt_PurchaseOrderItemsDatas[ 1 ]-Supplier
             posting_date                = lcl_tools=>convert_abap_timestamp_2_epoch( iv_date = cl_abap_context_info=>get_system_date( ) )
             supplier_invoice_idby_invc  = |{ is_header-NumeroNFe }{ is_header-Serie }|
             accounting_document_type    = 'RE'
             tax_is_calculated_automati  = abap_true
             direct_quoted_exchange_rat  = lt_PurchaseOrderItemsDatas[ 1 ]-ExchangeRate
             document_header_text        = '' "A ser definido
             payment_terms               = lt_PurchaseOrderItemsDatas[ 1 ]-PaymentTerms
             unplanned_delivery_cost_ta  = lt_PurchaseOrderItemsDatas[ 1 ]-TaxCode
             unplnd_deliv_cost_tax_juri  = lt_PurchaseOrderItemsDatas[ 1 ]-Companycode
             to_br_supplier_invoice_nfd  = value #(
                                             br_nfauthentication_date    = lcl_tools=>convert_abap_timestamp_2_epoch( iv_date = lv_dhRecbto_date )
                                             br_nfauthentication_time    = |PT{ lv_dhRecbto_time(2) }H{ lv_dhRecbto_time+2(2) }M{ lv_dhRecbto_time+4(2) }S|
                                             br_nfauthzn_protocol_numbe  = ls_protocolo-nProt
                                             br_nfauthzn_protocol_num_2  = ls_protocolo-nProt
                                             br_nfe_random_number        = is_header-ChaveNFe+34(9)
                                             br_nftype                   = '' "Validar com cliente
                                             br_nota_fiscal              = is_header-NumeroNFe
             )
             to_suplr_invc_item_pur_ord = value #( for item in lt_PurchaseOrderItemsDatas index into idx (
                                                     supplier_invoice_item       = idx
                                                     purchase_order              = item-PurchaseOrder
                                                     purchase_order_item         = item-PurchaseOrderItem
                                                     reference_document          = item-PurchasingHistoryDocument
                                                     reference_document_fiscal   = item-PurchasingHistoryDocumentYear
                                                     reference_document_item     = item-PurchasingHistoryDocumentItem
                                                     tax_code                    = item-TaxCode
                                                     quantity_in_purchase_order  = item-Quantity
                                                     supplier_invoice_item_amou  = item-NetPriceAmount
                                                     document_currency           = item-DocumentCurrency
                                                     purchase_order_qty_unit_is  = item-PurchaseOrderQuantityUnit
                                                     purchase_order_qty_unit_sa  = item-PurchaseOrderQuantityUnit
             ) )
         ).

         condense ls_business_data-invoice_gross_amount no-gaps.
         condense ls_business_data-direct_quoted_exchange_rat no-gaps.
         loop at ls_business_data-to_suplr_invc_item_pur_ord assigning field-symbol(<f_items>).
           condense <f_items>-quantity_in_purchase_order no-gaps.
           condense <f_items>-supplier_invoice_item_amou no-gaps.
         endloop.

         data(lv_response) = lcl_api_hub_read=>post_supplier_invoice( ls_business_data ).

         if lv_response-code ne 200.
           failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                            %key = value #( chavenfe = is_header-ChaveNFe )
                                            %action-etapa_800 = if_abap_behv=>mk-on ) ).
         endif.

         lcl_api_hub_read=>get_messages( importing t_message = data(lt_message) ).

         loop at lt_message into data(ls_message).
           append value #( %key = value #( chavenfe = is_header-ChaveNFe )
                           %msg = ls_message-msg ) to reported-_nfemonitorh.
         endloop.

       catch cx_http_dest_provider_error cx_web_http_client_error /iwbep/cx_cp_remote /iwbep/cx_gateway into data(lx_ERROR).
         failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                          %key = value #( chavenfe = is_header-ChaveNFe )
                                          %action-etapa_800 = if_abap_behv=>mk-on ) ).
         reported-_nfemonitorh = value #( ( %key = value #( chavenfe = is_header-ChaveNFe )
                                            %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                         text = lx_ERROR->get_text( ) ) ) ).
     endtry.
   endmethod.