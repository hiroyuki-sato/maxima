(setq si::*no-init* '( "ffg"))
(make-package "COMPILER" :use '("LISP"))
(make-package "SLOOP" :use '("LISP"))
(make-package "SERROR" :use '("LISP" "SLOOP"))
(make-package "ANSI-LOOP" :use '("LISP"))
(make-package "DEFPACKAGE" :use '("LISP"))
(make-package "TK" :use '("LISP" "SLOOP"))

(in-package "SYSTEM")
(defvar *command-args* nil)

(progn 
 (system:init-system) 
 (gbc t)

 (in-package "USER")

 (load (concatenate 'string si::*system-directory* "../gcl-tk/tk-package.lsp"))

 (or lisp::*link-array*
     (setq lisp::*link-array*
	   (make-array (ash 1 11)  :element-type 'string-char :fill-pointer 0)))
 (si::use-fast-links t)
 
 (setq compiler::*cmpinclude* "\"cmpinclude.h\"") 
 
 (load (concatenate 'string si::*system-directory* "../cmpnew/gcl_cmpmain.lsp")) 
 (gbc t)
 (load (concatenate 'string si::*system-directory* "../cmpnew/gcl_lfun_list.lsp"))
 (gbc t) 
 (load (concatenate 'string si::*system-directory* "../cmpnew/gcl_cmpopt.lsp"))
 (gbc t)
 (load (concatenate 'string si::*system-directory* "../lsp/gcl_auto_new.lsp")) 
 (gbc t)
 
 (when compiler::*cmpinclude-string*
   (with-open-file (st (concatenate 'string si::*system-directory* "../h/cmpinclude.h"))
		   (let
		       ((tem (make-array (file-length st) :element-type 'standard-char
					 :static t)))
		     (if (si::fread tem 0 (length tem) st)
			 (setq compiler::*cmpinclude-string* tem)))))
 
 (setf (symbol-function 'si:clear-compiler-properties)
       (symbol-function 'compiler::compiler-clear-compiler-properties))
 (setq system::*old-top-level* (symbol-function 'system:top-level))
 
 (defvar si::*lib-directory* (namestring "../"))
 
 (defun system::gcl-top-level (&aux tem)
   (si::set-up-top-level)
   
   (if (si::get-command-arg "-compile")
       (let (;(system::*quit-tag* (cons nil nil))
					;(system::*quit-tags* nil) (system::*break-level* '())
					;(system::*break-env* nil) (system::*ihs-base* 1)
					;(system::*ihs-top* 1) (system::*current-ihs* 1)
	     (*break-enable* nil) result)
	 (setq result
	       (system:error-set
		'(progn
		   (compile-file
		    (si::get-command-arg "-compile")
		    :output-file 
		    (or (si::get-command-arg "-o")
			(si::get-command-arg "-compile"))
		    :o-file
		    (cond ((equalp
			    (si::get-command-arg "-o-file")
			    "nil") nil)
			  ((si::get-command-arg "-o-file" t))
			  (t t))
		    :c-file (si::get-command-arg "-c-file" t)
		    :h-file (si::get-command-arg "-h-file" t)
		    :data-file (si::get-command-arg "-data-file" t)
		    :system-p (si::get-command-arg "-system-p" t)))))
	 (bye (if (or compiler::*error-p* (equal result '(nil))) 1 0))))
   (cond ((si::get-command-arg "-batch")
	  (setq si::*top-level-hook* 'bye))
	 ((si::get-command-arg "-f"))
	 (t  ;; if ANY header or license information is printed by the
	  ;; program, then the following License and Enhancement notice
	  ;; must be printed (see License).
	  (format t "GCL (GNU Common Lisp)  ~A~%~a~%~a~%~%~a~%" "(2.6.1) Fri Dec 12 16:23:54 UTC 2003"
		  "Licensed under GNU Library General Public License"
		  "Dedicated to the memory of W. Schelter"
		  "Use (help) to get some basic information on how to use GCL.")))
   (setq si::*ihs-top* 1)
   (in-package 'system::user) (incf system::*ihs-top* 2)
   (funcall system::*old-top-level*))
 
 (defun lisp-implementation-version nil (format nil "GCL-~a-~a" si::*gcl-major-version* si::*gcl-version*))
 
 (terpri)
 (setq si:*inhibit-macro-special* t)
 (gbc t) (system:reset-gbc-count)
 
 (defun system:top-level nil (system::gcl-top-level))
 
 (setq compiler::*default-c-file* nil)
 (setq compiler::*default-h-file* nil)
 (setq compiler::*default-data-file* nil)
 (setq compiler::*default-system-p* nil)
 (setq compiler::*keep-gaz* nil)
 
 (unintern 'system)
 (unintern 'lisp)
 (unintern 'compiler)
 (unintern 'user)
 (fmakunbound 'si::init-cmp-anon)
 
 (eval-when (load)
	    (if (fboundp 'get-system-time-zone)
		(setf system:*default-time-zone* (get-system-time-zone))
	      (setf system:*default-time-zone* 6)))
 
 (if (fboundp 'si::user-init) (si::user-init))
 (si::set-up-top-level)
 
 (setq si::*gcl-version* 6.1 si::*gcl-major-version* 2)
 (setq compiler::*cc* "gcc -c -g -O2 -g -Wall -DVOL=volatile -fsigned-char -fwritable-strings -pipe -g ")
 (setq compiler::*ld* "gcc -o ")
 (setq compiler::*ld-libs* "-u __gmpn_toom3_mul_n -lgcl -lm  -lgmp /usr/lib/gcc-lib/i486-linux/3.3.2/../../../libbfd.a /usr/lib/gcc-lib/i486-linux/3.3.2/../../../libiberty.a -lreadline -lncurses -lc -lgclp")
 (setq compiler::*opt-three* "")
 (setq compiler::*opt-two* "")
 (setq compiler::*init-lsp* "init_gcl.lsp")
 
 t)
(si::save-system "/tmp/nm")
