(defpackage mtg-api/supertypes
  (:use :cl)
  (:export #:fetch
           #:make-supertypes-api))
(in-package :mtg-api/supertypes)

(defclass supertypes-api-v1 (mtg-api/base:api-v1)
  ((resource :initarg :formats :initform "supertypes" :reader resource))
  (:documentation "Represents a list of supertypes using V1 of the API"))

(defmethod print-object ((object supertypes-api-v1) stream)
  (print-unreadable-object (object stream)
    (format stream "~A" (resource object))))

(defclass supertypes-api (supertypes-api-v1)
  ()
  (:documentation "A convenience class to represent the current version of the API"))

(defun make-supertypes-api ()
  (make-instance 'supertypes-api))

(defmethod fetch ((obj supertypes-api))
  (let ((url (format nil "~A/~A" (mtg-api/base:url obj) (resource obj))))
    (loop for format in (gethash (resource obj) (jonathan:parse (dexador:get url) :as :hash-table)) collect format)))
