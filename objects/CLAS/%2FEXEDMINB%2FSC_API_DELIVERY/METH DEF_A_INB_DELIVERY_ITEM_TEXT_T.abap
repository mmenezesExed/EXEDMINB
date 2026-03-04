  METHOD def_a_inb_delivery_item_text_t.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'A_INB_DELIVERY_ITEM_TEXT_T'
                                    is_structure              = VALUE tys_a_inb_delivery_item_text_t( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'A_InbDeliveryItemTextType' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'A_INB_DELIVERY_ITEM_TEXT' ).
    lo_entity_set->set_edm_name( 'A_InbDeliveryItemText' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'DELIVERY_DOCUMENT' ).
    lo_primitive_property->set_edm_name( 'DeliveryDocument' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DELIVERY_DOCUMENT_ITEM' ).
    lo_primitive_property->set_edm_name( 'DeliveryDocumentItem' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TEXT_ELEMENT' ).
    lo_primitive_property->set_edm_name( 'TextElement' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LANGUAGE' ).
    lo_primitive_property->set_edm_name( 'Language' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TEXT_ELEMENT_DESCRIPTION' ).
    lo_primitive_property->set_edm_name( 'TextElementDescription' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 30 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TEXT_ELEMENT_TEXT' ).
    lo_primitive_property->set_edm_name( 'TextElementText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DELIVERY_LONG_TEXT_IS_FORM' ).
    lo_primitive_property->set_edm_name( 'DeliveryLongTextIsFormatted' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.

  ENDMETHOD.