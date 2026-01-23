unmanaged implementation in class /exedminb/cl_nfemonitor_manage unique;
strict ( 2 );
auxiliary class /exedminb/cl_nfe_inb_processor;

define behavior for /EXEDMINB/I_NFeMonitorH alias _NFeMonitorH
lock master
authorization master ( instance )
{
  field ( readonly ) ChaveNFe;

  //Line Actions
  action executarProcesso result [1] $self;

  //Object Actions
  action migo;
  action miro;

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
  ChaveNFe, ItemNFe, ItemIdDiv, Material, DescricaoMaterial, NCM,
  CFOP, ValorUnitario, UnidadeMedida, AliquotaICMS, AliquotaIPI, ValorIPI;

  action dividir parameter /EXEDMINB/a_dividir_in_param;
  action eliminar;

  association _Header;
}