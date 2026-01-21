class-pool .
*"* class pool for class /EXEDMINB/CL_TAX_INTEG_HUB

*"* local type definitions
include /EXEDMINB/CL_TAX_INTEG_HUB====ccdef.

*"* class /EXEDMINB/CL_TAX_INTEG_HUB definition
*"* public declarations
  include /EXEDMINB/CL_TAX_INTEG_HUB====cu.
*"* protected declarations
  include /EXEDMINB/CL_TAX_INTEG_HUB====co.
*"* private declarations
  include /EXEDMINB/CL_TAX_INTEG_HUB====ci.
endclass. "/EXEDMINB/CL_TAX_INTEG_HUB definition

*"* macro definitions
include /EXEDMINB/CL_TAX_INTEG_HUB====ccmac.
*"* local class implementation
include /EXEDMINB/CL_TAX_INTEG_HUB====ccimp.

*"* test class
include /EXEDMINB/CL_TAX_INTEG_HUB====ccau.

class /EXEDMINB/CL_TAX_INTEG_HUB implementation.
*"* method's implementations
  include methods.
endclass. "/EXEDMINB/CL_TAX_INTEG_HUB implementation
