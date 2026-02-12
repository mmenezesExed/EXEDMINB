   method map_nfeh_tables_to_entity.
     r_entity = corresponding #( i_nfeheader
        mapping
          ChaveNFe           = Id
          Status             = statusProc
          Empresa            = bukrs
          LocalDeNegocio     = branch
          ProcessoSAP        = processo
          Atividade          = atividade
          NumeroNFe          = nNF
          Serie              = serie
          DataEmissao        = dhEmi
          EntradaMercadoria  = migo
          EntradaFatura      = miro
          Delivery           = delivery ).

     r_entity = corresponding #(
         base ( r_entity )
         i_nfeprotocolo
       mapping
         StatusNFe = cStat ).

     r_entity = corresponding #(
         base ( r_entity )
         i_nfeissuer
       mapping
         Emitente      = cnpj
         NomeEmitente  = xNome ).

     r_entity = corresponding #(
         base ( r_entity )
         i_nferecipient
       mapping
         Destinatario      = cnpj_cpf
         NomeDestinatario  = xNome ).

     r_entity = corresponding #(
         base ( r_entity )
         i_nfeicmstaxtot
       mapping
         ValorTotalNFe     = vNF
         ValorTotalICMS    = vICMS
         ValorTotalIPI     = vIPI
         ValorTotalICMSST  = vST
         ValorFrete        = vFrete
         ValorSeguro       = vSeg
         ValorOutrasDesp   = vOutro ).
   endmethod.