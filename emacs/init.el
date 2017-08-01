;;; package --- omnimike's init file
;;; Commentary:
;;; Code:
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(use-package evil
  :config
  (setq evil-want-C-u-scroll t)
  :init
  (evil-mode 1)
  (fset 'evil-visual-update-x-selection 'ignore))

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

;; keybindings

(global-set-key (kbd "C-c o") 'switch-to-minibuffer)

(defvar my-space-map (make-sparse-keymap)
  "Keymap for \"space leader\" shortcuts.")

(defun my-hyper-key (key cmd)
  "Add a key binding to both the hyper key and the space leader.

KEY the key to bind as a string
CMD the procedure to execute"
  (global-set-key (kbd (concat "H-" key)) cmd)
  (define-key my-space-map (kbd key) cmd))

(my-hyper-key "s" 'save-buffer)
(my-hyper-key "v" 'clipboard-yank)
(my-hyper-key "c" 'clipboard-kill-ring-save)
(my-hyper-key "x" 'clipboard-kill-region)
(my-hyper-key "q" 'save-buffers-kill-emacs)
(my-hyper-key "w" 'kill-this-buffer)
(my-hyper-key "," 'edit-init)
(my-hyper-key "u" 'universal-argument)

(define-key my-space-map (kbd "r") 'ranger)
(define-key my-space-map (kbd "t") 'helm-projectile-find-file)
(define-key my-space-map (kbd "p") 'helm-projectile-switch-project)
(define-key my-space-map (kbd "b") 'helm-buffers-list)
(define-key my-space-map (kbd "f") 'helm-projectile-ag)
(define-key my-space-map (kbd "<SPC>") 'helm-M-x)

(define-key evil-normal-state-map (kbd "<SPC>") my-space-map)

(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; appearance
(tool-bar-mode -1)
;(menu-bar-mode -1)
(toggle-scroll-bar -1)
(global-linum-mode t)

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
    (exec-path-from-shell use-package flycheck helm-ag-r helm-ag atom-one-dark-theme magit helm-projectile helm which-key ranger projectile evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.emacs-saves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

(which-key-mode)
(helm-projectile-on)

(use-package ranger
  :config
  (setq ranger-override-dired 'ranger))

(use-package dashboard
  :init
  (defvar dashboard-items '((projects . 10)
			  (bookmarks . 5)
			  (recents  . 5)
			  ))
  (dashboard-setup-startup-hook))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

;(setq-default message-log-max nil)
;(when (get-buffer "*Messages*")
;  (kill-buffer "*Messages*")
;  )
;;; init.el ends here

