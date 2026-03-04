  METHOD define_primitive_types.

    DATA lo_primitive_type TYPE REF TO /iwbep/if_v4_pm_prim_type.


    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'ACTUAL_DELIVERED_QTY_IN_BA'
                            iv_element             = VALUE tys_types_for_prim_types-actual_delivered_qty_in_ba( ) ).
    lo_primitive_type->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_type->set_precision( 3 ) ##NUMBER_OK.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'ACTUAL_DELIVERED_QTY_IN__2'
                            iv_element             = VALUE tys_types_for_prim_types-actual_delivered_qty_in__2( ) ).
    lo_primitive_type->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_type->set_precision( 3 ) ##NUMBER_OK.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'ACTUAL_DELIVERY_QUANTITY'
                            iv_element             = VALUE tys_types_for_prim_types-actual_delivery_quantity( ) ).
    lo_primitive_type->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_type->set_precision( 3 ) ##NUMBER_OK.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'ACTUAL_DELIVERY_QUANTITY_2'
                            iv_element             = VALUE tys_types_for_prim_types-actual_delivery_quantity_2( ) ).
    lo_primitive_type->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_type->set_precision( 3 ) ##NUMBER_OK.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'ACTUAL_GOODS_MOVEMENT_DATE'
                            iv_element             = VALUE tys_types_for_prim_types-actual_goods_movement_date( ) ).
    lo_primitive_type->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_type->set_precision( 7 ) ##NUMBER_OK.
    lo_primitive_type->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'ACTUAL_GOODS_MOVEMENT_DA_2'
                            iv_element             = VALUE tys_types_for_prim_types-actual_goods_movement_da_2( ) ).
    lo_primitive_type->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_type->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'BASE_UNIT'
                            iv_element             = VALUE tys_types_for_prim_types-base_unit( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'BASE_UNIT_2'
                            iv_element             = VALUE tys_types_for_prim_types-base_unit_2( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'BATCH'
                            iv_element             = VALUE tys_types_for_prim_types-batch( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'BATCH_BY_SUPPLIER'
                            iv_element             = VALUE tys_types_for_prim_types-batch_by_supplier( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_10'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_10( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_11'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_11( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_12'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_12( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_13'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_13( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_2'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_2( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_3'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_3( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_4'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_4( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_5'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_5( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_6'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_6( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_7'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_7( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_8'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_8( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_9'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_9( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_ITEM'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_item( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_ITEM_2'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_item_2( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_ITEM_3'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_item_3( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_ITEM_4'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_item_4( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_ITEM_5'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_item_5( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_ITEM_6'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_item_6( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_ITEM_7'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_item_7( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_ITEM_8'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_item_8( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_DOCUMENT_ITEM_9'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_document_item_9( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_QUANTITY_UNIT'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_quantity_unit( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DELIVERY_QUANTITY_UNIT_2'
                            iv_element             = VALUE tys_types_for_prim_types-delivery_quantity_unit_2( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'MANUFACTURE_DATE'
                            iv_element             = VALUE tys_types_for_prim_types-manufacture_date( ) ).
    lo_primitive_type->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_type->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'PUTAWAY_QUANTITY_IN_ORDER'
                            iv_element             = VALUE tys_types_for_prim_types-putaway_quantity_in_order( ) ).
    lo_primitive_type->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_type->set_precision( 3 ) ##NUMBER_OK.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'SERIAL_NUMBER'
                            iv_element             = VALUE tys_types_for_prim_types-serial_number( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'SERIAL_NUMBER_2'
                            iv_element             = VALUE tys_types_for_prim_types-serial_number_2( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'SHELF_LIFE_EXPIRATION_DATE'
                            iv_element             = VALUE tys_types_for_prim_types-shelf_life_expiration_date( ) ).
    lo_primitive_type->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_type->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

  ENDMETHOD.