(in-package :maxima)

#+ignore
(defmspec $makelist (x)
  (setq x (cdr x))
  (prog (n form arg a b c d lv)
     (setq n (length x))
     (cond
       ((= n 0) (return '((mlist))))
       ((= n 1)
        (setq form (first x))
        (return
          `((mlist) ,(meval `(($ev) ,@(list (list '(mquote) form)))))))
       ((= n 2)
        (setq form (first x))
        (setq b ($float (meval (second x))))
        (if (numberp b)
            (return
              (do
               ((m 1 (1+ m)) (ans))
               ((> m b) (cons '(mlist) (nreverse ans)))
                (push (meval `(($ev) ,@(list (list '(mquote) form))))
                      ans)))
            (merror (intl:gettext "makelist: second argument must evaluate to a number; found: ~M") b)))
       ((= n 3)
        (setq form (first x))
        (setq arg (second x))
        (setq b (meval (third x)))
        (if ($listp b)
            (setq lv (mapcar #'(lambda (u) (list '(mquote) u)) (cdr b)))
            (progn
              (setq b ($float (meval b)))
              (if ($numberp b)
                  (return
                    (do
                     ((m 1 (1+ m)) (ans))
                     ((> m b) (cons '(mlist) (nreverse ans)))
                      (push
                       (meval
                        `(($ev) ,@(list (list '(mquote) form)
                                        (list '(mequal) arg m)))) ans)))
                (merror (intl:gettext "makelist: third argument must be a number or a list; found: ~M") b)))))
       ((= n 4)
        (setq form (first x))
        (setq arg (second x))
        (setq a (meval (third x)))
        (setq b (meval (fourth x)))
        (setq d ($float (meval `((mplus) ,b ((mtimes) ,a -1)))))
        (if (numberp d)
            (setq lv (interval2 a 1 d))
            (merror (intl:gettext "makelist: the fourth argument minus the third one must evaluate to a number; found: ~M") d)))
       ((= n 5)
        (setq form (first x))
        (setq arg (second x))
        (setq a (meval (third x)))
        (setq b (meval (fourth x)))
        (setq c (meval (fifth x)))
        (setq d ($float
                 (meval 
                  `((mtimes) ((mplus) ,b ((mtimes) ,a -1)) ((mexpt) ,c -1)))))
        (if (numberp d)
            (setq lv (interval2 a c d))
            (merror (intl:gettext "makelist: the fourth argument minus the third one, divided by the fifth one must evaluate to a number; found: ~M") d)))
       (t (merror (intl:gettext "makelist: maximum 5 arguments allowed; found: ~M.~%To create a list with sublists, use nested makelist commands.") n)))
    
     (return 
       (do ((lv lv (cdr lv))
	    (ans))
	   ((null lv) (cons '(mlist) (nreverse ans)))
	 (push (meval `(($ev)
			,@(list (list '(mquote) form)
				(list '(mequal) arg (car lv)))))
	       ans)))))

  
(defmspec $makelist (x)
  (setq x (cdr x))
  (prog (n form arg a b c d lv)
     (setq n (length x))
     (cond
       ((= n 0) (return '((mlist))))
       ((= n 1)
        (setq form (first x))
        (return
          `((mlist) ,(meval `(($ev) ,@(list (list '(mquote) form)))))))
       ((= n 2)
        (setq form (first x))
        (setq b ($float (meval (second x))))
        (if (numberp b)
            (return
              (do
               ((m 1 (1+ m)) (ans))
               ((> m b) (cons '(mlist) (nreverse ans)))
                (push (meval `(($ev) ,@(list (list '(mquote) form))))
                      ans)))
            (merror (intl:gettext "makelist: second argument must evaluate to a number; found: ~M") b)))
       ((= n 3)
        (setq form (first x))
        (setq arg (second x))
        (setq b (meval (third x)))
        (if ($listp b)
            (setq lv (mapcar #'(lambda (u) (list '(mquote) u)) (cdr b)))
	  (return(simple_makelist5 form arg 1 (meval b) 1))
   ))
       ((= n 4)
        (setq form (first x))
        (setq arg (second x))
        (setq a (meval (third x)))
        (setq b (meval (fourth x)))
        (setq d ($float (meval `((mplus) ,b ((mtimes) ,a -1)))))
        (if (not (numberp d))
            (merror (intl:gettext "makelist: the fourth argument minus the third one must evaluate to a number; found: ~M") d))
	(return (simple_makelist5 form arg a b 1)))
       ((= n 5)
        (setq form (first x))
        (setq arg (second x))
        (setq a (meval (third x)))
        (setq b (meval (fourth x)))
        (setq c (meval (fifth x)))
        (setq d ($float
                 (meval 
                  `((mtimes) ((mplus) ,b ((mtimes) ,a -1)) ((mexpt) ,c -1)))))
        (if (not(numberp d))
	  (merror (intl:gettext "makelist: the fourth argument minus the third one, divided by the fifth one must evaluate to a number; found: ~M") d))
	
	(return (simple_makelist5 form arg a b 1)))
       (t (merror (intl:gettext "makelist: maximum 5 arguments allowed; found: ~M.~%To create a list with sublists, use nested makelist commands.") n)))
    
     (return 
       (do ((lv lv (cdr lv))
	    (ans))
	   ((null lv) (cons '(mlist) (nreverse ans)))
	 (push (meval `(($ev)
			,@(list (list '(mquote) form)
				(list '(mequal) arg (car lv)))))
	       ans)))))

  (defun simple_makelist5 (form arg a b c)  ; a, b, numbers. arg is symbol.
      (progv (list arg) '(0)
	(do ((count a (+ c count))
	     (ans))
	    ((> count b) (cons '(mlist)(nreverse ans)))
	  (set arg count) ; this should be the counter. "set" is deprecated tho
	  (push (meval form) ans))))
    
