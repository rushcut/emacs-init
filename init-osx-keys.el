(when *is-a-mac*
  (setq mac-command-modifier 'none)
  (setq mac-option-modifier 'meta)
  (setq default-input-method "MacOSX")
  ;; Make mouse wheel / trackpad scrolling less jerky
  (setq mouse-wheel-scroll-amount '(0.0001))
  (when *is-cocoa-emacs*
    ;; Woohoo!!
    (global-set-key (kbd "M-`") 'ns-next-frame)
    ;;(global-set-key (kbd "M-h") 'ns-do-hide-emacs)
    (eval-after-load "nxml-mode"
      '(define-key nxml-mode-map (kbd "M-h") nil))
    (global-set-key (kbd "M-ˍ") 'ns-do-hide-others) ;; what describe-key reports
    (global-set-key (kbd "M-c") 'ns-copy-including-secondary)
    (global-set-key (kbd "M-v") 'ns-paste-secondary))
  ;; Use Apple-w to close current buffer on OS-X (is normally bound to kill-ring-save)
  (eval-after-load "viper"
    '(global-set-key [(meta w)] 'kill-this-buffer)))


(provide 'init-osx-keys)
