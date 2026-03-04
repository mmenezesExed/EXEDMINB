  METHOD def_reverse_goods_receipt.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'REVERSE_GOODS_RECEIPT' ).
    lo_function->set_edm_name( 'ReverseGoodsReceipt' ) ##NO_TEXT.

    " Name of the runtime structure that represents the parameters of this operation
    lo_function->/iwbep/if_v4_pm_fu_advanced~set_parameter_structure_info( VALUE tys_parameters_4( ) ).

    lo_function_import = lo_function->create_function_import( 'REVERSE_GOODS_RECEIPT' ).
    lo_function_import->set_edm_name( 'ReverseGoodsReceipt' ) ##NO_TEXT.
    lo_function_import->/iwbep/if_v4_pm_func_imp_v2~set_http_method( 'POST' ).


    lo_parameter = lo_function->create_parameter( 'DELIVERY_DOCUMENT' ).
    lo_parameter->set_edm_name( 'DeliveryDocument' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'DELIVERY_DOCUMENT_6' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'ACTUAL_GOODS_MOVEMENT_DATE' ).
    lo_parameter->set_edm_name( 'ActualGoodsMovementDate' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'ACTUAL_GOODS_MOVEMENT_DA_2' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_complex_type( 'DELIVERY_MESSAGE' ).
    lo_return->set_is_collection( ).

  ENDMETHOD.