"! <p class="shorttext synchronized">Consumption model for client proxy - generated</p>
"! This class has been generated based on the metadata with namespace
"! <em>API_MATERIAL_DOCUMENT_SRV</em>
CLASS /exedminb/cl_api_material_doc DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_v4_abs_pm_model_prov
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES:
      "! <p class="shorttext synchronized">Types for "OData Primitive Types"</p>
      BEGIN OF tys_types_for_prim_types,
        "! Used for primitive type MATERIAL_DOCUMENT
        material_document        TYPE c LENGTH 10,
        "! Used for primitive type MATERIAL_DOCUMENT_2
        material_document_2      TYPE c LENGTH 10,
        "! Used for primitive type MATERIAL_DOCUMENT_ITEM
        material_document_item   TYPE c LENGTH 4,
        "! Used for primitive type MATERIAL_DOCUMENT_YEAR
        material_document_year   TYPE c LENGTH 4,
        "! Used for primitive type MATERIAL_DOCUMENT_YEAR_2
        material_document_year_2 TYPE c LENGTH 4,
        "! Used for primitive type POSTING_DATE
        posting_date             TYPE string,
        "! Used for primitive type POSTING_DATE_2
        posting_date_2           TYPE string,
      END OF tys_types_for_prim_types.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function Cancel</p>
      "! <em>with the internal name</em> CANCEL
      BEGIN OF tys_parameters_1,
        "! MaterialDocumentYear
        material_document_year TYPE c LENGTH 4,
        "! MaterialDocument
        material_document      TYPE c LENGTH 10,
        "! PostingDate
        posting_date           TYPE string,
      END OF tys_parameters_1,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_1</p>
      tyt_parameters_1 TYPE STANDARD TABLE OF tys_parameters_1 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function CancelItem</p>
      "! <em>with the internal name</em> CANCEL_ITEM
      BEGIN OF tys_parameters_2,
        "! MaterialDocumentYear
        material_document_year TYPE c LENGTH 4,
        "! MaterialDocument
        material_document      TYPE c LENGTH 10,
        "! MaterialDocumentItem
        material_document_item TYPE c LENGTH 4,
        "! PostingDate
        posting_date           TYPE string,
      END OF tys_parameters_2,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_2</p>
      tyt_parameters_2 TYPE STANDARD TABLE OF tys_parameters_2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">A_MaterialDocumentHeaderType</p>
      BEGIN OF tys_a_material_document_head_2,
        "! <em>Key property</em> MaterialDocumentYear
        material_document_year     TYPE c LENGTH 4,
        "! <em>Key property</em> MaterialDocument
        material_document          TYPE c LENGTH 10,
        "! InventoryTransactionType
        inventory_transaction_type TYPE c LENGTH 2,
        "! DocumentDate
        document_date              TYPE string,
        "! PostingDate
        posting_date               TYPE string,
        "! CreationDate
        creation_date              TYPE string,
        "! CreationTime
        creation_time              TYPE string,
        "! CreatedByUser
        created_by_user            TYPE c LENGTH 12,
        "! MaterialDocumentHeaderText
        material_document_header_t TYPE c LENGTH 25,
        "! ReferenceDocument
        reference_document         TYPE c LENGTH 16,
        "! VersionForPrintingSlip
        version_for_printing_slip  TYPE c LENGTH 1,
        "! ManualPrintIsTriggered
        manual_print_is_triggered  TYPE c LENGTH 1,
        "! CtrlPostgForExtWhseMgmtSyst
        ctrl_postg_for_ext_whse_mg TYPE c LENGTH 1,
        "! GoodsMovementCode
        goods_movement_code        TYPE c LENGTH 2,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_a_material_document_head_2,
      "! <p class="shorttext synchronized">List of A_MaterialDocumentHeaderType</p>
      tyt_a_material_document_head_2 TYPE STANDARD TABLE OF tys_a_material_document_head_2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">A_MaterialDocumentItemType</p>
      BEGIN OF tys_a_material_document_item_t,
        "! <em>Key property</em> MaterialDocumentYear
        material_document_year     TYPE c LENGTH 4,
        "! <em>Key property</em> MaterialDocument
        material_document          TYPE c LENGTH 10,
        "! <em>Key property</em> MaterialDocumentItem
        material_document_item     TYPE c LENGTH 4,
        "! Material
        material                   TYPE c LENGTH 40,
        "! Plant
        plant                      TYPE c LENGTH 4,
        "! StorageLocation
        storage_location           TYPE c LENGTH 4,
        "! Batch
        batch                      TYPE c LENGTH 10,
        "! BatchBySupplier
        batch_by_supplier          TYPE c LENGTH 15,
        "! GoodsMovementType
        goods_movement_type        TYPE c LENGTH 3,
        "! InventoryStockType
        inventory_stock_type       TYPE c LENGTH 2,
        "! InventoryValuationType
        inventory_valuation_type   TYPE c LENGTH 10,
        "! InventorySpecialStockType
        inventory_special_stock_ty TYPE c LENGTH 1,
        "! Supplier
        supplier                   TYPE c LENGTH 10,
        "! Customer
        customer                   TYPE c LENGTH 10,
        "! SalesOrder
        sales_order                TYPE c LENGTH 10,
        "! SalesOrderItem
        sales_order_item           TYPE c LENGTH 6,
        "! SalesOrderScheduleLine
        sales_order_schedule_line  TYPE c LENGTH 4,
        "! PurchaseOrder
        purchase_order             TYPE c LENGTH 10,
        "! PurchaseOrderItem
        purchase_order_item        TYPE c LENGTH 5,
        "! WBSElement
        wbselement                 TYPE c LENGTH 24,
        "! ManufacturingOrder
        manufacturing_order        TYPE c LENGTH 12,
        "! ManufacturingOrderItem
        manufacturing_order_item   TYPE c LENGTH 4,
        "! GoodsMovementRefDocType
        goods_movement_ref_doc_typ TYPE c LENGTH 1,
        "! GoodsMovementReasonCode
        goods_movement_reason_code TYPE c LENGTH 4,
        "! Delivery
        delivery                   TYPE c LENGTH 10,
        "! DeliveryItem
        delivery_item              TYPE c LENGTH 6,
        "! AccountAssignmentCategory
        account_assignment_categor TYPE c LENGTH 1,
        "! CostCenter
        cost_center                TYPE c LENGTH 10,
        "! ControllingArea
        controlling_area           TYPE c LENGTH 4,
        "! CostObject
        cost_object                TYPE c LENGTH 12,
        "! GLAccount
        glaccount                  TYPE c LENGTH 10,
        "! FunctionalArea
        functional_area            TYPE c LENGTH 16,
        "! ProfitabilitySegment
        profitability_segment      TYPE c LENGTH 10,
        "! ProfitCenter
        profit_center              TYPE c LENGTH 10,
        "! MasterFixedAsset
        master_fixed_asset         TYPE c LENGTH 12,
        "! FixedAsset
        fixed_asset                TYPE c LENGTH 4,
        "! MaterialBaseUnitISOCode
        material_base_unit_isocode TYPE c LENGTH 3,
        "! MaterialBaseUnitSAPCode
        material_base_unit_sapcode TYPE c LENGTH 3,
        "! MaterialBaseUnit
        material_base_unit         TYPE c LENGTH 3,
        "! QuantityInBaseUnit
        quantity_in_base_unit      TYPE p LENGTH 7 DECIMALS 3,
        "! EntryUnitISOCode
        entry_unit_isocode         TYPE c LENGTH 3,
        "! EntryUnitSAPCode
        entry_unit_sapcode         TYPE c LENGTH 3,
        "! EntryUnit
        entry_unit                 TYPE c LENGTH 3,
        "! QuantityInEntryUnit
        quantity_in_entry_unit     TYPE p LENGTH 7 DECIMALS 3,
        "! CompanyCodeCurrency
        company_code_currency      TYPE c LENGTH 5,
        "! GdsMvtExtAmtInCoCodeCrcy
        gds_mvt_ext_amt_in_co_code TYPE p LENGTH 8 DECIMALS 3,
        "! SlsPrcAmtInclVATInCoCodeCrcy
        sls_prc_amt_incl_vatin_co  TYPE p LENGTH 8 DECIMALS 3,
        "! FiscalYear
        fiscal_year                TYPE c LENGTH 4,
        "! FiscalYearPeriod
        fiscal_year_period         TYPE c LENGTH 7,
        "! FiscalYearVariant
        fiscal_year_variant        TYPE c LENGTH 2,
        "! IssgOrRcvgMaterial
        issg_or_rcvg_material      TYPE c LENGTH 40,
        "! IssgOrRcvgBatch
        issg_or_rcvg_batch         TYPE c LENGTH 10,
        "! IssuingOrReceivingPlant
        issuing_or_receiving_plant TYPE c LENGTH 4,
        "! IssuingOrReceivingStorageLoc
        issuing_or_receiving_stora TYPE c LENGTH 4,
        "! IssuingOrReceivingStockType
        issuing_or_receiving_stock TYPE c LENGTH 2,
        "! IssgOrRcvgSpclStockInd
        issg_or_rcvg_spcl_stock_in TYPE c LENGTH 1,
        "! IssuingOrReceivingValType
        issuing_or_receiving_val_t TYPE c LENGTH 10,
        "! IsCompletelyDelivered
        is_completely_delivered    TYPE abap_bool,
        "! MaterialDocumentItemText
        material_document_item_tex TYPE c LENGTH 50,
        "! GoodsRecipientName
        goods_recipient_name       TYPE c LENGTH 12,
        "! UnloadingPointName
        unloading_point_name       TYPE c LENGTH 25,
        "! ShelfLifeExpirationDate
        shelf_life_expiration_date TYPE string,
        "! ManufactureDate
        manufacture_date           TYPE string,
        "! SerialNumbersAreCreatedAutomly
        serial_numbers_are_created TYPE abap_bool,
        "! Reservation
        reservation                TYPE c LENGTH 10,
        "! ReservationItem
        reservation_item           TYPE c LENGTH 4,
        "! ReservationItemRecordType
        reservation_item_record_ty TYPE c LENGTH 1,
        "! ReservationIsFinallyIssued
        reservation_is_finally_iss TYPE abap_bool,
        "! SpecialStockIdfgSalesOrder
        special_stock_idfg_sales_o TYPE c LENGTH 10,
        "! SpecialStockIdfgSalesOrderItem
        special_stock_idfg_sales_2 TYPE c LENGTH 6,
        "! SpecialStockIdfgWBSElement
        special_stock_idfg_wbselem TYPE c LENGTH 24,
        "! IsAutomaticallyCreated
        is_automatically_created   TYPE c LENGTH 1,
        "! MaterialDocumentLine
        material_document_line     TYPE c LENGTH 6,
        "! MaterialDocumentParentLine
        material_document_parent_l TYPE c LENGTH 6,
        "! HierarchyNodeLevel
        hierarchy_node_level       TYPE c LENGTH 2,
        "! GoodsMovementIsCancelled
        goods_movement_is_cancelle TYPE abap_bool,
        "! ReversedMaterialDocumentYear
        reversed_material_document TYPE c LENGTH 4,
        "! ReversedMaterialDocument
        reversed_material_docume_2 TYPE c LENGTH 10,
        "! ReversedMaterialDocumentItem
        reversed_material_docume_3 TYPE c LENGTH 4,
        "! ReferenceDocumentFiscalYear
        reference_document_fiscal  TYPE c LENGTH 4,
        "! InvtryMgmtRefDocumentItem
        invtry_mgmt_ref_document_i TYPE c LENGTH 4,
        "! InvtryMgmtReferenceDocument
        invtry_mgmt_reference_docu TYPE c LENGTH 10,
        "! MaterialDocumentPostingType
        material_document_posting  TYPE c LENGTH 1,
        "! InventoryUsabilityCode
        inventory_usability_code   TYPE c LENGTH 1,
        "! EWMWarehouse
        ewmwarehouse               TYPE c LENGTH 4,
        "! EWMStorageBin
        ewmstorage_bin             TYPE c LENGTH 18,
        "! DebitCreditCode
        debit_credit_code          TYPE c LENGTH 1,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_a_material_document_item_t,
      "! <p class="shorttext synchronized">List of A_MaterialDocumentItemType</p>
      tyt_a_material_document_item_t TYPE STANDARD TABLE OF tys_a_material_document_item_t WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">A_SerialNumberMaterialDocumentType</p>
      BEGIN OF tys_a_serial_number_material_2,
        "! <em>Key property</em> Material
        material                   TYPE c LENGTH 40,
        "! <em>Key property</em> SerialNumber
        serial_number              TYPE c LENGTH 18,
        "! <em>Key property</em> MaterialDocument
        material_document          TYPE c LENGTH 10,
        "! <em>Key property</em> MaterialDocumentItem
        material_document_item     TYPE c LENGTH 4,
        "! <em>Key property</em> MaterialDocumentYear
        material_document_year     TYPE c LENGTH 4,
        "! ManufacturerSerialNumber
        manufacturer_serial_number TYPE c LENGTH 30,
        "! SerialNumberIsRecursive
        serial_number_is_recursive TYPE c LENGTH 1,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_a_serial_number_material_2,
      "! <p class="shorttext synchronized">List of A_SerialNumberMaterialDocumentType</p>
      tyt_a_serial_number_material_2 TYPE STANDARD TABLE OF tys_a_serial_number_material_2 WITH DEFAULT KEY.


    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the entity sets</p>
      BEGIN OF gcs_entity_set,
        "! A_MaterialDocumentHeader
        "! <br/> Collection of type 'A_MaterialDocumentHeaderType'
        a_material_document_header TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'A_MATERIAL_DOCUMENT_HEADER',
        "! A_MaterialDocumentItem
        "! <br/> Collection of type 'A_MaterialDocumentItemType'
        a_material_document_item   TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'A_MATERIAL_DOCUMENT_ITEM',
        "! A_SerialNumberMaterialDocument
        "! <br/> Collection of type 'A_SerialNumberMaterialDocumentType'
        a_serial_number_material_d TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'A_SERIAL_NUMBER_MATERIAL_D',
      END OF gcs_entity_set .

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the function imports</p>
      BEGIN OF gcs_function_import,
        "! Cancel
        "! <br/> See structure type {@link ..tys_parameters_1} for the parameters
        cancel      TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'CANCEL',
        "! CancelItem
        "! <br/> See structure type {@link ..tys_parameters_2} for the parameters
        cancel_item TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'CANCEL_ITEM',
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
         "! Dummy field - Structure must not be empty
         dummy TYPE int1 VALUE 0,
      END OF gcs_complex_type.

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal names for entity types</p>
      BEGIN OF gcs_entity_type,
        "! <p class="shorttext synchronized">Internal names for A_MaterialDocumentHeaderType</p>
        "! See also structure type {@link ..tys_a_material_document_head_2}
        BEGIN OF a_material_document_head_2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! to_MaterialDocumentItem
            to_material_document_item TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'TO_MATERIAL_DOCUMENT_ITEM',
          END OF navigation,
        END OF a_material_document_head_2,
        "! <p class="shorttext synchronized">Internal names for A_MaterialDocumentItemType</p>
        "! See also structure type {@link ..tys_a_material_document_item_t}
        BEGIN OF a_material_document_item_t,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! to_MaterialDocumentHeader
            to_material_document_heade TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'TO_MATERIAL_DOCUMENT_HEADE',
            "! to_SerialNumbers
            to_serial_numbers          TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'TO_SERIAL_NUMBERS',
          END OF navigation,
        END OF a_material_document_item_t,
        "! <p class="shorttext synchronized">Internal names for A_SerialNumberMaterialDocumentType</p>
        "! See also structure type {@link ..tys_a_serial_number_material_2}
        BEGIN OF a_serial_number_material_2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF a_serial_number_material_2,
      END OF gcs_entity_type.


    METHODS /iwbep/if_v4_mp_basic_pm~define REDEFINITION.

