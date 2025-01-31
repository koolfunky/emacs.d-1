;;; init-typescript.el --- Support the Typescript language -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'typescript-mode)
(maybe-require-package 'company)
(maybe-require-package 'flycheck)
(maybe-require-package 'tide)

(add-auto-mode 'typescript-mode
               "\\.ts\\'")

(setq-default typescript-indent-level 2)

(global-company-mode t)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "<tab>") 'company-complete-selection)

(setq-default company-idle-delay1 0.0)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq-default company-tooltip-align-annotations t)

(add-hook 'typescript-mode-hook 'tide-setup)
(add-hook 'typescript-mode-hook 'tide-hl-identifier-mode)
(add-hook 'before-save-hook 'tide-format-before-save)

(provide 'init-typescript)
;;; init-typescript.el ends here
