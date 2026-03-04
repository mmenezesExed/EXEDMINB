class-pool .
*"* class pool for class /EXEDMINB/BP_I_NFEFILES

*"* local type definitions
include /EXEDMINB/BP_I_NFEFILES=======ccdef.

*"* class /EXEDMINB/BP_I_NFEFILES definition
*"* public declarations
  include /EXEDMINB/BP_I_NFEFILES=======cu.
*"* protected declarations
  include /EXEDMINB/BP_I_NFEFILES=======co.
*"* private declarations
  include /EXEDMINB/BP_I_NFEFILES=======ci.
endclass. "/EXEDMINB/BP_I_NFEFILES definition

*"* macro definitions
include /EXEDMINB/BP_I_NFEFILES=======ccmac.
*"* local class implementation
include /EXEDMINB/BP_I_NFEFILES=======ccimp.

*"* test class
include /EXEDMINB/BP_I_NFEFILES=======ccau.

class /EXEDMINB/BP_I_NFEFILES implementation.
*"* method's implementations
  include methods.
endclass. "/EXEDMINB/BP_I_NFEFILES implementation
