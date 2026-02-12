   method revalida_autorizacao.
     if is_busca_status eq abap_true.
       "Busca status NF
       try.
           /exedminb/cl_tax_integ_hub=>get_nfe_xml( exporting i_accessKey   = conv string( iv_chave )
                                                    importing e_xml_xstring = data(nfe_xstring) ).

           if nfe_xstring is not initial.
             cv_cStatus = /exedminb/cl_tax_integ_hub=>extract_status_xml( exporting i_xml_xstring = nfe_xstring ).
           endif.

         catch cx_root into data(oref_error_nfe_status_update).
           failed-_nfemonitorh = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                          %key = value #( chavenfe = iv_chave )
                                          %action-etapa_600 = if_abap_behv=>mk-on ) ).
           reported-_nfemonitorh = value #( ( %key = value #( chavenfe = iv_chave )
                                              %msg = lcl_tools=>new_message_with_text( severity = lcl_tools=>ms-error
                                                                                       text = 'Falha ao determinar status NFe!' ) ) ).

           return.

       endtry.
     endif.
   endmethod.