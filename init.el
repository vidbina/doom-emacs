;;; init.el -*- lexical-binding: t; -*-
;;
;; Author:  Henrik Lissner <henrik@lissner.net>
;; URL:     https://github.com/hlissner/doom-emacs
;;
;;   =================     ===============     ===============   ========  ========
;;   \\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //
;;   ||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||
;;   || . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||
;;   ||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||
;;   || . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||
;;   ||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||
;;   || . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||
;;   ||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||
;;   ||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||
;;   ||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||
;;   ||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||
;;   ||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||
;;   ||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||
;;   ||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||
;;   ||.=='    _-'                                                     `' |  /==.||
;;   =='    _-'                                                            \/   `==
;;   \   _-'                                                                `-_   /
;;    `''                                                                      ``'
;;
;; These demons are not part of GNU Emacs.
;;
;;; License: MIT

;; Ensure Doom is always running out of this file's directory
(setq user-emacs-directory (file-name-directory load-file-name)
      load-prefer-newer noninteractive)


;;
;; Optimize startup
;;

(unless noninteractive
  (defvar doom--file-name-handler-alist
    file-name-handler-alist)
  (unless after-init-time
    ;; A big contributor to long startup times is the garbage collector, so we
    ;; up its memory threshold, temporarily and reset it later in
    ;; `doom|finalize'.
    (setq gc-cons-threshold 402653184
          gc-cons-percentage 1.0
          ;; consulted on every `require', `load' and various file reading
          ;; functions. You get a minor speed up by nooping this.
          file-name-handler-alist nil))

  (defun doom|finalize ()
    "Resets garbage collection settings to reasonable defaults (if you don't do
this, you'll get stuttering and random freezes) and resets
`file-name-handler-alist'."
    (setq file-name-handler-alist doom--file-name-handler-alist
          gc-cons-threshold 16777216
          gc-cons-percentage 0.2))

  (add-hook 'emacs-startup-hook #'doom|finalize)
  (add-hook 'doom-reload-hook   #'doom|finalize))


;;
;; Bootstrap Doom
;;

(require 'core (concat user-emacs-directory "core/core"))
