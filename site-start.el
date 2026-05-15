;;; site-start.el --- add Debian specific steps -*- lexical-binding: t; -*-

;;; Commentary:

;; Try to reproduce Debian patches to startup.el:
;; - add directories '/usr/share/emacs/site-lisp' and
;;   '/usr/share/<flavor>/site-lisp' to load path and run contained
;;   'subdirs.el' files,
;; - make sure that Debian elisp packages get initialized (except when starting
;;   Emacs with '--no-site-file').

;;; Code:

(defconst debian-emacs-flavor 'emacs-snapshot
  "A symbol representing the particular debian flavor of Emacs running.
Something like \='emacs20, \='xemacs20, \='emacs-snapshot, etc.")

(let ((flavored-site-lisp (format "/usr/share/%s/site-lisp"
                                  debian-emacs-flavor)))
  ;; add directories to load path and load optional `subdirs.el' files
  (mapc (lambda (dir)
          (add-to-list 'load-path dir)
          (let ((default-directory dir)
                (warning-inhibit-types '((files missing-lexbind-cookie))))
            (load (expand-file-name "subdirs.el") t t t)))
        (list
         ;; Adding '/usr/share/emacs/site-lisp' to `load-path' should not be
         ;; necessary, since /usr/share/<flavor>/site-lisp is also added
         ;; below. However, some packages refuse to install when
         ;; `debian-emacs-flavor' is 'emacs-snapshot' (why?), so it might be
         ;; better to keep it.
         ;;
         ;; There might be downsides to this I'm not aware of, so this maybe
         ;; a good reason to use a flavor different from 'emacs-snapshot'.
         "/usr/share/emacs/site-lisp"
         ;; add flavored site-lisp after the unflavored variant (keep this
         ;; at the last position in this list!)
         flavored-site-lisp))

  ;; When emacs is started with '--no-site-file', `site-run-file' gets set to
  ;; `nil'. Use this to skip loading `debian-startup' (as in original Debian
  ;; emacs packages).
  (when site-run-file
    (when (load (string-join (list flavored-site-lisp "debian-startup") "/")
                t t nil)
      ;; Now instrument all of the packages
      (debian-startup debian-emacs-flavor))))

;;; site-start.el ends here
