(defpackage mtg-api/tests/main
  (:use :cl
        :mtg-api
        :rove))
(in-package :mtg-api/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :mtg-api)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
