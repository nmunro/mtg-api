(defpackage mtg-api/sets
  (:use :cl)
  (:export #:make-sets-api
           #:fetch)
  (:shadow :set :type :block))
(in-package :mtg-api/sets)

(defclass sets-api-v1 (mtg-api/base:api-v1)
  ((resource :initarg :resource :initform "sets" :reader resource)
   (name     :initarg :name     :initform '()    :accessor name)
   (block    :initarg :block    :initform '()    :accessor block))
  (:documentation "Represents a 'set' resource using V1 of the API"))

(defmethod print-object ((object sets-api-v1) stream)
  (print-unreadable-object (object stream)
    (format stream "~A: Name = (~{~A~^, ~}) Block = (~{~A~^, ~})" (resource object) (name object) (block object))))

(defclass sets-api (sets-api-v1)
  ()
  (:documentation "A convenience class to represent the current version of the API"))

(defun make-sets-api (&rest args)
  (apply #'make-instance `(sets-api ,@(alexandria:flatten args))))

(defmethod args ((obj sets-api))
  (labels ((remove-slots (slot)
             (member slot '(resource)))

           (make-query-param (slot)
             (when (slot-value obj slot)
               (format nil "~A=~A" (string-downcase slot) (do-urlencode:urlencode (slot-value obj slot)))))

           (make-query-params (slots)
             (format nil "?~{~A~^&~}" (remove-if #'null (mapcar #'make-query-param slots)))))

    (let ((slots (mapcar #'closer-mop:slot-definition-name (closer-mop:class-direct-slots (class-of (make-instance 'sets-api-v1))))))
      (make-query-params (remove-if #'remove-slots slots)))))

(defmethod fetch ((obj sets-api))
    (let ((url (format nil "~A/~A~A" (mtg-api/base:url obj) (resource obj) (args obj))))
      (mapcar #'mtg-api/set:make-set (gethash "sets" (jonathan:parse (dexador:get url) :as :hash-table)))))
