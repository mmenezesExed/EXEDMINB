class-pool .
*"* class pool for class /EXEDMINB/SC_API_SUPPLINV_PROC

*"* local classes
include /EXEDMINB/SC_API_SUPPLINV_PROCcl.

*"* class /EXEDMINB/SC_API_SUPPLINV_PROC definition
*"* public declarations
  include /EXEDMINB/SC_API_SUPPLINV_PROCcu.
*"* protected declarations
  include /EXEDMINB/SC_API_SUPPLINV_PROCco.
*"* private declarations
  include /EXEDMINB/SC_API_SUPPLINV_PROCci.
endclass. "/EXEDMINB/SC_API_SUPPLINV_PROC definition

class /EXEDMINB/SC_API_SUPPLINV_PROC implementation.
*"* method's implementations
  include methods.
endclass. "/EXEDMINB/SC_API_SUPPLINV_PROC implementation
