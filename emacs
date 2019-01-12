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
(use-package helm-projectile :ensure t)
(use-package which-key :ensure t)
(use-package tabbar :ensure t)
(use-package move-text :ensure t)

;; Syntax
(use-package slim-mode :ensure t)


(require 'evil)
(require 'evil-leader)
(require 'helm)
(require 'which-key)

;; Syntax
(require 'slim-mode)

(global-evil-leader-mode)
(helm-mode 1)
(evil-commentary-mode)
(which-key-mode)
(evil-mode t)

(setq which-key-idle-delay 0.01)

(evil-leader/set-leader "<SPC>")

(evil-leader/set-key
  "." 'evil-window-vsplit
  "-" 'evil-window-split
  "t"  (lambda() (evil-window-vsplit) (interactive) (term "zsh"))
  "T"  (lambda() (evil-window-split) (interactive) (term "zsh"))
  "vr"  (lambda() (interactive) (find-file "~/.emacs"))
  "," 'neotree-toggle)

;; Keybindings
(setq mac-right-option-modifier 'none)

(global-set-key (kbd "s-j") 'evil-window-down)
(global-set-key (kbd "s-k") 'evil-window-up)
(global-set-key (kbd "s-h") 'evil-window-left)
(global-set-key (kbd "s-l") 'evil-window-right)
(global-set-key (kbd "s-w") 'kill-buffer)
(global-set-key "Q" 'delete-window)

(global-set-key (kbd "s-r") 'eval-buffer)
(global-set-key (kbd "M-s-<right>") 'next-buffer)
(global-set-key (kbd "M-s-<left>") 'previous-buffer)

;; Helm config
(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(define-key global-map [remap execute-extended-command] 'helm-M-x)
;; (setq helm-mode-fuzzy-match t)
(setq helm-M-x-fuzzy-match t)
(setq helm-completion-in-region-fuzzy-match t)

(define-key evil-normal-state-map (kbd "C-p") 'helm-projectile)

(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)

;; For faster scroll. 
;; TODO: Try to send the 7/-7 as an argument in key definition
(evil-define-motion my/fast-next-visual-line (count)
"Move the cursor COUNT screen lines down, or 5."
:type exclusive
  (let ((line-move-visual t))
  (evil-line-move (or count 7))))

(evil-define-motion my/fast-previous-visual-line (count)
"Move the cursor COUNT screen lines down, or 5."
:type exclusive
  (let ((line-move-visual t))
  (evil-line-move (or count -7))))

(define-key evil-normal-state-map  "J" 'my/fast-next-visual-line)
(define-key evil-normal-state-map  "K" 'my/fast-previous-visual-line)
(define-key evil-visual-state-map  "J" 'my/fast-next-visual-line)
(define-key evil-visual-state-map  "K" 'my/fast-previous-visual-line)

;; Doesn't work well with regions
(define-key evil-motion-state-map (kbd "M-J") 'move-text-down)
(define-key evil-motion-state-map (kbd "M-K") 'move-text-up)

;; https://emacsredux.com/blog/2013/03/26/smarter-open-line/
(defun smart-open-line ()
  "Insert an empty line after the current line.
Position the cursor at its beginning, according to the current mode."
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))

(defun smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(define-key evil-normal-state-map (kbd "M-j") 'smart-open-line)
(define-key evil-normal-state-map (kbd "M-k") 'smart-open-line-above)

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
(setq neo-theme 'arrow)
(setq neo-smart-open t)
(setq projectile-switch-project-action 'neotree-projectile-action)

;; Enter terminal in emacs mode
(evil-set-initial-state 'term-mode 'emacs)

(defadvice term-handle-exit
  (after term-kill-buffer-on-exit activate)
(kill-buffer) (delete-window))

;; Open emacs file in lisp mode
(add-to-list 'auto-mode-alist '("emacs" . lisp-mode))

;; Tab bar
(require 'tabbar)
(customize-set-variable 'tabbar-separator '(0.5))
(customize-set-variable 'tabbar-use-images nil)
(tabbar-mode 1)
(set-face-attribute 'tabbar-default nil
        :background "gray20" :foreground 
        "gray60" :distant-foreground "gray50"
        :family "Helvetica Neue" :box nil)
(set-face-attribute 'tabbar-unselected nil
        :background "gray80" :foreground "black" :box nil)
(set-face-attribute 'tabbar-modified nil
        :foreground "red4" :box nil
        :inherit 'tabbar-unselected)
(set-face-attribute 'tabbar-selected nil
        :background "#4090c0" :foreground "white" :box nil)
(set-face-attribute 'tabbar-selected-modified nil
        :inherit 'tabbar-selected :foreground "GoldenRod2" :box nil)
(set-face-attribute 'tabbar-button nil
        :box nil)
;; Group tabs by project/directory, and hide some buffers
;; <https://www.emacswiki.org/emacs/TabBarMode#toc15>
(defun my/tabbar-buffer-groups ()
  (cond ((member (buffer-name)
                 '("*Completions*"
                   "*scratch*"
                   "*Messages*"
                   "*Ediff Registry*"))
         (list "#hide"))
        (t (list (or (cdr (project-current))
                     (expand-file-name default-directory))))))
(setq tabbar-buffer-groups-function #'my/tabbar-buffer-groups)

;; Keep tabs sorted <https://www.emacswiki.org/emacs/TabBarMode#toc7>
(defun tabbar-add-tab (tabset object &optional _append_ignored)
  "Add to TABSET a tab with value OBJECT if there isn't one there yet.
 If the tab is added, it is added at the beginning of the tab list,
 unless the optional argument APPEND is non-nil, in which case it is
 added at the end."
  (let ((tabs (tabbar-tabs tabset)))
    (if (tabbar-get-tab object tabset)
        tabs
      (let ((tab (tabbar-make-tab object tabset)))
        (tabbar-set-template tabset nil)
        (set tabset (sort (cons tab tabs)
                 (lambda (a b) (string< (buffer-name (car a))
                               (buffer-name (car b))))))))))

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
    (move-text slim-mode tabbar helm-ag helm-projectile which-key evil-commentary helm projectile neotree evil-leader evil-visual-mark-mode)))
 '(tabbar-separator (quote (0.5)))
 '(tabbar-use-images nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
