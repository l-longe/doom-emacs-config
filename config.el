;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; user info
(setq user-full-name "Lathan Longe"
      user-mail-address "lathanlonge@hotmail.com"
      calendar-location-name "London,UK")

;; basic stuff
(setq delete-by-moving-to-trash t)         ; move deletes to trash

;; autosave the current visited file after 5 secs of idle
(setq auto-save-visited-interval 5)
(auto-save-visited-mode 1)

;; line wrapping column guide
(setq-default fill-column 120)
(add-hook! '(text-mode-hook prog-mode-hook conf-mode-hook)
  #'display-fill-column-indicator-mode)

;; clipboard integration
(setq select-enable-clipboard t)

;; hide gui chrome (menu/tool/scroll bars) in gui frames
(when (display-graphic-p)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

;;theme and ui
(setq doom-theme 'doom-manegarm)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")
(doom/set-frame-opacity 90)

;; ----- dashboard: banner + my cheat-sheet -----

(defun my/dashboard-cheat-sheet ()
  "Display a cheatsheet on the Doom dashboard."
  (insert "\n")
  (insert (propertize "QUICK REFERENCE:\n" 'face 'font-lock-keyword-face))
  (insert "\n")
  (insert "  Files & Buffers          Projects               Org/Notes\n")
  (insert "  SPC f f - Find file      SPC p p - Projects     SPC n n - Capture\n")
  (insert "  SPC f r - Recent files   SPC p f - Find file    SPC o a - Agenda\n")
  (insert "  SPC b b - Switch buffer  SPC p / - Search       SPC n j - Journal\n")
  (insert "  SPC f s - Save file      SPC o p - File tree\n")
  (insert "  SPC b k - Close buffer\n\n")
  (insert "  General                  Help\n")
  (insert "  SPC q q - Quit Emacs     SPC h k - Describe key\n")
  (insert "  SPC t T - Transparency   SPC h f - Describe function\n")
  (insert "  SPC w v - Split vert     SPC h v - Describe variable\n")
  (insert "  SPC w s - Split horiz\n\n"))

(after! doom-dashboard
  ;; order of widgets in the center panel
  (setq doom-dashboard-functions
        '(doom-dashboard-widget-banner
          my/dashboard-cheat-sheet
          doom-dashboard-widget-shortmenu
          doom-dashboard-widget-loaded))
  ;; optional later maybe: use an image instead of ascii logo (PNG/SVG path).
  ;; (setq fancy-splash-image "~/.config/doom/splash.png")
  )

;; always land on the dashboard buffer
(setq doom-fallback-buffer-name "*doom*"
      +doom-dashboard-name " *doom* ")

;; treemacs: open beside the dashboard on startup
;; open treemacs after the first real buffer (the dashboard) is shown
(add-hook! 'doom-first-buffer-hook
  (run-with-idle-timer 0.1 nil #'+treemacs/toggle))

(setq treemacs-width 30
      treemacs-position 'left
      treemacs-is-never-other-window t)

;; workspaces
(setq +workspaces-on-switch-project-behaviour t)

;;; python setup
(after! python
  ;; Use IPython REPL if installed
  (setq python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i --simple-prompt"))
(setq python-shell-interpreter "~/.venvs/doom-python/bin/python")


;; Format with Black on save (if black is installed)
(after! python
  (add-hook 'python-mode-hook
            (lambda ()
              (setq +format-with 'black))))

;; run tests easily with SPC m t (provided by :lang python in doom)

;;; --- C++ setup ---
(after! cc-mode
  ;; Use clang-format if available
  (add-hook 'c++-mode-hook
            (lambda ()
              (setq +format-with 'clang-format))))

;; Compilation shortcut
(map! :map c++-mode-map
      :localleader
      "c" #'compile
      "r" #'recompile)

;;; --- Java setup ---
(after! lsp-java
  ;; Use Eclipse JDT LS (LSP server)
  (setq lsp-java-format-enabled t
        lsp-java-format-settings-url nil   ; default Google/Oracle style
        lsp-java-save-action-organize-imports t))

;;; --- Dev helpers ---

;; Show line/column in mode line
(setq column-number-mode t)

;; Show matching parentheses instantly
(setq show-paren-delay 0)
(show-paren-mode 1)

;; Highlight TODO/FIXME in code
(after! hl-todo
  (setq hl-todo-keyword-faces
        '(("TODO"   . "#FF0000")
          ("FIXME"  . "#FF4500")
          ("NOTE"   . "#00FF00"))))

;; Enable LSP in all major coding languages
(after! lsp-mode
  (setq lsp-headerline-breadcrumb-enable t
        lsp-enable-symbol-highlighting t
        lsp-enable-on-type-formatting nil))

;; Company: completion popup delay shorter
(after! company
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1))


;; (No need for any other Treemacs-open hooks; do not open Treemacs in emacs-startup-hook)

