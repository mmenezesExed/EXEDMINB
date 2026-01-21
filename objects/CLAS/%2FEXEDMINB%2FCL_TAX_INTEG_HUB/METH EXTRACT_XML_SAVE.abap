  method extract_xml_save.

    data: lt_nfeheader    type table of /exedminb/t_nfeheader,
          lt_nfeissue     type table of /EXEDMINB/T_NFeIssuer,
          lt_nfeissueaddr type table of /EXEDMINB/T_NFeIssuerAddr,
          lt_nterecip     type table of /EXEDMINB/T_NFeRecipient,
          lt_nterecipaddr type table of /EXEDMINB/T_NFeRecipAddr,
          lt_nfeitem      type table of /EXEDMINB/t_nfeitem,
          lt_icms00       type table of /EXEDMINB/t_nfetaxicms00,
          lt_icms02       type table of /EXEDMINB/t_nfetaxicms02,
          lt_icms10       type table of /EXEDMINB/t_nfetaxicms10,
          lt_icms15       type table of /EXEDMINB/t_nfetaxicms15,
          lt_icms20       type table of /EXEDMINB/t_nfetaxicms20,
          lt_icms30       type table of /EXEDMINB/t_nfetaxicms30,
          lt_icms40       type table of /EXEDMINB/t_nfetaxicms40,
          lt_icms51       type table of /EXEDMINB/t_nfetaxicms51,
          lt_icms53       type table of /EXEDMINB/t_nfetaxicms53,
          lt_icms60       type table of /EXEDMINB/t_nfetaxicms60,
          lt_icms61       type table of /EXEDMINB/t_nfetaxicms61,
          lt_icms70       type table of /EXEDMINB/t_nfetaxicms70,
          lt_icms90       type table of /EXEDMINB/t_nfetaxicms90,
          lt_icmsst       type table of /EXEDMINB/t_nfetaxicmsst,
          lt_icmspart     type table of /EXEDMINB/t_nfetxicmspart,
          lt_ii           type table of /EXEDMINB/t_nfetaxii,
          lt_ipi          type table of /EXEDMINB/t_nfetaxipi,
          lt_cofins       type table of /EXEDMINB/t_nfetaxcofins,
          lt_pis          type table of /EXEDMINB/t_nfetaxpis,
          lt_pisst        type table of /EXEDMINB/t_nfetaxpisst,
          lt_cofinsst     type table of /EXEDMINB/t_nfetxcofinsst,
          lt_icmsufdest   type table of /EXEDMINB/t_nfeicmsufdest,
          lt_icmstax_tot  type table of /EXEDMINB/t_nfeicmstaxTot,
          lt_transp       type table of /EXEDMINB/t_nfetransport,
          lt_carrier      type table of /EXEDMINB/t_nfecarrier,
          lt_rettransp    type table of /EXEDMINB/t_nfetranspret,
          lt_veh          type table of /EXEDMINB/t_nfetranspveh,
          lt_tow          type table of /EXEDMINB/t_nfetransptow,
          lt_vol          type table of /EXEDMINB/t_nfetranspvol,
          lt_seal         type table of /EXEDMINB/t_securityseal,
          lt_invoice      type table of /EXEDMINB/t_nfeinvoice,
          lt_install      type table of /EXEDMINB/t_nfeinstallm,
          lt_payment      type table of /EXEDMINB/t_nfepayment,
          lt_paycard      type table of /EXEDMINB/t_paymentcard,
          lt_addinform    type table of /EXEDMINB/t_nfeaddinform,
          lt_taxinform    type table of /EXEDMINB/t_nfetaxinform,
          lt_txpayerinf   type table of /EXEDMINB/t_nfetxpayerinf,
          lt_legprocref   type table of /EXEDMINB/t_nfelegprocref,
          lt_nfeprot      type table of /EXEDMINB/T_NFEProtocolo,
          lt_stack        type standard table of string with empty key.

    data: ls_nfeheader    like line of lt_nfeheader,
          ls_nfeissue     like line of lt_nfeissue,
          ls_nfeissueaddr like line of lt_nfeissueaddr,
          ls_nterecip     like line of lt_nterecip,
          ls_nterecipaddr like line of lt_nterecipaddr,
          ls_nfeitem      like line of lt_nfeitem,
          ls_icms00       like line of lt_icms00,
          ls_icms02       like line of lt_icms02,
          ls_icms10       like line of lt_icms10,
          ls_icms15       like line of lt_icms15,
          ls_icms20       like line of lt_icms20,
          ls_icms30       like line of lt_icms30,
          ls_icms40       like line of lt_icms40,
          ls_icms51       like line of lt_icms51,
          ls_icms53       like line of lt_icms53,
          ls_icms60       like line of lt_icms60,
          ls_icms61       like line of lt_icms61,
          ls_icms70       like line of lt_icms70,
          ls_icms90       like line of lt_icms90,
          ls_icmsst       like line of lt_icmsst,
          ls_icmspart     like line of lt_icmspart,
          ls_ii           like line of lt_ii,
          ls_ipi          like line of lt_ipi,
          ls_cofins       like line of lt_cofins,
          ls_pis          like line of lt_pis,
          ls_pisst        like line of lt_pisst,
          ls_cofinsst     like line of lt_cofinsst,
          ls_icmsufdest   like line of lt_icmsufdest,
          ls_icmstax_tot  like line of lt_icmstax_tot,
          ls_transp       like line of lt_transp,
          ls_carrier      like line of lt_carrier,
          ls_rettransp    like line of lt_rettransp,
          ls_veh          like line of lt_veh,
          ls_tow          like line of lt_tow,
          ls_vol          like line of lt_vol,
          ls_seal         like line of lt_seal,
          ls_invoice      like line of lt_invoice,
          ls_install      like line of lt_install,
          ls_payment      like line of lt_payment,
          ls_paycard      like line of lt_paycard,
          ls_addinform    like line of lt_addinform,
          ls_taxinform    like line of lt_taxinform,
          ls_txpayerinf   like line of lt_txpayerinf,
          ls_legprocref   like line of lt_legprocref,
          ls_nfeprot      like line of lt_nfeprot.

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
          lv_legprocid  type i.

    data(lo_xml) = cl_sxml_string_reader=>create( i_xml_xstring ).

    do.

      lo_xml->next_node( ).

      case lo_xml->node_type.

        when if_sxml_node=>co_nt_element_open.

          "*** strip para pegar o atributo da tag
          lv_field = lo_xml->name.
          data(lv_tmp_open) = lv_field.
          replace pcre '.*[:/]' in lv_tmp_open with ''.

          lv_field = to_upper( lv_tmp_open ).

          if lv_field = 'INFNFE'.

            data: lv_attr_name type string,
                  lv_attr_val  type string.

            try.
                lo_xml->next_attribute( ).  "move to first attribute
                while lo_xml->node_type = if_sxml_node=>co_nt_attribute.

                  lv_attr_name = to_upper( lo_xml->name ).
                  lv_attr_val  = lo_xml->value.

                  if lv_attr_name = 'VERSAO'.
                    ls_nfeheader-versao = lv_attr_val.

                  elseif lv_attr_name = 'ID'.
                    replace first occurrence of pcre 'NFe' in lv_attr_val with '' ignoring case.
                    replace all occurrences of pcre '[^\d]' in lv_attr_val with ''.
                    ls_nfeheader-id = lv_attr_val.
                  endif.

                  lo_xml->next_attribute( ).

                endwhile.

              catch cx_sxml_state_error.
                exit. " fim da lista de atributos

            endtry.

          elseif lv_field = 'DET'.

            clear: lv_det_nitem, ls_nfeitem.

            try.

                lo_xml->next_attribute( ).

                while lo_xml->node_type = if_sxml_node=>co_nt_attribute.

                  data(lv_attr_name_i) = to_upper( lo_xml->name ).
                  data(lv_attr_val_i)  = lo_xml->value.

                  if lv_attr_name_i = 'NITEM'.
                    lv_det_nitem = conv i( lv_attr_val_i ).
                  endif.

                  lo_xml->next_attribute( ).

                endwhile.

              catch cx_sxml_state_error.
                lv_error = abap_true.
            endtry.

          elseif lv_field = 'DETPAG'.

            clear ls_payment.
            lv_paymentid  = lv_paymentid + 1.
            lv_paycardid  = 0.
            ls_payment-paymentid = lv_paymentid.

          elseif lv_field = 'CARD'.

            clear ls_paycard.
            ls_paycard-paymentid = lv_paymentid.
            lv_paycardid         = lv_paycardid + 1.
            ls_paycard-paymentcardid = lv_paycardid.

          elseif lv_field = 'OBSCONT' or lv_field = 'OBSFISCO'.

            try.
                lo_xml->next_attribute( ).

                while lo_xml->node_type = if_sxml_node=>co_nt_attribute.

                  data(lv_attr_name_obs) = to_upper( lo_xml->name ).
                  data(lv_attr_val_obs)  = lo_xml->value.

                  if lv_attr_name_obs = 'XCAMPO'.
                    if lv_field = 'OBSCONT'.
                      ls_txpayerinf-xcampo = lv_attr_val_obs.
                    else. " OBSFISCO
                      ls_taxinform-xcampo  = lv_attr_val_obs.
                    endif.
                  endif.

                  lo_xml->next_attribute( ).

                endwhile.

              catch cx_sxml_state_error.
                lv_error = abap_true.
            endtry.


          endif.

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

              "*** CABEÇALHO
            when 'NFEPROC/NFE/INFNFE/IDE/CUF'.      ls_nfeheader-cuf        = lv_value.
            when 'NFEPROC/NFE/INFNFE/IDE/CNF'.      ls_nfeheader-cnf        = lv_value.
            when 'NFEPROC/NFE/INFNFE/IDE/NATOP'.    ls_nfeheader-natop      = lv_value.
            when 'NFEPROC/NFE/INFNFE/IDE/MOD'.      ls_nfeheader-mod        = lv_value.
            when 'NFEPROC/NFE/INFNFE/IDE/SERIE'.    ls_nfeheader-serie      = lv_value.
            when 'NFEPROC/NFE/INFNFE/IDE/NNF'.      ls_nfeheader-nnf        = lv_value.
            when 'NFEPROC/NFE/INFNFE/IDE/TPNF'.     ls_nfeheader-tpnf       = lv_value.
            when 'NFEPROC/NFE/INFNFE/IDE/IDDEST'.   ls_nfeheader-iddest     = lv_value.
            when 'NFEPROC/NFE/INFNFE/IDE/CMUNFG'.   ls_nfeheader-cmunfg     = lv_value.
            when 'NFEPROC/NFE/INFNFE/IDE/TPIMP'.    ls_nfeheader-tpimp      = lv_value.
            when 'NFEPROC/NFE/INFNFE/IDE/TPEMIS'.   ls_nfeheader-tpemis     = lv_value.
            when 'NFEPROC/NFE/INFNFE/IDE/FINNFE'.   ls_nfeheader-finnfe     = lv_value.
            when 'NFEPROC/NFE/INFNFE/IDE/INDFINAL'. ls_nfeheader-indfinal   = lv_value.
            when 'NFEPROC/NFE/INFNFE/IDE/INDPRES'.  ls_nfeheader-indpres    = lv_value.
            when 'NFEPROC/NFE/INFNFE/IDE/PROCEMI'.  ls_nfeheader-procemi    = lv_value.
            when 'NFEPROC/NFE/INFNFE/IDE/VERPROC'.  ls_nfeheader-verproc    = lv_value.
            when 'NFEPROC/NFE/INFNFE/IDE/XJUST'.    ls_nfeheader-xjust      = lv_value.

            when 'NFEPROC/NFE/INFNFE/IDE/DHEMI'.
              try.
                  cl_abap_utclong=>read_iso_format( exporting string = lv_value
                                                    importing value  = ls_nfeheader-dhemi ).
                catch cx_abap_utclong_invalid.
                  lv_error = abap_true.
                catch cx_sy_conversion_no_date_time.
                  lv_error = abap_true.
                catch cx_parameter_invalid_range.
                  lv_error = abap_true.
              endtry.

            when 'NFEPROC/NFE/INFNFE/IDE/DHCONT'.
              try.
                  cl_abap_utclong=>read_iso_format( exporting string = lv_value
                                                    importing value  = ls_nfeheader-dhcont ).
                catch cx_abap_utclong_invalid.
                  lv_error = abap_true.
                catch cx_sy_conversion_no_date_time.
                  lv_error = abap_true.
                catch cx_parameter_invalid_range.
                  lv_error = abap_true.
              endtry.

              "*** EMITENTE
            when 'NFEPROC/NFE/INFNFE/EMIT/CNPJ'.   ls_nfeissue-cnpj  = lv_value.
            when 'NFEPROC/NFE/INFNFE/EMIT/XNOME'.  ls_nfeissue-xnome = lv_value.
            when 'NFEPROC/NFE/INFNFE/EMIT/XFANT'.  ls_nfeissue-xfant = lv_value.
            when 'NFEPROC/NFE/INFNFE/EMIT/IE'.     ls_nfeissue-ie    = lv_value.
            when 'NFEPROC/NFE/INFNFE/EMIT/IEST'.   ls_nfeissue-iest  = lv_value.
            when 'NFEPROC/NFE/INFNFE/EMIT/IM'.     ls_nfeissue-im    = lv_value.
            when 'NFEPROC/NFE/INFNFE/EMIT/CNAE'.   ls_nfeissue-cnae  = lv_value.
            when 'NFEPROC/NFE/INFNFE/EMIT/CRT'.    ls_nfeissue-crt   = lv_value.

              "*** EMITENTE - ENDERECO
            when 'NFEPROC/NFE/INFNFE/EMIT/ENDEREMIT/XLGR'.   ls_nfeissueaddr-xlgr    = lv_value.
            when 'NFEPROC/NFE/INFNFE/EMIT/ENDEREMIT/NRO'.    ls_nfeissueaddr-nro     = lv_value.
            when 'NFEPROC/NFE/INFNFE/EMIT/ENDEREMIT/XCPL'.   ls_nfeissueaddr-xcpl    = lv_value.
            when 'NFEPROC/NFE/INFNFE/EMIT/ENDEREMIT/XBAIRRO'.ls_nfeissueaddr-xbairro = lv_value.
            when 'NFEPROC/NFE/INFNFE/EMIT/ENDEREMIT/CMUN'.   ls_nfeissueaddr-cmun    = lv_value.
            when 'NFEPROC/NFE/INFNFE/EMIT/ENDEREMIT/XMUN'.   ls_nfeissueaddr-xmun    = lv_value.
            when 'NFEPROC/NFE/INFNFE/EMIT/ENDEREMIT/UF'.     ls_nfeissueaddr-uf      = lv_value.
            when 'NFEPROC/NFE/INFNFE/EMIT/ENDEREMIT/CEP'.    ls_nfeissueaddr-cep     = lv_value.
            when 'NFEPROC/NFE/INFNFE/EMIT/ENDEREMIT/CPAIS'.  ls_nfeissueaddr-cpais   = lv_value.
            when 'NFEPROC/NFE/INFNFE/EMIT/ENDEREMIT/XPAIS'.  ls_nfeissueaddr-xpais   = lv_value.
            when 'NFEPROC/NFE/INFNFE/EMIT/ENDEREMIT/FONE'.   ls_nfeissueaddr-fone    = lv_value.

              "*** DESTINATÁRIO
            when 'NFEPROC/NFE/INFNFE/DEST/CNPJ'.         ls_nterecip-cnpj_cpf  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DEST/CPF'.          ls_nterecip-cnpj_cpf  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DEST/XNOME'.        ls_nterecip-xnome     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DEST/INDIEDEST'.    ls_nterecip-indiedest = lv_value.
            when 'NFEPROC/NFE/INFNFE/DEST/IE'.           ls_nterecip-ie        = lv_value.
            when 'NFEPROC/NFE/INFNFE/DEST/EMAIL'.        ls_nterecip-email     = lv_value.

              "*** DESTINATÁRIO - ENDEREÇO
            when 'NFEPROC/NFE/INFNFE/DEST/ENDERDEST/XLGR'.    ls_nterecipaddr-xlgr    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DEST/ENDERDEST/NRO'.     ls_nterecipaddr-nro     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DEST/ENDERDEST/XCPL'.    ls_nterecipaddr-xcpl    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DEST/ENDERDEST/XBAIRRO'. ls_nterecipaddr-xbairro = lv_value.
            when 'NFEPROC/NFE/INFNFE/DEST/ENDERDEST/CMUN'.    ls_nterecipaddr-cmun    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DEST/ENDERDEST/XMUN'.    ls_nterecipaddr-xmun    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DEST/ENDERDEST/UF'.      ls_nterecipaddr-uf      = lv_value.
            when 'NFEPROC/NFE/INFNFE/DEST/ENDERDEST/CEP'.     ls_nterecipaddr-cep     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DEST/ENDERDEST/CPAIS'.   ls_nterecipaddr-cpais   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DEST/ENDERDEST/XPAIS'.   ls_nterecipaddr-xpais   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DEST/ENDERDEST/FONE'.    ls_nterecipaddr-fone    = lv_value.

              "*** ITENS
            when 'NFEPROC/NFE/INFNFE/DET/PROD/CPROD'.     ls_nfeitem-cprod    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/PROD/CEAN'.      ls_nfeitem-cean     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/PROD/XPROD'.     ls_nfeitem-xprod    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/PROD/NCM'.       ls_nfeitem-ncm      = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/PROD/CFOP'.      ls_nfeitem-cfop     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/PROD/UCOM'.      ls_nfeitem-ucom     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/PROD/QCOM'.      ls_nfeitem-qcom     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/PROD/VUNCOM'.    ls_nfeitem-vuncom   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/PROD/VPROD'.     ls_nfeitem-vprod    = lv_value.

            when 'NFEPROC/NFE/INFNFE/DET/PROD/CEANTRIB'.  ls_nfeitem-ceantrib = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/PROD/UTRIB'.     ls_nfeitem-utrib    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/PROD/QTRIB'.     ls_nfeitem-qtrib    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/PROD/VUNTRIB'.   ls_nfeitem-vuntrib  = lv_value.

            when 'NFEPROC/NFE/INFNFE/DET/PROD/INDTOT'.    ls_nfeitem-indtot   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/PROD/XPED'.      ls_nfeitem-xped     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/PROD/NITEMPED'.  ls_nfeitem-nitemped = lv_value.

              "*** IMPOSTOS
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/VTOTTRIB'. ls_nfeitem-vtottrib = lv_value.

              "*** ICMS00
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS00/ORIG'.   ls_icms00-orig  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS00/CST'.    ls_icms00-cst   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS00/MODBC'.  ls_icms00-modbc = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS00/VBC'.    ls_icms00-vbc   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS00/PICMS'.  ls_icms00-picms = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS00/VICMS'.  ls_icms00-vicms = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS00/PFCP'.   ls_icms00-pfcp  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS00/VFCP'.   ls_icms00-vfcp  = lv_value.

              "*** ICMS02
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS02/ORIG'.      ls_icms02-orig      = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS02/CST'.       ls_icms02-cst       = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS02/QBCMONO'.   ls_icms02-qbcmono   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS02/ADREMICMS'. ls_icms02-adremicms = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS02/VICMSMONO'. ls_icms02-vicmsmono = lv_value.

              "*** ICMS10
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS10/ORIG'.     ls_icms10-orig    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS10/CST'.      ls_icms10-cst     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS10/MODBC'.    ls_icms10-modbc   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS10/VBC'.      ls_icms10-vbc     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS10/PICMS'.    ls_icms10-picms   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS10/VICMS'.    ls_icms10-vicms   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS10/MODBCST'.  ls_icms10-modbcst = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS10/VBCST'.    ls_icms10-vbcst   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS10/PICMSST'.  ls_icms10-picmsst = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS10/VICMSST'.  ls_icms10-vicmsst = lv_value.

              "*** ICMS15
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS15/ORIG'.            ls_icms15-orig          	= lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS15/CST'.             ls_icms15-cst            = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS15/QBCMONO'.         ls_icms15-qbcmono        = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS15/ADREMICMS'.       ls_icms15-adremicms      = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS15/VICMSMONO'.       ls_icms15-vicmsmono      = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS15/QBCMONORETEN'.    ls_icms15-qbcmonoreten  	= lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS15/ADREMICMSRETEN'.  ls_icms15-adremicmsreten = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS15/VICMSMONORETEN'.  ls_icms15-vicmsmonoreten = lv_value.

              "*** ICMS20
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS20/ORIG'.   ls_icms20-orig   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS20/CST'.    ls_icms20-cst    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS20/MODBC'.  ls_icms20-modbc  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS20/PREDBC'. ls_icms20-predbc = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS20/VBC'.    ls_icms20-vbc    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS20/PICMS'.  ls_icms20-picms  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS20/VICMS'.  ls_icms20-vicms  = lv_value.

              "*** ICMS30
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS30/ORIG'.     ls_icms30-orig    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS30/CST'.      ls_icms30-cst     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS30/MODBCST'.  ls_icms30-modbcst = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS30/VBCST'.    ls_icms30-vbcst   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS30/PICMSST'.  ls_icms30-picmsst = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS30/VICMSST'.  ls_icms30-vicmsst = lv_value.

              "*** ICMS40
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS40/ORIG'.         ls_icms40-orig       = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS40/CST'.          ls_icms40-cst        = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS40/VICMSDESON'.   ls_icms40-vicmsdeson = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS40/MOTDESICMS'.   ls_icms40-motdesicms = lv_value.

              "*** ICMS51
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS51/ORIG'.     ls_icms51-orig     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS51/CST'.      ls_icms51-cst      = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS51/MODBC'.    ls_icms51-modbc    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS51/VBC'.      ls_icms51-vbc      = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS51/PICMS'.    ls_icms51-picms    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS51/VICMSOP'.  ls_icms51-vicmsop  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS51/PDIF'.     ls_icms51-pdif     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS51/VICMSDIF'. ls_icms51-vicmsdif = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS51/VICMS'.    ls_icms51-vicms    = lv_value.

              "*** ICMS53
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS53/ORIG'.        ls_icms53-orig         = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS53/CST'.         ls_icms53-cst          = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS53/QBCMONO'.     ls_icms53-qbcmono      = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS53/ADREMICMS'.   ls_icms53-adremicms    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS53/VICMSMONOOP'. ls_icms53-vicmsmonoOp  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS53/PDIF'.        ls_icms53-pdif         = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS53/VICMSMONODIF'.ls_icms53-vicmsmonodif = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS53/VICMSMONO'.   ls_icms53-vicmsmono    = lv_value.

              "*** ICMS60
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS60/ORIG'.      ls_icms60-orig         = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS60/CST'.       ls_icms60-cst          = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS60/VBCSTRET'.  ls_icms60-vbcstret     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS60/VICMSSTRET'.ls_icms60-vicmsstret   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS60/VBCEFET'.   ls_icms60-vbcefet      = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS60/VICMSEFET'. ls_icms60-vicmsefet    = lv_value.

              "*** ICMS61
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS61/ORIG'.        ls_icms61-orig         = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS61/CST'.         ls_icms61-cst          = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS61/QBCMONORET'.  ls_icms61-qbcmonoret   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS61/ADREMICMSRET'.ls_icms61-adremicmsret = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS61/VICMSMONORET'.ls_icms61-vicmsmonoret = lv_value.

              "*** ICMS70
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS70/ORIG'.     ls_icms70-orig    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS70/CST'.      ls_icms70-cst     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS70/MODBC'.    ls_icms70-modbc   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS70/PREDBC'.   ls_icms70-predbc  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS70/VBC'.      ls_icms70-vbc     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS70/PICMS'.    ls_icms70-picms   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS70/VICMS'.    ls_icms70-vicms   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS70/MODBCST'.  ls_icms70-modbcst = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS70/VBCST'.    ls_icms70-vbcst   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS70/PICMSST'.  ls_icms70-picmsst = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS70/VICMSST'.  ls_icms70-vicmsst = lv_value.

              "*** ICMS90
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS90/ORIG'.     ls_icms90-orig    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS90/CST'.      ls_icms90-cst     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS90/MODBC'.    ls_icms90-modbc   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS90/VBC'.      ls_icms90-vbc     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS90/PICMS'.    ls_icms90-picms   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS90/VICMS'.    ls_icms90-vicms   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS90/MODBCST'.  ls_icms90-modbcst = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS90/VBCST'.    ls_icms90-vbcst   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS90/PICMSST'.  ls_icms90-picmsst = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMS90/VICMSST'.  ls_icms90-vicmsst = lv_value.

              "*** ICMSST
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSST/ORIG'.     ls_icmsst-orig    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSST/CST'.      ls_icmsst-cst     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSST/MODBC'.    ls_icmsst-modbc   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSST/VBC'.      ls_icmsst-vbc     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSST/PICMS'.    ls_icmsst-picms   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSST/VICMS'.    ls_icmsst-vicms   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSST/MODBCST'.  ls_icmsst-modbcst = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSST/VBCST'.    ls_icmsst-vbcst   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSST/PICMSST'.  ls_icmsst-picmsst = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSST/VICMSST'.  ls_icmsst-vicmsst = lv_value.

              "*** ICMSPart
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSPART/ORIG'.     ls_icmspart-orig    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSPART/CST'.      ls_icmspart-cst     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSPART/MODBC'.    ls_icmspart-modbc   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSPART/VBC'.      ls_icmspart-vbc     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSPART/PREDBC'.   ls_icmspart-predbc  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSPART/PICMS'.    ls_icmspart-picms   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSPART/VICMS'.    ls_icmspart-vicms   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSPART/MODBCST'.  ls_icmspart-modbcst = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSPART/VBCST'.    ls_icmspart-vbcst   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSPART/PICMSST'.  ls_icmspart-picmsst = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSPART/VICMSST'.  ls_icmspart-vicmsst = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSPART/PBCOP'.    ls_icmspart-pbcop   = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMS/ICMSPART/UFST'.     ls_icmspart-ufst    = lv_value.

              "*** II
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/II/VBC'.        ls_ii-vbc       = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/II/VDESPADU'.   ls_ii-vdespadu  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/II/VII'.        ls_ii-vii       = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/II/VIOF'.       ls_ii-viof      = lv_value.

              "*** IPI
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/IPI/CENQ'.           ls_ipi-cenq = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/IPI/IPITRIB/CST'.    ls_ipi-cst  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/IPI/IPINT/CST'.      ls_ipi-cst  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/IPI/IPITRIB/VBC'.    ls_ipi-vbc  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/IPI/IPITRIB/PIPI'.   ls_ipi-pipi = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/IPI/IPITRIB/VIPI'.   ls_ipi-vipi = lv_value.


              "*** COFINS
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/COFINS/COFINSALIQ/CST'.     ls_cofins-cst      = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/COFINS/COFINSALIQ/VBC'.     ls_cofins-vbc      = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/COFINS/COFINSALIQ/PCOFINS'. ls_cofins-pcofins  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/COFINS/COFINSALIQ/VCOFINS'. ls_cofins-vcofins  = lv_value.

            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/COFINS/COFINSOUTR/CST'.     ls_cofins-cst      = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/COFINS/COFINSOUTR/VBC'.     ls_cofins-vbc      = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/COFINS/COFINSOUTR/PCOFINS'. ls_cofins-pcofins  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/COFINS/COFINSOUTR/VCOFINS'. ls_cofins-vcofins  = lv_value.

            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/COFINS/COFINSNT/CST'.     ls_cofins-cst      = lv_value.

              "*** PIS
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/PIS/PISALIQ/CST'.   ls_pis-cst  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/PIS/PISALIQ/VBC'.   ls_pis-vbc  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/PIS/PISALIQ/PPIS'.  ls_pis-ppis = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/PIS/PISALIQ/VPIS'.  ls_pis-vpis = lv_value.

            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/PIS/PISOUTR/CST'.   ls_pis-cst  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/PIS/PISOUTR/VBC'.   ls_pis-vbc  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/PIS/PISOUTR/PPIS'.  ls_pis-ppis = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/PIS/PISOUTR/VPIS'.  ls_pis-vpis = lv_value.

            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/PIS/PISNT/CST'.     ls_pis-cst  = lv_value.

              "*** PISST
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/PISST/VBC'.          ls_pisst-vbc          = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/PISST/PPIS'.         ls_pisst-ppis         = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/PISST/QBCPROD'.      ls_pisst-qbcprod      = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/PISST/VALIQPROD'.    ls_pisst-valiQprod    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/PISST/VPIS'.         ls_pisst-vpis         = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/PISST/INDSOMAPISST'. ls_pisst-indsomapisst = lv_value.

              "*** COFINSST
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/COFINSST/VBC'.       ls_cofinsst-vbc      = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/COFINSST/PCOFINS'.   ls_cofinsst-pcofins  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/COFINSST/VCOFINS'.   ls_cofinsst-vcofins  = lv_value.

              "*** ICMSUFDest (DIFAL)
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMSUFDEST/VBCUFDEST'.       ls_icmsufdest-vbcufdest       = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMSUFDEST/VBCFCPUFDEST'.    ls_icmsufdest-vbcfcpufdest    = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMSUFDEST/PFCPUFDEST'.      ls_icmsufdest-pfcpufdest      = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMSUFDEST/PICMSUFDEST'.     ls_icmsufdest-picmsufdest     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMSUFDEST/PICMSINTER'.      ls_icmsufdest-picmsinter      = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMSUFDEST/PICMSINTERPART'.  ls_icmsufdest-picmsinterpart  = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMSUFDEST/VFCPUFDEST'.      ls_icmsufdest-vfcpufdest      = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMSUFDEST/VICMSUFDEST'.     ls_icmsufdest-vicmsufdest     = lv_value.
            when 'NFEPROC/NFE/INFNFE/DET/IMPOSTO/ICMSUFDEST/VICMSUFREMET'.    ls_icmsufdest-vicmsufremet    = lv_value.

              "*** ICMSTot
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VBC'.                ls_icmstax_tot-vbc                = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VICMS'.              ls_icmstax_tot-vicms              = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VICMSDESON'.         ls_icmstax_tot-vicmsdeson         = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VFCPUFDEST'.         ls_icmstax_tot-vfcpufdest         = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VICMSUFDEST'.        ls_icmstax_tot-vicmsufdest        = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VICMSUFREMET'.       ls_icmstax_tot-vicmsufremet       = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VFCP'.               ls_icmstax_tot-vfcp               = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VBCST'.              ls_icmstax_tot-vbcst              = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VST'.                ls_icmstax_tot-vst                = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VFCPST'.             ls_icmstax_tot-vfcpst             = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VFCPSTRET'.          ls_icmstax_tot-vfcpstret          = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/QBCMONO'.            ls_icmstax_tot-qbcmono            = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VICMSMONO'.          ls_icmstax_tot-vicmsmono          = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/QBCMONORETEN'.       ls_icmstax_tot-qbcmonoreten       = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VICMSMONORETEN'.     ls_icmstax_tot-vicmsmonoreten     = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VICMSMONORET'.       ls_icmstax_tot-vicmsmonoret       = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VPROD'.              ls_icmstax_tot-vprod              = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VFRETE'.             ls_icmstax_tot-vfrete             = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VSEG'.               ls_icmstax_tot-vseg               = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VDESC'.              ls_icmstax_tot-vdesc              = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VII'.                ls_icmstax_tot-vii                = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VIPI'.               ls_icmstax_tot-vipi               = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VIPIDEVOL'.          ls_icmstax_tot-vipidevol          = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VPIS'.               ls_icmstax_tot-vpis               = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VCOFINS'.            ls_icmstax_tot-vcofins            = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VOUTRO'.             ls_icmstax_tot-voutro             = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VNF'.                ls_icmstax_tot-vnf                = lv_value.
            when 'NFEPROC/NFE/INFNFE/TOTAL/ICMSTOT/VTOTTRIB'.           ls_icmstax_tot-vtottrib           = lv_value.

              "*** modFrete
            when 'NFEPROC/NFE/INFNFE/TRANSP/MODFRETE'.  ls_transp-modfrete = lv_value.

              "*** CARRIER
            when 'NFEPROC/NFE/INFNFE/TRANSP/TRANSPORTA/CNPJ'.   ls_carrier-cnpj   = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/TRANSPORTA/CPF'.    ls_carrier-cpf    = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/TRANSPORTA/XNOME'.  ls_carrier-xnome  = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/TRANSPORTA/IE'.     ls_carrier-ie     = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/TRANSPORTA/XENDER'. ls_carrier-xender = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/TRANSPORTA/XMUN'.   ls_carrier-xmun   = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/TRANSPORTA/UF'.     ls_carrier-uf     = lv_value.

              "***RET TRANSP
            when 'NFEPROC/NFE/INFNFE/TRANSP/RETTRANSP/VSERV'.    ls_rettransp-vserv     = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/RETTRANSP/VBCRET'.   ls_rettransp-vbcret    = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/RETTRANSP/PICMSRET'. ls_rettransp-picmsret  = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/RETTRANSP/VICMSRET'. ls_rettransp-vicmsret  = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/RETTRANSP/CFOP'.     ls_rettransp-cfop      = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/RETTRANSP/CMUNFG'.   ls_rettransp-cmunfg    = lv_value.

              "*** VEIC TRANSP
            when 'NFEPROC/NFE/INFNFE/TRANSP/VEICTRANSP/PLACA'. ls_veh-placa = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/VEICTRANSP/UF'.    ls_veh-uf    = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/VEICTRANSP/RNTC'.  ls_veh-rntc  = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/VEICTRANSP/VAGAO'. ls_veh-vagao = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/VEICTRANSP/BALSA'. ls_veh-balsa = lv_value.

              "*** REBOQUE
            when 'NFEPROC/NFE/INFNFE/TRANSP/REBOQUE/PLACA'. ls_tow-placa = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/REBOQUE/UF'.    ls_tow-uf    = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/REBOQUE/RNTC'.  ls_tow-rntc  = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/REBOQUE/VAGAO'. ls_tow-vagao = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/REBOQUE/BALSA'. ls_tow-balsa = lv_value.

              "*** VOL
            when 'NFEPROC/NFE/INFNFE/TRANSP/VOL/QVOL'.   ls_vol-qvol   = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/VOL/ESP'.    ls_vol-esp    = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/VOL/MARCA'.  ls_vol-marca  = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/VOL/NVOL'.   ls_vol-nvol   = lv_value. lv_curr_nvol = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/VOL/PESOL'.  ls_vol-pesol  = lv_value.
            when 'NFEPROC/NFE/INFNFE/TRANSP/VOL/PESOB'.  ls_vol-pesob  = lv_value.

              "*** LACRES
            when 'NFEPROC/NFE/INFNFE/TRANSP/VOL/LACRES/NLACRE'.
              ls_seal-nvol  = cond #( when ls_vol-nvol is not initial then ls_vol-nvol else lv_curr_nvol ).
              ls_seal-nlacre = lv_value.

              "*** INVOICE
            when 'NFEPROC/NFE/INFNFE/COBR/FAT/NFAT'.   ls_invoice-nfat  = lv_value.
            when 'NFEPROC/NFE/INFNFE/COBR/FAT/VORIG'.  ls_invoice-vorig = lv_value.
            when 'NFEPROC/NFE/INFNFE/COBR/FAT/VDESC'.  ls_invoice-vdesc = lv_value.
            when 'NFEPROC/NFE/INFNFE/COBR/FAT/VLIQ'.   ls_invoice-vliq  = lv_value.

              "*** INSTALLMENT
            when 'NFEPROC/NFE/INFNFE/COBR/DUP/NDUP'.   ls_install-ndup  = lv_value.
            when 'NFEPROC/NFE/INFNFE/COBR/DUP/DVENC'.
              data(lv_dvenc) = lv_value.
              replace all occurrences of '-' in lv_dvenc with ''.
              ls_install-dvenc = lv_dvenc.

            when 'NFEPROC/NFE/INFNFE/COBR/DUP/VDUP'.   ls_install-vdup  = lv_value.

              "*** PAYMENT
            when 'NFEPROC/NFE/INFNFE/PAG/DETPAG/TPAG'. ls_payment-tpag = lv_value.

            when 'NFEPROC/NFE/INFNFE/PAG/DETPAG/VPAG'. ls_payment-vpag = lv_value.

              "*** PAYMENT CARD
            when 'NFEPROC/NFE/INFNFE/PAG/DETPAG/CARD/CNPJ'. ls_paycard-cnpj = lv_value.
            when 'NFEPROC/NFE/INFNFE/PAG/DETPAG/CARD/TBAND'. ls_paycard-tband = lv_value.
            when 'NFEPROC/NFE/INFNFE/PAG/DETPAG/CARD/CAUT'. ls_paycard-caut = lv_value.

              "*** Dados adicionais
            when 'NFEPROC/NFE/INFNFE/INFADIC/INFADFISCO'. ls_addinform-infadfisco = lv_value.
            when 'NFEPROC/NFE/INFNFE/INFADIC/INFCPL'. ls_addinform-infcpl1 = lv_value.

              "*** Tax Payer Information (obsCont)
            when 'NFEPROC/NFE/INFNFE/INFADIC/OBSCONT/XTEXTO'. ls_txpayerinf-xtexto = lv_value.

              "*** Tax Information (obsFisco)
            when 'NFEPROC/NFE/INFNFE/INFADIC/OBSFISCO/XTEXTO'. ls_taxinform-xtexto = lv_value.

              "*** Legal Process Reference
            when 'NFEPROC/NFE/INFNFE/INFADIC/PROCREF/NPROC'. ls_legprocref-nproc = lv_value.
            when 'NFEPROC/NFE/INFNFE/INFADIC/PROCREF/INDPROC'. ls_legprocref-indproc = lv_value.

              "*** PROTOCOLO DA NFE (protNFe)
            when 'NFEPROC/PROTNFE/INFPROT/TPAMB'.    ls_nfeprot-tpamb = lv_value.
            when 'NFEPROC/PROTNFE/INFPROT/VERAPLIC'. ls_nfeprot-veraplic = lv_value.
            when 'NFEPROC/PROTNFE/INFPROT/CHNFE'.    ls_nfeprot-id = lv_value.

            when 'NFEPROC/PROTNFE/INFPROT/DHRECBTO'.
              try.
                  cl_abap_utclong=>read_iso_format( exporting string = lv_value
                                                    importing value  = ls_nfeprot-dhrecbto ).
                catch cx_abap_utclong_invalid.
                  lv_error = abap_true.
                catch cx_sy_conversion_no_date_time.
                  lv_error = abap_true.
                catch cx_parameter_invalid_range.
                  lv_error = abap_true.
              endtry.

            when 'NFEPROC/PROTNFE/INFPROT/NPROT'.   ls_nfeprot-nprot = lv_value.
            when 'NFEPROC/PROTNFE/INFPROT/DIGVAL'.  ls_nfeprot-digval = lv_value.
            when 'NFEPROC/PROTNFE/INFPROT/CSTAT'.   ls_nfeprot-cstat = lv_value.
            when 'NFEPROC/PROTNFE/INFPROT/XMOTIVO'. ls_nfeprot-xmotivo = lv_value.


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

          if lv_field = 'ICMS00'.
            ls_icms00-id     = ls_nfeheader-id.
            ls_icms00-itemid = lv_det_nitem.

            if ls_icms00-cst is not initial or ls_icms00-vbc is not initial.
              append ls_icms00 to lt_icms00.
            endif.

            clear ls_icms00.
          endif.

          if lv_field = 'ICMS02'.
            ls_icms02-id     = ls_nfeheader-id.
            ls_icms02-itemid = lv_det_nitem.

            if ls_icms02-cst is not initial or ls_icms02-qbcmono is not initial.
              append ls_icms02 to lt_icms02.
            endif.

            clear ls_icms02.
          endif.

          if lv_field = 'ICMS10'.
            ls_icms10-id     = ls_nfeheader-id.
            ls_icms10-itemid = lv_det_nitem.

            if ls_icms10-cst is not initial or ls_icms10-vbc is not initial or ls_icms10-vbcst is not initial.
              append ls_icms10 to lt_icms10.
            endif.

            clear ls_icms10.
          endif.

          if lv_field = 'ICMS15'.
            ls_icms15-id     = ls_nfeheader-id.
            ls_icms15-itemid = lv_det_nitem.

            if ls_icms15-cst is not initial or ls_icms15-qbcmono is not initial or ls_icms15-qbcmonoreten is not initial.
              append ls_icms15 to lt_icms15.
            endif.

            clear ls_icms15.
          endif.

          if lv_field = 'ICMS20'.
            ls_icms20-id     = ls_nfeheader-id.
            ls_icms20-itemid = lv_det_nitem.


            if ls_icms20-cst is not initial or ls_icms20-vbc is not initial.
              append ls_icms20 to lt_icms20.
            endif.

            clear ls_icms20.
          endif.

          if lv_field = 'ICMS30'.
            ls_icms30-id     = ls_nfeheader-id.
            ls_icms30-itemid = lv_det_nitem.

            if ls_icms30-cst is not initial or ls_icms30-vbcst is not initial.
              append ls_icms30 to lt_icms30.
            endif.

            clear ls_icms30.
          endif.

          if lv_field = 'ICMS40'.
            ls_icms40-id     = ls_nfeheader-id.
            ls_icms40-itemid = lv_det_nitem.

            if ls_icms40-cst is not initial.
              append ls_icms40 to lt_icms40.
            endif.

            clear ls_icms40.
          endif.

          if lv_field = 'ICMS51'.
            ls_icms51-id     = ls_nfeheader-id.
            ls_icms51-itemid = lv_det_nitem.

            if ls_icms51-cst is not initial or ls_icms51-vbc is not initial.
              append ls_icms51 to lt_icms51.
            endif.

            clear ls_icms51.
          endif.

          if lv_field = 'ICMS53'.

            ls_icms53-id     = ls_nfeheader-id.
            ls_icms53-itemid = lv_det_nitem.

            if ls_icms53-cst is not initial or ls_icms53-qbcmono is not initial.
              append ls_icms53 to lt_icms53.
            endif.

            clear ls_icms53.
          endif.

          if lv_field = 'ICMS60'.

            ls_icms60-id     = ls_nfeheader-id.
            ls_icms60-itemid = lv_det_nitem.

            if ls_icms60-cst is not initial or ls_icms60-vbcstret is not initial or ls_icms60-vbcefet is not initial.
              append ls_icms60 to lt_icms60.
            endif.

            clear ls_icms60.
          endif.

          if lv_field = 'ICMS61'.
            ls_icms61-id     = ls_nfeheader-id.
            ls_icms61-itemid = lv_det_nitem.

            if ls_icms61-cst is not initial or ls_icms61-qbcmonoret is not initial.
              append ls_icms61 to lt_icms61.
            endif.

            clear ls_icms61.
          endif.

          if lv_field = 'ICMS70'.

            ls_icms70-id     = ls_nfeheader-id.
            ls_icms70-itemid = lv_det_nitem.

            if ls_icms70-cst is not initial or ls_icms70-vbc is not initial or ls_icms70-vbcst is not initial.
              append ls_icms70 to lt_icms70.
            endif.

            clear ls_icms70.
          endif.

          if lv_field = 'ICMS90'.

            ls_icms90-id     = ls_nfeheader-id.
            ls_icms90-itemid = lv_det_nitem.

            if ls_icms90-cst is not initial or ls_icms90-vbc is not initial or ls_icms90-vbcst is not initial.
              append ls_icms90 to lt_icms90.
            endif.

            clear ls_icms90.
          endif.

          if lv_field = 'ICMSST'.

            ls_icmsst-id     = ls_nfeheader-id.
            ls_icmsst-itemid = lv_det_nitem.
            if ls_icmsst-cst is not initial or ls_icmsst-vbc is not initial or ls_icmsst-vbcst is not initial.
              append ls_icmsst to lt_icmsst.
            endif.

            clear ls_icmsst.
          endif.

          if lv_field = 'ICMSPART'.
            ls_icmspart-id     = ls_nfeheader-id.
            ls_icmspart-itemid = lv_det_nitem.

            if ls_icmspart-cst is not initial or ls_icmspart-vbc is not initial or ls_icmspart-vbcst is not initial.
              append ls_icmspart to lt_icmspart.
            endif.

            clear ls_icmspart.
          endif.

          if lv_field = 'II'.
            ls_ii-id     = ls_nfeheader-id.
            ls_ii-itemid = lv_det_nitem.

            if ls_ii-vbc is not initial or ls_ii-vii is not initial or ls_ii-viof is not initial.
              append ls_ii to lt_ii.
            endif.

            clear ls_ii.
          endif.

          if lv_field = 'IPI'.
            ls_ipi-id     = ls_nfeheader-id.
            ls_ipi-itemid = lv_det_nitem.

            if ls_ipi-cst is not initial or ls_ipi-vbc is not initial or ls_ipi-vipi is not initial.
              append ls_ipi to lt_ipi.
            endif.

            clear ls_ipi.
          endif.

          if lv_field = 'ICMSPART'.
            ls_icmspart-id     = ls_nfeheader-id.
            ls_icmspart-itemid = lv_det_nitem.

            if ls_icmspart-cst is not initial or
               ls_icmspart-vbc is not initial or
               ls_icmspart-vbcst is not initial.
              append ls_icmspart to lt_icmspart.
            endif.

            clear ls_icmspart.
          endif.

          if lv_field = 'COFINS'.
            ls_cofins-id     = ls_nfeheader-id.
            ls_cofins-itemid = lv_det_nitem.

            if ls_cofins-cst is not initial or ls_cofins-vbc is not initial or ls_cofins-vcofins is not initial.
              append ls_cofins to lt_cofins.
            endif.

            clear ls_cofins.
          endif.

          if lv_field = 'PIS'.
            ls_pis-id     = ls_nfeheader-id.
            ls_pis-itemid = lv_det_nitem.

            if ls_pis-cst is not initial or ls_pis-vbc is not initial or ls_pis-vpis is not initial.
              append ls_pis to lt_pis.
            endif.

            clear ls_pis.
          endif.

          if lv_field = 'PISST'.
            ls_pisst-id     = ls_nfeheader-id.
            ls_pisst-itemid = lv_det_nitem.

            if ls_pisst-vbc is not initial or ls_pisst-vpis is not initial or ls_pisst-qbcprod is not initial.
              append ls_pisst to lt_pisst.
            endif.

            clear ls_pisst.
          endif.

          if lv_field = 'COFINSST'.
            ls_cofinsst-id     = ls_nfeheader-id.
            ls_cofinsst-itemid = lv_det_nitem.

            if ls_cofinsst-vbc is not initial or ls_cofinsst-vcofins is not initial.
              append ls_cofinsst to lt_cofinsst.
            endif.

            clear ls_cofinsst.
          endif.

          if lv_field = 'ICMSUFDEST'.
            ls_icmsufdest-id     = ls_nfeheader-id.
            ls_icmsufdest-itemid = lv_det_nitem.

            if ls_icmsufdest-vbcufdest     is not initial or
               ls_icmsufdest-vicmsufdest   is not initial or
               ls_icmsufdest-vicmsufremet  is not initial or
               ls_icmsufdest-vfcpufdest    is not initial.
              append ls_icmsufdest to lt_icmsufdest.
            endif.

            clear ls_icmsufdest.
          endif.

          if lv_field = 'ICMSTOT'.
            ls_icmstax_tot-id = ls_nfeheader-id.

            if ls_icmstax_tot-vnf is not initial or ls_icmstax_tot-vprod is not initial or ls_icmstax_tot-vtottrib is not initial.
              append ls_icmstax_tot to lt_icmstax_tot.
            endif.

            clear ls_icmstax_tot.
          endif.

          if lv_field = 'TRANSP'.
            ls_transp-id = ls_nfeheader-id.

            if ls_transp-modfrete is not initial.
              append ls_transp to lt_transp.
            endif.

            clear ls_transp.
          endif.

          if lv_field = 'TRANSPORTA'.
            ls_carrier-id = ls_nfeheader-id.

            if ls_carrier-cnpj is not initial or ls_carrier-cpf is not initial or ls_carrier-xnome is not initial.
              append ls_carrier to lt_carrier.
            endif.

            clear ls_carrier.
          endif.

          if lv_field = 'RETTRANSP'.
            ls_rettransp-id = ls_nfeheader-id.

            if ls_rettransp-vserv is not initial or ls_rettransp-vicmsret is not initial.
              append ls_rettransp to lt_rettransp.
            endif.

            clear ls_rettransp.
          endif.

          if lv_field = 'VEICTRANSP'.
            ls_veh-id = ls_nfeheader-id.

            if ls_veh-placa is not initial or ls_veh-rntc is not initial.
              append ls_veh to lt_veh.
            endif.

            clear ls_veh.
          endif.

          if lv_field = 'REBOQUE'.
            ls_tow-id = ls_nfeheader-id.

            if ls_tow-placa is not initial or ls_tow-rntc is not initial.
              append ls_tow to lt_tow.
            endif.

            clear ls_tow.
          endif.

          if lv_field = 'VOL'.
            ls_vol-id = ls_nfeheader-id.

            if ls_vol-nvol is not initial or ls_vol-qvol is not initial or ls_vol-pesob is not initial.
              append ls_vol to lt_vol.
            endif.

            clear: ls_vol, lv_curr_nvol.
          endif.

          if lv_field = 'LACRES'.
            ls_seal-id = ls_nfeheader-id.

            if ls_seal-nlacre is not initial.

              if ls_seal-nvol is initial.
                ls_seal-nvol = lv_curr_nvol.
              endif.
              append ls_seal to lt_seal.
            endif.

            clear ls_seal.
          endif.

          if lv_field = 'FAT'.
            ls_invoice-id = ls_nfeheader-id.

            if ls_invoice-nfat is not initial or ls_invoice-vliq is not initial.    .
              append ls_invoice to lt_invoice.
            endif.

            clear ls_invoice.
          endif.

          if lv_field = 'DUP'.
            ls_install-id = ls_nfeheader-id.

            if ls_install-ndup is not initial.
              append ls_install to lt_install.
            endif.

            clear ls_install.
          endif.

          if lv_field = 'DETPAG'.

            ls_payment-id = ls_nfeheader-id.

            if ls_payment-tpag is not initial
            or ls_payment-vpag is not initial.
              append ls_payment to lt_payment.
            endif.

            clear ls_payment.
          endif.

          if lv_field = 'CARD'.

            ls_paycard-id = ls_nfeheader-id.

            if ls_paycard-cnpj  is not initial
            or ls_paycard-tband is not initial
            or ls_paycard-caut  is not initial.
              append ls_paycard to lt_paycard.
            endif.

            clear ls_paycard.
          endif.

          if lv_field = 'INFADIC'.

            ls_addinform-id = ls_nfeheader-id.

            if ls_addinform-infadfisco is not initial or
               ls_addinform-infcpl1   is not initial or
               ls_addinform-infcpl2   is not initial or
               ls_addinform-infcpl3   is not initial.
              append ls_addinform to lt_addinform.
            endif.

            clear ls_addinform.
          endif.

          if lv_field = 'OBSCONT'.

            ls_txpayerinf-id = ls_nfeheader-id.

            lv_taxpayerid = lv_taxpayerid + 1.
            ls_txpayerinf-payerinforid = lv_taxpayerid.

            if ls_txpayerinf-xcampo is not initial or
               ls_txpayerinf-xtexto is not initial.
              append ls_txpayerinf to lt_txpayerinf.
            endif.

            clear ls_txpayerinf.
          endif.

          if lv_field = 'OBSFISCO'.

            ls_taxinform-id = ls_nfeheader-id.

            lv_taxinfoid = lv_taxinfoid + 1.
            ls_taxinform-payerinforid = lv_taxinfoid.

            if ls_taxinform-xcampo is not initial or
               ls_taxinform-xtexto is not initial.
              append ls_taxinform to lt_taxinform.
            endif.

            clear ls_taxinform.
          endif.

          if lv_field = 'PROCREF'.

            ls_legprocref-id = ls_nfeheader-id.

            lv_legprocid = lv_legprocid + 1.
            ls_legprocref-procid = lv_legprocid.

            if ls_legprocref-nproc   is not initial or
               ls_legprocref-indproc is not initial.
              append ls_legprocref to lt_legprocref.
            endif.

            clear ls_legprocref.
          endif.


          if lv_field = 'DET'.

            if ls_nfeheader-id is not initial.
              ls_nfeitem-id     = ls_nfeheader-id.
            endif.

            ls_nfeitem-itemid = lv_det_nitem.

            if ls_nfeitem-cprod is not initial or ls_nfeitem-xprod is not initial.
              append ls_nfeitem to lt_nfeitem.
            endif.

            clear: ls_nfeitem, lv_det_nitem.

          endif.

          if lv_field = 'INFPROT'.

            if ls_nfeprot-id is not initial.
              append ls_nfeprot to lt_nfeprot.
            endif.

            clear ls_nfeprot.

          endif.

          if lv_field = 'NFEPROC'.

            if ls_nfeheader-id is not initial.

              if ls_nfeheader-id is not initial.
                ls_nfeissue-id      = ls_nfeheader-id.
                ls_nfeissueaddr-id  = ls_nfeheader-id.
                ls_nterecip-id      = ls_nfeheader-id.
                ls_nterecipaddr-id  = ls_nfeheader-id.
              endif.

              " Cabeçalho
              if ls_nfeheader-id is not initial.
                append ls_nfeheader to lt_nfeheader.
              endif.

              " Emitente
              if ls_nfeissue-cnpj is not initial or ls_nfeissue-xnome is not initial.
                append ls_nfeissue to lt_nfeissue.
              endif.

              " Endereço do Emitente
              if ls_nfeissueaddr-xlgr    is not initial or
                 ls_nfeissueaddr-cmun    is not initial or
                 ls_nfeissueaddr-cep     is not initial.
                append ls_nfeissueaddr to lt_nfeissueaddr.
              endif.

              " Destinatário
              if ls_nterecip-cnpj_cpf is not initial or
                 ls_nterecip-xnome    is not initial or
                 ls_nterecip-email    is not initial.
                append ls_nterecip to lt_nterecip.
              endif.

              " Endereço do Destinatário
              if ls_nterecipaddr-xlgr is not initial or
                 ls_nterecipaddr-cmun is not initial or
                 ls_nterecipaddr-cep  is not initial.
                append ls_nterecipaddr to lt_nterecipaddr.
              endif.

            endif.

            clear: ls_nfeheader,
                   ls_nfeissue,
                   ls_nfeissueaddr,
                   ls_nterecip,
                   ls_nterecipaddr,
                   lv_paymentid,
                   lv_paycardid,
                   lv_taxpayerid,
                   lv_taxinfoid,
                   lv_legprocid.

          endif.


        when if_sxml_node=>co_nt_final.
          exit.

      endcase.
    enddo.

    if lt_nfeheader is not initial.
      modify /EXEDMINB/t_nfeheader from table @lt_nfeheader.
    endif.

    if lt_nfeissue is not initial.
      modify /EXEDMINB/t_nfeissuer from table @lt_nfeissue.
    endif.

    if lt_nfeissueaddr is not initial.
      modify /EXEDMINB/t_nfeissueraddr from table @lt_nfeissueaddr.
    endif.

    if lt_nterecip is not initial.
      modify /EXEDMINB/t_nferecipient from table @lt_nterecip.
    endif.

    if lt_nterecipaddr is not initial.
      modify /EXEDMINB/t_nferecipaddr from table @lt_nterecipaddr.
    endif.

    if lt_nfeitem is not initial.
      modify /EXEDMINB/t_nfeitem from table @lt_nfeitem.
    endif.

    if lt_icms00 is not initial.
      modify /EXEDMINB/t_nfetaxicms00 from table @lt_icms00.
    endif.

    if lt_icms02 is not initial.
      modify /EXEDMINB/t_nfetaxicms02 from table @lt_icms02.
    endif.

    if lt_icms10 is not initial.
      modify /EXEDMINB/t_nfetaxicms10 from table @lt_icms10.
    endif.

    if lt_icms15 is not initial.
      modify /EXEDMINB/t_nfetaxicms15 from table @lt_icms15.
    endif.

    if lt_icms20 is not initial.
      modify /EXEDMINB/t_nfetaxicms20 from table @lt_icms20.
    endif.

    if lt_icms30 is not initial.
      modify /EXEDMINB/t_nfetaxicms30 from table @lt_icms30.
    endif.

    if lt_icms40 is not initial.
      modify /EXEDMINB/t_nfetaxicms40 from table @lt_icms40.
    endif.

    if lt_icms51 is not initial.
      modify /EXEDMINB/t_nfetaxicms51 from table @lt_icms51.
    endif.

    if lt_icms53 is not initial.
      modify /EXEDMINB/t_nfetaxicms53 from table @lt_icms53.
    endif.

    if lt_icms60 is not initial.
      modify /EXEDMINB/t_nfetaxicms60 from table @lt_icms60.
    endif.

    if lt_icms61 is not initial.
      modify /EXEDMINB/t_nfetaxicms61 from table @lt_icms61.
    endif.

    if lt_icms70 is not initial.
      modify /EXEDMINB/t_nfetaxicms70 from table @lt_icms70.
    endif.

    if lt_icms90 is not initial.
      modify /EXEDMINB/t_nfetaxicms90 from table @lt_icms90.
    endif.

    if lt_icmsst is not initial.
      modify /EXEDMINB/t_nfetaxicmsst from table @lt_icmsst.
    endif.

    if lt_icmspart is not initial.
      modify /EXEDMINB/t_nfetxicmspart from table @lt_icmspart.
    endif.

    if lt_ii is not initial.
      modify /EXEDMINB/t_nfetaxii from table @lt_ii.
    endif.

    if lt_ipi is not initial.
      modify /EXEDMINB/t_nfetaxipi from table @lt_ipi.
    endif.

    if lt_cofins is not initial.
      modify /EXEDMINB/t_nfetaxcofins from table @lt_cofins.
    endif.

    if lt_pis is not initial.
      modify /EXEDMINB/t_nfetaxpis from table @lt_pis.
    endif.

    if lt_pisst is not initial.
      modify /EXEDMINB/t_nfetaxpisst from table @lt_pisst.
    endif.

    if lt_cofinsst is not initial.
      modify /EXEDMINB/t_nfetxcofinsst from table @lt_cofinsst.
    endif.

    if lt_icmsufdest is not initial.
      modify /EXEDMINB/t_nfeicmsufdest from table @lt_icmsufdest.
    endif.

    if lt_icmstax_tot is not initial.
      modify /EXEDMINB/t_nfeicmstaxTot from table @lt_icmstax_tot.
    endif.

    if lt_transp is not initial.
      modify /EXEDMINB/t_nfetransport from table @lt_transp.
    endif.

    if lt_carrier is not initial.
      modify /EXEDMINB/t_nfecarrier from table @lt_carrier.
    endif.

    if lt_rettransp is not initial.
      modify /EXEDMINB/t_nfetranspret from table @lt_rettransp.
    endif.

    if lt_veh is not initial.
      modify /EXEDMINB/t_nfetranspveh from table @lt_veh.
    endif.

    if lt_tow is not initial.
      modify /EXEDMINB/t_nfetransptow from table @lt_tow.
    endif.

    if lt_vol is not initial.
      modify /EXEDMINB/t_nfetranspvol from table @lt_vol.
    endif.

    if lt_seal is not initial.
      insert /EXEDMINB/t_securityseal from table @lt_seal.
    endif.

    if lt_invoice is not initial.
      modify /EXEDMINB/t_nfeinvoice from table @lt_invoice.
    endif.

    if lt_install is not initial.
      modify /EXEDMINB/t_nfeinstallm from table @lt_install.
    endif.

    if lt_payment is not initial.
      modify /EXEDMINB/t_nfepayment from table @lt_payment.
    endif.

    if lt_paycard is not initial.
      modify /EXEDMINB/t_paymentcard from table @lt_paycard.
    endif.

    if lt_addinform is not initial.
      modify /EXEDMINB/t_nfeaddinform from table @lt_addinform.
    endif.

    if lt_taxinform is not initial.
      modify /EXEDMINB/t_nfetaxinform from table @lt_taxinform.
    endif.

    if lt_txpayerinf is not initial.
      modify /EXEDMINB/t_nfetxpayerinf from table @lt_txpayerinf.
    endif.

    if lt_legprocref is not initial.
      modify /EXEDMINB/t_nfelegprocref from table @lt_legprocref.
    endif.

    if lt_nfeprot is not initial.
      modify /EXEDMINB/T_NFEProtocolo from table @lt_nfeprot.
    endif.

  endmethod.