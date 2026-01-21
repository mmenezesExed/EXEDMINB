CLASS lhc__nfemonitorc DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _nfemonitorc RESULT result.
    METHODS executarProcessoMassa FOR MODIFY
      IMPORTING keys FOR ACTION _nfemonitorc~executarProcessoMassa RESULT result.

ENDCLASS.

CLASS lhc__nfemonitorc IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD executarProcessoMassa.
    APPEND VALUE #( %tky = keys[ 1 ]-%tky ) TO failed-_nfemonitorc.
    APPEND VALUE #(
      %tky     = keys[ 1 ]-%tky
      %msg     = me->new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Erro processo!' )
    ) TO reported-_nfemonitorc.
  ENDMETHOD.

ENDCLASS.