  METHOD def_set_putaway_quantity_with.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'SET_PUTAWAY_QUANTITY_WITH' ).
    lo_function->set_edm_name( 'SetPutawayQuantityWithBaseQuantity' ) ##NO_TEXT.

    " Name of the runtime structure that represents the parameters of this operation
    lo_function->/iwbep/if_v4_pm_fu_advanced~set_parameter_structure_info( VALUE tys_parameters_5( ) ).

    lo_function_import = lo_function->create_function_import( 'SET_PUTAWAY_QUANTITY_WITH' ).
    lo_function_import->set_edm_name( 'SetPutawayQuantityWithBaseQuantity' ) ##NO_TEXT.
    lo_function_import->/iwbep/if_v4_pm_func_imp_v2~set_http_method( 'POST' ).


    lo_parameter = lo_function->create_parameter( 'ACTUAL_DELIVERED_QTY_IN_BA' ).
    lo_parameter->set_edm_name( 'ActualDeliveredQtyInBaseUnit' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'ACTUAL_DELIVERED_QTY_IN_BA' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'BASE_UNIT' ).
    lo_parameter->set_edm_name( 'BaseUnit' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'BASE_UNIT' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'DELIVERY_DOCUMENT' ).
    lo_parameter->set_edm_name( 'DeliveryDocument' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'DELIVERY_DOCUMENT_11' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'DELIVERY_DOCUMENT_ITEM' ).
    lo_parameter->set_edm_name( 'DeliveryDocumentItem' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'DELIVERY_DOCUMENT_ITEM_7' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_complex_type( 'PUTAWAY_REPORT' ).
    lo_return->set_is_collection( ).

  ENDMETHOD.