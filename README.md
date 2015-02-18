tilatex
=======

A collection of LaTeX packages and classes providing common
functionality used at the Institute for Theoretical Information
Technology, RWTH Aachen University, Germany.

Packages
--------

[Packages are available at the openSUSE Build Service.](https://software.opensuse.org/download.html?project=home%3Arothe38&package=tilatex)

Versioning
----------

Versions are tagged using the following scheme: `YYYYMMDD`.

If you need to tag more than one version at a day, then the scheme is
`YYYYMMDD.x`, where `x` is an integer that is incremented, starting at `1`.

Development
-----------

Once you have updated this repository and tagged the new version, you
want to build new packages for our fellow colleagues.
For this, we use the [openSUSE Build Service](https://build.opensuse.org/).

First, install the [Open Build Service command line tool](https://en.opensuse.org/openSUSE:OSC).

You can trigger the download of package specific files (e.g. Spec File,
`PKGBUILD`) as follows (defined in `_service` in the OBS repository).
This should also trigger a rebuild of all packages.

    $ osc service remoterun home:rothe38 tilatex

A rebuild of all packages can be triggered using the following command.

    $ osc rebuild home:rothe38 tilatex --all

Checking out the repository (only needed if you have to edit the
`_service` file.

    $ osc co home:rothe38 tilatex

Commit changes to the `_service` file.

    $ pwd
    /path/to/home:rothe38/tilatex
    $ osc commit

