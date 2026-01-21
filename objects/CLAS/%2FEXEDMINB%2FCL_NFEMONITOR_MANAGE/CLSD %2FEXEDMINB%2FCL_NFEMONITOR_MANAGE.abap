class-pool .
*"* class pool for class /EXEDMINB/CL_NFEMONITOR_MANAGE

*"* local type definitions
include /EXEDMINB/CL_NFEMONITOR_MANAGEccdef.

*"* class /EXEDMINB/CL_NFEMONITOR_MANAGE definition
*"* public declarations
  include /EXEDMINB/CL_NFEMONITOR_MANAGEcu.
*"* protected declarations
  include /EXEDMINB/CL_NFEMONITOR_MANAGEco.
*"* private declarations
  include /EXEDMINB/CL_NFEMONITOR_MANAGEci.
endclass. "/EXEDMINB/CL_NFEMONITOR_MANAGE definition

*"* macro definitions
include /EXEDMINB/CL_NFEMONITOR_MANAGEccmac.
*"* local class implementation
include /EXEDMINB/CL_NFEMONITOR_MANAGEccimp.

*"* test class
include /EXEDMINB/CL_NFEMONITOR_MANAGEccau.

class /EXEDMINB/CL_NFEMONITOR_MANAGE implementation.
*"* method's implementations
  include methods.
endclass. "/EXEDMINB/CL_NFEMONITOR_MANAGE implementation
