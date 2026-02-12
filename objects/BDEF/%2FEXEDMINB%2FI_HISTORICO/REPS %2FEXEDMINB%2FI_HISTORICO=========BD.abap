managed implementation in class /exedminb/bp_i_historico unique;
strict ( 2 );

define behavior for /EXEDMINB/I_HISTORICO alias Historico
persistent table /exedminb/t_historico
lock master
authorization master ( global )
//etag master <field_name>
{
  field ( readonly, numbering:managed ) Id;

  validation obligatory_fields on save { create; }
  determination set_readonly_fields on save { create; }

  create;
  internal update;

}