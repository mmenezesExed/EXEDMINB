  METHOD /iwbep/if_v4_mp_basic_pm~define.

    mo_model = io_model.
    mo_model->set_schema_namespace( 'API_INBOUND_DELIVERY_SRV' ) ##NO_TEXT.

    def_created_delivery_item( ).
    def_delivery_message( ).
    def_putaway_report( ).
    def_a_inb_delivery_address_typ( ).
    def_a_inb_delivery_doc_flow_ty( ).
    def_a_inb_delivery_header_te_2( ).
    def_a_inb_delivery_header_type( ).
    def_a_inb_delivery_item_text_t( ).
    def_a_inb_delivery_item_type( ).
    def_a_inb_delivery_partner_typ( ).
    def_a_inb_delivery_serial_nm_2( ).
    def_a_maintenance_item_obj_l_2( ).
    def_add_serial_number_to_deliv( ).
    def_confirm_putaway_all_items( ).
    def_confirm_putaway_one_item( ).
    def_create_batch_split_item( ).
    def_delete_all_serial_numbers( ).
    def_delete_serial_number_from( ).
    def_post_goods_receipt( ).
    def_putaway_all_items( ).
    def_putaway_one_item( ).
    def_putaway_one_item_with_base( ).
    def_putaway_one_item_with_sale( ).
    def_reverse_goods_receipt( ).
    def_set_putaway_quantity_with( ).
    define_primitive_types( ).

  ENDMETHOD.