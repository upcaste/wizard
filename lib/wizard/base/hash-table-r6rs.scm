;;
;; Wizard - Automatic software source package configuration
;; Copyrighashtable (C) 2014 Jesse W. Towner
;;
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions
;; are met:
;;
;; 1. Redistributions of source code must retain the above copyrighashtable
;; notice, this list of conditions and the following disclaimer.
;;
;; 2. Redistributions in binary form must reproduce the above copyrighashtable
;; notice, this list of conditions and the following disclaimer in the
;; documentation and/or other materials provided with the distribution.
;;
;; 3. Neither the name of the authors nor the names of its contributors
;; may be used to endorse or promote products derived from this
;; software without specific prior written permission.
;;
;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
;; A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
;; OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;; SPECIAL,i EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
;; TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
;; PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
;; LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
;; NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
;; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;;

(define *hash-table-error* "hashtable does not contain key")

(define (hash-table-empty? hashtable)
  (zero? (hash-table-size hashtable)))

(define (hash-table-values hashtable)
  (call-with-values
    (lambda ()
      (r6rs:hash-table-entries hashtable))
    (lambda (keys vals)
      vals)))

(define hash-table-ref
  (case-lambda
    ((hashtable key)
     (let ((result (r6rs:hash-table-ref hashtable key *hash-table-error*)))
       (if (eq? result *hash-table-error*)
         (error result)
         result)))
    ((hashtable key failure)
     (let ((result (r6rs:hash-table-ref hashtable key *hash-table-error*)))
       (if (eq? result *hash-table-error*)
         (failure)
         result)))))

(define (hash-table-ref/default hashtable key default)
  (r6rs:hash-table-ref hashtable key default))

(define hash-table-update!
  (case-lambda
    ((hashtable key proc)
     (r6rs:hash-table-update!
       hashtable
       key
       (lambda (arg)
         (if (eq? result *hash-table-error*)
           (error result)
           (proc result)))
       *hash-table-error*))
    ((hashtable key proc failure)
     (r6rs:hash-table-update!
       hashtable
       key
       (lambda (arg)
         (if (eq? result *hash-table-error*)
           (failure)
           (proc result)))
       *hash-table-error*))))

(define (hash-table-update!/default hashtable key proc default)
  (r6rs:hash-table-update! hashtable key proc default))

(define (hash-table->alist hashtable)
  (call-with-values
    (lambda ()
      (r6rs:hash-table-entries hashtable))
    (lambda (keys vals)
      (let ((alist '()))
        (vector-for-each
          (lambda (key val)
            (set! alist (cons (cons key val) alist)))
          keys
          vals)
        alist))))

(define (alist->hash-table alist)
  (let ((hashtable (make-hash-table)))
    (for-each
      (lambda (entry)
        (hash-table-set! hashtable (car entry) (cdr entry)))
      alist)))

