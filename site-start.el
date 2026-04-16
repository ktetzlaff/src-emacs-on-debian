;;; site-start.el --- add Debian specific steps -*- lexical-binding: t; -*-

;;; Commentary:

;; Make sure that Debian elisp packages get initialized (except when starting
;; Emacs with -q/--no-init-file).

;;; Code:

;; Load debian-startup.el and run startup
(defconst debian-emacs-flavor 'emacs-snapshot
    "A symbol representing the particular debian flavor of Emacs running.
Something like \='emacs20, \='xemacs20, \='emacs-snapshot, etc.")

;; When emacs was started with -q/--no-init-file, `init-user-file' gets set to
;; nil. Use this to skip loading `debian-startup' (as in the original Debian
;; emacs packages).
(when init-file-user
    (if (load "debian-startup" t t nil)
        ;; Now instrument all of the packages
        (debian-startup debian-emacs-flavor))

    ;; Adding '/usr/share/emacs/site-lisp' should not be necessary, since
    ;; /usr/share/<emacs-snapshot>/site-lisp is (indirectly) already in
    ;; `load-path'. However, some packages refuse to install when
    ;; `debian-emacs-flavor' is 'emacs-snapshot' (why?), so it might be better
    ;; to keep it.
    ;;
    ;; Maybe there are to this downsides I'm not aware of, but that would be a
    ;; good reason to use a flavor different from 'emacs-snapshot'.
    (add-to-list 'load-path "/usr/share/emacs/site-lisp"))

;;; site-start.el ends here
