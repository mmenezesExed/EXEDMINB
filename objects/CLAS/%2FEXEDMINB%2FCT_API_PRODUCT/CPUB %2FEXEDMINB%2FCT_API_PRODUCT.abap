class /EXEDMINB/CT_API_PRODUCT definition
  public
  inheriting from CL_COMM_TARGET_HTTP_LV5
  create public .

public section.

  methods CONSTRUCTOR
    raising
      CX_APPDESTINATION
      CX_COMMUNICATION_TARGET_ERROR .