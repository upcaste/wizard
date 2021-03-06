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

(define (make-hash-table)
  (gauche:make-hash-table 'equal?))

(define (hash-table-contains? hashtable key)
  (gauche:hash-table-exists? hashtable key))

(define (hash-table-size hashtable)
  (gauche:hash-table-num-entries hashtable))

(define (hash-table-empty? hashtable)
  (zero? (hash-table-size hashtable)))

(define hash-table-ref
  (case-lambda
    ((hashtable key)
     (gauche:hash-table-get hashtable key))
    ((hashtable key failure)
     (if (hash-table-contains? hashtable key)
       (gauche:hash-table-get hashtable key)
       (failure)))))

(define (hash-table-ref/default hashtable key default)
  (gauche:hash-table-get hashtable key default))

(define (hash-table-set! hashtable key value)
  (gauche:hash-table-put! hashtable key value))

(define hash-table-update!
  (case-lambda
    ((hashtable key proc)
     (gauche:hash-table-update! hashtable key proc))
    ((hashtable key proc failure)
     (if (hash-table-contains? hashtable key)
       (gauche:hash-table-update! hashtable key proc)
       (failure)))))

(define (hash-table-update!/default hashtable key proc default)
  (gauche:hash-table-update! hashtable key proc default))

