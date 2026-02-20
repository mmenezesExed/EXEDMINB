class lhc_CadUn definition inheriting from cl_abap_behavior_handler.
  private section.

    methods get_global_authorizations for global authorization
      importing request requested_authorizations for CadUn result result.

    methods get_instance_authorizations for instance authorization
      importing keys request requested_authorizations for CadUn result result.

endclass.

class lhc_CadUn implementation.

  method get_global_authorizations.
  endmethod.

  METHOD get_instance_authorizations.
  ENDMETHOD.

endclass.