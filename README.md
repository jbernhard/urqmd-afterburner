# urqmd-afterburner

UrQMD, tailored for use a hadronic afterburner in hybrid hydro+cascade models.

## Attribution

UrQMD is a large, complex model written by many contributors.
Please see the UrQMD website http://urqmd.org and the included license file for more information.

## Usage

This repository contains

- The latest public version of UrQMD (3.4), not including the large equation of state tables, which are only used for UrQMD's built-in hydro mode.
- The OSCAR to UrQMD converter (`osc2u`) written by Steffen A. Bass.
- A simple wrapper script, `afterburner`, that runs `osc2u` and `urqmd` in sequence.

Compile and install:

    mkdir build && cd build
    cmake ..
    make install

This will place several files in `<prefix>/urqmd-afterburner`: the compiled binaries `osc2u` and `urqmd`, and the wrapper script `afterburner`.

Invoke the afterburner with two arguments:

    afterburner input_file output_file

where `input_file` is an OSCAR 1997A file containing particle data (presumably produced by a Cooper-Frye hypersurface sampler) and `output_file` is the desired filename for the final particle data.

The Fortran parsing in `osc2u` is rather strict, so the OSCAR input file must follow the format exactly.
The [UrQMD manual](http://urqmd.org/documentation/urqmd-3.4.pdf) specifies the format in tables 12-13 and code listing 8 on pages 31-32.

I have defined a new, simple output format for UrQMD, and set it as the default output format in `afterburner`.
This format seeks to be easy to parse and contain only the necessary information for computing standard event-by-event observables (charged-particle multiplicity, flow cumulants, etc).
Each event is preceded by a commented header line with the event number and total number of particles in the event:

    # event n particles m

Then, each particle line has columns:

    ID charge mass pT phi eta

where `ID` is the PDG Monte Carlo particle ID, `charge` and `mass` are the corresponding properties of the species, `pT` is the magnitude of transverse momentum, `phi` is the azimuthal angle of transverse momentum, and `eta` is the pseudorapidity.
Multiple events are simply concatenated together.
