  method if_sadl_exit_calc_element_read~calculate.

    data lt_original_data type standard table of /exedminb/c_nfemonitorh with default key.
    lt_original_data = corresponding #( it_original_data ).

    if line_exists( it_requested_calc_elements[ table_line = 'XMLATTACHMENT' ] ).
      loop at lt_original_data assigning field-symbol(<f>).
        <f>-xmlFileName = |{ <f>-ChaveNFe }.xml|.
        <f>-xmlMimeType = 'text/xml'.
        /exedminb/cl_tax_integ_hub=>get_nfe_xml(
          exporting
            i_accesskey   = conv #( <f>-ChaveNFe )
          importing
            e_xml_xstring = <f>-xmlAttachment
        ).

*        <f>-pdfFileName = |{ <f>-ChaveNFe }.pdf|.
*        <f>-pdfMimeType = 'application/pdf'.
*        /exedminb/cl_tax_integ_hub=>get_nfe_pdf(
*          exporting
*            i_accesskey = conv #( <f>-ChaveNFe )
*          importing
*            e_pdf       = final(pdf)
*        ).
*        <f>-pdfAttachment = cl_abap_conv_codepage=>create_out( )->convert( source = pdf ).
      endloop.
    endif.

    ct_calculated_data = corresponding #( lt_original_data ).

  endmethod.