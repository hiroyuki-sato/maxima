;;; Compiled by f2cl version 2.0 beta Date: 2007/05/04 17:29:50 
;;; Using Lisp CMU Common Lisp Snapshot 2007-05 (19D)
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':simple-array)
;;;           (:array-slicing nil) (:declare-common nil)
;;;           (:float-format double-float))

(in-package :slatec)


(let ((ntj0 0)
      (xsml 0.0)
      (bj0cs
       (make-array 19
                   :element-type 'double-float
                   :initial-contents '(0.10025416196893913 -0.6652230077644051
                                       0.2489837034982813 -0.03325272317003577
                                       0.0023114179304694017
                                       -9.911277419950809e-5
                                       2.891670864399881e-6
                                       -6.121085866303263e-8
                                       9.838650793856784e-10
                                       -1.2423551597301765e-11
                                       1.2654336302559046e-13
                                       -1.0619456495287245e-15
                                       7.470621075802456e-18
                                       -4.469703227441278e-20
                                       2.302428158433744e-22
                                       -1.0319144794166698e-24
                                       4.060817827487332e-27
                                       -1.4143836005240915e-29
                                       4.391090549669888e-32)))
      (first$ nil))
  (declare (type f2cl-lib:logical first$)
           (type (simple-array double-float (19)) bj0cs)
           (type (double-float) xsml)
           (type (integer) ntj0))
  (setq first$ f2cl-lib:%true%)
  (defun dbesj0 (x)
    (declare (type (double-float) x))
    (prog ((ampl 0.0) (theta 0.0) (y 0.0) (dbesj0 0.0))
      (declare (type (double-float) dbesj0 y theta ampl))
      (cond
        (first$
         (setf ntj0
                 (initds bj0cs 19
                  (* 0.1f0 (f2cl-lib:freal (f2cl-lib:d1mach 3)))))
         (setf xsml (f2cl-lib:fsqrt (* 8.0 (f2cl-lib:d1mach 3))))))
      (setf first$ f2cl-lib:%false%)
      (setf y (abs x))
      (if (> y 4.0) (go label20))
      (setf dbesj0 1.0)
      (if (> y xsml) (setf dbesj0 (dcsevl (- (* 0.125 y y) 1.0) bj0cs ntj0)))
      (go end_label)
     label20
      (multiple-value-bind (var-0 var-1 var-2)
          (d9b0mp y ampl theta)
        (declare (ignore var-0))
        (setf ampl var-1)
        (setf theta var-2))
      (setf dbesj0 (* ampl (cos theta)))
      (go end_label)
     end_label
      (return (values dbesj0 nil)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::dbesj0
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types '((double-float))
                                            :return-values '(nil)
                                            :calls '(fortran-to-lisp::d9b0mp
                                                     fortran-to-lisp::dcsevl
                                                     fortran-to-lisp::initds
                                                     fortran-to-lisp::d1mach))))
