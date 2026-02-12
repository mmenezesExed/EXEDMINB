   method map_nfei_tables_to_entity.
     e_entity = value #( for nfeitem in i_nfeitem ( ChaveNFe = nfeitem-Id
                                                    ItemNFe = nfeitem-ItemId
                                                    Pedido = nfeitem-xPed
                                                    ItemPedido = nfeitem-nItemPed
                                                    ncm = nfeitem-ncm
                                                    cfop = nfeitem-cfop
                                                    Quantidade = nfeitem-qCom
                                                    ValorUnitario = nfeitem-vUnCom
                                                    UnidadeMedida = nfeitem-uCom

                                                    Origem = cond #(
                                                                when line_exists( i_icms00[ Id = nfeitem-Id ] ) then i_icms00[ Id = nfeitem-Id ]-cst
                                                                when line_exists( i_icms02[ Id = nfeitem-Id ] ) then i_icms02[ Id = nfeitem-Id ]-cst
                                                                when line_exists( i_icms10[ Id = nfeitem-Id ] ) then i_icms10[ Id = nfeitem-Id ]-cst
                                                                when line_exists( i_icms15[ Id = nfeitem-Id ] ) then i_icms15[ Id = nfeitem-Id ]-cst
                                                                when line_exists( i_icms20[ Id = nfeitem-Id ] ) then i_icms20[ Id = nfeitem-Id ]-cst
                                                                when line_exists( i_icms30[ Id = nfeitem-Id ] ) then i_icms30[ Id = nfeitem-Id ]-cst
                                                                when line_exists( i_icms40[ Id = nfeitem-Id ] ) then i_icms40[ Id = nfeitem-Id ]-cst
                                                                when line_exists( i_icms51[ Id = nfeitem-Id ] ) then i_icms51[ Id = nfeitem-Id ]-cst
                                                                when line_exists( i_icms53[ Id = nfeitem-Id ] ) then i_icms53[ Id = nfeitem-Id ]-cst
                                                                when line_exists( i_icms60[ Id = nfeitem-Id ] ) then i_icms60[ Id = nfeitem-Id ]-cst
                                                                when line_exists( i_icms61[ Id = nfeitem-Id ] ) then i_icms61[ Id = nfeitem-Id ]-cst
                                                                when line_exists( i_icms70[ Id = nfeitem-Id ] ) then i_icms70[ Id = nfeitem-Id ]-cst
                                                                when line_exists( i_icms90[ Id = nfeitem-Id ] ) then i_icms90[ Id = nfeitem-Id ]-cst
                                                                when line_exists( i_icmspart[ Id = nfeitem-Id ] ) then i_icmspart[ Id = nfeitem-Id ]-cst
                                                                when line_exists( i_icmsst[ Id = nfeitem-Id ] ) then i_icmsst[ Id = nfeitem-Id ]-cst )

                                                    AliquotaICMS = cond #(
                                                                     when line_exists( i_icms00[ Id = nfeitem-Id ] ) then i_icms00[ Id = nfeitem-Id ]-pICMS
                                                                     when line_exists( i_icms10[ Id = nfeitem-Id ] ) then i_icms10[ Id = nfeitem-Id ]-pICMS
                                                                     when line_exists( i_icms20[ Id = nfeitem-Id ] ) then i_icms20[ Id = nfeitem-Id ]-pICMS
                                                                     when line_exists( i_icms51[ Id = nfeitem-Id ] ) then i_icms51[ Id = nfeitem-Id ]-pICMS
                                                                     when line_exists( i_icms70[ Id = nfeitem-Id ] ) then i_icms70[ Id = nfeitem-Id ]-pICMS
                                                                     when line_exists( i_icms90[ Id = nfeitem-Id ] ) then i_icms90[ Id = nfeitem-Id ]-pICMS
                                                                     when line_exists( i_icmspart[ Id = nfeitem-Id ] ) then i_icmspart[ Id = nfeitem-Id ]-pICMS
                                                                     when line_exists( i_icmsst[ Id = nfeitem-Id ] ) then i_icmsst[ Id = nfeitem-Id ]-pICMS )

                                                    ValorICMS = cond #(
                                                                     when line_exists( i_icms00[ Id = nfeitem-Id ] ) then i_icms00[ Id = nfeitem-Id ]-vICMS
                                                                     when line_exists( i_icms10[ Id = nfeitem-Id ] ) then i_icms10[ Id = nfeitem-Id ]-vICMS
                                                                     when line_exists( i_icms20[ Id = nfeitem-Id ] ) then i_icms20[ Id = nfeitem-Id ]-vICMS
                                                                     when line_exists( i_icms51[ Id = nfeitem-Id ] ) then i_icms51[ Id = nfeitem-Id ]-vICMS
                                                                     when line_exists( i_icms70[ Id = nfeitem-Id ] ) then i_icms70[ Id = nfeitem-Id ]-vICMS
                                                                     when line_exists( i_icms90[ Id = nfeitem-Id ] ) then i_icms90[ Id = nfeitem-Id ]-vICMS
                                                                     when line_exists( i_icmspart[ Id = nfeitem-Id ] ) then i_icmspart[ Id = nfeitem-Id ]-vICMS
                                                                     when line_exists( i_icmsst[ Id = nfeitem-Id ] ) then i_icmsst[ Id = nfeitem-Id ]-vICMS )

                                                    AliquotaIPI = cond #( when line_exists( i_ipi[ Id = nfeitem-Id ] ) then i_ipi[ Id = nfeitem-Id ]-pIPI )
                                                    ValorIPI = cond #( when line_exists( i_ipi[ Id = nfeitem-Id ] ) then i_ipi[ Id = nfeitem-Id ]-vIPI ) ) ).

   endmethod.