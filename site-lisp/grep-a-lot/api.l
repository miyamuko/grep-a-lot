; -*- mode: lisp; package: grep-a-lot; encoding: shift_jis -*-

;;; grep-a-lot/api.l
;;
;; Copyright (c) 2011-2012 MIYAMUKO Katsuyuki.
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

(export '(*grep-a-lot-buffer-regexp*
          *grep-a-lot-buffer-format*
          *grep-a-lot-abbrev-length*
          *grep-a-lot-rename-buffer-hook*
          ))


(defvar *grep-a-lot-buffer-regexp* "^\\*[a-z]?grep:")
(defvar *grep-a-lot-buffer-format* "*~A:<~A>*")
(defvar *grep-a-lot-abbrev-length* 20)
(defvar *grep-a-lot-rename-buffer-hook* nil)


(defun grep-a-lot-goto (&key reverse (buffer-bar-order *next-buffer-in-tab-order*))
  (let ((next (get-next-grep-a-lot-buffer
               :reverse reverse
               :buffer-bar-order buffer-bar-order)))
    (when next
      (set-buffer next))))

(defun get-next-grep-a-lot-buffer (&key reverse
                                        (buffer-bar-order *next-buffer-in-tab-order*))
  (let* ((obuffer (selected-buffer))
         (current obuffer))
    (loop
      (let ((next (get-next-buffer current reverse buffer-bar-order)))
        (when (equal obuffer next)
          (return nil))
        (when (grep-a-lot-buffer-p next)
          (return next))
        (setf current next)))))

(defun list-grep-a-lot-buffers (&key buffer-bar-order)
  (remove-if-not #'grep-a-lot-buffer-p
                 (buffer-list :buffer-bar-order buffer-bar-order)))

(defun last-grep-a-lot-buffer ()
  (car (last (list-grep-a-lot-buffers :buffer-bar-order t))))

(defun grep-a-lot-buffer-p (buffer)
  (string-matchp *grep-a-lot-buffer-regexp* (buffer-name buffer)))

(defun grep-a-lot-buffer-name (buffer-name pattern)
  (let ((keyword (cond ((typep pattern 'regexp)
                        (compiled-regexp-source pattern))
                       ((stringp pattern)
                        pattern)
                       (t
                        (warn "Unsupported pattern type: ~S" pattern)
                        (format nil "~S" pattern)))))
    (format nil *grep-a-lot-buffer-format*
            buffer-name
            (abbreviate-display-string keyword *grep-a-lot-abbrev-length*))))

(defun rename-grep-buffer (buffer-name pattern)
  (unless (grep-a-lot-buffer-p (selected-buffer))
    (rename-buffer (grep-a-lot-buffer-name buffer-name pattern))
    (run-hooks '*grep-a-lot-rename-buffer-hook*)))

(defun invoke (pkg-name func-name &rest args)
  (let ((pkg (find-package pkg-name)))
    (when pkg
      (let ((func (find-symbol func-name pkg)))
        (when (and func (fboundp func))
          (apply func args))))))


(provide "grep-a-lot/api")

;;; End
