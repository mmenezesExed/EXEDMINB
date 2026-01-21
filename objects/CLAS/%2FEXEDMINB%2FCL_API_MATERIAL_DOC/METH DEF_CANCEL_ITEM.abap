  METHOD def_cancel_item.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'CANCEL_ITEM' ).
    lo_function->set_edm_name( 'CancelItem' ) ##NO_TEXT.

    " Name of the runtime structure that represents the parameters of this operation
    lo_function->/iwbep/if_v4_pm_fu_advanced~set_parameter_structure_info( VALUE tys_parameters_2( ) ).

    lo_function_import = lo_function->create_function_import( 'CANCEL_ITEM' ).
    lo_function_import->set_edm_name( 'CancelItem' ) ##NO_TEXT.
    lo_function_import->/iwbep/if_v4_pm_func_imp_v2~set_http_method( 'POST' ).


    lo_parameter = lo_function->create_parameter( 'MATERIAL_DOCUMENT_YEAR' ).
    lo_parameter->set_edm_name( 'MaterialDocumentYear' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'MATERIAL_DOCUMENT_YEAR_2' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'MATERIAL_DOCUMENT' ).
    lo_parameter->set_edm_name( 'MaterialDocument' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'MATERIAL_DOCUMENT_2' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'MATERIAL_DOCUMENT_ITEM' ).
    lo_parameter->set_edm_name( 'MaterialDocumentItem' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'MATERIAL_DOCUMENT_ITEM' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'POSTING_DATE' ).
    lo_parameter->set_edm_name( 'PostingDate' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'POSTING_DATE_2' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_entity_type( 'A_MATERIAL_DOCUMENT_ITEM_T' ).

  ENDMETHOD.