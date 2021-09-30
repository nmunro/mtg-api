(defpackage mtg-api
  (:use :cl)
  (:shadow :type :id :set))
(in-package :mtg-api)

(defclass mtg-resource ()
  ())

(defgeneric load-resource ()
  (:documentation "Gets a resource from the MTG API"))

(defclass card (mtg-resource)
  ((name           :initarg :name           :initform ""  :reader name)
   (mana-cost      :initarg :mana-cost      :initform ""  :reader mana-cost)
   (cmc            :initarg :cmc            :initform ""  :reader cmc)
   (colors         :initarg :color          :initform '() :reader colors)
   (color-identity :initarg :color-identity :initform '() :reader color-identity)
   (type           :initarg :type           :initform ""  :reader type)
   (types          :initarg :types          :initform '() :reader types)
   (sub-types      :initarg :sub-types      :initform '() :reader sub-types)
   (rarity         :initarg :rarity         :initform ""  :reader rarity)
   (set            :initarg :set            :initform ""  :reader set)
   (set-name       :initarg :set-name       :initform ""  :reader set-name)
   (text           :initarg :text           :initform ""  :reader text)
   (artist         :initarg :artist         :initform ""  :reader artist)
   (num            :initarg :number         :initform ""  :reader num)
   (power          :initarg :power          :initform ""  :reader power)
   (toughness      :initarg :toughness      :initform ""  :reader toughness)
   (layout         :initarg :layout         :initform ""  :reader layout)
   (multiverse-id  :initarg :multiverse-id  :initform ""  :reader multiver-id)
   (image-url      :initarg :image-url      :initform ""  :reader image-url)
   (variations     :initarg :variations     :initform '() :reader variations)
   (foreign-names  :initarg :foreign-names  :initform '() :reader foreign-names)
   (printings      :initarg :printings      :initform '() :reader printings)
   (original-text  :initarg :original-text  :initform ""  :reader original-text)
   (original-type  :initarg :original-type  :initform ""  :reader original-type)
   (legalities     :initarg :legalities     :initform '() :reader legalities)
   (id             :initarg :id             :initform ""  :reader id)))

(defmethod print-object ((object card) stream)
  (print-unreadable-object (object stream)
    (format stream "~A" (name object))))

(defun main ()
  (let* ((data (dexador:get "https://api.magicthegathering.io/v1/cards"))
       (cards (cadr (assoc :cards (json:decode-json-from-string data)))))
   (dolist (card cards)
      (format t "~A~%" card))

   (format t "~%~%")
   (format t "~A~%" (first cards))))

(main)

(defun all ()
  0)

(defun where (name val)
  (format nil "~A -> ~A" name val))

(where :page 5)