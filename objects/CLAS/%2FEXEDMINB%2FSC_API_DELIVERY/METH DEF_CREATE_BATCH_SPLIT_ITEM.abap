  METHOD def_create_batch_split_item.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'CREATE_BATCH_SPLIT_ITEM' ).
    lo_function->set_edm_name( 'CreateBatchSplitItem' ) ##NO_TEXT.

    " Name of the runtime structure that represents the parameters of this operation
    lo_function->/iwbep/if_v4_pm_fu_advanced~set_parameter_structure_info( VALUE tys_parameters_8( ) ).

    lo_function_import = lo_function->create_function_import( 'CREATE_BATCH_SPLIT_ITEM' ).
    lo_function_import->set_edm_name( 'CreateBatchSplitItem' ) ##NO_TEXT.
    lo_function_import->/iwbep/if_v4_pm_func_imp_v2~set_http_method( 'POST' ).


    lo_parameter = lo_function->create_parameter( 'BATCH_BY_SUPPLIER' ).
    lo_parameter->set_edm_name( 'BatchBySupplier' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'BATCH_BY_SUPPLIER' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'MANUFACTURE_DATE' ).
    lo_parameter->set_edm_name( 'ManufactureDate' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'MANUFACTURE_DATE' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'SHELF_LIFE_EXPIRATION_DATE' ).
    lo_parameter->set_edm_name( 'ShelfLifeExpirationDate' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'SHELF_LIFE_EXPIRATION_DATE' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'ACTUAL_DELIVERY_QUANTITY' ).
    lo_parameter->set_edm_name( 'ActualDeliveryQuantity' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'ACTUAL_DELIVERY_QUANTITY' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'BATCH' ).
    lo_parameter->set_edm_name( 'Batch' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'BATCH' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'DELIVERY_DOCUMENT' ).
    lo_parameter->set_edm_name( 'DeliveryDocument' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'DELIVERY_DOCUMENT_7' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'DELIVERY_DOCUMENT_ITEM' ).
    lo_parameter->set_edm_name( 'DeliveryDocumentItem' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'DELIVERY_DOCUMENT_ITEM_3' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'DELIVERY_QUANTITY_UNIT' ).
    lo_parameter->set_edm_name( 'DeliveryQuantityUnit' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'DELIVERY_QUANTITY_UNIT' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'PUTAWAY_QUANTITY_IN_ORDER' ).
    lo_parameter->set_edm_name( 'PutawayQuantityInOrderUnit' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'PUTAWAY_QUANTITY_IN_ORDER' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_complex_type( 'CREATED_DELIVERY_ITEM' ).

  ENDMETHOD.