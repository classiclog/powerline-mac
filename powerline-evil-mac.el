;;; powerline-evil-mac.el --- Powerline Evil for Mac

;; Copyright (C) 2016 classiclog

;; Author: classiclog <classiclogair@gmail.com>
;; URL: http://github.com/classiclog/
;; Version: 1.0
;; Package-Requires: ((powerline-evil "1.0"))
;; Keywords: mode-line, powerline, evil, EmacsMac.app, mac-input-source

;;; Commentary:
;;
;; Powerline Evil Utilities for EmacsMac.app
;; EmacsMac.app is available via Homebrew and MacPorts (as emacs-mac-app).
;;

;;; Code:

(require 'powerline-evil)
(require 'powerline-evil-mac-themes)

(powerline-evil-center-color-mac-input-source-theme)
;(powerline-evil-vim-color-mac-input-source-theme)
;(powerline-evil-vim-mac-input-source-theme)
;(mac-input-source-theme) 

(set-face-attribute 'mode-line
  nil :foreground "#fff" :background "#FF0066")
(set-face-attribute 'powerline-active1
  nil :foreground "#fff" :background "#FF6699")
(set-face-attribute 'powerline-active2
  nil :foreground "#000" :background "#ffaeb9")
(set-face-attribute 'powerline-evil-normal-face
  nil :foreground "#000" :background "turquoise")
(set-face-attribute 'powerline-evil-insert-face
  nil :foreground "#fff" :background "blue")
;; To view a list of color names, type M-x list-colors-display. 

;;;
;;; EmacsMac.app API mac-input-source
;;;
;; http://peccu.hatenablog.com/entry/2015/03/13/090000

(defun mac-input-source-cursor-color ()
  (set-cursor-color
    (if (string-match "\\.US$" (mac-input-source)) "firebrick" "blue"))
)

(defun mac-input-source-mode ()
  (mac-input-source-cursor-color)
  (if (string-match "\\.US$" (mac-input-source)) "[Aa]" "[あ]")
)

(defun mac-selected-keyboard-input-source-change-hook-func ()
  (force-mode-line-update)
)

(add-hook 'mac-selected-keyboard-input-source-change-hook
          'mac-selected-keyboard-input-source-change-hook-func)
(mac-input-source-cursor-color)


(provide 'powerline-evil-mac)

;; Local Variables:
;; coding: utf-8
;;; powerline-evil-mac.el ends here
