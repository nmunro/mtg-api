(defpackage mtg-api/formats
  (:use :cl)
  (:export #:make-formats-api
           #:fetch))
(in-package :mtg-api/formats)

(defclass formats-api-v1 (mtg-api/base:api-v1)
  ((resource :initarg :formats :initform "formats" :reader resource))
  (:documentation "Represents a list of formats using V1 of the API"))

(defmethod print-object ((object formats-api-v1) stream)
  (print-unreadable-object (object stream)
    (format stream "~A" (resource object))))

(defclass formats-api (formats-api-v1)
  ()
  (:documentation "A convenience class to represent the current version of the API"))

(defun make-formats-api ()
  (make-instance 'formats-api))

(defmethod fetch ((obj formats-api))
  (let ((url (format nil "~A/~A" (mtg-api/base:url obj) (resource obj))))
    (loop for format in (gethash "formats" (jonathan:parse (dexador:get url) :as :hash-table)) collect format)))
