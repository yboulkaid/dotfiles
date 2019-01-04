(require 'package)

(setq backup-directory-alist `(("." . "~/.saves")))

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

(use-package evil :ensure t)
(use-package evil-leader :ensure t)
(use-package evil-commentary :ensure t)
(use-package neotree :ensure t)
(use-package projectile :ensure t)
(use-package helm :ensure t)

(require 'evil)
(require 'evil-leader)
(require 'helm)

(global-evil-leader-mode)
(evil-mode t)
(helm-mode 1)
(evil-commentary-mode)

(evil-leader/set-leader "<SPC>")

(evil-leader/set-key
  "." 'evil-window-vsplit
  "-" 'evil-window-split
  "vr" (lambda() (interactive)(find-file "~/.emacs"))
  "," 'neotree-toggle)

(global-set-key (kbd "s-j") 'evil-window-down)
(global-set-key (kbd "s-k") 'evil-window-up)
(global-set-key (kbd "s-h") 'evil-window-left)
(global-set-key (kbd "s-l") 'evil-window-right)
(global-set-key (kbd "s-w") 'delete-window)
(global-set-key "Q" 'delete-window)

(global-set-key (kbd "s-r") 'eval-buffer)

;; Helm config
(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(define-key global-map [remap execute-extended-command] 'helm-M-x)
(setq helm-mode-fuzzy-match t)
(setq helm-M-x-fuzzy-match t)
(setq helm-completion-in-region-fuzzy-match t)

(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; For faster scroll. Doesn't work very well
;; TODO: Make it better?
(defun my/fast-next-visual-line ()
  (interactive)
  (evil-next-visual-line 7))
(defun my/fast-previous-visual-line ()
  (interactive)
  (evil-previous-visual-line 7))
(define-key evil-normal-state-map  "J" 'my/fast-next-visual-line)
(define-key evil-normal-state-map  "K" 'my/fast-previous-visual-line)
(define-key evil-visual-state-map  "J" 'my/fast-next-visual-line)
(define-key evil-visual-state-map  "K" 'my/fast-previous-visual-line)

;; Hide scrollbar and toolbar
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Always follow symlinks
(setq vc-follow-symlinks t)

;; Override evi mode in neotree: https://www.emacswiki.org/emacs/NeoTree
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)

;; Open emacs file in lisp mode
(add-to-list 'auto-mode-alist '("emacs" . lisp-mode))

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
 '(package-selected-packages
   (quote
    (evil-commentary helm projectile neotree evil-leader evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
