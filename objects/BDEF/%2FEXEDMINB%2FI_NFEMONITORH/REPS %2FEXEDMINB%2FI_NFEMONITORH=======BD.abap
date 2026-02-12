unmanaged implementation in class /exedminb/cl_nfemonitor_manage unique;
strict ( 2 );
auxiliary class /exedminb/cl_nfe_inb_processor;

define behavior for /EXEDMINB/I_NFeMonitorH alias _NFeMonitorH
lock master
authorization master ( instance )
{
  field ( readonly ) ChaveNFe;

  delete;

  //Object Actions
  action etapa_100;
  action etapa_200;
  action etapa_300;
  action etapa_400;
  action etapa_500;
  action etapa_600;
  action etapa_700;
  action etapa_800;
  action etapa_900;

  association _Item;
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