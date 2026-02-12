class-pool .
*"* class pool for class /EXEDMINB/BP_I_HISTORICO

*"* local type definitions
include /EXEDMINB/BP_I_HISTORICO======ccdef.

*"* class /EXEDMINB/BP_I_HISTORICO definition
*"* public declarations
  include /EXEDMINB/BP_I_HISTORICO======cu.
*"* protected declarations
  include /EXEDMINB/BP_I_HISTORICO======co.
*"* private declarations
  include /EXEDMINB/BP_I_HISTORICO======ci.
endclass. "/EXEDMINB/BP_I_HISTORICO definition

*"* macro definitions
include /EXEDMINB/BP_I_HISTORICO======ccmac.
*"* local class implementation
include /EXEDMINB/BP_I_HISTORICO======ccimp.

*"* test class
include /EXEDMINB/BP_I_HISTORICO======ccau.

class /EXEDMINB/BP_I_HISTORICO implementation.
*"* method's implementations
  include methods.
endclass. "/EXEDMINB/BP_I_HISTORICO implementation
