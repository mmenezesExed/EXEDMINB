  METHOD def_a_maintenance_item_obj_l_2.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'A_MAINTENANCE_ITEM_OBJ_L_2'
                                    is_structure              = VALUE tys_a_maintenance_item_obj_l_2( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'A_MaintenanceItemObjListType' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'A_MAINTENANCE_ITEM_OBJ_LIS' ).
    lo_entity_set->set_edm_name( 'A_MaintenanceItemObjList' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'ASSEMBLY' ).
    lo_primitive_property->set_edm_name( 'Assembly' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'EQUIPMENT' ).
    lo_primitive_property->set_edm_name( 'Equipment' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 18 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FUNCTIONAL_LOCATION' ).
    lo_primitive_property->set_edm_name( 'FunctionalLocation' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MAINTENANCE_ITEM_OBJECT' ).
    lo_primitive_property->set_edm_name( 'MaintenanceItemObject' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MAINTENANCE_ITEM_OBJECT_LI' ).
    lo_primitive_property->set_edm_name( 'MaintenanceItemObjectList' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int64' ) ##NO_TEXT.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MAINTENANCE_NOTIFICATION' ).
    lo_primitive_property->set_edm_name( 'MaintenanceNotification' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MAINT_OBJECT_LOC_ACCT_ASSG' ).
    lo_primitive_property->set_edm_name( 'MaintObjectLocAcctAssgmtNmbr' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MATERIAL' ).
    lo_primitive_property->set_edm_name( 'Material' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SERIAL_NUMBER' ).
    lo_primitive_property->set_edm_name( 'SerialNumber' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 18 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MANUFACTURER_SERIAL_NUMBER' ).
    lo_primitive_property->set_edm_name( 'ManufacturerSerialNumber' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 30 ) ##NUMBER_OK.

  ENDMETHOD.