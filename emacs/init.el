;;; package --- omnimike's init file
;;; Commentary:
;;; Code:
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(defalias 'yes-or-no-p 'y-or-n-p)

(use-package evil
  :config
  (evil-mode 1)
  (fset 'evil-visual-update-x-selection 'ignore)
  )

;; mac-specific
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'hyper)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )

;; custom-functions
(defun edit-init ()
  "Open init.el."
  (interactive)
  (find-file user-init-file))

(defun switch-to-minibuffer ()
  "Switch to minibuffer window."
  (interactive)
  (if (active-minibuffer-window)
      (select-window (active-minibuffer-window))
    (error "Minibuffer is not active")))

(defun save-all ()
  "Save all buffers."
  (interactive)
  (save-some-buffers t))

(defun my-recenter ()
  "Recenter my way."
  (interactive)
  (recenter (/ (window-body-height) 4))
  )

;; keybindings

(global-set-key (kbd "C-c o") 'switch-to-minibuffer)

(defvar my-space-map (make-sparse-keymap)
  "Keymap for \"space leader\" shortcuts.")

(defvar my-return-map (make-sparse-keymap)
  "Keymap for \"return leader\" shortcuts.")

(defun my-hyper-key (key cmd)
  "Add a key binding to both the hyper key and the space leader.

KEY the key to bind as a string
CMD the procedure to execute"
  (global-set-key (kbd (concat "H-" key)) cmd)
  (define-key my-space-map (kbd key) cmd)
  )

(defun my-remap-key (new-key old-key)
  "Remap a prefix key.

NEW-KEY the key to bind it to
OLD-KEY the key to replace"
  (define-key key-translation-map (kbd (concat "H-" new-key)) old-key)
  (define-key key-translation-map (kbd (concat "<SPC> " new-key)) old-key)
  )

(my-hyper-key "s" 'save-buffer)
(my-hyper-key "v" 'clipboard-yank)
(my-hyper-key "c" 'clipboard-kill-ring-save)
(my-hyper-key "x" 'clipboard-kill-region)
(my-hyper-key "z" 'undo-tree-undo)
(my-hyper-key "q" 'save-buffers-kill-emacs)
(my-hyper-key "w" 'kill-this-buffer)
(my-hyper-key "a" 'mark-whole-buffer)
(my-hyper-key "," 'edit-init)
(my-hyper-key "r" 'ranger)
(my-hyper-key "p" 'helm-projectile-switch-project)
(my-hyper-key "o" 'helm-projectile-find-file)
(my-hyper-key "i" 'helm-buffers-list)
(my-hyper-key ";" 'helm-M-x)
(my-hyper-key "'" 'shell-command)
(my-hyper-key "l" 'avy-goto-line)
(my-hyper-key "f" 'helm-projectile-ag)
(my-hyper-key "k" 'evil-scroll-up)
(my-hyper-key "j" 'evil-scroll-down)
(my-hyper-key "g" 'magit-status)
(my-hyper-key "h" 'my-recenter)

(define-key my-space-map (kbd "TAB") 'other-window)

(my-remap-key "m" (kbd "C-x"))
(my-remap-key "n" (kbd "C-c"))
(my-remap-key "e" (kbd "C-w"))
(my-remap-key "y" (kbd "C-h"))
(define-key evil-normal-state-map (kbd "<SPC>") my-space-map)

(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; appearance
(tool-bar-mode -1)
;(menu-bar-mode -1)
(toggle-scroll-bar -1)
(global-linum-mode t)
(set-face-attribute 'default nil :height 100)

;; variables
(setq vc-follow-symlinks t)
(global-auto-revert-mode t)
(setq-default indent-tabs-mode nil)
;(setq-default show-trailing-whitespace t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (atom-one-dark)))
 '(custom-safe-themes
   (quote
    ("08b8807d23c290c840bbb14614a83878529359eaba1805618b3be7d61b0b0a32" default)))
 '(package-selected-packages
   (quote
    (evil-magit powerline avy php-mode js2-mode lua-mode json-mode exec-path-from-shell use-package flycheck helm-ag-r helm-ag atom-one-dark-theme magit helm-projectile helm which-key ranger projectile evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; hooks
(add-hook 'focus-out-hook 'save-all)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; package-config
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.emacs-saves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

(which-key-mode)

(use-package ranger
  :config
  (setq ranger-override-dired 'ranger))

(use-package dashboard
  :config
  (setq
   dashboard-items
   '((recents . 20)
     (bookmarks . 5)
     (projects . 15)
     ))
  (setq dashboard-startup-banner nil)
  (dashboard-setup-startup-hook))

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode t)
  (setq-default
   flycheck-disabled-checkers
   '(javascript-jscs
     javascript-jshint
     html-tidy
     )))


(use-package helm-projectile
  :config
  (setq-default projectile-enable-caching t)
  (setq-default helm-mode-fuzzy-match t)
  (setq-default helm-completion-in-region-fuzzy-match t)
  (helm-projectile-on))

(use-package evil-magit)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;(setq-default message-log-max nil)
;(when (get-buffer "*Messages*")
;  (kill-buffer "*Messages*")
;  )
;;; init.el ends here
