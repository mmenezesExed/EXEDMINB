projection;
strict ( 2 );

define behavior for /EXEDMINB/C_NFEMONITORLOGH alias _NFeMonitorH
{
  use update;

  use action etapa_700;
  use action etapa_800;

  use association _Item;
  use association _Delivery;
}

define behavior for /EXEDMINB/C_NFEMONITORLOGI alias _NFeMonitorI
{

  use association _Header;
}

define behavior for /EXEDMINB/C_NFEMINBDELIVERY alias _NFeMonitorDelivery
{
  use update;

  use association _Header;
}