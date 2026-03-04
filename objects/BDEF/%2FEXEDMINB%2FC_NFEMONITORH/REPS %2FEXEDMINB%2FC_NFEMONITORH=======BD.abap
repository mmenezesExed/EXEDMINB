projection;
strict ( 2 );
use side effects;

define behavior for /EXEDMINB/C_NFEMONITORH //alias <alias_name>
{
  use update;
  use delete;

  use action processar;
  use action reprocessar;
  use action etapa_500;

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