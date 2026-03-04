class-pool .
*"* class pool for class /EXEDMINB/CL_NFEMONITOR_FILES

*"* local type definitions
include /EXEDMINB/CL_NFEMONITOR_FILES=ccdef.

*"* class /EXEDMINB/CL_NFEMONITOR_FILES definition
*"* public declarations
  include /EXEDMINB/CL_NFEMONITOR_FILES=cu.
*"* protected declarations
  include /EXEDMINB/CL_NFEMONITOR_FILES=co.
*"* private declarations
  include /EXEDMINB/CL_NFEMONITOR_FILES=ci.
endclass. "/EXEDMINB/CL_NFEMONITOR_FILES definition

*"* macro definitions
include /EXEDMINB/CL_NFEMONITOR_FILES=ccmac.
*"* local class implementation
include /EXEDMINB/CL_NFEMONITOR_FILES=ccimp.

*"* test class
include /EXEDMINB/CL_NFEMONITOR_FILES=ccau.

class /EXEDMINB/CL_NFEMONITOR_FILES implementation.
*"* method's implementations
  include methods.
endclass. "/EXEDMINB/CL_NFEMONITOR_FILES implementation
