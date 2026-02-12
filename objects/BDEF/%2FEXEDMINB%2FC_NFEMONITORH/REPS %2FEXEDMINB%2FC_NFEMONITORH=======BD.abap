projection;
strict ( 2 );

define behavior for /EXEDMINB/C_NFEMONITORH //alias <alias_name>
{

  use delete;

  use action etapa_100;
  use action etapa_200;
  use action etapa_300;
  use action etapa_400;
  use action etapa_500;
  use action etapa_600;
  use action etapa_700;
  use action etapa_800;
  use action etapa_900;

  use association _Item;
}

define behavior for /EXEDMINB/C_NFEMONITORI //alias <alias_name>
{
  use create;
  use update;

  use action dividir;
  use action eliminar;

  use association _Header;
}