   method map_entity_to_nfeh_tables.

     e_nfeheader = corresponding #( i_entity
        mapping
          Id         = ChaveNFe
          statusProc = Status
          bukrs      = Empresa
          branch     = LocalDeNegocio
          processo   = ProcessoSAP
          atividade  = Atividade
          nNF        = NumeroNFe
          serie      = Serie
          dhEmi      = DataEmissao
          migo       = EntradaMercadoria
          miro       = EntradaFatura
          delivery   = Delivery ).

     e_nfeprotocolo = corresponding #( i_entity
       mapping
         id     = ChaveNFe
         cStat  = StatusNFe ).

     e_nfeissuer = corresponding #( i_entity
       mapping
         id     = ChaveNFe
         cnpj   = Emitente
         xNome  = NomeEmitente ).

     e_nferecipient = corresponding #( i_entity
       mapping
         id        = ChaveNFe
         cnpj_cpf  = Destinatario
         xNome     = NomeDestinatario ).

     e_nfeicmstaxtot = corresponding #( i_entity
       mapping
         id     = ChaveNFe
         vNF    = ValorTotalNFe
         vICMS  = ValorTotalICMS
         vIPI   = ValorTotalIPI
         vST    = ValorTotalICMSST
         vFrete = ValorFrete
         vSeg   = ValorSeguro
         vOutro = ValorOutrasDesp ).

   endmethod.