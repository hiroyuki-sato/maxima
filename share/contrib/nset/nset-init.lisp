(defun $setup_autoload (filename &rest functions)
  (let ((file ($file_search filename)))
    (dolist (func functions)
      (nonsymchk func '$setup_autoload)
      (putprop (setq func (dollarify-name func)) file 'autoload)
      (add2lnc func $props)))
  '$done)

;; This version of generic-autoload in Maxima 5.9.0 doesn't recognize
;; "fas", "fasl" and "x86f" as valid extensions for compiled Lisp
;; code.

#+cl
(defun generic-autoload (file &aux type)
  (setq file (pathname (cdr file)))
  (setq type (pathname-type file))
  (let ((bin-ext #+gcl "o"
		 #+cmu (c::backend-fasl-file-type c::*target-backend*)
		 #+clisp "fas"
		 #+allegro "fasl"
		 #-(or gcl cmu clisp allegro) ""))
    (if (member type (list bin-ext "lisp" "lsp")  :test 'equalp)
	(load file :verbose 't) ($batchload file))))

;; Autoload the nset functions that simplify.

(add2lnc '$set $props)
(defprop $set simp-set operators)
(autof 'simp-set '|nset|)

(add2lnc '$kron_delta $props)
(defprop $kron_delta simp-kron-delta operators)
(autof 'simp-kron-delta '|nset|)

(add2lnc '$belln $props)
(defprop $belln simp-belln operators)
(autof 'simp-belln '|nset|)

(add2lnc '$divisors $props)
(defprop $divisors simp-divisors operators)
(autof 'simp-divisors '|nset|)

(add2lnc '$mobius $props)
(defprop $mobius simp-mobius operators)
(autof 'simp-mobius '|nset|)

(add2lnc '$stirling1 $props)
(defprop $stirling1 simp-stirling1 operators)
(autof 'simp-stirling1 '|nset|)

(add2lnc '$stirling2 $props)
(defprop $stirling2 simp-stirling2 operators)
(autof 'simp-stirling2 '|nset|)

;; Autoload non-simplifying functions in nset.

($setup_autoload "nset" 
		 '$adjoin 
		 '$cardinality 
		 '$complement 
		 '$cartesian_product 
		 '$disjointp 
		 '$elementp
		 '$emptyp
		 '$equiv_classes 
		 '$extremal_subset 
		 '$flatten  
		 '$full_listify 
		 '$fullsetify 
		 '$intersect 
		 '$intersection
		 '$integer_partitions
		 '$listify  
		 '$makeset
		 '$num_distinct_partitions
		 '$num_partitions
		 '$partition_set 
		 '$permutations 
		 '$powerset 
		 '$setdifference 
		 '$set_partitions
		 '$setify 
		 '$setp 
		 '$subset 
		 '$subsetp 
		 '$symmdifference 
		 '$union)
