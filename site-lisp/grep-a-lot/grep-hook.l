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
  ;; - 基本的には ed::scan-files を直接呼ぶ場合を考慮して、
  ;;   ed::*find-error-scanner* というバッファローカル変数に入っている
  ;;   クロージャが束縛している pattern 変数から取り出す。
  ;; - ただし、grep-dialog で「非同期grep」をチェックしていると、
  ;;   このバッファローカル変数は取得できないので
  ;;   ed::*minibuffer-search-string-history* から取得する。
  ;; - ちなみに ed::*last-grepd-regexp* は利用されていない。
  ;; - 非同期 grep の場合はバッファ名を変更しても、なにかキー入力するまでは
  ;;   バッファバーに反映されない (refresh-screen してもだめ)。
  (or (get-grep-search-pattern-from-find-error-scanner)
      (get-grep-search-pattern-from-minibuffer-search-string-history)
      "???"))

(defun get-grep-search-pattern-from-find-error-scanner ()
  (when ed::*find-error-scanner*
    (let* ((vars (si:closure-variable ed::*find-error-scanner*))
           (pattern (cdr (assoc 'ed::pattern vars))))
      (cond ((typep pattern 'regexp)
             (compiled-regexp-source pattern))
            ((stringp pattern)
             pattern)))))

(defun get-grep-search-pattern-from-minibuffer-search-string-history ()
  (car ed::*minibuffer-search-string-history*))

(defun rename-grep-buffer-hook ()
  (rename-grep-buffer "*grep*" (get-grep-search-pattern)))

(add-hook '*grep-hook* 'rename-grep-buffer-hook)
(add-hook '*grepd-hook* 'rename-grep-buffer-hook)


(provide "grep-a-lot/grep-hook")

;;; End
