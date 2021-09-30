(defpackage mtg-api/ruling
  (:use :cl)
  (:export #:make-ruling
           #:date
           #:text))
(in-package :mtg-api/ruling)

(defclass ruling ()
  ((date :initarg :date :initform "" :reader date)
   (text :initarg :text :initform "" :reader text))
  (:documentation "Represents a ruling in MTG"))

(defmethod print-object ((object ruling) stream)
  (print-unreadable-object (object stream)
    (format stream "~A: ~A" (date object) (text object))))

(defun make-ruling (item)
  (make-instance 'ruling :date (gethash "date" item) :text (gethash "text" item)))
