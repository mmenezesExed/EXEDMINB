managed implementation in class /exedminb/bp_t_atividades unique;
strict ( 2 );

define behavior for /EXEDMINB/T_ATIVIDADES alias _Atividades
lock master
authorization master ( instance )
//etag master <field_name>
{
  field( readonly : update ) Atividade;

  create ( authorization : global );
  update;
  delete;
}