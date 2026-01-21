  private section.
    types: begin of y_rg_supplier,
             sign   type ddsign,
             option type ddoption,
             low    type I_PurchaseOrderAPI01-Supplier,
             high   type I_PurchaseOrderAPI01-Supplier,
           end of y_rg_supplier.

    types tt_rangesupplier type table of y_rg_supplier with empty key.

    methods atribuir_pedido_item importing is_header type /exedminb/i_nfemonitorh
                                 changing  it_items  type y_data_itens
                                           mapped    type yt_mapped
                                           failed    type yt_failed
                                           reported  type yt_resported.
    methods Validacao_Geral importing is_header type /exedminb/i_nfemonitorh
                                      it_items  type y_data_itens
                            changing  mapped    type yt_mapped
                                      failed    type yt_failed
                                      reported  type yt_resported.
    methods Validacao_impostos importing is_header type /exedminb/i_nfemonitorh
                                         it_items  type y_data_itens
                               changing  mapped    type yt_mapped
                                         failed    type yt_failed
                                         reported  type yt_resported.
    methods executar_ar importing is_header type /exedminb/i_nfemonitorh.
