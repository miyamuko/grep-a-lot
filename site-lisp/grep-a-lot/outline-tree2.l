; -*- mode: lisp; package: grep-a-lot; encoding: shift_jis -*-

;;; grep-a-lot/outline-tree2.l
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
  (require "grep-a-lot/api")
  )

(in-package :grep-a-lot)

(defun refresh-outline-tree2 ()
  ;; outline-tree2 がロードされている場合に実行
  (invoke "outline-tree2" "outline-tree-create-buffer-node-by-buffer"))

(defun grep-a-lot-setup-outline-tree2-hook ()
  (add-hook '*grep-a-lot-rename-buffer-hook*
            'refresh-outline-tree2))

;; outline-tree2 は ed::*after-rename-buffer-hook* が定義されている場合は、
;; バッファ名の変更に追従できる。
;; http://raido.sakura.ne.jp/southly/rn/index.rb?1161833288.txt
;; それ以外の場合にのみ grep-a-lot 側で処理する。
(unless (boundp 'ed::*after-rename-buffer-hook*)
  (grep-a-lot-setup-outline-tree2-hook))


(provide "grep-a-lot/outline-tree2")

;;; End
