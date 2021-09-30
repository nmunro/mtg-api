(defpackage mtg-api/translation
  (:use :cl)
  (:export #:make-translation
           #:name
           #:language
           #:multiverse-id))
(in-package :mtg-api/translation)

(defclass translation ()
  ((name          :initarg :name          :initform "" :reader name)
   (language      :initarg :language      :initform "" :reader language)
   (multiverse-id :initarg :multiverse-id :initform "" :reader multiverse-id))
  (:documentation "Represents a translation in MTG"))

(defmethod print-object ((object translation) stream)
  (print-unreadable-object (object stream)
    (format stream "~A (~A): ~A" (name object) (language object) (multiverse-id object))))

(defun make-translation (item)
  (make-instance 'translation :name (gethash "name" item) :language (gethash "language" item) :multiverse-id (gethash "multiverseid" item)))
