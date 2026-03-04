  METHOD def_putaway_one_item_with_sale.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'PUTAWAY_ONE_ITEM_WITH_SALE' ).
    lo_function->set_edm_name( 'PutawayOneItemWithSalesQuantity' ) ##NO_TEXT.

    " Name of the runtime structure that represents the parameters of this operation
    lo_function->/iwbep/if_v4_pm_fu_advanced~set_parameter_structure_info( VALUE tys_parameters_3( ) ).

    lo_function_import = lo_function->create_function_import( 'PUTAWAY_ONE_ITEM_WITH_SALE' ).
    lo_function_import->set_edm_name( 'PutawayOneItemWithSalesQuantity' ) ##NO_TEXT.
    lo_function_import->/iwbep/if_v4_pm_func_imp_v2~set_http_method( 'POST' ).


    lo_parameter = lo_function->create_parameter( 'ACTUAL_DELIVERY_QUANTITY' ).
    lo_parameter->set_edm_name( 'ActualDeliveryQuantity' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'ACTUAL_DELIVERY_QUANTITY_2' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'DELIVERY_DOCUMENT' ).
    lo_parameter->set_edm_name( 'DeliveryDocument' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'DELIVERY_DOCUMENT_13' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'DELIVERY_DOCUMENT_ITEM' ).
    lo_parameter->set_edm_name( 'DeliveryDocumentItem' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'DELIVERY_DOCUMENT_ITEM_9' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'DELIVERY_QUANTITY_UNIT' ).
    lo_parameter->set_edm_name( 'DeliveryQuantityUnit' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'DELIVERY_QUANTITY_UNIT_2' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_complex_type( 'PUTAWAY_REPORT' ).
    lo_return->set_is_collection( ).

  ENDMETHOD.