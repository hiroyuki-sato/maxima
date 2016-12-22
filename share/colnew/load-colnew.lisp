#+nil
(format t "colnew.system = ~S~%" (merge-pathnames (make-pathname :name "colnew" :type "system") *load-pathname*))
(load (merge-pathnames (make-pathname :name "colnew" :type "system") *load-pathname*))

(mk:oos "colnew-if" :compile)
