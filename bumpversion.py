#!/usr/bin/env python2

import time
import subprocess


class File(object):
    def __init__(self, source, identifier):
        self._source = source
        self._identifier = identifier

        self._prolog = []
        self._version = None
        self._epilog = []

        # Parse the file.
        self._parse()

    def __repr__(self):
        return self._source

    def get_path(self):
        return self._source

    def _parse(self):
        with open(self._source) as f:
            s = f.read()
        list_ = self._prolog
        for line in s.splitlines(True):
            if self._version is None:
                version = self._parse_version_string(line)
                if version:
                    # We found a version string, so switch to the epilog list
                    # to store the remaining lines, store the version object,
                    # and continue.
                    list_ = self._epilog
                    self._version = version
                    continue
            list_.append(line)

    def _verify_version_parts(self, release, patch):
        # Verify the release format (yyyymmdd).
        try:
            # This will raise a {Value,Type}Error if `release` is not a string,
            # does not contain eight characters or is not purely numeric.
            if not isinstance(release, str) or len(release) != 8:
                raise TypeError
            release = int(release)
        except (ValueError, TypeError):
            self._fatal_error(
                "Invalid release format: `{:s}`".format(release))

        # Verify the patch level if given.
        if patch is not None:
            try:
                patch = int(patch)
            except ValueError:
                self._fatal_error("Invalid patch level: `{:s}`".format(patch))

        return release, patch

    def _fatal_error(self, message):
        raise SystemExit("{:s} ({:s})".format(message, self._source))

    def _parse_version_string(self, string):
        if self._identifier in string:
            version = string.replace(self._identifier, "").strip()
            parts = filter(None, version.split("."))
            if "." in string and len(parts) == 1 or len(parts) > 2:
                # We found a dot in the version string, but no proper patch
                # level, or we found more than one dot, so raise an error.
                self._fatal_error(
                    "Malformed version string: `{:s}`".format(version))
            try:
                release, patch = parts
            except ValueError:
                release = parts[0]
                patch = None
            return Version(*self._verify_version_parts(release, patch))
        return None

    def get_version(self):
        return self._version

    def _unparse(self, version):
        return "".join(self._prolog + [version] + self._epilog)

    def update(self):
        self._version.bump()
        version_string = "{:s}{:s}\n".format(self._identifier, self._version)
        content = self._unparse(version_string)
        with open(self._source, "w") as f:
            f.write(content)

class Version(object):
    def __init__(self, release, patch):
        self._release = release
        self._patch = patch

    def bump(self):
        new_release = int(time.strftime("%Y%m%d"))
        if self._release == new_release:
            if self._patch is None:
                self._patch = 1
            else:
                self._patch += 1
        else:
            self._release = new_release
            self._patch = None

    def as_string(self):
        return str(self)

    def __str__(self):
        if self._patch:
            version_string = "{:d}.{:d}".format(self._release, self._patch)
        else:
            version_string = str(self._release)
        return version_string

    def __eq__(self, other):
        return self._release == other._release and self._patch == other._patch

    def __ne__(self, other):
        return not (self == other)


def _spawn_process(program, args):
    PIPE = subprocess.PIPE
    process = subprocess.Popen([program] + args, stdout=PIPE, stderr=PIPE)
    return map(str.strip, process.communicate())

def index_dirty():
    stdout, _ = _spawn_process("git", ["diff", "--shortstat"])
    return bool(stdout)

def changes_staged():
    stdout, _ = _spawn_process("git", ["diff", "--shortstat --staged"])
    return bool(stdout)

def tag_exists(version):
    stdout, _ = _spawn_process("git", ["tag"])
    return version in stdout.splitlines()

def stage_file(file_):
    _, stderr = _spawn_process("git", ["add", file_])
    if stderr:
        raise SystemExit("Staging failed: {:s}".format(stderr))

def commit_changes(message):
    subprocess.call(["git", "commit", "-m", message])

def create_tag(version):
    subprocess.call(["git", "tag", version])

def main():
    if index_dirty():
        raise SystemExit("There are uncommitted changes in your index")

    files = [File(source, identifier) for source, identifier in [
        ("dist/archlinux/PKGBUILD", "pkgver="),
        ("dist/rpm/tilatex.spec", "Version: ")
    ]]

    # Verify that all version strings are identical.
    other_file = None
    for file_ in files:
        if other_file is None:
            other_file = file_
            # No versions to compare yet, moving on.
            continue
        else:
            version = file_.get_version()
            other_version = other_file.get_version()
            if version != other_version:
                raise SystemExit(
                    "Version mismatch: `{:s}` ({:s}) <-> `{:s}` ({:s})".format(
                        version, file_, other_version, other_file))

    # Test if there's a tag for the current version.
    version_string = version.as_string()
    if not tag_exists(version_string):
        raise SystemExit(
            "There is no tag for version `{:s}` yet".format(version_string))

    # We issue the actual file updates in a secondary loop so that we don't end
    # up with a few updated and a few outdated files.
    for file_ in files:
        # This modifies the the File's Version instance.
        file_.update()
        stage_file(file_.get_path())
    new_version_string = version.as_string()

    if changes_staged():
        raise SystemExit("Nothing to commit")

    # Commit the changes.
    commit_changes("Version bump: `{:s}` -> `{:s}`".format(
        version_string, new_version_string))

    # Create a tag.
    create_tag(new_version_string)

if __name__ == "__main__":
    main()

