; -*- mode: lisp; package: grep-a-lot; encoding: shift_jis -*-

;;; grep-a-lot/commands.l
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
  (require "grep-a-lot/util")
  (require "grep-a-lot/context")
  )

(in-package :grep-a-lot)

(export '(grep-a-lot-goto-next
          grep-a-lot-goto-prev
          grep-a-lot-pop-stack
          grep-a-lot-clear-stack
          grep-a-lot-restart-context
          grep-a-lot-setup-keys
          ))

(defun grep-a-lot-goto-next ()
  "次の grep バッファを開く"
  (interactive)
  (grep-a-lot-goto :reverse nil))

(defun grep-a-lot-goto-prev ()
  "前の grep バッファを開く"
  (interactive)
  (grep-a-lot-goto :reverse t))

(defun grep-a-lot-pop-stack ()
  "現在の grep バッファを削除する"
  (interactive)
  (let ((current (selected-buffer)))
    (when (grep-a-lot-buffer-p current)
      (grep-a-lot-goto-next)
      (kill-buffer current))))

(defun grep-a-lot-clear-stack ()
  "全 grep バッファを削除する"
  (interactive)
  (mapc 'kill-buffer (list-grep-a-lot-buffers)))

(defun grep-a-lot-restart-context ()
  "現在の grep バッファを開く"
  (interactive)
  (let* ((b (grep-a-lot-last-context))
         (w (get-buffer-window b)))
    (if w
        (set-window w)
      (set-buffer b))))

(defun grep-a-lot-setup-keys ()
  "Emacs の grep-a-lot と同じキーバインドを定義する。
M-g goto-line は使えなくなるので注意。"
  (interactive)
  (define-key esc-map '(#\g #\]) 'grep-a-lot-goto-next)
  (define-key esc-map '(#\g #\[) 'grep-a-lot-goto-prev)
  (define-key esc-map '(#\g #\-) 'grep-a-lot-pop-stack)
  (define-key esc-map '(#\g #\_) 'grep-a-lot-clear-stack)
  (define-key esc-map '(#\g #\=) 'grep-a-lot-restart-context))


(provide "grep-a-lot/commands")

;;; End
