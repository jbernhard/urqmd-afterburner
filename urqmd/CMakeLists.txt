# Adapted from the makefiles in the public UrQMD distribution.
if("${CMAKE_Fortran_COMPILER_ID}" STREQUAL "Intel")
  set(SYSTEM_FILES intranf.f erf.f)
else()
  set(SYSTEM_FILES gnuranf.f)
endif()

add_executable(urqmd
  addpart.f
  angdis.f
  anndec.f
  bessel.f
  blockres.f
  boxprg.f
  cascinit.f
  coload.f
  dectim.f
  delpart.f
  detbal.f
  dwidth.f
  error.f
  getmass.f
  getspin.f
  hepnam.f
  hepchg.f
  hepcmp.f
  init.f
  input.f
  iso.f
  ityp2pdg.f
  jdecay2.f
  make22.f
  numrec.f
  output.f
  paulibl.f
  proppot.f
  pythia6409.f
  quadri.f90
  saveinfo.f
  scatter.f
  siglookup.f
  string.f
  tabinit.f
  upmerge.f
  whichres.f
  urqmd.f
  ${SYSTEM_FILES}
)

install(TARGETS urqmd DESTINATION bin)
