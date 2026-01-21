  method CONSTRUCTOR.
  SUPER->constructor(
    EXPORTING
      id = cid
      template_pathprefix = CTEMPLATE_PATHPREFIX
      SECKEY = CONV int8( '8047616034977111378-' )
      created_by_cota = Ccreated_by_cota
      multiple_appdests = CMULTIPLE_APPDESTS
     ).
  endmethod.