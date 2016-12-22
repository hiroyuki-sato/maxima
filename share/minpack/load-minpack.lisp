(in-package #-gcl #:maxima #+GCL "MAXIMA")

#+ecl ($load "lisp-utils/defsystem.lisp")

(load (merge-pathnames (make-pathname :name "minpack" :type "system") *load-pathname*))

(mk:oos "minpack-interface" :compile)
