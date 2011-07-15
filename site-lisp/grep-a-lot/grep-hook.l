; -*- mode: lisp; package: grep-a-lot; encoding: shift_jis -*-

;;; grep-a-lot/grep-hook.l
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

(defun get-grep-search-pattern ()
  ;; 検索文字列を頑張って取得する。
  ;; *last-grep-regexp* や *last-fgrep-regexp* や *minibuffer-search-string-history*
  ;; を見る方法もあるが、ed::scan-files を直接呼んだ場合は取得できない。
  ;; そこで、ed::*find-error-scanner* というバッファローカル変数に入っている
  ;; クロージャが束縛している pattern 変数から取り出す。
  (let* ((vars (si:closure-variable ed::*find-error-scanner*))
         (pattern (cdr (assoc 'ed::pattern vars))))
    (cond ((typep pattern 'regexp)
           (compiled-regexp-source pattern))
          ((stringp pattern)
           pattern)
          (t
           "???"))))

(defun rename-grep-buffer-hook ()
  (rename-grep-buffer "*grep*" (get-grep-search-pattern)))

(add-hook '*grep-hook* 'rename-grep-buffer-hook)
(add-hook '*grepd-hook* 'rename-grep-buffer-hook)


(provide "grep-a-lot/grep-hook")

;;; End
