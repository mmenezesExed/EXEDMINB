  METHOD /iwbep/if_v4_mp_basic_pm~define.

    mo_model = io_model.
    mo_model->set_schema_namespace( 'API_MATERIAL_DOCUMENT_SRV' ) ##NO_TEXT.

    def_a_material_document_head_2( ).
    def_a_material_document_item_t( ).
    def_a_serial_number_material_2( ).
    def_cancel( ).
    def_cancel_item( ).
    define_primitive_types( ).

  ENDMETHOD.