(defpackage mtg-api/set
  (:use :cl)
  (:export #:make-set-api
           #:make-set
           #:code
           #:gatherer-code
           #:old-code
           #:expansion
           #:name
           #:type
           #:border
           #:mkm-id
           #:booster
           #:mkm-name
           #:release-date
           #:online-only
           #:magic-cards-info-code
           #:block
           #:fetch)
  (:shadow :set :type :block))
(in-package :mtg-api/set)

(defclass set-api-v1 (mtg-api/base:api-v1)
  ((resource :initarg :resource :initform "sets" :reader resource)
   (code     :initarg :code     :initform '()    :reader code)
   (booster  :initarg :booster  :initform nil    :reader booster))
  (:documentation "Represents a 'set' resource using V1 of the API"))

(defmethod print-object ((object set-api-v1) stream)
  (print-unreadable-object (object stream)
    (format stream "~A: Code = ~A" (resource object) (code object))))

(defclass set-api (set-api-v1)
  ()
  (:documentation "A convenience class to represent the current version of the API"))

(defun make-set-api (&rest args)
  (apply #'make-instance `(set-api ,@(alexandria:flatten args))))

(defclass set ()
  ((code                  :initarg :code                  :initform ""  :reader code)
   (gathererCode          :initarg :gatherer-code         :initform ""  :reader gatherer-code)
   (old-code              :initarg :old-code              :initform ""  :reader old-code)
   (expansion             :initarg :expansion             :initform ""  :reader expansion)
   (name                  :initarg :name                  :initform ""  :reader name)
   (type                  :initarg :type                  :initform ""  :reader type)
   (border                :initarg :border                :initform ""  :reader border)
   (mkm-id                :initarg :mkm-id                :initform 0   :reader mkm-id)
   (booster               :initarg :booster               :initform nil :reader booster)
   (mkm-name              :initarg :mkm-name              :initform ""  :reader mkm-name)
   (release-date          :initarg :release-date          :initform ""  :reader release-date)
   (onlineOnly            :initarg :online-only           :initform nil :reader online-only)
   (magic-cards-info-code :initarg :magic-cards-info-code :initform ""  :reader magic-cards-info-code)
   (block                 :initarg :block                 :initform ""  :reader block))
  (:documentation "Represents a 'set' as returned from the /set resource of the API"))

(defmethod print-object ((object set) stream)
  (print-unreadable-object (object stream)
    (format stream "~A (~A)" (name object) (code object))))

(defun make-set (item)
    (make-instance 'set
                   :code                  (gethash "code" item)
                   :gatherer-code         (gethash "gathererCode" item)
                   :old-code              (gethash "oldCode" item)
                   :expansion             (gethash "expansion" item)
                   :name                  (gethash "name" item)
                   :type                  (gethash "type" item)
                   :border                (gethash "border" item)
                   :mkm-id                (gethash "mkm_id" item)
                   :booster               (gethash "booster" item)
                   :block                 (gethash "block" item)
                   :mkm-name              (gethash "mkm_name" item)
                   :release-date          (gethash "releaseDate" item)
                   :online-only           (gethash "onlineOnly" item)
                   :magic-cards-info-code (gethash "magicCardsInfoCode" item)))

(defmethod fetch ((obj set-api))
  (let ((url (format nil "~A/~A/~A" (mtg-api/base:url obj) (resource obj) (code obj))))
    (if (booster obj)
        (mapcar #'mtg-api/card:make-card (gethash "cards" (jonathan:parse (dexador:get (format nil "~A/booster" url)) :as :hash-table)))
        (make-set (gethash "set" (jonathan:parse (dexador:get url) :as :hash-table))))))
