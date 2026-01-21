class-pool .
*"* class pool for class /EXEDMINB/CL_NFE_INB_PROCESSOR

*"* local type definitions
include /EXEDMINB/CL_NFE_INB_PROCESSORccdef.

*"* class /EXEDMINB/CL_NFE_INB_PROCESSOR definition
*"* public declarations
  include /EXEDMINB/CL_NFE_INB_PROCESSORcu.
*"* protected declarations
  include /EXEDMINB/CL_NFE_INB_PROCESSORco.
*"* private declarations
  include /EXEDMINB/CL_NFE_INB_PROCESSORci.
endclass. "/EXEDMINB/CL_NFE_INB_PROCESSOR definition

*"* macro definitions
include /EXEDMINB/CL_NFE_INB_PROCESSORccmac.
*"* local class implementation
include /EXEDMINB/CL_NFE_INB_PROCESSORccimp.

*"* test class
include /EXEDMINB/CL_NFE_INB_PROCESSORccau.

class /EXEDMINB/CL_NFE_INB_PROCESSOR implementation.
*"* method's implementations
  include methods.
endclass. "/EXEDMINB/CL_NFE_INB_PROCESSOR implementation
