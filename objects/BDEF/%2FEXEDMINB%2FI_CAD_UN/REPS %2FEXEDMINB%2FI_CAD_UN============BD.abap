managed implementation in class /exedminb/cl_bp_i_cad_un unique;
strict ( 2 );

define behavior for /EXEDMINB/I_CAD_UN alias CadUn
persistent table /exedminb/t_cad_un
lock master
authorization master ( instance )
{
  field ( readonly : update ) Fornecedor, unFor;

  create ( authorization : global );
  update;
  delete;

}