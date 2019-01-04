(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package evil
  :ensure t)

(use-package evil-leader
  :ensure t)

(require 'evil)
(require 'evil-leader)

(global-evil-leader-mode)
(evil-mode t)

(evil-leader/set-leader "<SPC>")

(evil-leader/set-key
  "." 'evil-window-vsplit
  "-" 'evil-window-split
  "vr" (lambda() (interactive)(find-file "~/.emacs")))

(global-set-key "\M-j" 'evil-window-down)
(global-set-key "\M-k" 'evil-window-up)
(global-set-key "\M-h" 'evil-window-left)
(global-set-key "\M-l" 'evil-window-right)

(global-set-key "Q" 'delete-window)
;; (define-key evil-motion-state-map (kbd "J") (lambda () (interactive) (evil-next-line 7)))

;; Hide scrollbar and toolbar
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Always follow symlinks
(setq vc-follow-symlinks t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (blackboard)))
 '(custom-safe-themes
   (quote
    ("4c7a1f0559674bf6d5dd06ec52c8badc5ba6e091f954ea364a020ed702665aa1" default)))
 '(package-selected-packages (quote (evil-leader evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
