*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section
class lcl_abap_behv_msg definition create public inheriting from cx_no_check.
  public section.

    interfaces if_abap_behv_message .

    aliases msgty
      for if_t100_dyn_msg~msgty .
    aliases msgv1
      for if_t100_dyn_msg~msgv1 .
    aliases msgv2
      for if_t100_dyn_msg~msgv2 .
    aliases msgv3
      for if_t100_dyn_msg~msgv3 .
    aliases msgv4
      for if_t100_dyn_msg~msgv4 .

    methods constructor
      importing
        !textid   like if_t100_message=>t100key optional
        !previous like previous optional
        !msgty    type symsgty optional
        !msgv1    type simple optional
        !msgv2    type simple optional
        !msgv3    type simple optional
        !msgv4    type simple optional .

endclass.

class lcl_tools definition.
  public section.
    constants ms like if_abap_behv_message=>severity value if_abap_behv_message=>severity ##NO_TEXT.
    constants mc like if_abap_behv=>cause value if_abap_behv=>cause ##NO_TEXT.

    class-methods: convert_abap_timestamp_2_epoch
      importing
                !iv_date            type sydate
                !iv_time            type syuzeit optional
                !iv_msec            type n default 000
      returning value(ev_timestamp) type string .

    class-methods new_message
      importing
        !id        type symsgid
        !number    type symsgno
        !severity  type if_abap_behv_message=>t_severity
        !v1        type simple optional
        !v2        type simple optional
        !v3        type simple optional
        !v4        type simple optional
      returning
        value(obj) type ref to if_abap_behv_message .

    class-methods new_message_with_text
      importing
        !severity  type if_abap_behv_message=>t_severity default if_abap_behv_message=>severity-error
        !text      type csequence optional
      returning
        value(obj) type ref to if_abap_behv_message .

    class-methods trata_html_text importing text type string
                                  returning value(r_text) type string.
endclass.