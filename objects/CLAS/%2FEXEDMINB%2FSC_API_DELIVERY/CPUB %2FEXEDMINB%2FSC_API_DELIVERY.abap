"! <p class="shorttext synchronized">Consumption model for client proxy - generated</p>
"! This class has been generated based on the metadata with namespace
"! <em>API_INBOUND_DELIVERY_SRV</em>
CLASS /exedminb/sc_api_delivery DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_v4_abs_pm_model_prov
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES:
      "! <p class="shorttext synchronized">Types for "OData Primitive Types"</p>
      BEGIN OF tys_types_for_prim_types,
        "! Used for primitive type ACTUAL_DELIVERED_QTY_IN_BA
        actual_delivered_qty_in_ba TYPE decfloat16,
        "! Used for primitive type ACTUAL_DELIVERED_QTY_IN__2
        actual_delivered_qty_in__2 TYPE decfloat16,
        "! Used for primitive type ACTUAL_DELIVERY_QUANTITY
        actual_delivery_quantity   TYPE decfloat16,
        "! Used for primitive type ACTUAL_DELIVERY_QUANTITY_2
        actual_delivery_quantity_2 TYPE decfloat16,
        "! Used for primitive type ACTUAL_GOODS_MOVEMENT_DATE
        actual_goods_movement_date TYPE timestampl,
        "! Used for primitive type ACTUAL_GOODS_MOVEMENT_DA_2
        actual_goods_movement_da_2 TYPE timestamp,
        "! Used for primitive type BASE_UNIT
        base_unit                  TYPE c LENGTH 3,
        "! Used for primitive type BASE_UNIT_2
        base_unit_2                TYPE c LENGTH 3,
        "! Used for primitive type BATCH
        batch                      TYPE c LENGTH 10,
        "! Used for primitive type BATCH_BY_SUPPLIER
        batch_by_supplier          TYPE c LENGTH 15,
        "! Used for primitive type DELIVERY_DOCUMENT
        delivery_document          TYPE c LENGTH 10,
        "! Used for primitive type DELIVERY_DOCUMENT_10
        delivery_document_10       TYPE c LENGTH 10,
        "! Used for primitive type DELIVERY_DOCUMENT_11
        delivery_document_11       TYPE c LENGTH 10,
        "! Used for primitive type DELIVERY_DOCUMENT_12
        delivery_document_12       TYPE c LENGTH 10,
        "! Used for primitive type DELIVERY_DOCUMENT_13
        delivery_document_13       TYPE c LENGTH 10,
        "! Used for primitive type DELIVERY_DOCUMENT_2
        delivery_document_2        TYPE c LENGTH 10,
        "! Used for primitive type DELIVERY_DOCUMENT_3
        delivery_document_3        TYPE c LENGTH 10,
        "! Used for primitive type DELIVERY_DOCUMENT_4
        delivery_document_4        TYPE c LENGTH 10,
        "! Used for primitive type DELIVERY_DOCUMENT_5
        delivery_document_5        TYPE c LENGTH 10,
        "! Used for primitive type DELIVERY_DOCUMENT_6
        delivery_document_6        TYPE c LENGTH 10,
        "! Used for primitive type DELIVERY_DOCUMENT_7
        delivery_document_7        TYPE c LENGTH 10,
        "! Used for primitive type DELIVERY_DOCUMENT_8
        delivery_document_8        TYPE c LENGTH 10,
        "! Used for primitive type DELIVERY_DOCUMENT_9
        delivery_document_9        TYPE c LENGTH 10,
        "! Used for primitive type DELIVERY_DOCUMENT_ITEM
        delivery_document_item     TYPE c LENGTH 6,
        "! Used for primitive type DELIVERY_DOCUMENT_ITEM_2
        delivery_document_item_2   TYPE c LENGTH 6,
        "! Used for primitive type DELIVERY_DOCUMENT_ITEM_3
        delivery_document_item_3   TYPE c LENGTH 6,
        "! Used for primitive type DELIVERY_DOCUMENT_ITEM_4
        delivery_document_item_4   TYPE c LENGTH 6,
        "! Used for primitive type DELIVERY_DOCUMENT_ITEM_5
        delivery_document_item_5   TYPE c LENGTH 6,
        "! Used for primitive type DELIVERY_DOCUMENT_ITEM_6
        delivery_document_item_6   TYPE c LENGTH 6,
        "! Used for primitive type DELIVERY_DOCUMENT_ITEM_7
        delivery_document_item_7   TYPE c LENGTH 6,
        "! Used for primitive type DELIVERY_DOCUMENT_ITEM_8
        delivery_document_item_8   TYPE c LENGTH 6,
        "! Used for primitive type DELIVERY_DOCUMENT_ITEM_9
        delivery_document_item_9   TYPE c LENGTH 6,
        "! Used for primitive type DELIVERY_QUANTITY_UNIT
        delivery_quantity_unit     TYPE c LENGTH 3,
        "! Used for primitive type DELIVERY_QUANTITY_UNIT_2
        delivery_quantity_unit_2   TYPE c LENGTH 3,
        "! Used for primitive type MANUFACTURE_DATE
        manufacture_date           TYPE timestamp,
        "! Used for primitive type PUTAWAY_QUANTITY_IN_ORDER
        putaway_quantity_in_order  TYPE decfloat16,
        "! Used for primitive type SERIAL_NUMBER
        serial_number              TYPE c LENGTH 18,
        "! Used for primitive type SERIAL_NUMBER_2
        serial_number_2            TYPE c LENGTH 18,
        "! Used for primitive type SHELF_LIFE_EXPIRATION_DATE
        shelf_life_expiration_date TYPE timestamp,
      END OF tys_types_for_prim_types.

    TYPES:
      "! <p class="shorttext synchronized">CreatedDeliveryItem</p>
      BEGIN OF tys_created_delivery_item,
        "! DeliveryDocument
        delivery_document      TYPE c LENGTH 10,
        "! DeliveryDocumentItem
        delivery_document_item TYPE c LENGTH 6,
      END OF tys_created_delivery_item,
      "! <p class="shorttext synchronized">List of CreatedDeliveryItem</p>
      tyt_created_delivery_item TYPE STANDARD TABLE OF tys_created_delivery_item WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">DeliveryMessage</p>
      BEGIN OF tys_delivery_message,
        "! CollectiveProcessing
        collective_processing      TYPE c LENGTH 10,
        "! DeliveryDocument
        delivery_document          TYPE c LENGTH 10,
        "! DeliveryDocumentItem
        delivery_document_item     TYPE c LENGTH 6,
        "! ScheduleLine
        schedule_line              TYPE c LENGTH 4,
        "! CollectiveProcessingMsgCounter
        collective_processing_msg  TYPE c LENGTH 2,
        "! SystemMessageIdentification
        system_message_identificat TYPE c LENGTH 20,
        "! SystemMessageNumber
        system_message_number      TYPE c LENGTH 3,
        "! SystemMessageType
        system_message_type        TYPE c LENGTH 1,
        "! SystemMessageVariable1
        system_message_variable_1  TYPE c LENGTH 50,
        "! SystemMessageVariable2
        system_message_variable_2  TYPE c LENGTH 50,
        "! SystemMessageVariable3
        system_message_variable_3  TYPE c LENGTH 50,
        "! SystemMessageVariable4
        system_message_variable_4  TYPE c LENGTH 50,
        "! CollectiveProcessingType
        collective_processing_type TYPE c LENGTH 1,
      END OF tys_delivery_message,
      "! <p class="shorttext synchronized">List of DeliveryMessage</p>
      tyt_delivery_message TYPE STANDARD TABLE OF tys_delivery_message WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">PutawayReport</p>
      BEGIN OF tys_putaway_report,
        "! SystemMessageIdentification
        system_message_identificat TYPE c LENGTH 20,
        "! SystemMessageNumber
        system_message_number      TYPE c LENGTH 3,
        "! SystemMessageType
        system_message_type        TYPE c LENGTH 1,
        "! SystemMessageVariable1
        system_message_variable_1  TYPE c LENGTH 50,
        "! SystemMessageVariable2
        system_message_variable_2  TYPE c LENGTH 50,
        "! SystemMessageVariable3
        system_message_variable_3  TYPE c LENGTH 50,
        "! SystemMessageVariable4
        system_message_variable_4  TYPE c LENGTH 50,
        "! Batch
        batch                      TYPE c LENGTH 10,
        "! DeliveryQuantityUnit
        delivery_quantity_unit     TYPE c LENGTH 3,
        "! ActualDeliveryQuantity
        actual_delivery_quantity   TYPE p LENGTH 7 DECIMALS 3,
        "! DeliveryDocumentItemText
        delivery_document_item_tex TYPE c LENGTH 40,
        "! Material
        material                   TYPE c LENGTH 40,
        "! DeliveryDocumentItem
        delivery_document_item     TYPE c LENGTH 6,
        "! DeliveryDocument
        delivery_document          TYPE c LENGTH 10,
      END OF tys_putaway_report,
      "! <p class="shorttext synchronized">List of PutawayReport</p>
      tyt_putaway_report TYPE STANDARD TABLE OF tys_putaway_report WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function AddSerialNumberToDeliveryItem</p>
      "! <em>with the internal name</em> ADD_SERIAL_NUMBER_TO_DELIV
      BEGIN OF tys_parameters_1,
        "! DeliveryDocument
        delivery_document      TYPE c LENGTH 10,
        "! DeliveryDocumentItem
        delivery_document_item TYPE c LENGTH 6,
        "! SerialNumber
        serial_number          TYPE c LENGTH 18,
      END OF tys_parameters_1,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_1</p>
      tyt_parameters_1 TYPE STANDARD TABLE OF tys_parameters_1 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function PutawayOneItemWithBaseQuantity</p>
      "! <em>with the internal name</em> PUTAWAY_ONE_ITEM_WITH_BASE
      BEGIN OF tys_parameters_2,
        "! ActualDeliveredQtyInBaseUnit
        actual_delivered_qty_in_ba TYPE decfloat16,
        "! BaseUnit
        base_unit                  TYPE c LENGTH 3,
        "! DeliveryDocument
        delivery_document          TYPE c LENGTH 10,
        "! DeliveryDocumentItem
        delivery_document_item     TYPE c LENGTH 6,
      END OF tys_parameters_2,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_2</p>
      tyt_parameters_2 TYPE STANDARD TABLE OF tys_parameters_2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function PutawayOneItemWithSalesQuantity</p>
      "! <em>with the internal name</em> PUTAWAY_ONE_ITEM_WITH_SALE
      BEGIN OF tys_parameters_3,
        "! ActualDeliveryQuantity
        actual_delivery_quantity TYPE decfloat16,
        "! DeliveryDocument
        delivery_document        TYPE c LENGTH 10,
        "! DeliveryDocumentItem
        delivery_document_item   TYPE c LENGTH 6,
        "! DeliveryQuantityUnit
        delivery_quantity_unit   TYPE c LENGTH 3,
      END OF tys_parameters_3,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_3</p>
      tyt_parameters_3 TYPE STANDARD TABLE OF tys_parameters_3 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function ReverseGoodsReceipt</p>
      "! <em>with the internal name</em> REVERSE_GOODS_RECEIPT
      BEGIN OF tys_parameters_4,
        "! DeliveryDocument
        delivery_document          TYPE c LENGTH 10,
        "! ActualGoodsMovementDate
        actual_goods_movement_date TYPE timestamp,
      END OF tys_parameters_4,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_4</p>
      tyt_parameters_4 TYPE STANDARD TABLE OF tys_parameters_4 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function SetPutawayQuantityWithBaseQuantity</p>
      "! <em>with the internal name</em> SET_PUTAWAY_QUANTITY_WITH
      BEGIN OF tys_parameters_5,
        "! ActualDeliveredQtyInBaseUnit
        actual_delivered_qty_in_ba TYPE decfloat16,
        "! BaseUnit
        base_unit                  TYPE c LENGTH 3,
        "! DeliveryDocument
        delivery_document          TYPE c LENGTH 10,
        "! DeliveryDocumentItem
        delivery_document_item     TYPE c LENGTH 6,
      END OF tys_parameters_5,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_5</p>
      tyt_parameters_5 TYPE STANDARD TABLE OF tys_parameters_5 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function ConfirmPutawayAllItems</p>
      "! <em>with the internal name</em> CONFIRM_PUTAWAY_ALL_ITEMS
      BEGIN OF tys_parameters_6,
        "! DeliveryDocument
        delivery_document TYPE c LENGTH 10,
      END OF tys_parameters_6,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_6</p>
      tyt_parameters_6 TYPE STANDARD TABLE OF tys_parameters_6 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function ConfirmPutawayOneItem</p>
      "! <em>with the internal name</em> CONFIRM_PUTAWAY_ONE_ITEM
      BEGIN OF tys_parameters_7,
        "! DeliveryDocument
        delivery_document      TYPE c LENGTH 10,
        "! DeliveryDocumentItem
        delivery_document_item TYPE c LENGTH 6,
      END OF tys_parameters_7,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_7</p>
      tyt_parameters_7 TYPE STANDARD TABLE OF tys_parameters_7 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function CreateBatchSplitItem</p>
      "! <em>with the internal name</em> CREATE_BATCH_SPLIT_ITEM
      BEGIN OF tys_parameters_8,
        "! BatchBySupplier
        batch_by_supplier          TYPE c LENGTH 15,
        "! ManufactureDate
        manufacture_date           TYPE timestamp,
        "! ShelfLifeExpirationDate
        shelf_life_expiration_date TYPE timestamp,
        "! ActualDeliveryQuantity
        actual_delivery_quantity   TYPE decfloat16,
        "! Batch
        batch                      TYPE c LENGTH 10,
        "! DeliveryDocument
        delivery_document          TYPE c LENGTH 10,
        "! DeliveryDocumentItem
        delivery_document_item     TYPE c LENGTH 6,
        "! DeliveryQuantityUnit
        delivery_quantity_unit     TYPE c LENGTH 3,
        "! PutawayQuantityInOrderUnit
        putaway_quantity_in_order  TYPE decfloat16,
      END OF tys_parameters_8,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_8</p>
      tyt_parameters_8 TYPE STANDARD TABLE OF tys_parameters_8 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function DeleteAllSerialNumbersFromDeliveryItem</p>
      "! <em>with the internal name</em> DELETE_ALL_SERIAL_NUMBERS
      BEGIN OF tys_parameters_9,
        "! DeliveryDocument
        delivery_document      TYPE c LENGTH 10,
        "! DeliveryDocumentItem
        delivery_document_item TYPE c LENGTH 6,
      END OF tys_parameters_9,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_9</p>
      tyt_parameters_9 TYPE STANDARD TABLE OF tys_parameters_9 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function DeleteSerialNumberFromDeliveryItem</p>
      "! <em>with the internal name</em> DELETE_SERIAL_NUMBER_FROM
      BEGIN OF tys_parameters_10,
        "! DeliveryDocument
        delivery_document      TYPE c LENGTH 10,
        "! DeliveryDocumentItem
        delivery_document_item TYPE c LENGTH 6,
        "! SerialNumber
        serial_number          TYPE c LENGTH 18,
      END OF tys_parameters_10,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_10</p>
      tyt_parameters_10 TYPE STANDARD TABLE OF tys_parameters_10 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function PostGoodsReceipt</p>
      "! <em>with the internal name</em> POST_GOODS_RECEIPT
      BEGIN OF tys_parameters_11,
        "! DeliveryDocument
        delivery_document          TYPE c LENGTH 10,
        "! ActualGoodsMovementDate
        actual_goods_movement_date TYPE timestampl,
      END OF tys_parameters_11,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_11</p>
      tyt_parameters_11 TYPE STANDARD TABLE OF tys_parameters_11 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function PutawayAllItems</p>
      "! <em>with the internal name</em> PUTAWAY_ALL_ITEMS
      BEGIN OF tys_parameters_12,
        "! DeliveryDocument
        delivery_document TYPE c LENGTH 10,
      END OF tys_parameters_12,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_12</p>
      tyt_parameters_12 TYPE STANDARD TABLE OF tys_parameters_12 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function PutawayOneItem</p>
      "! <em>with the internal name</em> PUTAWAY_ONE_ITEM
      BEGIN OF tys_parameters_13,
        "! DeliveryDocument
        delivery_document      TYPE c LENGTH 10,
        "! DeliveryDocumentItem
        delivery_document_item TYPE c LENGTH 6,
      END OF tys_parameters_13,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_13</p>
      tyt_parameters_13 TYPE STANDARD TABLE OF tys_parameters_13 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">A_InbDeliveryAddressType</p>
      BEGIN OF tys_a_inb_delivery_address_typ,
        "! <em>Key property</em> AddressID
        address_id                 TYPE c LENGTH 10,
        "! AdditionalStreetPrefixName
        additional_street_prefix_n TYPE c LENGTH 40,
        "! AdditionalStreetSuffixName
        additional_street_suffix_n TYPE c LENGTH 40,
        "! AddressTimeZone
        address_time_zone          TYPE c LENGTH 6,
        "! Building
        building                   TYPE c LENGTH 20,
        "! BusinessPartnerName1
        business_partner_name_1    TYPE c LENGTH 40,
        "! BusinessPartnerName2
        business_partner_name_2    TYPE c LENGTH 40,
        "! BusinessPartnerName3
        business_partner_name_3    TYPE c LENGTH 40,
        "! BusinessPartnerName4
        business_partner_name_4    TYPE c LENGTH 40,
        "! CareOfName
        care_of_name               TYPE c LENGTH 40,
        "! CityCode
        city_code                  TYPE c LENGTH 12,
        "! CityName
        city_name                  TYPE c LENGTH 40,
        "! CitySearch
        city_search                TYPE c LENGTH 25,
        "! CompanyPostalCode
        company_postal_code        TYPE c LENGTH 10,
        "! CorrespondenceLanguage
        correspondence_language    TYPE c LENGTH 2,
        "! Country
        country                    TYPE c LENGTH 3,
        "! County
        county                     TYPE c LENGTH 40,
        "! DeliveryServiceNumber
        delivery_service_number    TYPE c LENGTH 10,
        "! DeliveryServiceTypeCode
        delivery_service_type_code TYPE c LENGTH 4,
        "! District
        district                   TYPE c LENGTH 40,
        "! FaxNumber
        fax_number                 TYPE c LENGTH 30,
        "! Floor
        floor                      TYPE c LENGTH 10,
        "! FormOfAddress
        form_of_address            TYPE c LENGTH 4,
        "! FullName
        full_name                  TYPE c LENGTH 80,
        "! HomeCityName
        home_city_name             TYPE c LENGTH 40,
        "! HouseNumber
        house_number               TYPE c LENGTH 10,
        "! HouseNumberSupplementText
        house_number_supplement_te TYPE c LENGTH 10,
        "! Nation
        nation                     TYPE c LENGTH 1,
        "! Person
        person                     TYPE c LENGTH 10,
        "! PhoneNumber
        phone_number               TYPE c LENGTH 30,
        "! POBox
        pobox                      TYPE c LENGTH 10,
        "! POBoxDeviatingCityName
        pobox_deviating_city_name  TYPE c LENGTH 40,
        "! POBoxDeviatingCountry
        pobox_deviating_country    TYPE c LENGTH 3,
        "! POBoxDeviatingRegion
        pobox_deviating_region     TYPE c LENGTH 3,
        "! POBoxIsWithoutNumber
        pobox_is_without_number    TYPE abap_bool,
        "! POBoxLobbyName
        pobox_lobby_name           TYPE c LENGTH 40,
        "! POBoxPostalCode
        pobox_postal_code          TYPE c LENGTH 10,
        "! PostalCode
        postal_code                TYPE c LENGTH 10,
        "! PrfrdCommMediumType
        prfrd_comm_medium_type     TYPE c LENGTH 3,
        "! Region
        region                     TYPE c LENGTH 3,
        "! RoomNumber
        room_number                TYPE c LENGTH 10,
        "! SearchTerm1
        search_term_1              TYPE c LENGTH 20,
        "! StreetName
        street_name                TYPE c LENGTH 60,
        "! StreetPrefixName
        street_prefix_name         TYPE c LENGTH 40,
        "! StreetSearch
        street_search              TYPE c LENGTH 25,
        "! StreetSuffixName
        street_suffix_name         TYPE c LENGTH 40,
        "! TaxJurisdiction
        tax_jurisdiction           TYPE c LENGTH 15,
        "! TransportZone
        transport_zone             TYPE c LENGTH 10,
      END OF tys_a_inb_delivery_address_typ,
      "! <p class="shorttext synchronized">List of A_InbDeliveryAddressType</p>
      tyt_a_inb_delivery_address_typ TYPE STANDARD TABLE OF tys_a_inb_delivery_address_typ WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">A_InbDeliveryDocFlowType</p>
      BEGIN OF tys_a_inb_delivery_doc_flow_ty,
        "! DeliveryVersion
        delivery_version           TYPE c LENGTH 4,
        "! <em>Key property</em> PrecedingDocument
        preceding_document         TYPE c LENGTH 10,
        "! PrecedingDocumentCategory
        preceding_document_categor TYPE c LENGTH 4,
        "! <em>Key property</em> PrecedingDocumentItem
        preceding_document_item    TYPE c LENGTH 6,
        "! QuantityInBaseUnit
        quantity_in_base_unit      TYPE p LENGTH 8 DECIMALS 3,
        "! SDFulfillmentCalculationRule
        sdfulfillment_calculation  TYPE c LENGTH 1,
        "! SubsequentDocument
        subsequent_document        TYPE c LENGTH 10,
        "! <em>Key property</em> SubsequentDocumentCategory
        subsequent_document_catego TYPE c LENGTH 4,
        "! SubsequentDocumentItem
        subsequent_document_item   TYPE c LENGTH 6,
        "! TransferOrderInWrhsMgmtIsConfd
        transfer_order_in_wrhs_mgm TYPE abap_bool,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_a_inb_delivery_doc_flow_ty,
      "! <p class="shorttext synchronized">List of A_InbDeliveryDocFlowType</p>
      tyt_a_inb_delivery_doc_flow_ty TYPE STANDARD TABLE OF tys_a_inb_delivery_doc_flow_ty WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">A_InbDeliveryHeaderTextType</p>
      BEGIN OF tys_a_inb_delivery_header_te_2,
        "! <em>Key property</em> DeliveryDocument
        delivery_document          TYPE c LENGTH 10,
        "! <em>Key property</em> TextElement
        text_element               TYPE c LENGTH 4,
        "! <em>Key property</em> Language
        language                   TYPE c LENGTH 2,
        "! TextElementDescription
        text_element_description   TYPE c LENGTH 30,
        "! TextElementText
        text_element_text          TYPE string,
        "! DeliveryLongTextIsFormatted
        delivery_long_text_is_form TYPE abap_bool,
      END OF tys_a_inb_delivery_header_te_2,
      "! <p class="shorttext synchronized">List of A_InbDeliveryHeaderTextType</p>
      tyt_a_inb_delivery_header_te_2 TYPE STANDARD TABLE OF tys_a_inb_delivery_header_te_2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">A_InbDeliveryHeaderType</p>
      BEGIN OF tys_a_inb_delivery_header_type,
        "! ReceivingLocationTimeZone
        receiving_location_time_zo TYPE c LENGTH 6,
        "! ActualDeliveryRoute
        actual_delivery_route      TYPE c LENGTH 6,
        "! ActualGoodsMovementDate
        actual_goods_movement_date TYPE timestampl,
        "! ActualGoodsMovementTime
        actual_goods_movement_time TYPE timn,
        "! BillingDocumentDate
        billing_document_date      TYPE timestampl,
        "! BillOfLading
        bill_of_lading             TYPE c LENGTH 35,
        "! CompleteDeliveryIsDefined
        complete_delivery_is_defin TYPE abap_bool,
        "! ConfirmationTime
        confirmation_time          TYPE timn,
        "! CreatedByUser
        created_by_user            TYPE c LENGTH 12,
        "! CreationDate
        creation_date              TYPE timestampl,
        "! CreationTime
        creation_time              TYPE timn,
        "! CustomerGroup
        customer_group             TYPE c LENGTH 2,
        "! DeliveryBlockReason
        delivery_block_reason      TYPE c LENGTH 2,
        "! DeliveryDate
        delivery_date              TYPE timestampl,
        "! <em>Key property</em> DeliveryDocument
        delivery_document          TYPE c LENGTH 10,
        "! DeliveryDocumentBySupplier
        delivery_document_by_suppl TYPE c LENGTH 35,
        "! DeliveryDocumentType
        delivery_document_type     TYPE c LENGTH 4,
        "! DeliveryIsInPlant
        delivery_is_in_plant       TYPE abap_bool,
        "! DeliveryPriority
        delivery_priority          TYPE c LENGTH 2,
        "! DeliveryTime
        delivery_time              TYPE timn,
        "! DeliveryVersion
        delivery_version           TYPE c LENGTH 4,
        "! DepreciationPercentage
        depreciation_percentage    TYPE p LENGTH 3 DECIMALS 2,
        "! DistrStatusByDecentralizedWrhs
        distr_status_by_decentrali TYPE c LENGTH 1,
        "! DocumentDate
        document_date              TYPE timestampl,
        "! ExternalIdentificationType
        external_identification_ty TYPE c LENGTH 1,
        "! ExternalTransportSystem
        external_transport_system  TYPE c LENGTH 5,
        "! FactoryCalendarByCustomer
        factory_calendar_by_custom TYPE c LENGTH 2,
        "! GoodsIssueOrReceiptSlipNumber
        goods_issue_or_receipt_sli TYPE c LENGTH 10,
        "! GoodsIssueTime
        goods_issue_time           TYPE timn,
        "! HandlingUnitInStock
        handling_unit_in_stock     TYPE c LENGTH 1,
        "! HdrGeneralIncompletionStatus
        hdr_general_incompletion_s TYPE c LENGTH 1,
        "! HdrGoodsMvtIncompletionStatus
        hdr_goods_mvt_incompletion TYPE c LENGTH 1,
        "! HeaderBillgIncompletionStatus
        header_billg_incompletion  TYPE c LENGTH 1,
        "! HeaderBillingBlockReason
        header_billing_block_reaso TYPE c LENGTH 2,
        "! HeaderDelivIncompletionStatus
        header_deliv_incompletion  TYPE c LENGTH 1,
        "! HeaderGrossWeight
        header_gross_weight        TYPE p LENGTH 8 DECIMALS 3,
        "! HeaderNetWeight
        header_net_weight          TYPE p LENGTH 8 DECIMALS 3,
        "! HeaderPackingIncompletionSts
        header_packing_incompletio TYPE c LENGTH 1,
        "! HeaderPickgIncompletionStatus
        header_pickg_incompletion  TYPE c LENGTH 1,
        "! HeaderVolume
        header_volume              TYPE p LENGTH 8 DECIMALS 3,
        "! HeaderVolumeUnit
        header_volume_unit         TYPE c LENGTH 3,
        "! HeaderWeightUnit
        header_weight_unit         TYPE c LENGTH 3,
        "! IncotermsClassification
        incoterms_classification   TYPE c LENGTH 3,
        "! IncotermsTransferLocation
        incoterms_transfer_locatio TYPE c LENGTH 28,
        "! IntercompanyBillingDate
        intercompany_billing_date  TYPE timestampl,
        "! InternalFinancialDocument
        internal_financial_documen TYPE c LENGTH 10,
        "! IsDeliveryForSingleWarehouse
        is_delivery_for_single_war TYPE c LENGTH 1,
        "! IsExportDelivery
        is_export_delivery         TYPE c LENGTH 1,
        "! LastChangeDate
        last_change_date           TYPE timestampl,
        "! LastChangedByUser
        last_changed_by_user       TYPE c LENGTH 12,
        "! LoadingDate
        loading_date               TYPE timestampl,
        "! LoadingPoint
        loading_point              TYPE c LENGTH 2,
        "! LoadingTime
        loading_time               TYPE timn,
        "! MeansOfTransport
        means_of_transport         TYPE c LENGTH 20,
        "! MeansOfTransportRefMaterial
        means_of_transport_ref_mat TYPE c LENGTH 40,
        "! MeansOfTransportType
        means_of_transport_type    TYPE c LENGTH 4,
        "! OrderCombinationIsAllowed
        order_combination_is_allow TYPE abap_bool,
        "! OrderID
        order_id                   TYPE c LENGTH 12,
        "! OverallDelivConfStatus
        overall_deliv_conf_status  TYPE c LENGTH 1,
        "! OverallDelivReltdBillgStatus
        overall_deliv_reltd_billg  TYPE c LENGTH 1,
        "! OverallGoodsMovementStatus
        overall_goods_movement_sta TYPE c LENGTH 1,
        "! OverallIntcoBillingStatus
        overall_intco_billing_stat TYPE c LENGTH 1,
        "! OverallPackingStatus
        overall_packing_status     TYPE c LENGTH 1,
        "! OverallPickingConfStatus
        overall_picking_conf_statu TYPE c LENGTH 1,
        "! OverallPickingStatus
        overall_picking_status     TYPE c LENGTH 1,
        "! OverallProofOfDeliveryStatus
        overall_proof_of_delivery  TYPE c LENGTH 1,
        "! OverallSDProcessStatus
        overall_sdprocess_status   TYPE c LENGTH 1,
        "! OverallWarehouseActivityStatus
        overall_warehouse_activity TYPE c LENGTH 1,
        "! OvrlItmDelivIncompletionSts
        ovrl_itm_deliv_incompletio TYPE c LENGTH 1,
        "! OvrlItmGdsMvtIncompletionSts
        ovrl_itm_gds_mvt_incomplet TYPE c LENGTH 1,
        "! OvrlItmGeneralIncompletionSts
        ovrl_itm_general_incomplet TYPE c LENGTH 1,
        "! OvrlItmPackingIncompletionSts
        ovrl_itm_packing_incomplet TYPE c LENGTH 1,
        "! OvrlItmPickingIncompletionSts
        ovrl_itm_picking_incomplet TYPE c LENGTH 1,
        "! PaymentGuaranteeProcedure
        payment_guarantee_procedur TYPE c LENGTH 6,
        "! PickedItemsLocation
        picked_items_location      TYPE c LENGTH 20,
        "! PickingDate
        picking_date               TYPE timestampl,
        "! PickingTime
        picking_time               TYPE timn,
        "! PlannedGoodsIssueDate
        planned_goods_issue_date   TYPE timestampl,
        "! ProofOfDeliveryDate
        proof_of_delivery_date     TYPE timestampl,
        "! ProposedDeliveryRoute
        proposed_delivery_route    TYPE c LENGTH 6,
        "! ReceivingPlant
        receiving_plant            TYPE c LENGTH 4,
        "! RouteSchedule
        route_schedule             TYPE c LENGTH 10,
        "! SalesDistrict
        sales_district             TYPE c LENGTH 6,
        "! SalesOffice
        sales_office               TYPE c LENGTH 4,
        "! SalesOrganization
        sales_organization         TYPE c LENGTH 4,
        "! SDDocumentCategory
        sddocument_category        TYPE c LENGTH 4,
        "! ShipmentBlockReason
        shipment_block_reason      TYPE c LENGTH 2,
        "! ShippingCondition
        shipping_condition         TYPE c LENGTH 2,
        "! ShippingPoint
        shipping_point             TYPE c LENGTH 4,
        "! ShippingType
        shipping_type              TYPE c LENGTH 2,
        "! ShipToParty
        ship_to_party              TYPE c LENGTH 10,
        "! SoldToParty
        sold_to_party              TYPE c LENGTH 10,
        "! SpecialProcessingCode
        special_processing_code    TYPE c LENGTH 4,
        "! StatisticsCurrency
        statistics_currency        TYPE c LENGTH 5,
        "! Supplier
        supplier                   TYPE c LENGTH 10,
        "! TotalBlockStatus
        total_block_status         TYPE c LENGTH 1,
        "! TotalCreditCheckStatus
        total_credit_check_status  TYPE c LENGTH 1,
        "! TotalNumberOfPackage
        total_number_of_package    TYPE c LENGTH 5,
        "! TransactionCurrency
        transaction_currency       TYPE c LENGTH 5,
        "! TransportationGroup
        transportation_group       TYPE c LENGTH 4,
        "! TransportationPlanningDate
        transportation_planning_da TYPE timestampl,
        "! TransportationPlanningStatus
        transportation_planning_st TYPE c LENGTH 1,
        "! TransportationPlanningTime
        transportation_planning_ti TYPE timn,
        "! UnloadingPointName
        unloading_point_name       TYPE c LENGTH 25,
        "! Warehouse
        warehouse                  TYPE c LENGTH 3,
        "! WarehouseGate
        warehouse_gate             TYPE c LENGTH 3,
        "! WarehouseStagingArea
        warehouse_staging_area     TYPE c LENGTH 10,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_a_inb_delivery_header_type,
      "! <p class="shorttext synchronized">List of A_InbDeliveryHeaderType</p>
      tyt_a_inb_delivery_header_type TYPE STANDARD TABLE OF tys_a_inb_delivery_header_type WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">A_InbDeliveryItemTextType</p>
      BEGIN OF tys_a_inb_delivery_item_text_t,
        "! <em>Key property</em> DeliveryDocument
        delivery_document          TYPE c LENGTH 10,
        "! <em>Key property</em> DeliveryDocumentItem
        delivery_document_item     TYPE c LENGTH 6,
        "! <em>Key property</em> TextElement
        text_element               TYPE c LENGTH 4,
        "! <em>Key property</em> Language
        language                   TYPE c LENGTH 2,
        "! TextElementDescription
        text_element_description   TYPE c LENGTH 30,
        "! TextElementText
        text_element_text          TYPE string,
        "! DeliveryLongTextIsFormatted
        delivery_long_text_is_form TYPE abap_bool,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_a_inb_delivery_item_text_t,
      "! <p class="shorttext synchronized">List of A_InbDeliveryItemTextType</p>
      tyt_a_inb_delivery_item_text_t TYPE STANDARD TABLE OF tys_a_inb_delivery_item_text_t WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">A_InbDeliveryItemType</p>
      BEGIN OF tys_a_inb_delivery_item_type,
        "! ActualDeliveredQtyInBaseUnit
        actual_delivered_qty_in_ba TYPE p LENGTH 7 DECIMALS 3,
        "! ActualDeliveryQuantity
        actual_delivery_quantity   TYPE p LENGTH 7 DECIMALS 3,
        "! AdditionalCustomerGroup1
        additional_customer_group  TYPE c LENGTH 3,
        "! AdditionalCustomerGroup2
        additional_customer_grou_2 TYPE c LENGTH 3,
        "! AdditionalCustomerGroup3
        additional_customer_grou_3 TYPE c LENGTH 3,
        "! AdditionalCustomerGroup4
        additional_customer_grou_4 TYPE c LENGTH 3,
        "! AdditionalCustomerGroup5
        additional_customer_grou_5 TYPE c LENGTH 3,
        "! AdditionalMaterialGroup1
        additional_material_group  TYPE c LENGTH 3,
        "! AdditionalMaterialGroup2
        additional_material_grou_2 TYPE c LENGTH 3,
        "! AdditionalMaterialGroup3
        additional_material_grou_3 TYPE c LENGTH 3,
        "! AdditionalMaterialGroup4
        additional_material_grou_4 TYPE c LENGTH 3,
        "! AdditionalMaterialGroup5
        additional_material_grou_5 TYPE c LENGTH 3,
        "! AlternateProductNumber
        alternate_product_number   TYPE c LENGTH 40,
        "! BaseUnit
        base_unit                  TYPE c LENGTH 3,
        "! Batch
        batch                      TYPE c LENGTH 10,
        "! BatchBySupplier
        batch_by_supplier          TYPE c LENGTH 15,
        "! BatchClassification
        batch_classification       TYPE c LENGTH 18,
        "! BOMExplosion
        bomexplosion               TYPE c LENGTH 8,
        "! BusinessArea
        business_area              TYPE c LENGTH 4,
        "! ConsumptionPosting
        consumption_posting        TYPE c LENGTH 1,
        "! ControllingArea
        controlling_area           TYPE c LENGTH 4,
        "! CostCenter
        cost_center                TYPE c LENGTH 10,
        "! CreatedByUser
        created_by_user            TYPE c LENGTH 12,
        "! CreationDate
        creation_date              TYPE timestampl,
        "! CreationTime
        creation_time              TYPE timn,
        "! CustEngineeringChgStatus
        cust_engineering_chg_statu TYPE c LENGTH 17,
        "! <em>Key property</em> DeliveryDocument
        delivery_document          TYPE c LENGTH 10,
        "! <em>Key property</em> DeliveryDocumentItem
        delivery_document_item     TYPE c LENGTH 6,
        "! DeliveryDocumentItemCategory
        delivery_document_item_cat TYPE c LENGTH 4,
        "! DeliveryDocumentItemText
        delivery_document_item_tex TYPE c LENGTH 40,
        "! DeliveryGroup
        delivery_group             TYPE c LENGTH 3,
        "! DeliveryQuantityUnit
        delivery_quantity_unit     TYPE c LENGTH 3,
        "! DeliveryRelatedBillingStatus
        delivery_related_billing_s TYPE c LENGTH 1,
        "! DeliveryToBaseQuantityDnmntr
        delivery_to_base_quantity  TYPE p LENGTH 3 DECIMALS 0,
        "! DeliveryToBaseQuantityNmrtr
        delivery_to_base_quantit_2 TYPE p LENGTH 3 DECIMALS 0,
        "! DepartmentClassificationByCust
        department_classification  TYPE c LENGTH 4,
        "! DistributionChannel
        distribution_channel       TYPE c LENGTH 2,
        "! Division
        division                   TYPE c LENGTH 2,
        "! FixedShipgProcgDurationInDays
        fixed_shipg_procg_duration TYPE p LENGTH 3 DECIMALS 2,
        "! GLAccount
        glaccount                  TYPE c LENGTH 10,
        "! GoodsMovementReasonCode
        goods_movement_reason_code TYPE c LENGTH 4,
        "! GoodsMovementStatus
        goods_movement_status      TYPE c LENGTH 1,
        "! GoodsMovementType
        goods_movement_type        TYPE c LENGTH 3,
        "! HigherLevelItem
        higher_level_item          TYPE c LENGTH 6,
        "! InspectionLot
        inspection_lot             TYPE c LENGTH 12,
        "! InspectionPartialLot
        inspection_partial_lot     TYPE c LENGTH 6,
        "! IntercompanyBillingStatus
        intercompany_billing_statu TYPE c LENGTH 1,
        "! InternationalArticleNumber
        international_article_numb TYPE c LENGTH 18,
        "! InventorySpecialStockType
        inventory_special_stock_ty TYPE c LENGTH 1,
        "! InventoryValuationType
        inventory_valuation_type   TYPE c LENGTH 10,
        "! IsCompletelyDelivered
        is_completely_delivered    TYPE abap_bool,
        "! IsNotGoodsMovementsRelevant
        is_not_goods_movements_rel TYPE c LENGTH 1,
        "! IsSeparateValuation
        is_separate_valuation      TYPE abap_bool,
        "! IssgOrRcvgBatch
        issg_or_rcvg_batch         TYPE c LENGTH 10,
        "! IssgOrRcvgMaterial
        issg_or_rcvg_material      TYPE c LENGTH 40,
        "! IssgOrRcvgSpclStockInd
        issg_or_rcvg_spcl_stock_in TYPE c LENGTH 1,
        "! IssgOrRcvgStockCategory
        issg_or_rcvg_stock_categor TYPE c LENGTH 1,
        "! IssgOrRcvgValuationType
        issg_or_rcvg_valuation_typ TYPE c LENGTH 10,
        "! IssuingOrReceivingPlant
        issuing_or_receiving_plant TYPE c LENGTH 4,
        "! IssuingOrReceivingStorageLoc
        issuing_or_receiving_stora TYPE c LENGTH 4,
        "! ItemBillingBlockReason
        item_billing_block_reason  TYPE c LENGTH 2,
        "! ItemBillingIncompletionStatus
        item_billing_incompletion  TYPE c LENGTH 1,
        "! ItemDeliveryIncompletionStatus
        item_delivery_incompletion TYPE c LENGTH 1,
        "! ItemGdsMvtIncompletionSts
        item_gds_mvt_incompletion  TYPE c LENGTH 1,
        "! ItemGeneralIncompletionStatus
        item_general_incompletion  TYPE c LENGTH 1,
        "! ItemGrossWeight
        item_gross_weight          TYPE p LENGTH 8 DECIMALS 3,
        "! ItemIsBillingRelevant
        item_is_billing_relevant   TYPE c LENGTH 1,
        "! ItemNetWeight
        item_net_weight            TYPE p LENGTH 8 DECIMALS 3,
        "! ItemPackingIncompletionStatus
        item_packing_incompletion  TYPE c LENGTH 1,
        "! ItemPickingIncompletionStatus
        item_picking_incompletion  TYPE c LENGTH 1,
        "! ItemVolume
        item_volume                TYPE p LENGTH 8 DECIMALS 3,
        "! ItemVolumeUnit
        item_volume_unit           TYPE c LENGTH 3,
        "! ItemWeightUnit
        item_weight_unit           TYPE c LENGTH 3,
        "! LastChangeDate
        last_change_date           TYPE timestampl,
        "! LoadingGroup
        loading_group              TYPE c LENGTH 4,
        "! ManufactureDate
        manufacture_date           TYPE timestampl,
        "! Material
        material                   TYPE c LENGTH 40,
        "! MaterialByCustomer
        material_by_customer       TYPE c LENGTH 35,
        "! MaterialFreightGroup
        material_freight_group     TYPE c LENGTH 8,
        "! MaterialGroup
        material_group             TYPE c LENGTH 9,
        "! MaterialIsBatchManaged
        material_is_batch_managed  TYPE abap_bool,
        "! MaterialIsIntBatchManaged
        material_is_int_batch_mana TYPE abap_bool,
        "! NumberOfSerialNumbers
        number_of_serial_numbers   TYPE int4,
        "! OrderID
        order_id                   TYPE c LENGTH 12,
        "! OrderItem
        order_item                 TYPE c LENGTH 4,
        "! OriginalDeliveryQuantity
        original_delivery_quantity TYPE p LENGTH 7 DECIMALS 3,
        "! OriginallyRequestedMaterial
        originally_requested_mater TYPE c LENGTH 40,
        "! OverdelivTolrtdLmtRatioInPct
        overdeliv_tolrtd_lmt_ratio TYPE p LENGTH 2 DECIMALS 1,
        "! PackingStatus
        packing_status             TYPE c LENGTH 1,
        "! PartialDeliveryIsAllowed
        partial_delivery_is_allowe TYPE c LENGTH 1,
        "! PaymentGuaranteeForm
        payment_guarantee_form     TYPE c LENGTH 2,
        "! PickingConfirmationStatus
        picking_confirmation_statu TYPE c LENGTH 1,
        "! PickingControl
        picking_control            TYPE c LENGTH 1,
        "! PickingStatus
        picking_status             TYPE c LENGTH 1,
        "! Plant
        plant                      TYPE c LENGTH 4,
        "! PrimaryPostingSwitch
        primary_posting_switch     TYPE c LENGTH 1,
        "! ProductAvailabilityDate
        product_availability_date  TYPE timestampl,
        "! ProductAvailabilityTime
        product_availability_time  TYPE timn,
        "! ProductConfiguration
        product_configuration      TYPE c LENGTH 18,
        "! ProductHierarchyNode
        product_hierarchy_node     TYPE c LENGTH 18,
        "! ProfitabilitySegment
        profitability_segment      TYPE c LENGTH 10,
        "! ProfitCenter
        profit_center              TYPE c LENGTH 10,
        "! ProofOfDeliveryRelevanceCode
        proof_of_delivery_relevanc TYPE c LENGTH 1,
        "! ProofOfDeliveryStatus
        proof_of_delivery_status   TYPE c LENGTH 1,
        "! QuantityIsFixed
        quantity_is_fixed          TYPE abap_bool,
        "! ReceivingPoint
        receiving_point            TYPE c LENGTH 25,
        "! ReferenceDocumentLogicalSystem
        reference_document_logical TYPE c LENGTH 10,
        "! ReferenceSDDocument
        reference_sddocument       TYPE c LENGTH 10,
        "! ReferenceSDDocumentCategory
        reference_sddocument_categ TYPE c LENGTH 4,
        "! ReferenceSDDocumentItem
        reference_sddocument_item  TYPE c LENGTH 6,
        "! DeliveryDocumentItemBySupplier
        delivery_document_item_by  TYPE c LENGTH 6,
        "! RetailPromotion
        retail_promotion           TYPE c LENGTH 10,
        "! SalesDocumentItemType
        sales_document_item_type   TYPE c LENGTH 1,
        "! SalesGroup
        sales_group                TYPE c LENGTH 3,
        "! SalesOffice
        sales_office               TYPE c LENGTH 4,
        "! SDDocumentCategory
        sddocument_category        TYPE c LENGTH 4,
        "! SDProcessStatus
        sdprocess_status           TYPE c LENGTH 1,
        "! ShelfLifeExpirationDate
        shelf_life_expiration_date TYPE timestampl,
        "! StatisticsDate
        statistics_date            TYPE timestampl,
        "! StockType
        stock_type                 TYPE c LENGTH 1,
        "! StorageBin
        storage_bin                TYPE c LENGTH 10,
        "! StorageLocation
        storage_location           TYPE c LENGTH 4,
        "! StorageType
        storage_type               TYPE c LENGTH 3,
        "! SubsequentMovementType
        subsequent_movement_type   TYPE c LENGTH 3,
        "! TransportationGroup
        transportation_group       TYPE c LENGTH 4,
        "! UnderdelivTolrtdLmtRatioInPct
        underdeliv_tolrtd_lmt_rati TYPE p LENGTH 2 DECIMALS 1,
        "! UnlimitedOverdeliveryIsAllowed
        unlimited_overdelivery_is  TYPE abap_bool,
        "! VarblShipgProcgDurationInDays
        varbl_shipg_procg_duration TYPE p LENGTH 3 DECIMALS 2,
        "! Warehouse
        warehouse                  TYPE c LENGTH 3,
        "! WarehouseActivityStatus
        warehouse_activity_status  TYPE c LENGTH 1,
        "! WarehouseStagingArea
        warehouse_staging_area     TYPE c LENGTH 10,
        "! DeliveryVersion
        delivery_version           TYPE c LENGTH 4,
        "! WarehouseStockCategory
        warehouse_stock_category   TYPE c LENGTH 1,
        "! WarehouseStorageBin
        warehouse_storage_bin      TYPE c LENGTH 10,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_a_inb_delivery_item_type,
      "! <p class="shorttext synchronized">List of A_InbDeliveryItemType</p>
      tyt_a_inb_delivery_item_type TYPE STANDARD TABLE OF tys_a_inb_delivery_item_type WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">A_InbDeliveryPartnerType</p>
      BEGIN OF tys_a_inb_delivery_partner_typ,
        "! AddressID
        address_id       TYPE c LENGTH 10,
        "! ContactPerson
        contact_person   TYPE c LENGTH 10,
        "! Customer
        customer         TYPE c LENGTH 10,
        "! <em>Key property</em> PartnerFunction
        partner_function TYPE c LENGTH 2,
        "! Personnel
        personnel        TYPE c LENGTH 8,
        "! <em>Key property</em> SDDocument
        sddocument       TYPE c LENGTH 10,
        "! SDDocumentItem
        sddocument_item  TYPE c LENGTH 6,
        "! Supplier
        supplier         TYPE c LENGTH 10,
      END OF tys_a_inb_delivery_partner_typ,
      "! <p class="shorttext synchronized">List of A_InbDeliveryPartnerType</p>
      tyt_a_inb_delivery_partner_typ TYPE STANDARD TABLE OF tys_a_inb_delivery_partner_typ WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">A_InbDeliverySerialNmbrType</p>
      BEGIN OF tys_a_inb_delivery_serial_nm_2,
        "! DeliveryDate
        delivery_date              TYPE timestampl,
        "! DeliveryDocument
        delivery_document          TYPE c LENGTH 10,
        "! DeliveryDocumentItem
        delivery_document_item     TYPE c LENGTH 6,
        "! <em>Key property</em> MaintenanceItemObjectList
        maintenance_item_object_li TYPE int8,
        "! SDDocumentCategory
        sddocument_category        TYPE c LENGTH 4,
      END OF tys_a_inb_delivery_serial_nm_2,
      "! <p class="shorttext synchronized">List of A_InbDeliverySerialNmbrType</p>
      tyt_a_inb_delivery_serial_nm_2 TYPE STANDARD TABLE OF tys_a_inb_delivery_serial_nm_2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">A_MaintenanceItemObjListType</p>
      BEGIN OF tys_a_maintenance_item_obj_l_2,
        "! Assembly
        assembly                   TYPE c LENGTH 40,
        "! Equipment
        equipment                  TYPE c LENGTH 18,
        "! FunctionalLocation
        functional_location        TYPE c LENGTH 40,
        "! <em>Key property</em> MaintenanceItemObject
        maintenance_item_object    TYPE int4,
        "! <em>Key property</em> MaintenanceItemObjectList
        maintenance_item_object_li TYPE int8,
        "! MaintenanceNotification
        maintenance_notification   TYPE c LENGTH 12,
        "! MaintObjectLocAcctAssgmtNmbr
        maint_object_loc_acct_assg TYPE c LENGTH 12,
        "! Material
        material                   TYPE c LENGTH 40,
        "! SerialNumber
        serial_number              TYPE c LENGTH 18,
        "! ManufacturerSerialNumber
        manufacturer_serial_number TYPE c LENGTH 30,
      END OF tys_a_maintenance_item_obj_l_2,
      "! <p class="shorttext synchronized">List of A_MaintenanceItemObjListType</p>
      tyt_a_maintenance_item_obj_l_2 TYPE STANDARD TABLE OF tys_a_maintenance_item_obj_l_2 WITH DEFAULT KEY.


    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the entity sets</p>
      BEGIN OF gcs_entity_set,
        "! A_InbDeliveryAddress
        "! <br/> Collection of type 'A_InbDeliveryAddressType'
        a_inb_delivery_address     TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'A_INB_DELIVERY_ADDRESS',
        "! A_InbDeliveryDocFlow
        "! <br/> Collection of type 'A_InbDeliveryDocFlowType'
        a_inb_delivery_doc_flow    TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'A_INB_DELIVERY_DOC_FLOW',
        "! A_InbDeliveryHeader
        "! <br/> Collection of type 'A_InbDeliveryHeaderType'
        a_inb_delivery_header      TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'A_INB_DELIVERY_HEADER',
        "! A_InbDeliveryHeaderText
        "! <br/> Collection of type 'A_InbDeliveryHeaderTextType'
        a_inb_delivery_header_text TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'A_INB_DELIVERY_HEADER_TEXT',
        "! A_InbDeliveryItem
        "! <br/> Collection of type 'A_InbDeliveryItemType'
        a_inb_delivery_item        TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'A_INB_DELIVERY_ITEM',
        "! A_InbDeliveryItemText
        "! <br/> Collection of type 'A_InbDeliveryItemTextType'
        a_inb_delivery_item_text   TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'A_INB_DELIVERY_ITEM_TEXT',
        "! A_InbDeliveryPartner
        "! <br/> Collection of type 'A_InbDeliveryPartnerType'
        a_inb_delivery_partner     TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'A_INB_DELIVERY_PARTNER',
        "! A_InbDeliverySerialNmbr
        "! <br/> Collection of type 'A_InbDeliverySerialNmbrType'
        a_inb_delivery_serial_nmbr TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'A_INB_DELIVERY_SERIAL_NMBR',
        "! A_MaintenanceItemObjList
        "! <br/> Collection of type 'A_MaintenanceItemObjListType'
        a_maintenance_item_obj_lis TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'A_MAINTENANCE_ITEM_OBJ_LIS',
      END OF gcs_entity_set .

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the function imports</p>
      BEGIN OF gcs_function_import,
        "! AddSerialNumberToDeliveryItem
        "! <br/> See structure type {@link ..tys_parameters_1} for the parameters
        add_serial_number_to_deliv TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'ADD_SERIAL_NUMBER_TO_DELIV',
        "! ConfirmPutawayAllItems
        "! <br/> See structure type {@link ..tys_parameters_6} for the parameters
        confirm_putaway_all_items  TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'CONFIRM_PUTAWAY_ALL_ITEMS',
        "! ConfirmPutawayOneItem
        "! <br/> See structure type {@link ..tys_parameters_7} for the parameters
        confirm_putaway_one_item   TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'CONFIRM_PUTAWAY_ONE_ITEM',
        "! CreateBatchSplitItem
        "! <br/> See structure type {@link ..tys_parameters_8} for the parameters
        create_batch_split_item    TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'CREATE_BATCH_SPLIT_ITEM',
        "! DeleteAllSerialNumbersFromDeliveryItem
        "! <br/> See structure type {@link ..tys_parameters_9} for the parameters
        delete_all_serial_numbers  TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'DELETE_ALL_SERIAL_NUMBERS',
        "! DeleteSerialNumberFromDeliveryItem
        "! <br/> See structure type {@link ..tys_parameters_10} for the parameters
        delete_serial_number_from  TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'DELETE_SERIAL_NUMBER_FROM',
        "! PostGoodsReceipt
        "! <br/> See structure type {@link ..tys_parameters_11} for the parameters
        post_goods_receipt         TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'POST_GOODS_RECEIPT',
        "! PutawayAllItems
        "! <br/> See structure type {@link ..tys_parameters_12} for the parameters
        putaway_all_items          TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'PUTAWAY_ALL_ITEMS',
        "! PutawayOneItem
        "! <br/> See structure type {@link ..tys_parameters_13} for the parameters
        putaway_one_item           TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'PUTAWAY_ONE_ITEM',
        "! PutawayOneItemWithBaseQuantity
        "! <br/> See structure type {@link ..tys_parameters_2} for the parameters
        putaway_one_item_with_base TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'PUTAWAY_ONE_ITEM_WITH_BASE',
        "! PutawayOneItemWithSalesQuantity
        "! <br/> See structure type {@link ..tys_parameters_3} for the parameters
        putaway_one_item_with_sale TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'PUTAWAY_ONE_ITEM_WITH_SALE',
        "! ReverseGoodsReceipt
        "! <br/> See structure type {@link ..tys_parameters_4} for the parameters
        reverse_goods_receipt      TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'REVERSE_GOODS_RECEIPT',
        "! SetPutawayQuantityWithBaseQuantity
        "! <br/> See structure type {@link ..tys_parameters_5} for the parameters
        set_putaway_quantity_with  TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'SET_PUTAWAY_QUANTITY_WITH',
      END OF gcs_function_import.

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the bound functions</p>
      BEGIN OF gcs_bound_function,
         "! Dummy field - Structure must not be empty
         dummy TYPE int1 VALUE 0,
      END OF gcs_bound_function.

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal names for complex types</p>
      BEGIN OF gcs_complex_type,
        "! <p class="shorttext synchronized">Internal names for CreatedDeliveryItem</p>
        "! See also structure type {@link ..tys_created_delivery_item}
        BEGIN OF created_delivery_item,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF created_delivery_item,
        "! <p class="shorttext synchronized">Internal names for DeliveryMessage</p>
        "! See also structure type {@link ..tys_delivery_message}
        BEGIN OF delivery_message,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF delivery_message,
        "! <p class="shorttext synchronized">Internal names for PutawayReport</p>
        "! See also structure type {@link ..tys_putaway_report}
        BEGIN OF putaway_report,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF putaway_report,
      END OF gcs_complex_type.

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal names for entity types</p>
      BEGIN OF gcs_entity_type,
        "! <p class="shorttext synchronized">Internal names for A_InbDeliveryAddressType</p>
        "! See also structure type {@link ..tys_a_inb_delivery_address_typ}
        BEGIN OF a_inb_delivery_address_typ,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF a_inb_delivery_address_typ,
        "! <p class="shorttext synchronized">Internal names for A_InbDeliveryDocFlowType</p>
        "! See also structure type {@link ..tys_a_inb_delivery_doc_flow_ty}
        BEGIN OF a_inb_delivery_doc_flow_ty,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF a_inb_delivery_doc_flow_ty,
        "! <p class="shorttext synchronized">Internal names for A_InbDeliveryHeaderTextType</p>
        "! See also structure type {@link ..tys_a_inb_delivery_header_te_2}
        BEGIN OF a_inb_delivery_header_te_2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF a_inb_delivery_header_te_2,
        "! <p class="shorttext synchronized">Internal names for A_InbDeliveryHeaderType</p>
        "! See also structure type {@link ..tys_a_inb_delivery_header_type}
        BEGIN OF a_inb_delivery_header_type,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! to_DeliveryDocumentItem
            to_delivery_document_item  TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'TO_DELIVERY_DOCUMENT_ITEM',
            "! to_DeliveryDocumentPartner
            to_delivery_document_partn TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'TO_DELIVERY_DOCUMENT_PARTN',
            "! to_DeliveryDocumentText
            to_delivery_document_text  TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'TO_DELIVERY_DOCUMENT_TEXT',
          END OF navigation,
        END OF a_inb_delivery_header_type,
        "! <p class="shorttext synchronized">Internal names for A_InbDeliveryItemTextType</p>
        "! See also structure type {@link ..tys_a_inb_delivery_item_text_t}
        BEGIN OF a_inb_delivery_item_text_t,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF a_inb_delivery_item_text_t,
        "! <p class="shorttext synchronized">Internal names for A_InbDeliveryItemType</p>
        "! See also structure type {@link ..tys_a_inb_delivery_item_type}
        BEGIN OF a_inb_delivery_item_type,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! to_DeliveryDocumentItemText
            to_delivery_document_item TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'TO_DELIVERY_DOCUMENT_ITEM',
            "! to_DocumentFlow
            to_document_flow          TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'TO_DOCUMENT_FLOW',
            "! to_SerialDeliveryItem
            to_serial_delivery_item   TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'TO_SERIAL_DELIVERY_ITEM',
          END OF navigation,
        END OF a_inb_delivery_item_type,
        "! <p class="shorttext synchronized">Internal names for A_InbDeliveryPartnerType</p>
        "! See also structure type {@link ..tys_a_inb_delivery_partner_typ}
        BEGIN OF a_inb_delivery_partner_typ,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! to_Address
            to_address TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'TO_ADDRESS',
          END OF navigation,
        END OF a_inb_delivery_partner_typ,
        "! <p class="shorttext synchronized">Internal names for A_InbDeliverySerialNmbrType</p>
        "! See also structure type {@link ..tys_a_inb_delivery_serial_nm_2}
        BEGIN OF a_inb_delivery_serial_nm_2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! to_MaintenanceItemObject
            to_maintenance_item_object TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'TO_MAINTENANCE_ITEM_OBJECT',
          END OF navigation,
        END OF a_inb_delivery_serial_nm_2,
        "! <p class="shorttext synchronized">Internal names for A_MaintenanceItemObjListType</p>
        "! See also structure type {@link ..tys_a_maintenance_item_obj_l_2}
        BEGIN OF a_maintenance_item_obj_l_2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF a_maintenance_item_obj_l_2,
      END OF gcs_entity_type.


    METHODS /iwbep/if_v4_mp_basic_pm~define REDEFINITION.

