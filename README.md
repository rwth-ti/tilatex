# tilatex

A collection of LaTeX packages and classes providing common
functionality used at the Institute for Theoretical Information
Technology, RWTH Aachen University, Germany.

## Installation

### Linux

    export TILATEXPATH=/path/to/tilatex/
    cd ${TILATEXPATH}
    make ctan
    mkdir -p ~/texmf/tex/latex
    ln -s ${TILATEXPATH}/tds/tex/latex/tilatex ~/texmf/tex/latex

### OS X

    export TILATEXPATH=/path/to/tilatex/
    cd ${TILATEXPATH}
    make ctan
    mkdir -p ~/Library/texmf/tex/latex
    ln -s ${TILATEXPATH}/tds/tex/latex/tilatex ~/Library/texmf/tex/latex

## Versioning

Versions are tagged using the following scheme: `YYYYMMDD`.

If you need to tag more than one version at a day, then the scheme is
`YYYYMMDD.x`, where `x` is an integer that is incremented, starting at `1`.

