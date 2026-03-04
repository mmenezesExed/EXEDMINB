  method if_sadl_exit_calc_element_read~get_calculation_info.
    if line_exists( it_requested_calc_elements[ table_line = 'XMLATTACHMENT' ] ).
      append 'CHAVENFE' to et_requested_orig_elements.
    endif.
  endmethod.