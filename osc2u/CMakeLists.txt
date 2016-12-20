add_executable(osc2u
  osc2u.f
  pdg2ityp.f
  vni_procev.f
  blockres.f
  dectim.f
  gnuranf.f
)

install(TARGETS osc2u DESTINATION bin)
