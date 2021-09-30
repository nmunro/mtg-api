(defpackage mtg-api/legality
  (:use :cl)
  (:export #:make-legality
           #:game-format
           #:legality))
(in-package :mtg-api/legality)

(defclass legality ()
  ((format   :initarg :format   :initform "" :reader game-format)
   (legality :initarg :legality :initform "" :reader legality))
  (:documentation "Represents a legality in MTG"))

(defmethod print-object ((object legality) stream)
  (print-unreadable-object (object stream)
    (format stream "~A: ~A" (game-format object) (legality object))))

(defun make-legality (item)
  (make-instance 'legality :format (gethash "format" item) :legality (gethash "legality" item)))
