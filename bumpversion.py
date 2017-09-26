#!/usr/bin/env python2

from __future__ import print_function

import time
import subprocess


class Version(object):
    def __init__(self, version_string):
        self._release, self._patch = self._parse_version_string(version_string)

    def _parse_version_string(self, string):
        parts = filter(None, string.split("."))
        if "." in string and len(parts) == 1 or len(parts) > 2:
            # We found a dot in the version string, but no proper patch
            # level, or we found more than one dot, so raise an error.
            self._fatal_error("Malformed version string: `{}`".format(string))
        try:
            release, patch = parts
        except ValueError:
            release = parts[0]
            patch = None
        return self._verify_version_parts(release, patch)

    def _fatal_error(self, message):
        raise SystemExit(message)

    def _verify_version_parts(self, release, patch):
        # Verify the release format (yyyymmdd).
        try:
            # This will raise a {Value,Type}Error if `release` is not a string,
            # does not contain eight characters or is not purely numeric.
            if not isinstance(release, str) or len(release) != 8:
                raise TypeError
            release = int(release)
        except (ValueError, TypeError):
            self._fatal_error("Invalid release format: `{}`".format(release))

        # Verify the patch level if given.
        if patch is not None:
            try:
                patch = int(patch)
            except ValueError:
                self._fatal_error("Invalid patch level: `{}`".format(patch))

        return release, patch

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
            version_string = "{}.{}".format(self._release, self._patch)
        else:
            version_string = str(self._release)
        return version_string


def _spawn_process(program, args):
    PIPE = subprocess.PIPE
    process = subprocess.Popen([program] + args, stdout=PIPE, stderr=PIPE)
    return map(str.strip, process.communicate())


def get_latest_version():
    version_string, _ = _spawn_process(
        "git", "describe --tags --abbrev=0".split())
    return Version(version_string)


def tag_exists(version):
    stdout, _ = _spawn_process("git", ["tag"])
    return version in stdout.splitlines()


def create_tag(version, message):
    subprocess.call(["git", "tag", "-m", message, version])


def main():
    version = get_latest_version()
    version_string = version.as_string()
    version.bump()
    new_version_string = version.as_string()
    if tag_exists(new_version_string):
        raise SystemExit(
            "Tag for version `{:s}` already exists".format(new_version_string))

    # Commit the changes.
    tag_message = "Version bump: `{:s}` -> `{:s}`".format(
        version_string, new_version_string)

    # Create a tag.
    create_tag(new_version_string, tag_message)
    print(tag_message)


if __name__ == "__main__":
    main()
