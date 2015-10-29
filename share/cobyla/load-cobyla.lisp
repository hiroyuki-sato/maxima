(in-package #-gcl #:maxima #+GCL "MAXIMA")

#+ecl
($load "lisp-utils/defsystem.lisp")

(load (merge-pathnames (make-pathname :name "cobyla" :type "system") *load-pathname*))

(mk:oos "cobyla-interface" :compile)
