# Integrating Emacs built from source into Debian

https://rrthomas@github.com/rrthomas/src-emacs-on-debian

Maintainer: Reuben Thomas <rrt@sc3d.org>  
Author: Michael Olson <mwolson@members.fsf.org>  

N.B.: If you use this package, you should purge it before upgrading your
distribution, because otherwise it is likely to break the upgrade process:
the `emacs` binary may well depend on library versions that are removed by the
upgrade, and hence the emacsen-common hooks will fail!

This git repository contains some useful resources for integrating
Emacs built from source into Debian or derivatives like Ubuntu.

There are two parts to this kit:

1. The local `site-start.el` will be copied to the `site-lisp`
   directory of the newly installed Emacs. It adds Debian specific
   initialization steps to the Emacs startup sequence. E.g. it
   configures elisp libraries installed as Debian packages.

2. `restore-emacs` should be run every time you update your Emacs
   installed from source (e.g. with `git pull`), from the top-level
   source directory. It runs `make install` in the current directory,
   fixes some symlinks, and installs `emacs-snapshot_1.0_all.deb`, a
   package which provides Emacs to satisfy the dependencies of other
   packages.

Also, see https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=840793

In `emacsen-common`, until the bug is fixed,
`/usr/lib/emacsen-common/packages/install/emacsen-common` must be patched to
make the integration into `emacsen-common` work. The following applies to
`emacsen-common` 3.0.8, lines 14–15:

```
(cd /usr/share/${flavor}/site-lisp
  ln -s ../../emacsen-common/debian-startup.el .)
```

   should be replaced with:

```
ln -s /usr/share/emacsen-common/debian-startup.el /usr/share/${flavor}/site-lisp/
```
