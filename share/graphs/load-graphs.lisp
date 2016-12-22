(in-package #-gcl #:maxima #+gcl "MAXIMA")

#+ecl ($load "lisp-utils/defsystem.lisp")

(load (merge-pathnames (make-pathname :name "graphs" :type "system") *load-pathname*))

(mk:oos "graphs" :compile)
