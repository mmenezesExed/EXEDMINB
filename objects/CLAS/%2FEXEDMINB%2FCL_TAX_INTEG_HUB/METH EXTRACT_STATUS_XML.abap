  method extract_status_xml.
    data(lo_xml) = cl_sxml_string_reader=>create( i_xml_xstring ).

    data: lv_field      type string,
          lv_value      type string,
          lv_path       type string,
          lv_error      type abap_boolean,
          lv_det_nitem  type i,
          lv_curr_nvol  type /EXEDMINB/t_nfetranspvol-nvol,
          lv_paymentid  type i,
          lv_paycardid  type i,
          lv_taxpayerid type i,
          lv_taxinfoid  type i,
          lv_legprocid  type i,
          lt_stack      type standard table of string with empty key..

    do.

      lo_xml->next_node( ).

      case lo_xml->node_type.

        when if_sxml_node=>co_nt_element_open.

          "*** strip para pegar o atributo da tag
          lv_field = lo_xml->name.
          data(lv_tmp_open) = lv_field.
          replace pcre '.*[:/]' in lv_tmp_open with ''.

          lv_field = to_upper( lv_tmp_open ).

          "*** Pega o Path
          append lv_field to lt_stack.
          clear lv_path.
          loop at lt_stack assigning field-symbol(<s_open>).
            if lv_path is initial.
              lv_path = <s_open>.
            else.
              lv_path = |{ lv_path }/{ <s_open> }|.
            endif.
          endloop.
          translate lv_path to upper case.


        when if_sxml_node=>co_nt_value.
          lv_value = lo_xml->value.

          data(lv_map_path) = lv_path.
          if lv_map_path cp 'NOTASFISCAIS/*'.
            replace first occurrence of 'NOTASFISCAIS/' in lv_map_path with ''.
          endif.

          "*** Mapeamento por caminho
          case lv_map_path.

            when 'NFEPROC/PROTNFE/INFPROT/CSTAT'. cstat = lv_value.

          endcase.

        when if_sxml_node=>co_nt_element_close.

          " --- strip_ns (inline) ---
          lv_field = lo_xml->name.
          data(lv_tmp_close) = lv_field.
          replace pcre '.*[:/]' in lv_tmp_close with ''.
          lv_field = lv_tmp_close.
          translate lv_field to upper case.

          " --- pop (inline) ---
          delete lt_stack index lines( lt_stack ).
          clear lv_path.
          loop at lt_stack assigning field-symbol(<s_close>).
            if lv_path is initial.
              lv_path = <s_close>.
            else.
              lv_path = |{ lv_path }/{ <s_close> }|.
            endif.
          endloop.
          translate lv_path to upper case.

        when if_sxml_node=>co_nt_final.
          exit.

      endcase.
    enddo.
  endmethod.