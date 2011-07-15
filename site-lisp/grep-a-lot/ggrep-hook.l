; -*- mode: lisp; package: grep-a-lot; encoding: shift_jis -*-

;;; grep-a-lot/ggrep-hook.l
;;
;; Copyright (c) 2011 MIYAMUKO Katsuyuki.
;;
;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:
;;
;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
;; LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
;; OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

;;; Code:

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "grep-a-lot/package")
  )

(in-package :grep-a-lot)

(defun get-ggrep-search-pattern ()
  (values ed::*last-ggrep-method*
          (if (equal *this-command* 'ed::fggrep)
              ed::*last-fggrep-pattern-list*
            ed::*last-ggrep-regexp-list*)))

(defun get-ggrepd-search-pattern ()
  (labels ((empty-string-p (str)
             (or (not str)
                 (string= "" str)))
           (get-pattern (setting)
             (cadr (assoc "pattern" setting :test #'string=))))
    (values ed::*ggrep-method*
            (remove-if #'empty-string-p
                       (mapcar #'get-pattern ed::*ggrep-patterns*)))))

(defun rename-ggrep-buffer (method patterns)
  (let* ((sep (string-upcase (string method)))
         (pattern (format nil (concat "~{~A~^ " sep " ~}")
                          patterns)))
    (rename-grep-buffer "*ggrep*" pattern)))

(defun rename-ggrep-buffer-hook ()
  (multiple-value-call 'rename-ggrep-buffer (get-ggrep-search-pattern)))

(defun rename-ggrepd-buffer-hook ()
  (multiple-value-call 'rename-ggrep-buffer (get-ggrepd-search-pattern)))

(add-hook 'ed::*ggrep-hook* 'rename-ggrep-buffer-hook)
(add-hook 'ed::*ggrepd-hook* 'rename-ggrepd-buffer-hook)

(provide "grep-a-lot/ggrep-hook")

;;; End
