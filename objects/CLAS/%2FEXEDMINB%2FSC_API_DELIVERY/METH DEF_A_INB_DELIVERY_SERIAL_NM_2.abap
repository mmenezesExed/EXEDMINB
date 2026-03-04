  METHOD def_a_inb_delivery_serial_nm_2.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'A_INB_DELIVERY_SERIAL_NM_2'
                                    is_structure              = VALUE tys_a_inb_delivery_serial_nm_2( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'A_InbDeliverySerialNmbrType' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'A_INB_DELIVERY_SERIAL_NMBR' ).
    lo_entity_set->set_edm_name( 'A_InbDeliverySerialNmbr' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'DELIVERY_DATE' ).
    lo_primitive_property->set_edm_name( 'DeliveryDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 7 ) ##NUMBER_OK.
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DELIVERY_DOCUMENT' ).
    lo_primitive_property->set_edm_name( 'DeliveryDocument' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DELIVERY_DOCUMENT_ITEM' ).
    lo_primitive_property->set_edm_name( 'DeliveryDocumentItem' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MAINTENANCE_ITEM_OBJECT_LI' ).
    lo_primitive_property->set_edm_name( 'MaintenanceItemObjectList' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int64' ) ##NO_TEXT.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SDDOCUMENT_CATEGORY' ).
    lo_primitive_property->set_edm_name( 'SDDocumentCategory' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.

    lo_navigation_property = lo_entity_type->create_navigation_property( 'TO_MAINTENANCE_ITEM_OBJECT' ).
    lo_navigation_property->set_edm_name( 'to_MaintenanceItemObject' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'A_MAINTENANCE_ITEM_OBJ_L_2' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_many_optional ).

  ENDMETHOD.