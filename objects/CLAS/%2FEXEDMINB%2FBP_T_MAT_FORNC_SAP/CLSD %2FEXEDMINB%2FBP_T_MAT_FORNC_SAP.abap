class-pool .
*"* class pool for class /EXEDMINB/BP_T_MAT_FORNC_SAP

*"* local type definitions
include /EXEDMINB/BP_T_MAT_FORNC_SAP==ccdef.

*"* class /EXEDMINB/BP_T_MAT_FORNC_SAP definition
*"* public declarations
  include /EXEDMINB/BP_T_MAT_FORNC_SAP==cu.
*"* protected declarations
  include /EXEDMINB/BP_T_MAT_FORNC_SAP==co.
*"* private declarations
  include /EXEDMINB/BP_T_MAT_FORNC_SAP==ci.
endclass. "/EXEDMINB/BP_T_MAT_FORNC_SAP definition

*"* macro definitions
include /EXEDMINB/BP_T_MAT_FORNC_SAP==ccmac.
*"* local class implementation
include /EXEDMINB/BP_T_MAT_FORNC_SAP==ccimp.

*"* test class
include /EXEDMINB/BP_T_MAT_FORNC_SAP==ccau.

class /EXEDMINB/BP_T_MAT_FORNC_SAP implementation.
*"* method's implementations
  include methods.
endclass. "/EXEDMINB/BP_T_MAT_FORNC_SAP implementation
