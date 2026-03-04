  PRIVATE SECTION.

    "! <p class="shorttext synchronized">Model</p>
    DATA mo_model TYPE REF TO /iwbep/if_v4_pm_model.


    "! <p class="shorttext synchronized">Define CreatedDeliveryItem</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_created_delivery_item RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define DeliveryMessage</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_delivery_message RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PutawayReport</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_putaway_report RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define A_InbDeliveryAddressType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_a_inb_delivery_address_typ RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define A_InbDeliveryDocFlowType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_a_inb_delivery_doc_flow_ty RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define A_InbDeliveryHeaderTextType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_a_inb_delivery_header_te_2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define A_InbDeliveryHeaderType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_a_inb_delivery_header_type RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define A_InbDeliveryItemTextType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_a_inb_delivery_item_text_t RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define A_InbDeliveryItemType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_a_inb_delivery_item_type RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define A_InbDeliveryPartnerType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_a_inb_delivery_partner_typ RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define A_InbDeliverySerialNmbrType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_a_inb_delivery_serial_nm_2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define A_MaintenanceItemObjListType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_a_maintenance_item_obj_l_2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define AddSerialNumberToDeliveryItem</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_add_serial_number_to_deliv RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define ConfirmPutawayAllItems</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_confirm_putaway_all_items RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define ConfirmPutawayOneItem</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_confirm_putaway_one_item RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define CreateBatchSplitItem</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_create_batch_split_item RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define DeleteAllSerialNumbersFromDeliveryItem</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_delete_all_serial_numbers RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define DeleteSerialNumberFromDeliveryItem</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_delete_serial_number_from RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PostGoodsReceipt</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_post_goods_receipt RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PutawayAllItems</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_putaway_all_items RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PutawayOneItem</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_putaway_one_item RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PutawayOneItemWithBaseQuantity</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_putaway_one_item_with_base RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PutawayOneItemWithSalesQuantity</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_putaway_one_item_with_sale RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define ReverseGoodsReceipt</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_reverse_goods_receipt RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define SetPutawayQuantityWithBaseQuantity</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_set_putaway_quantity_with RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define all primitive types</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS define_primitive_types RAISING /iwbep/cx_gateway.
