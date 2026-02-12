class lhc_Historico definition inheriting from cl_abap_behavior_handler.
  private section.

    methods get_global_authorizations for global authorization
      importing request requested_authorizations for Historico result result.

    methods set_readonly_fields for determine on save
      importing keys for Historico~set_readonly_fields.
    methods obligatory_fields for validate on save
      importing keys for Historico~obligatory_fields.

endclass.

class lhc_Historico implementation.

  method get_global_authorizations.
    result = value #( %create = if_abap_behv=>auth-allowed  ).
  endmethod.

  method set_readonly_fields.

    read entities of /exedminb/i_historico
      in local mode entity Historico
      fields ( IdHistorico )
      with corresponding #( keys )
      result data(lt_historico).

    delete lt_historico where IdNfe is initial.
    delete lt_historico where IdHistorico is not initial.

    check lt_historico is not initial.

    sort lt_historico by IdNfe.

    types: begin of y_max_id_hist,
             IdNfe type /exedminb/i_historico-IdNfe,
             maxid type /exedminb/i_historico-IdHistorico,
           end of y_max_id_hist,
           ty_max_id_hist type table of y_max_id_hist.

    data lt_max_id_hist type ty_max_id_hist.
    data lv_max type /exedminb/t_historico-IdHistorico.

    cl_abap_tstmp=>systemtstmp_syst2utc( exporting syst_date = cl_abap_context_info=>get_system_date( )
                                                   syst_time = cl_abap_context_info=>get_system_time( )
                                         importing utc_tstmp = data(created_at) ).

    loop at lt_historico into data(ls_historico).
      if not line_exists( lt_max_id_hist[ IdNfe = ls_historico-IdNfe ] ).
        select max( IdHistorico )
          from /exedminb/t_historico
          where IdNfe eq @ls_historico-IdNfe
          into @lv_max.

        if sy-subrc eq 0.
          append value #( IdNfe = ls_historico-IdNfe
                          maxid = lv_max ) to lt_max_id_hist.
        endif.
      endif.

      lv_max = lt_max_id_hist[ IdNfe = ls_historico-IdNfe ]-maxid.
      lt_max_id_hist[ IdNfe = ls_historico-IdNfe ]-maxid = lv_max + 1.

      modify entities of  /exedminb/i_historico
        in local mode entity Historico
        update fields ( IdHistorico created_at created_by )
        with value #( ( %tky = ls_historico-%tky
                        IdHistorico = lt_max_id_hist[ IdNfe = ls_historico-IdNfe ]-maxid
                        created_at = created_at
                        created_by = cl_abap_context_info=>get_user_technical_name( ) ) )
        failed final(failed)
        reported final(lt_reported).

    endloop.

  endmethod.

  method obligatory_fields.
    read entities of /exedminb/i_historico
      in local mode entity Historico
      fields ( IdNfe IdHistorico Etapa Status Descricao )
      with corresponding #( keys )
      result data(lt_historico).

    check lt_historico is not initial.

    loop at lt_historico into data(ls_historico) where IdNfe is initial
                                                    or IdHistorico is initial
                                                    or Status is initial
                                                    or Descricao is initial.

      failed-historico = value #( ( %fail = value #( cause = if_abap_behv=>cause-unauthorized )
                                    %key = ls_historico-%key
                                    %create = if_abap_behv=>mk-on ) ).
      reported-historico = value #( ( %key = ls_historico-%key
                                      %msg = me->new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                            text = 'Dados para historico não informados!' ) ) ).

    endloop.

  endmethod.

endclass.