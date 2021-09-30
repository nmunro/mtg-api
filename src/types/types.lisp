(defpackage mtg-api/types
  (:use :cl)
  (:export #:fetch
           #:make-types-api))
(in-package :mtg-api/types)

(defclass types-api-v1 (mtg-api/base:api-v1)
  ((resource :initarg :formats :initform "types" :reader resource))
  (:documentation "Represents a list of types using V1 of the API"))

(defmethod print-object ((object types-api-v1) stream)
  (print-unreadable-object (object stream)
    (format stream "~A" (resource object))))

(defclass types-api (types-api-v1)
  ()
  (:documentation "A convenience class to represent the current version of the API"))

(defun make-types-api ()
  (make-instance 'types-api))

(defmethod fetch ((obj types-api))
  (let ((url (format nil "~A/~A" (mtg-api/base:url obj) (resource obj))))
    (loop for format in (gethash (resource obj) (jonathan:parse (dexador:get url) :as :hash-table)) collect format)))
