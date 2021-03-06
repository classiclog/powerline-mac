;;; powerline-evil-mac-themes.el --- Powerline Evil Themes for Mac

;; Copyright (C) 2016 classiclog

;; Author: classiclog <classiclogair@gmail.com>
;; URL: http://github.com/classiclog/
;; Version: 1.0
;; Package-Requires: ((powerline-evil-mac "1.0"))
;; Keywords: mode-line, powerline, evil, EmacsMac.app, mac-input-source

;;; Commentary:
;;
;; Powerline Evil Themes for EmacsMac.app
;; Included themes:
;; EmacsMac.app is available via Homebrew and MacPorts (as emacs-mac-app).
;;

;;; Code:

;;;###autoload
(defun powerline-evil-center-color-mac-input-source-theme ()
  "Powerline's center-evil them with the evil state in color."
  (interactive)
  (setq-default mode-line-format '("%e" (:eval (let*
    (
      (active (powerline-selected-window-active))
      (mode-line (if active 'mode-line 'mode-line-inactive))
      (face1 (if active 'powerline-active1 'powerline-inactive1))
      (face2 (if active 'powerline-active2 'powerline-inactive2))
      (separator-left (intern (format "powerline-%s-%s"
        (powerline-current-separator)
        (car powerline-default-separator-dir))))
      (separator-right (intern (format "powerline-%s-%s"
        (powerline-current-separator)
        (cdr powerline-default-separator-dir))))
      (lhs (list
        (powerline-raw (mac-input-source-mode) mode-line)
        (powerline-raw mode-line-front-space mode-line)
        (powerline-raw mode-line-mule-info mode-line)
        (powerline-raw mode-line-client mode-line)
        (powerline-raw mode-line-modified mode-line)
        (powerline-raw mode-line-remote mode-line)
;        (powerline-raw "%*" nil 'l)
;        (powerline-buffer-size nil 'l)
        (powerline-buffer-id nil 'l)
        (powerline-raw " ")
        (funcall separator-left mode-line face1)
        (powerline-narrow face1 'l)
        (powerline-vc face1)))
      (rhs (list
        (powerline-raw global-mode-string face1 'r)
        (powerline-raw "%4l" face1 'r)
        (powerline-raw ":" face1)
        (powerline-raw "%3c" face1 'r)
        (funcall separator-right face1 mode-line)
        (powerline-raw " ")
        (powerline-raw "%6p" nil 'r)
        (powerline-hud face2 face1)))
      (center (append
        (list
          (powerline-raw " " face1)
          (funcall separator-left face1 face2)
          (when (boundp 'erc-modified-channels-object)
            (powerline-raw erc-modified-channels-object face2 'l))
          (powerline-major-mode face2 'l)
          (powerline-process face2)
          (powerline-raw " " face2))
        (let ((evil-face (powerline-evil-face)))
          (if (split-string (format-mode-line minor-mode-alist))
            (append (if evil-mode
              (list
                (funcall separator-right face2 evil-face)
                (powerline-raw (powerline-evil-tag) evil-face 'l)
                (powerline-raw " " evil-face)
                (funcall separator-left evil-face face2)))
                (list (powerline-minor-modes face2 'l)
                (powerline-raw " " face2)
                (funcall separator-right face2 face1)))
            (list
              (powerline-raw (powerline-evil-tag) evil-face)
              (funcall separator-right evil-face face1))))))
    )
    (concat (powerline-render lhs)
      (powerline-fill-center face1 (/ (powerline-width center) 2.0))
      (powerline-render center)
      (powerline-fill face1 (powerline-width rhs))
      (powerline-render rhs))
  ))))
)

;;;###autoload
(defun powerline-evil-vim-color-mac-input-source-theme ()
  "Powerline's Vim-like mode-line with evil state at the beginning in color."
  (interactive)
  (setq-default mode-line-format '("%e" (:eval (let*
    (
      (active (powerline-selected-window-active))
      (mode-line (if active 'mode-line 'mode-line-inactive))
      (face1 (if active 'powerline-active1 'powerline-inactive1))
      (face2 (if active 'powerline-active2 'powerline-inactive2))
      (separator-left (intern
        (format "powerline-%s-%s"
          (powerline-current-separator)
          (car powerline-default-separator-dir))))
      (separator-right (intern
        (format "powerline-%s-%s"
          (powerline-current-separator)
          (cdr powerline-default-separator-dir))))
      (lhs (list
        (let ((evil-face (powerline-evil-face)))
          (if evil-mode
              (powerline-raw (powerline-evil-tag) evil-face)
            (powerline-raw "" evil-face)))
        (powerline-raw (mac-input-source-mode) mode-line)
        (powerline-buffer-id `(mode-line-buffer-id ,mode-line) 'l)
        (powerline-raw "[" mode-line 'l)
        (powerline-major-mode mode-line)
        (powerline-process mode-line)
        (powerline-raw "]" mode-line)
        (when (buffer-modified-p)
          (powerline-raw "[+]" mode-line))
        (when buffer-read-only
          (powerline-raw "[RO]" mode-line))
        (powerline-raw "[%z]" mode-line)
;        (powerline-raw (concat "[" (mode-line-eol-desc) "]") mode-line)
        (when (and (boundp 'which-func-mode) which-func-mode)
          (powerline-raw which-func-format nil 'l))
        (when (boundp 'erc-modified-channels-object)
          (powerline-raw erc-modified-channels-object face1 'l))
        (powerline-raw "[" mode-line 'l)
        (powerline-minor-modes mode-line)
        (powerline-raw "%n" mode-line)
        (powerline-raw "]" mode-line)
        (when (and vc-mode buffer-file-name)
          (let ((backend (vc-backend buffer-file-name)))
            (when backend
              (concat (powerline-raw "[" mode-line 'l)
                (powerline-raw
                    (format "%s / %s" backend
                      (vc-working-revision buffer-file-name backend)))
                (powerline-raw "]" mode-line)))))))
      (rhs (list
        (powerline-raw '(10 "%i"))
        (powerline-raw global-mode-string mode-line 'r)
        (powerline-raw "%l," mode-line 'l)
        (powerline-raw (format-mode-line '(10 "%c")))
        (powerline-raw
          (replace-regexp-in-string "%" "%%" (format-mode-line '(-3 "%p")))
          mode-line 'r)))
    )
    (concat (powerline-render lhs)
      (powerline-fill mode-line (powerline-width rhs))
      (powerline-render rhs))
  ))))
)

;;;###autoload
(defun mac-input-source-theme ()
  (interactive)
  (setq-default mode-line-format
    (list ""
      (mac-input-source-mode)
      'mode-line-mule-info
      'mode-line-modified
      "%b--"
      '(line-number-mode "L%l--")
      '(-3 . "%p")
      "-%-"
    )
  )
)


(provide 'powerline-evil-mac-themes)

;; Local Variables:
;; coding: utf-8
;;; powerline-evil-mac-themes.el ends here
