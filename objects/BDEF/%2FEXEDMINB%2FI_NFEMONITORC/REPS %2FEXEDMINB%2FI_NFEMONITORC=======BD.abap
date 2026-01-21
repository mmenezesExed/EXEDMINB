managed implementation in class /exedminb/cl_bp_nfemonitor unique;
strict ( 2 );

define behavior for /EXEDMINB/I_NFeMonitorC alias _NFeMonitorC
persistent table /exedminb/t_nfeheader
lock master
authorization master ( instance )
//etag master <field_name>
{

  field ( readonly ) Empresa, LocalDeNegocio, ProcessoSAP, Atividade;

  action executarProcessoMassa result [1] $self;

  mapping for /exedminb/t_nfeheader {
    Empresa = bukrs;
    LocalDeNegocio = branch;
    ProcessoSAP = processo;
    Atividade = atividade;
  }
}