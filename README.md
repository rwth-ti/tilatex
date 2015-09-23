# tilatex

A collection of LaTeX packages and classes providing common
functionality used at the Institute for Theoretical Information
Technology, RWTH Aachen University, Germany.

## Versioning

Versions are tagged using the following scheme: `YYYYMMDD`.

If you need to tag more than one version at a day, then the scheme is
`YYYYMMDD.x`, where `x` is an integer that is incremented, starting at `1`.

## Installation

### Linux

    $ mkdir -p ~/texmf/tex/latex
    $ cd ~/texmf/tex/latex
    $ for i in /path/to/tilatex/src/* ; do ln -s ${i} . ; done

