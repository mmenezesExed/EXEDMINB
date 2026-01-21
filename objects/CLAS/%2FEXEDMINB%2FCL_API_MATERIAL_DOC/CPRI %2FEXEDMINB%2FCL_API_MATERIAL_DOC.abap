  PRIVATE SECTION.

    "! <p class="shorttext synchronized">Model</p>
    DATA mo_model TYPE REF TO /iwbep/if_v4_pm_model.


    "! <p class="shorttext synchronized">Define A_MaterialDocumentHeaderType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_a_material_document_head_2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define A_MaterialDocumentItemType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_a_material_document_item_t RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define A_SerialNumberMaterialDocumentType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_a_serial_number_material_2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define Cancel</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_cancel RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define CancelItem</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_cancel_item RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define all primitive types</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS define_primitive_types RAISING /iwbep/cx_gateway.
