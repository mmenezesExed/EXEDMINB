   private section.

     types: begin of y_rg_supplier,
              sign   type ddsign,
              option type ddoption,
              low    type I_PurchaseOrderAPI01-Supplier,
              high   type I_PurchaseOrderAPI01-Supplier,
            end of y_rg_supplier.

     types tt_rangesupplier type table of y_rg_supplier with empty key.


