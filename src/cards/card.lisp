(defpackage mtg-api/card
  (:use :cl)
  (:export #:fetch
           #:make-card-api
           #:id
           #:name
           #:layout
           #:mana-cost
           #:multiverse-id
           #:cmc
           #:colors
           #:color-identity
           #:type
           #:supertypes
           #:types
           #:subtypes
           #:rarity
           #:set
           #:set-name
           #:text
           #:flavor
           #:artist
           #:number
           #:power
           #:toughness
           #:image-url
           #:watermark
           #:rulings
           #:foreign-names
           #:printings
           #:original-text
           #:original-type
           #:legalities
           #:make-card)
  (:shadow :id :type :set :number))
(in-package :mtg-api/card)

(defclass card-api-v1 (mtg-api/base:api-v1)
  ((resource       :initarg :formats :initform "cards" :reader resource)
   (id             :initarg :id      :initform nil     :reader id))
  (:documentation "Represents a card using V1 of the API"))

(defmethod print-object ((object card-api-v1) stream)
  (print-unreadable-object (object stream)
    (format stream "~A" (resource object))))

(defclass card-api (card-api-v1)
  ()
  (:documentation "A convenience class to represent the current version of the API"))

(defun make-card-api (&rest args)
  (apply #'make-instance `(card-api ,@(alexandria:flatten args))))

(defclass card ()
  ((id             :initarg :id             :initform nil     :reader id)
   (name           :initarg :name           :initform nil     :reader name)
   (layout         :initarg :layout         :initform nil     :reader layout)
   (mana-cost      :initarg :mana-cost      :initform nil     :reader mana-cost)
   (multiverse-id  :initarg :multiverse-id  :initform nil     :reader multiverse-id)
   (cmc            :initarg :cmc            :initform 0       :reader cmc)
   (colors         :initarg :colors         :initform nil     :reader colors)
   (color-identity :initarg :color-identity :initform nil     :reader color-identity)
   (type           :initarg :type           :initform nil     :reader type)
   (supertypes     :initarg :supertypes     :initform nil     :reader supertypes)
   (types          :initarg :types          :initform nil     :reader types)
   (subtypes       :initarg :subtypes       :initform nil     :reader subtypes)
   (rarity         :initarg :rarity         :initform nil     :reader rarity)
   (set            :initarg :set            :initform nil     :reader set)
   (set-name       :initarg :set-name       :initform nil     :reader set-name)
   (text           :initarg :text           :initform nil     :reader text)
   (flavor         :initarg :flavor         :initform nil     :reader flavor)
   (artist         :initarg :artist         :initform nil     :reader artist)
   (number         :initarg :number         :initform nil     :reader number)
   (power          :initarg :power          :initform nil     :reader power)
   (toughness      :initarg :toughness      :initform nil     :reader toughness)
   (image-url      :initarg :image-url      :initform nil     :reader image-url)
   (watermark      :initarg :watermark      :initform nil     :reader watermark)
   (rulings        :initarg :rulings        :initform nil     :reader rulings)
   (foreign-names  :initarg :foreign-names  :initform nil     :reader foreign-names)
   (printings      :initarg :printings      :initform nil     :reader printings)
   (original-text  :initarg :original-text  :initform nil     :reader original-text)
   (original-type  :initarg :original-type  :initform nil     :reader original-type)
   (legalities     :initarg :legalities     :initform nil     :reader legalities))
  (:documentation "Represents a card"))

(defmethod print-object ((object card) stream)
  (print-unreadable-object (object stream)
    (format stream "~A" (name object))))

(defun make-card (item)
  (make-instance 'card
                 :id             (gethash "id" item)
                 :name           (gethash "name" item)
                 :layout         (gethash "layout" item)
                 :mana-cost      (gethash "manaCost" item)
                 :multiverse-id  (gethash "multiverseid" item)
                 :cmc            (gethash "cmc" item)
                 :colors         (gethash "colors" item)
                 :color-identity (gethash "colorIdentity" item)
                 :type           (gethash "type" item)
                 :supertypes     (gethash "supertypes" item)
                 :types          (gethash "types" item)
                 :subtypes       (gethash "subtypes" item)
                 :rarity         (gethash "rarity" item)
                 :set            (gethash "set" item)
                 :set-name       (gethash "setName" item)
                 :text           (gethash "text" item)
                 :flavor         (gethash "flavor" item)
                 :artist         (gethash "artist" item)
                 :number         (gethash "number" item)
                 :power          (gethash "power" item)
                 :toughness      (gethash "toughness" item)
                 :image-url      (gethash "imageUrl" item)
                 :watermark      (gethash "watermark" item)
                 :rulings        (mapcar #'mtg-api/ruling:make-ruling (gethash "rulings" item))
                 :foreign-names  (mapcar #'mtg-api/translation:make-translation (gethash "foreignNames" item))
                 :printings      (gethash "printings" item)
                 :original-text  (gethash "originalText" item)
                 :original-type  (gethash "originalType" item)
                 :legalities     (mapcar #'mtg-api/legality:make-legality (gethash "legalities" item))))

(defmethod fetch ((obj card-api))
  (let ((url (format nil "~A/~A/~A" (mtg-api/base:url obj) (resource obj) (id obj))))
    (make-card (gethash "card" (jonathan:parse (dexador:get url) :as :hash-table)))))
