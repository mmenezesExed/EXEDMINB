class lhc_I_NFEFILES definition inheriting from cl_abap_behavior_handler.
  private section.

    methods get_instance_authorizations for instance authorization
      importing keys request requested_authorizations for /exedminb/i_nfefiles result result.

endclass.

class lhc_I_NFEFILES implementation.

  method get_instance_authorizations.
  endmethod.

endclass.