;; Modify so as to signal an error if label appears more than once
;; stupid lack of type safety
(define (extract-labels text receive)
  (let ((labels '()))
    (if (null? text)
        (receive '() '())
        (extract-labels (cdr text)
                        (lambda (insts labels)
                          (let ((next-inst (car text)))
                            (if (symbol? next-inst)
                              (if (assoc next-inst labels)
                                (error "Label already present in Machine  code." next-inst)
                                (begin (set! labels (cons next-inst labels))
                                       (receive insts
                                           (cons (make-label-entry next-inst
                                                                   insts)
                                                 labels))))
                              (receive (cons (make-instruction next-inst)
                                             insts)
                                       labels))))))))

;; context related code
(define (assemble controller-text machine)
  (extract-labels controller-text 
                  (lambda (insts labels)
                    (update-insts! labels machine)
                    insts)))
(define (update-insts! insts labels machine)
  (let ((pc (get-register machine 'pc))
        (flag (get-register machine 'flag))
        (stack (machine 'stack))
        (ops (machine 'operation))
        (siep! set-instruction-execution-proc!)
        (mep make-execution-procedure))
    (for-each 
      (lambda (inst)
        (siep! inst 
               (mep (instruction-text inst) 
                    labels 
                    machine 
                    pc 
                    flag 
                    stack 
                    ops)))
      insts)))

;; Damn, I can't really wrap my head around the format of the code.
