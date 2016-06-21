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

where `input_file` contains particle data (presumably produced by a Cooper-Frye hypersurface sampler) in the format described below and `output_file` is the desired filename for the final particle data.

### Input format

Input files contain particle data for one or more events; multiple events are concatenated together.
Each event begins with a commented header line

    # nparticles

The first two characters of the line are skipped, and the next 10 are read as an integer.
The Python format string is `'# {:10d}'`.

After the header line, each particle line has columns

    ID t x y z E px py pz

i.e. the particle's PDG ID, then its position and momentum four-vectors.
The format is an integer of width 10 followed by 8 floating points in format `24.16e`.
The Python format string is `('{:10d}' + 8*'{:24.16e}')`.

#### Warning

The input file must be formatted carefully or it will not be correctly parsed.
The number of particles in the event header must match the actual number of particle lines, and all numbers must follow the expected formats (`10d` for integers and `24.16e` for floats).

### Output format

The default output format is easy to parse and contains only the necessary information for computing standard event-by-event observables (charged-particle multiplicity, flow cumulants, etc).

Similar to the input format, files contain one or more events concatenated together, each beginning with a commented header line and followed by particle lines.
The header contains the event number and total number of particles in the event:

    # event n particles m

Then, particle lines have columns:

    ID charge pT phi y eta

where `ID` is the PDG Monte Carlo particle ID, `charge` is the...charge, `pT` is the magnitude of transverse momentum, `phi` is the azimuthal angle of transverse momentum, `y` is the rapidity, and `eta` is the pseudorapidity.
