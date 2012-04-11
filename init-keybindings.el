;; Helper library to find unbound key combinations.
(require 'unbound)
(require 'repeat)

(defun fg/eshell-with-prefix ()
  (interactive)
  (setq current-prefix-arg '(4))
  (call-interactively 'eshell))

;; From http://groups.google.com/group/gnu.emacs.help/browse_thread/thread/44728fda08f1ec8f?hl=en&tvc=2
(defun make-repeatable-command (cmd)
  "Returns a new command that is a repeatable version of CMD.
The new command is named CMD-repeat.  CMD should be a quoted
command.

This allows you to bind the command to a compound keystroke and
repeat it with just the final key.  For example:

  (global-set-key (kbd \"C-c a\") (make-repeatable-command 'foo))

will create a new command called foo-repeat.  Typing C-c a will
just invoke foo.  Typing C-c a a a will invoke foo three times,
and so on."
  (fset (intern (concat (symbol-name cmd) "-repeat"))
        `(lambda ,(help-function-arglist cmd) ;; arg list
           ,(format "A repeatable version of `%s'." (symbol-name cmd)) ;; doc string
           ,(interactive-form cmd) ;; interactive form
           ;; see also repeat-message-function
           (setq last-repeatable-command ',cmd)
           (repeat nil)))
  (intern (concat (symbol-name cmd) "-repeat")))

(global-unset-key "\C-l")
(defvar ctl-l-map (make-keymap)
  "Keymap for local bindings and functions, prefixed by (^L)")
(define-key global-map "\C-l" 'Control-L-prefix)
(fset 'Control-L-prefix ctl-l-map)

(define-key ctl-l-map "A"		'ack)
(define-key ctl-l-map "aa"		'fg/anything-jump)
(define-key ctl-l-map "ab"		'anything-browse-code)
(define-key ctl-l-map "ac"		'fg/anything-contact)
(define-key ctl-l-map "ad"		'anything-c-apropos)
(define-key ctl-l-map "af"		'anything-find-files)
(define-key ctl-l-map "ag"		'fg/anything-rgrep)
(define-key ctl-l-map "ai"		'fg/anything-help)
(define-key ctl-l-map "al"		'anything-locate)
(define-key ctl-l-map "am"		'fg/anything-man-pages)
(define-key ctl-l-map "ar"		'anything-regexp)
(define-key ctl-l-map "at"		'fg/anything-tag)
(define-key ctl-l-map "au"		'anything-ucs)
(define-key ctl-l-map "ay"		'anything-show-kill-ring)
(define-key ctl-l-map "ax"		'anything-M-x)
(define-key ctl-l-map "br"		'rename-buffer)
(define-key ctl-l-map "bb"		'anything-buffers+)
(define-key ctl-l-map "caa"		'align)
(define-key ctl-l-map "car"		'align-regexp)
(define-key ctl-l-map "csb"		'hs-show-block)
(define-key ctl-l-map "csa"		'hs-show-all)
(define-key ctl-l-map "chb"		'hs-hide-block)
(define-key ctl-l-map "cha"		'hs-hide-all)
(define-key ctl-l-map "cr"		'recompile)
(define-key ctl-l-map "cc"		'compile)
(define-key ctl-l-map "cl"		'pylookup-lookup)
(define-key ctl-l-map "d"		'duplicate-line)
(define-key ctl-l-map "eb"		'ediff-buffers)
(define-key ctl-l-map "el"		'ediff-regions-linewise)
(define-key ctl-l-map "ew"		'ediff-regions-wordwise)
(define-key ctl-l-map "ef"		'ediff-files)
(define-key ctl-l-map "fn"		'find-name-dired)
(define-key ctl-l-map "G"		'rgrep)
(define-key ctl-l-map "gfn"		'flymake-goto-next-error)
(define-key ctl-l-map "gfp"		'flymake-goto-prev-error)
(define-key ctl-l-map "if"              'fg/connect-to-freenode)
(define-key ctl-l-map "ii"              'fg/connect-to-iptego)
(define-key ctl-l-map "il"              'fg/connect-to-bitlbee)
(define-key ctl-l-map "k"		'kill-whole-line)
(define-key ctl-l-map "l"		'goto-line)
(define-key ctl-l-map "n"		'notmuch)
(define-key ctl-l-map "ma"		'auto-complete-mode)
(define-key ctl-l-map "mc"		'company-mode)
(define-key ctl-l-map "mf"		'flymake-mode)
(define-key ctl-l-map "ml"		'lighthouse-mode)
(define-key ctl-l-map "mr"		'auto-revert-mode)
(define-key ctl-l-map "mw"		'whitespace-mode)
(define-key ctl-l-map "of"		'org-footnote-action)
(define-key ctl-l-map "q"		'query-replace)
(define-key ctl-l-map "Q"		'query-replace-regexp)
(define-key ctl-l-map "r"		'revert-buffer)
(define-key ctl-l-map "ss"		'eshell)
(define-key ctl-l-map "sn"		'fg/eshell-with-prefix)
(define-key ctl-l-map "tn"		'multi-term-next)
(define-key ctl-l-map "tp"		'multi-term-prev)
(define-key ctl-l-map "tt"		'multi-term)
(define-key ctl-l-map "ui"		'ucs-insert)
(define-key ctl-l-map "U"		'browse-url-default-macosx-browser)
(define-key ctl-l-map "v="		'vc-diff)
(define-key ctl-l-map "vd"		'vc-dir)
(define-key ctl-l-map "vD"		'vc-delete-file)
(define-key ctl-l-map "vF"		'vc-pull)
(define-key ctl-l-map "vg"		'vc-annotate)
(define-key ctl-l-map "vl"		'vc-print-log)
(define-key ctl-l-map "vu"		'vc-revert)
(define-key ctl-l-map "vv"		'vc-next-action)
(define-key ctl-l-map "vh"		'monky-status)
(define-key ctl-l-map "vm"		'magit-status)
(define-key ctl-l-map "wb"		'winring-submit-bug-report)
(define-key ctl-l-map "wc"		'winring-new-configuration)
(define-key ctl-l-map "wd"		'winring-duplicate-configuration)
(define-key ctl-l-map "wj"		'winring-jump-to-configuration)
(define-key ctl-l-map "wk"		'winring-delete-configuration)
(define-key ctl-l-map "wn"		'winring-next-configuration)
(define-key ctl-l-map "wp"		'winring-prev-configuration)
(define-key ctl-l-map "wr"		'winring-rename-configuration)
(define-key ctl-l-map "wt"		'fg/rotate-windows)
(define-key ctl-l-map "wv"		'winring-version)
(define-key ctl-l-map "xx"		'execute-extended-command)
(define-key ctl-l-map "xb"		'eval-buffer)
(define-key ctl-l-map "xe"		'eval-last-sexp)
(define-key ctl-l-map "xr"		'eval-region)
(define-key ctl-l-map "!"		'shell-command)
(define-key ctl-l-map "^"		'join-line)
(define-key ctl-l-map "%"		'goto-match-paren)
(define-key ctl-l-map "<"		'beginning-of-buffer)
(define-key ctl-l-map ">"		'end-of-buffer)

(global-set-key (kbd "M-U") 'upcase-word)
(global-unset-key (kbd "M-u"))
(let ((binding-char-pairs `((,(kbd "M-u a") . "ä")
                            (,(kbd "M-u o") . "ö")
                            (,(kbd "M-u u") . "ü")
                            (,(kbd "M-u A") . "Ä")
                            (,(kbd "M-u O") . "Ö")
                            (,(kbd "M-u U") . "Ü"))))
  (dolist (pair binding-char-pairs)
    (define-key global-map (car pair)
      (lexical-let ((char (cdr pair))) (lambda () (interactive) (insert char))))))

(global-set-key (kbd "M-F") 'forward-whitespace)
(global-set-key (kbd "M-B") 'fg/backward-whitespace)
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)
(global-set-key (kbd "C-x r t") 'inline-string-rectangle)

(global-set-key (kbd "C-`") 'other-window)

(global-set-key "\C-x2" (split-window-func-with-other-buffer 'split-window-vertically))
(global-set-key "\C-x3" (split-window-func-with-other-buffer 'split-window-horizontally))
(global-set-key "\C-x|" 'split-window-horizontally-instead)
(global-set-key "\C-x_" 'split-window-vertically-instead)

(global-set-key (kbd "M-`") 'flymake-goto-next-error)
(global-set-key (kbd "C-c w") (make-repeatable-command 'er/expand-region))
(global-set-key (kbd "M-y") 'anything-show-kill-ring)

(global-set-key (kbd "s-<up>") 'backward-up-sexp)
(global-set-key (kbd "s-<down>") 'down-list)
(global-set-key (kbd "s-f") 'forward-sexp)
(global-set-key (kbd "s-b") 'backward-sexp)
(global-set-key (kbd "s-n") 'forward-sentence)
(global-set-key (kbd "s-p") 'backward-sentence)
(global-set-key (kbd "s-u") 'backward-up-list)
(global-set-key (kbd "s-a") 'beginning-of-defun)
(global-set-key (kbd "s-e") 'end-of-defun)
(global-set-key (kbd "s-h") 'mark-defun)
(global-set-key (kbd "s-k") 'kill-sexp)
(global-set-key (kbd "s-t") 'transpose-sexps)

(global-set-key (kbd "C-h t") 'describe-face)

(when *is-a-mac*
  (setq mac-command-modifier 'super)
  (setq mac-option-modifier 'meta)
  (setq default-input-method "MacOSX")
  (setq mouse-wheel-scroll-amount '(0.0001)))

(when *is-cocoa-emacs*
  (global-set-key (kbd "S-`") 'ns-next-frame)
  (global-set-key (kbd "S-h") 'ns-do-hide-others))


(add-hook 'outline-minor-mode-hook
          (lambda () (local-set-key (kbd "M-o")
                               outline-mode-prefix-map)))

(global-set-key (kbd "C-M-=") 'increase-default-font-height)
(global-set-key (kbd "C-M--") 'decrease-default-font-height)

(define-key dired-mode-map "o" 'fg/dired-open-mac)

(global-set-key (kbd "M-'") 'fg/zap-to-char)
(global-set-key (kbd "C-'") 'fg/jump-to-next-char)

(global-set-key [remap kill-word] 'fg/kill-word)
(global-set-key [remap backward-kill-word] 'fg/backward-kill-word)

(define-key js2-mode-map (kbd "C-c s") 'fg/install-reload-browser-on-save-hook)

(define-key message-mode-map (kbd "C-c C-b") 'fg/goto-message-body)
(define-key notmuch-search-mode-map (kbd "Q") 'fg/quit-untag-inbox-unread)
(define-key notmuch-search-mode-map (kbd "i") 'fg/notmuch-mark-read)
(define-key notmuch-search-mode-map (kbd "I") 'fg/notmuch-mark-read-and-drop-inbox-tag)
(define-key notmuch-hello-mode-map "g" 'notmuch-hello-update)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cb" 'org-iswitchb)
(define-key global-map "\C-c\C-xf" 'org-footnote-action)

(eval-after-load 'paredit
  '(progn
     ;; These are handy everywhere, not just in lisp modes
     (global-set-key (kbd "M-(") 'paredit-wrap-round)
     (global-set-key (kbd "M-[") 'paredit-wrap-square)
     (global-set-key (kbd "M-{") 'paredit-wrap-curly)

     (global-set-key (kbd "M-)") 'paredit-close-round-and-newline)
     (global-set-key (kbd "M-]") 'paredit-close-square-and-newline)
     (global-set-key (kbd "M-}") 'paredit-close-curly-and-newline)

     (dolist (binding (list (kbd "C-<left>") (kbd "C-<right>")
                            (kbd "C-M-<left>") (kbd "C-M-<right>")))
       (define-key paredit-mode-map binding nil))

     ;; Disable kill-sentence, which is easily confused with the kill-sexp
     ;; binding, but doesn't preserve sexp structure
     (define-key paredit-mode-map [remap kill-sentence] nil)
     (define-key paredit-mode-map [remap backward-kill-sentence] nil)))


(provide 'init-keybindings)
