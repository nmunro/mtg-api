(defsystem "mtg-api"
  :version "0.1.0"
  :author "Neil Munro (NMunro)"
  :license ""
  :depends-on (:dexador
               :do-urlencode
               :jonathan
               :alexandria
               :closer-mop)
  :components ((:module "src"
                :components
                ((:file "base")
                 (:module "formats"
                  :components
                  ((:file "formats")))
                 (:module "types"
                  :components
                  ((:file "types")
                   (:file "subtypes")
                   (:file "supertypes")))
                 (:module "cards"
                  :components
                  ((:file "legality")
                   (:file "ruling")
                   (:file "translation")
                   (:file "card")
                   (:file "cards")))
                 (:module "set"
                  :components
                  ((:file "set")
                   (:file "sets")))
                 (:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "mtg-api/tests"))))

(defsystem "mtg-api/tests"
  :author ""
  :license ""
  :depends-on ("mtg-api"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for mtg-api"
  :perform (test-op (op c) (symbol-call :rove :run c)))
