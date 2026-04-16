# Integrating Emacs built from source into Debian

https://github.com/rrthomas/src-emacs-on-debian

Maintainer: Reuben Thomas <rrt@sc3d.org>  
Author: Michael Olson <mwolson@members.fsf.org>  

N.B.: If you use this package, you should purge it before upgrading your
distribution, because otherwise it is likely to break the upgrade process: the
`emacs` binary may well depend on library versions that are removed by the
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

In emacsen-common, until the bug is fixed,
`/usr/local/emacs/<version>/site-lisp` must be moved to
`/usr/share/emacs-snapshot/site-lisp`. This is automatically handled by the
`restore-emacs` script.

# Backwards Compatibility

Compared to earlier versions of `restore-emacs`, the way Emacs is integrated
into the Debian Emacs management scripts has changed. The script has been
tested for backwards compatibility. However, if you have previously used the
`restore-emacs` it might be worth checking the following three directories:

* `/etc/emacs-snapshot`: Previously, this was a directory containing
  `site-start.d` as a symbolic link to `/etc/emacs/site-start.d`. Now,
  `restore-emacs` just creates a symbolic link from `/etc/emacs-snapshot`
  to `/etc/emacs`.
* `/usr/share/emacs-snapshot`: Previously, this was a symbolic link to
  `/usr/local/share/emacs/<version>`. Now, it is a local directory containing a
  `site-start` directory and a symbolic link to
  `/usr/local/share/emacs/<version>`.
* `/usr/local/share/emacs/site-lisp`: Is now a symbolic link to
  `/usr/share/emacs-snapshot/site-start`.

Normally, if you have not modified any of those directories manually and if you
have not installed a different `emacs-snapshot` package (e.g. from the
https://emacs.secretsauce.net/ project), it should be safe to delete them. They
will be recreated with the new structure the next time you run `restore-emacs`.
So, after careful checking, consider running the following:

``` sh
sudo rm -r /etc/emacs-snapshot /usr/share/emacs-snapshot \
    /usr/local/share/emacs/site-lisp
```

just before using the updated `restore-emacs` script.
