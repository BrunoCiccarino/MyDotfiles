;; Configuração de pacotes
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Instala use-package se não estiver instalado
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Divisão da tela
(split-window-vertically (round (* 0.7 (window-height))))
(other-window 1)

(defun check-and-install-doom-themes ()
  "Check if `doom-themes` is installed. If not, prompt the user to install it."
  (interactive)
  (condition-case nil
      (require 'doom-themes)
    (error
     (when (y-or-n-p "Doom Themes is not installed. Do you want to install it? ")
       (package-refresh-contents)
       (package-install 'doom-themes)))))

(unless (package-installed-p 'hydra)
  (package-refresh-contents)
  (package-install 'hydra))

(load-theme 'doom-shades-of-purple t)

(require 'hydra)

(defun safe-load-theme (theme)
  "Load THEME only if it's available."
  (if (member theme (custom-available-themes))
      (load-theme theme t)
    (message "Theme %s not found" theme)))

(defhydra load-themes (:color blue)
  "load themes"
  ("1" (load-theme 'doom-shades-of-purple t) "doom shades of purple")
  ("2" (load-theme 'doom-snazzy t) "doom-snazzy")
  ("3" (load-theme 'doom-dracula t) "doom-dracula")
  ("4" (load-theme 'doom-spacegrey t) "doom-spacegrey")
  ("q" nil "quit"))

(global-set-key (kbd "C-c b") 'load-themes/body)

(set-fringe-mode 15)
(electric-indent-mode 1)
(column-number-mode t)
(global-display-line-numbers-mode t)
(global-hl-line-mode t)
(global-visual-line-mode t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

(setq inhibit-startup-message t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Configurações adicionais
(setq auto-mode-alist (append '(("\\.scm$" . scheme-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.lisp$" . lisp-mode)) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.el\\'" . emacs-lisp-mode))

;; Adiciona o diretório de fontes ao caminho de fontes do Emacs
(let ((font-file (expand-file-name "JetBrainsMono-Bold.ttf" user-emacs-directory)))
  (when (file-exists-p font-file)
    (add-to-list 'default-frame-alist `(font . ,(format "%s-%d" "JetBrains Mono" 12)))
    (set-face-attribute 'default nil :font (format "%s-%d" "JetBrains Mono" 12))
    (set-fontset-font t 'unicode (font-spec :name "JetBrains Mono") nil 'prepend)))


(use-package all-the-icons
  :ensure t)


(use-package treemacs
  :bind ("<f8>" . treemacs)
  :custom
  (treemacs-is-never-other-window t)
  :hook
  (treemacs-mode . treemacs-project-follow-mode))

;; Configurar vertico e vertico-posframe
(use-package vertico
  :init
  (vertico-mode))

(use-package vertico-posframe
  :after vertico
  :custom
  (vertico-posframe-parameters
   '((left-fringe . 8)
     (right-fringe . 8)))
  :config
  (vertico-posframe-mode 1))

;; Configurar lsp-mode e lsp-pyright
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((python-mode . lsp))
  :commands lsp)

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package lsp-pyright
  :after lsp-mode
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))

;; Configurar teclas globais
(global-set-key (kbd "C-c C-e") 'eval-last-sexp)
(global-set-key (kbd "C-c C-r") 'eval-region)
