(defpackage mtg-api/base
  (:use :cl)
  (:export #:api-v1
           #:url
           #:args
           #:fetch))
(in-package :mtg-api/base)

(defclass api-v1 ()
  ((url  :initarg :url :initform "https://api.magicthegathering.io/v1" :reader url))
  (:documentation "Represents an abstract API resource for V1 of the API"))

(defgeneric args (obj)
  (:documentation "Converts any specific data into query params"))

(defgeneric fetch (obj)
  (:documentation "Makes a http request for obj"))
