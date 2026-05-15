# ChangeLog

## [?.?](https://github.com/ktetzlaff/src-emacs-on-debian/compare/0.4...fixes-and-improvements-for-debian-bullseye-and-later) (2026-05-??)

### Features

- Allow starting `restore-emacs` from anywhere when providing the Emacs source tree location as command line option.
- Remove manual installation steps (eliminate need to modify `debian-common` files).
- Automatically re-run with sudo (if necessary and if sudo is available).
- Separate Emacs build and install steps to:
  - avoid creating build artefacts as superuser,
  - run the build with multiple parallel make jobs.
- Allow changing the name of the installed Emacs flavor from the default (emacs-snapshot) - not fully tested, yet.
- Add version info to `restore-emacs`.
- Add help/usage message.
- Add option handling. Add options:
  - `--help`: show usage message,
  - `--version`: show version info,
  - positional: path to Emacs src tree,

### Documentation

- Update README.md:
  - new section *Using the `restore-emacs` script*,
  - new section *Backwards Compatibility*.

### Bug Fixes

TODO ...

### Other

- Verify that `restore-emacs` works on Debian forky.
- Fix shellcheck issues.

## [0.4](https://github.com/ktetzlaff/src-emacs-on-debian/compare/0.3...0.4) (2026-05-15)

Bugfix release.

### Bug Fixes

- Fix version detection for Emacs versions >= 30.0.
- Always install `emacs-snapshot_1.0_all.deb` from the directory which contains the `restore-emacs` script.

### Documentation

- Update README.md:
  - document maintainer change,
  - remove link to repository,
  - update paragraph about patching `emacsen-common`.

### Other

- Add CHANGELOG.md (this file).

## 0.3 (020-09-06, unofficial)

Last commit before the repository changed ownership from github user *rrthomas* to *ktetzlaff*.
