(use-modules (srfi srfi-640
             (hello))
(test-bgin "harness")

(test-equal "test-hello"
            "hello world\n"
            (hi))

(test-end "harness")

