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
  "-" 'evil-window-split)

(global-set-key "\M-j" 'evil-window-down)
(global-set-key "\M-k" 'evil-window-up)
(global-set-key "\M-h" 'evil-window-left)
(global-set-key "\M-l" 'evil-window-right)

(global-set-key "Q" 'delete-window)
(define-key evil-motion-state-map (kbd "J") (lambda () (interactive) (evil-next-line 7)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (evil-leader evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
