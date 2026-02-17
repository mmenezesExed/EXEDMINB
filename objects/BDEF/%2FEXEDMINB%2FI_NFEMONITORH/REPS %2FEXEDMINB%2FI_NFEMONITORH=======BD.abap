unmanaged implementation in class /exedminb/cl_nfemonitor_manage unique;
strict ( 2 );
auxiliary class /exedminb/cl_nfe_inb_processor;

define behavior for /EXEDMINB/I_NFeMonitorH alias _NFeMonitorH
lock master
authorization master ( instance, global )
{
  field ( readonly ) ChaveNFe;

  delete;

  //Object Actions
  action processar result [1] $self;
  action reprocessar result [1] $self;

  internal action etapa_100;
  internal action etapa_200;
  internal action etapa_300;
  internal action etapa_400;
  internal action etapa_500;
  internal action etapa_600;
  internal action etapa_700;
  internal action etapa_800;
  internal action etapa_900;

  side effects {
    action processar   affects entity _Historico;
    action reprocessar affects entity _Historico;
  }

  association _Item;
  association _Historico;
}

define behavior for /EXEDMINB/I_NFeMonitorI alias _NFeMonitorI
lock dependent by _Header
authorization dependent by _Header
{
  create ( authorization : global ) ;
  update;
  internal delete;
  field ( readonly )
  ChaveNFe, ItemNFe, ItemIdDiv, Plant, Material, DescricaoMaterial, NCM,
  CFOP, ValorUnitario, UnidadeMedida, ValorICMS, AliquotaICMS, AliquotaIPI, ValorIPI;

  action dividir parameter /EXEDMINB/a_dividir_in_param;
  action eliminar;

  association _Header;
}