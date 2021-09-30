(defpackage mtg-api/subtypes
  (:use :cl)
  (:export #:fetch
           #:make-subtypes-api))
(in-package :mtg-api/subtypes)

(defclass subtypes-api-v1 (mtg-api/base:api-v1)
  ((resource :initarg :formats :initform "subtypes" :reader resource))
  (:documentation "Represents a list of subtypes using V1 of the API"))

(defmethod print-object ((object subtypes-api-v1) stream)
  (print-unreadable-object (object stream)
    (format stream "~A" (resource object))))

(defclass subtypes-api (subtypes-api-v1)
  ()
  (:documentation "A convenience class to represent the current version of the API"))

(defun make-subtypes-api ()
  (make-instance 'subtypes-api))

(defmethod fetch ((obj subtypes-api))
  (let ((url (format nil "~A/~A" (mtg-api/base:url obj) (resource obj))))
    (loop for format in (gethash (resource obj) (jonathan:parse (dexador:get url) :as :hash-table)) collect format)))
