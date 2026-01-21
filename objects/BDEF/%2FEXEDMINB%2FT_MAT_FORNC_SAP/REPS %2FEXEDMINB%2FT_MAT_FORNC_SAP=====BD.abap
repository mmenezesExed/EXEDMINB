managed implementation in class /exedminb/bp_t_mat_fornc_sap unique;
strict ( 2 );

define behavior for /EXEDMINB/T_Mat_Fornc_SAP alias _MaterialForncSAP
lock master
authorization master ( instance )
//etag master <field_name>
{
  create ( authorization : global );
  update;
  delete;
  field ( readonly: update ) CNPJ, Material_Fornecedor;
}