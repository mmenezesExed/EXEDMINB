  METHOD def_a_supplier_invoice_odntype.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'A_SUPPLIER_INVOICE_ODNTYPE'
                                    is_structure              = VALUE tys_a_supplier_invoice_odntype( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'A_SupplierInvoiceODNType' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'A_SUPPLIER_INVOICE_ODN' ).
    lo_entity_set->set_edm_name( 'A_SupplierInvoiceODN' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'AFDFUNIQUE_KEY_UUID' ).
    lo_primitive_property->set_edm_name( 'AFDFUniqueKeyUUID' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Guid' ) ##NO_TEXT.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SUPPLIER_INVOICE' ).
    lo_primitive_property->set_edm_name( 'SupplierInvoice' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FISCAL_YEAR' ).
    lo_primitive_property->set_edm_name( 'FiscalYear' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'OFFICIAL_DOCUMENT_NUMBER_C' ).
    lo_primitive_property->set_edm_name( 'OfficialDocumentNumberCountry' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'OFFICIAL_DOCUMENT_NUMBER_T' ).
    lo_primitive_property->set_edm_name( 'OfficialDocumentNumberType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'OFFICIAL_DOCUMENT_NUMBER' ).
    lo_primitive_property->set_edm_name( 'OfficialDocumentNumber' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 200 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ODNLEGAL_DATE_TIME_TEXT' ).
    lo_primitive_property->set_edm_name( 'ODNLegalDateTimeText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 30 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'OFFICIAL_DOCUMENT_NUMBER_I' ).
    lo_primitive_property->set_edm_name( 'OfficialDocumentNumberIntType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

  ENDMETHOD.