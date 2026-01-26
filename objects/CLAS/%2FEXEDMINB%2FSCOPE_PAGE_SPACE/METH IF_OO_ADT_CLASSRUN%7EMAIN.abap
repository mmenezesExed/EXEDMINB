  method if_oo_adt_classrun~main.
    DATA(lo_scope_api) = cl_aps_bc_scope_change_api=>create_instance( ).

    lo_scope_api->scope(
        EXPORTING
            it_object_scope = VALUE #(
                pgmid = if_aps_bc_scope_change_api=>gc_tadir_pgmid-r3tr
                scope_state = if_aps_bc_scope_change_api=>gc_scope_state-on

*               Space template
                ( object = if_aps_bc_scope_change_api=>gc_tadir_object-UIST
                  obj_name = '/EXEDMINB/MONITOR_INBOUND' )

*               Page template
                ( object = if_aps_bc_scope_change_api=>gc_tadir_object-uipg
                  obj_name = '/EXEDMINB/MONITOR_INBOUND' )
            )
            iv_simulate = abap_false
            iv_force = abap_false
        IMPORTING
            et_object_result = DATA(lt_results)
            et_message = DATA(lt_messages) ).

  endmethod.