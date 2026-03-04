managed implementation in class /exedminb/bp_i_nfefiles unique;
strict ( 2 );

define behavior for /EXEDMINB/I_NFEFILES //alias <alias_name>
persistent table /exedminb/t_nfefiles
lock master
authorization master ( instance )
//etag master <field_name>
{
  update;
  field ( readonly ) Id, IdFile, Attachment, FileName, MimeType, Descricao;
}