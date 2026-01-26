class-pool .
*"* class pool for class /EXEDMINB/SCOPE_PAGE_SPACE

*"* local type definitions
include /EXEDMINB/SCOPE_PAGE_SPACE====ccdef.

*"* class /EXEDMINB/SCOPE_PAGE_SPACE definition
*"* public declarations
  include /EXEDMINB/SCOPE_PAGE_SPACE====cu.
*"* protected declarations
  include /EXEDMINB/SCOPE_PAGE_SPACE====co.
*"* private declarations
  include /EXEDMINB/SCOPE_PAGE_SPACE====ci.
endclass. "/EXEDMINB/SCOPE_PAGE_SPACE definition

*"* macro definitions
include /EXEDMINB/SCOPE_PAGE_SPACE====ccmac.
*"* local class implementation
include /EXEDMINB/SCOPE_PAGE_SPACE====ccimp.

*"* test class
include /EXEDMINB/SCOPE_PAGE_SPACE====ccau.

class /EXEDMINB/SCOPE_PAGE_SPACE implementation.
*"* method's implementations
  include methods.
endclass. "/EXEDMINB/SCOPE_PAGE_SPACE implementation
