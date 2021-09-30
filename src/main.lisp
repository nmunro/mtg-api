(defpackage mtg-api
  (:use :cl)
  (:export #:card
           #:cards
           #:set
           #:sets
           #:types
           #:subtypes
           #:supertypes
           #:formats)
  (:shadow #:set))
(in-package :mtg-api)

(defun card (&rest clauses)
  (let ((args (loop for (i v) on clauses by #'cddr collect (apply #'where v))))
    (mtg-api/card:fetch (mtg-api/card:make-card-api args))))

(defun cards (&rest clauses)
  (let ((args (loop for (i v) on clauses by #'cddr collect (apply #'where v))))
    (mtg-api/cards:fetch (apply #'mtg-api/cards:make-cards-api args))))

(defun set (&rest clauses)
  (let ((args (loop for (i v) on clauses by #'cddr collect (apply #'where v))))
    (mtg-api/set:fetch (mtg-api/set:make-set-api args))))

(defun sets (&rest clauses)
  (let ((args (loop for (i v) on clauses by #'cddr collect (apply #'where v))))
    (mtg-api/sets:fetch (mtg-api/sets:make-sets-api args))))

(defun types ()
  (mtg-api/types:fetch (mtg-api/types:make-types-api)))

(defun subtypes ()
  (mtg-api/subtypes:fetch (mtg-api/subtypes:make-subtypes-api)))

(defun supertypes ()
  (mtg-api/supertypes:fetch (mtg-api/supertypes:make-supertypes-api)))

(defun formats ()
  (mtg-api/formats:fetch (mtg-api/formats:make-formats-api)))

(defun where (op &rest args)
  (flet ((fn (item)
           (cond
             ((eq item :and) ",")
             ((eq item :or) "|")
             (t item))))
    `(,op ,(format nil "~{~A~}" (mapcar #'fn args)))))
