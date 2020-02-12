;;; -*- Mode: Lisp; package:maxima; syntax:common-lisp ;Base: 10 -*- ;;;
;;; Translated on: 2016-09-04 22:35:58-07:00
;;; Maxima version: branch_5_38_base_223_gcf9cbb2
;;; Lisp implementation: SBCL
;;; Lisp version: 1.3.0
(in-package :maxima)
;;** Translator flags were: **

;; transcompile: true;
;; tr_semicompile: false;
;; translate_fast_arrays: false;
;; tr_warn_undeclared: compile;
;; tr_warn_meval: compfile;
;; tr_warn_fexpr: compfile;
;; tr_warn_mode: all;
;; tr_warn_undefined_variable: all;
;; tr_function_call_default: general;
;; tr_array_as_ref: true;
;; tr_numer: false;
;; define_variable: false;

(SIMPLIFY ($LOAD '"zeilberger"))
(SIMPLIFY ($LOAD '"solve_rec/solve_rec"))
(SIMPLIFY ($LOAD '"simplifying.lisp"))
(SIMPLIFY ($LOAD '"opsubst"))
NIL
(SIMPLIFY ($PUT '$SIMPLIFY_SUM 1.0 '$VERSION))
(EVAL-WHEN (:COMPILE-TOPLEVEL :LOAD-TOPLEVEL :EXECUTE)
  (MEVAL* '(($MODEDECLARE) $ZEILBERGER_CHECK $BOOLEAN))
  (DEFPROP $ZEILBERGER_CHECK ASSIGN-MODE-CHECK ASSIGN)
  (DEF-MTRVAR $ZEILBERGER_CHECK T))
(EVAL-WHEN (:COMPILE-TOPLEVEL :LOAD-TOPLEVEL :EXECUTE)
  (MEVAL* '(($MODEDECLARE) $SUM_MIN $ANY))
  NIL
  (DEF-MTRVAR $SUM_MIN 0.))
(EVAL-WHEN (:COMPILE-TOPLEVEL :LOAD-TOPLEVEL :EXECUTE)
  (MEVAL* '(($MODEDECLARE) $USE_SIMPSUM $BOOLEAN))
  (DEFPROP $USE_SIMPSUM ASSIGN-MODE-CHECK ASSIGN)
  (DEF-MTRVAR $USE_SIMPSUM T))
(EVAL-WHEN (:COMPILE-TOPLEVEL :LOAD-TOPLEVEL :EXECUTE)
  (MEVAL* '(($MODEDECLARE) $USE_HARMONIC $BOOLEAN))
  (DEFPROP $USE_HARMONIC ASSIGN-MODE-CHECK ASSIGN)
  (DEF-MTRVAR $USE_HARMONIC T))
(EVAL-WHEN (:COMPILE-TOPLEVEL :LOAD-TOPLEVEL :EXECUTE)
  (MEVAL* '(($MODEDECLARE) $USE_INTEGRAL $BOOLEAN))
  (DEFPROP $USE_INTEGRAL ASSIGN-MODE-CHECK ASSIGN)
  (DEF-MTRVAR $USE_INTEGRAL T))
(EVAL-WHEN (:COMPILE-TOPLEVEL :LOAD-TOPLEVEL :EXECUTE)
  (MEVAL* '(($MODEDECLARE) $USE_GOSPER $BOOLEAN))
  (DEFPROP $USE_GOSPER ASSIGN-MODE-CHECK ASSIGN)
  (DEF-MTRVAR $USE_GOSPER T))
(EVAL-WHEN (:COMPILE-TOPLEVEL :LOAD-TOPLEVEL :EXECUTE)
  (MEVAL* '(($MODEDECLARE) $USE_RATFUN $BOOLEAN))
  (DEFPROP $USE_RATFUN ASSIGN-MODE-CHECK ASSIGN)
  (DEF-MTRVAR $USE_RATFUN T))
(EVAL-WHEN (:COMPILE-TOPLEVEL :LOAD-TOPLEVEL :EXECUTE)
  (MEVAL* '(($MODEDECLARE) $USE_ZEILBERGER $BOOLEAN))
  (DEFPROP $USE_ZEILBERGER ASSIGN-MODE-CHECK ASSIGN)
  (DEF-MTRVAR $USE_ZEILBERGER T))
(EVAL-WHEN (:COMPILE-TOPLEVEL :LOAD-TOPLEVEL :EXECUTE)
  (MEVAL* '(($MODEDECLARE) $USE_HYPERGEOMETRIC $BOOLEAN))
  (DEFPROP $USE_HYPERGEOMETRIC ASSIGN-MODE-CHECK ASSIGN)
  (DEF-MTRVAR $USE_HYPERGEOMETRIC T))
(EVAL-WHEN (:COMPILE-TOPLEVEL :LOAD-TOPLEVEL :EXECUTE)
  (MEVAL* '(($MODEDECLARE) $USE_TELESCOPING $BOOLEAN))
  (DEFPROP $USE_TELESCOPING ASSIGN-MODE-CHECK ASSIGN)
  (DEF-MTRVAR $USE_TELESCOPING T))
(EVAL-WHEN (:COMPILE-TOPLEVEL :LOAD-TOPLEVEL :EXECUTE)
  (MEVAL* '(($MODEDECLARE) $SIMPLIFY_SUM_DEPTH $FIXNUM))
  (DEFPROP $SIMPLIFY_SUM_DEPTH ASSIGN-MODE-CHECK ASSIGN)
  (DEF-MTRVAR $SIMPLIFY_SUM_DEPTH 0.))
(EVAL-WHEN (:COMPILE-TOPLEVEL :LOAD-TOPLEVEL :EXECUTE)
  (MEVAL* '(($MODEDECLARE) $SIMPLIFY_SUM_MAX_DEPTH $FIXNUM))
  (DEFPROP $SIMPLIFY_SUM_MAX_DEPTH ASSIGN-MODE-CHECK ASSIGN)
  (DEF-MTRVAR $SIMPLIFY_SUM_MAX_DEPTH 3.))
(EVAL-WHEN (:COMPILE-TOPLEVEL :LOAD-TOPLEVEL :EXECUTE)
  (MEVAL*
   '(($DECLARE
      (65. "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
       SRC))
     $SIMPLIFY_SUM $EVFUN)))
(EVAL-WHEN (:COMPILE-TOPLEVEL :LOAD-TOPLEVEL :EXECUTE)
  (MEVAL* '(($MODEDECLARE) $VERBOSE_LEVEL $FIXNUM))
  (DEFPROP $VERBOSE_LEVEL ASSIGN-MODE-CHECK ASSIGN)
  (DEF-MTRVAR $VERBOSE_LEVEL 0.))
(PROGN
 (DEFPROP $SS_PRINT_MESSAGE T TRANSLATED)
 (ADD2LNC '$SS_PRINT_MESSAGE $PROPS)
 (DEFMTRFUN ($SS_PRINT_MESSAGE $ANY MDEFINE T NIL)
      ($LEVEL $MESS)
    (DECLARE (SPECIAL $MESS $LEVEL))
    (COND
     ((TRP-NOT (IS-BOOLE-CHECK (MLSP (TRD-MSYMEVAL $VERBOSE_LEVEL 0.) $LEVEL)))
      (SIMPLIFY (MAPPLY-TR (TRD-MSYMEVAL $PRINT '$PRINT) $MESS))))
    ))
(PROGN
 (DEFPROP $SIMPLIFY_SUM T TRANSLATED)
 (ADD2LNC '$SIMPLIFY_SUM $PROPS)
 (DEFMTRFUN ($SIMPLIFY_SUM $ANY MDEFINE NIL NIL)
      ($EXPR)
    (DECLARE (SPECIAL $EXPR))
    (COND (($MAPATOM $EXPR) $EXPR)
          ((TRP-NOT
            (LIKE ($PART $EXPR 0.)
                  (SIMPLIFY ($NOUNIFY (TRD-MSYMEVAL $SUM '$SUM)))))
           (SIMPLIFY
            (MAP1 (GETOPR (TRD-MSYMEVAL $SIMPLIFY_SUM '$SIMPLIFY_SUM)) $EXPR)))
          ((AND
            (OR (LIKE ($PART $EXPR 3.) (*MMINUS (TRD-MSYMEVAL $INF '$INF)))
                (LIKE ($PART $EXPR 3.) (TRD-MSYMEVAL $MINF '$MINF)))
            (LIKE ($PART $EXPR 4.) (TRD-MSYMEVAL $INF '$INF)))
           ((LAMBDA ($SUMMAND $VAR_ $LO $HI)
              (DECLARE (SPECIAL $HI $LO $VAR_ $SUMMAND))
              (MSET
               '((MLIST
                  (94.
                   "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                   SRC))
                 $SUMMAND $VAR_ $LO $HI)
               (SIMPLIFY ($ARGS $EXPR)))
              (ADD*
               (SIMPLIFY
                (MFUNCTION-CALL $SIMPLIFY_SUM
                                (SIMPLIFY
                                 (MFUNCALL '$SUM $SUMMAND $VAR_ 0.
                                           (TRD-MSYMEVAL $INF '$INF)))))
               (SIMPLIFY
                (MFUNCTION-CALL $SIMPLIFY_SUM
                                (SIMPLIFY
                                 (MFUNCALL '$SUM
                                           (SIMPLIFY
                                            ($SUBSTITUTE
                                             (SIMPLIFY
                                              (LIST '(MEQUAL) $VAR_
                                                    (*MMINUS $VAR_)))
                                             $SUMMAND))
                                           $VAR_ 1.
                                           (TRD-MSYMEVAL $INF '$INF)))))))
            '$SUMMAND '$VAR_ '$LO '$HI))
          ((OR (LIKE ($PART $EXPR 3.) (*MMINUS (TRD-MSYMEVAL $INF '$INF)))
               (LIKE ($PART $EXPR 3.) (TRD-MSYMEVAL $MINF '$MINF)))
           (LIST '(MLIST) (TRD-MSYMEVAL $SUMMAND '$SUMMAND)
                 (TRD-MSYMEVAL $VAR_ '$VAR_) (TRD-MSYMEVAL $LO '$LO)
                 (TRD-MSYMEVAL $HI '$HI))
           (SIMPLIFY
            (MFUNCTION-CALL $SIMPLIFY_SUM
                            (SIMPLIFY
                             (MFUNCALL '$SUM
                                       (SIMPLIFY
                                        ($SUBSTITUTE
                                         (SIMPLIFY
                                          (LIST '(MEQUAL)
                                                (TRD-MSYMEVAL $VAR_ '$VAR_)
                                                (*MMINUS
                                                 (TRD-MSYMEVAL $VAR_ '$VAR_))))
                                         (TRD-MSYMEVAL $SUMMAND '$SUMMAND)))
                                       (TRD-MSYMEVAL $VAR_ '$VAR_)
                                       (*MMINUS (TRD-MSYMEVAL $HI '$HI))
                                       (TRD-MSYMEVAL $INF '$INF))))))
          ((LIKE
            ((LAMBDA ()
               ((LAMBDA (MCATCH)
                  (PROG2 NIL
                      (CATCH 'MCATCH
                        (PROGN
                         (SIMPLIFY
                          (SCANMAP1
                           (GETOPR
                            (M-TLAMBDA ($U)
                              (DECLARE (SPECIAL $U))
                              (COND
                               ((AND (NOT ($ATOM $U))
                                     ($MEMBER ($PART $U 0.)
                                              (LIST '(MLIST)
                                                    (TRD-MSYMEVAL %SIN '%SIN)
                                                    (TRD-MSYMEVAL %COS '%COS)
                                                    (TRD-MSYMEVAL %SINH '%SINH)
                                                    (TRD-MSYMEVAL %COSH
                                                                  '%COSH))))
                                ((LAMBDA (X)
                                   (COND
                                    ((NULL MCATCH) (DISPLA X)
                                     (MERROR
                                      (INTL:GETTEXT
                                       "throw: not within 'catch'."))))
                                   (THROW 'MCATCH X))
                                 T)))))
                           $EXPR (TRD-MSYMEVAL $BOTTOMUP '$BOTTOMUP)))))
                    (ERRLFUN1 MCATCH)))
                (CONS BINDLIST LOCLIST))))
            T)
           ((LAMBDA ($SM1)
              (DECLARE (SPECIAL $SM1))
              (COND
               ((IS-BOOLE-CHECK (SIMPLIFY (MFUNCTION-CALL $FREEOF_SUM $SM1)))
                (SIMPLIFY
                 (MFUNCTION-CALL $TRIGSIMP (SIMPLIFY ($RECTFORM $SM1)))))
               (T $EXPR)))
            (SIMPLIFY
             (MFUNCTION-CALL $SIMPLIFY_SUM
                             (SIMPLIFY
                              (MFUNCTION-CALL $SPLIT_SUM
                                              (SIMPLIFY
                                               ($EXPAND
                                                (SIMPLIFY
                                                 ($EXPONENTIALIZE
                                                  $EXPR))))))))))
          ((LIKE
            ((LAMBDA ()
               ((LAMBDA (MCATCH)
                  (PROG2 NIL
                      (CATCH 'MCATCH
                        (PROGN
                         (SIMPLIFY
                          (SCANMAP1
                           (GETOPR
                            (M-TLAMBDA ($U)
                              (DECLARE (SPECIAL $U))
                              (COND
                               ((AND (NOT ($ATOM $U))
                                     (LIKE ($PART $U 0.)
                                           (TRD-MSYMEVAL $FIB '$FIB)))
                                ((LAMBDA (X)
                                   (COND
                                    ((NULL MCATCH) (DISPLA X)
                                     (MERROR
                                      (INTL:GETTEXT
                                       "throw: not within 'catch'."))))
                                   (THROW 'MCATCH X))
                                 T)))))
                           $EXPR (TRD-MSYMEVAL $BOTTOMUP '$BOTTOMUP)))))
                    (ERRLFUN1 MCATCH)))
                (CONS BINDLIST LOCLIST))))
            T)
           ((LAMBDA ($SM1)
              (DECLARE (SPECIAL $SM1))
              (COND
               ((IS-BOOLE-CHECK (SIMPLIFY (MFUNCTION-CALL $FREEOF_SUM $SM1)))
                ((LAMBDA ($ALGEBRAIC)
                   (DECLARE (SPECIAL $ALGEBRAIC))
                   (SIMPLIFY ($RATSIMP $SM1)))
                 T))))
            (SIMPLIFY
             (MFUNCTION-CALL $SIMPLIFY_SUM
                             (SIMPLIFY
                              (MFUNCTION-CALL $SPLIT_SUM
                                              (SIMPLIFY
                                               ($EXPAND
                                                (SIMPLIFY
                                                 ($FIBTOPHI $EXPR))))))))))
          ((AND (NOT ($ATOM ($PART $EXPR 1.)))
                (LIKE ($PART $EXPR 1. 0.) (TRD-MSYMEVAL %LOG '%LOG))
                (TRP-NOT (LIKE ($PART $EXPR 3.) (TRD-MSYMEVAL $MINF '$MINF))))
           ((LAMBDA ($%UP $%SUB)
              (DECLARE (SPECIAL $%SUB $%UP))
              (COND
               ((LIKE ($PART $EXPR 4.) (TRD-MSYMEVAL $INF '$INF))
                (PROGN
                 (IF (NOT (BOUNDP '$%SUB))
                     (ADD2LNC '$%SUB $VALUES))
                 (SETQ $%SUB
                         (SIMPLIFY
                          (LIST '(%LOG)
                                (SIMPLIFY
                                 (MFUNCTION-CALL $SIMPLIFY_PRODUCT
                                                 (SIMPLIFY
                                                  (MFUNCALL
                                                   (TRD-MSYMEVAL $PRODUCT
                                                                 '$PRODUCT)
                                                   (SIMPLIFY
                                                    (LIST '(%EXP)
                                                          ($PART $EXPR 1.)))
                                                   ($PART $EXPR 2.)
                                                   ($PART $EXPR 3.)
                                                   $%UP))))))))
                (PROGN
                 (IF (NOT (BOUNDP '$%SUB))
                     (ADD2LNC '$%SUB $VALUES))
                 (SETQ $%SUB
                         (SIMPLIFY
                          ($LIMIT $%SUB $%UP (TRD-MSYMEVAL $INF '$INF)))))
                (COND
                 ((NOT
                   (AND ($FREEOF (TRD-MSYMEVAL $INF '$INF) $%SUB)
                        ($FREEOF (TRD-MSYMEVAL $MINF '$MINF) $%SUB)))
                  (SIMPLIFY ($ERROR '"Sum is divergent!")))
                 ((IS-BOOLE-CHECK
                   (SIMPLIFY (MFUNCTION-CALL $FREEOF_LIMIT $%SUB)))
                  $%SUB)
                 (T $EXPR)))
               (T
                (SIMPLIFY
                 (LIST '(%LOG)
                       (SIMPLIFY
                        (MFUNCTION-CALL $SIMPLIFY_PRODUCT
                                        (SIMPLIFY
                                         (MAPPLY-TR
                                          (TRD-MSYMEVAL $PRODUCT '$PRODUCT)
                                          ($CONS
                                           (SIMPLIFY
                                            (LIST '(%EXP) ($PART $EXPR 1.)))
                                           (SIMPLIFY
                                            ($REST
                                             (SIMPLIFY
                                              ($ARGS $EXPR))))))))))))))
            '$%UP '$%SUB))
          (T
           ((LAMBDA
                ($SIMPSUM $SUMMAND $VAR $LO $HI $SM1 $LINSOLVEWARN
                 $SIMPLIFY_SUM_DEPTH $SS_NEW_CONTEXT)
              (DECLARE
               (SPECIAL $SS_NEW_CONTEXT $SIMPLIFY_SUM_DEPTH $LINSOLVEWARN $SM1
                $HI $LO $VAR $SUMMAND $SIMPSUM))
              (ASSIGN-MODE-CHECK '$SIMPLIFY_SUM_DEPTH $SIMPLIFY_SUM_DEPTH)
              (PROG ()
                (COND
                 ((IS-BOOLE-CHECK
                   (MGRP $SIMPLIFY_SUM_DEPTH
                         (TRD-MSYMEVAL $SIMPLIFY_SUM_MAX_DEPTH 0.)))
                  (RETURN $EXPR)))
                (COND
                 (($MEMBER $SS_NEW_CONTEXT (TRD-MSYMEVAL $CONTEXTS '$CONTEXTS))
                  (SIMPLIFY ($KILLCONTEXT $SS_NEW_CONTEXT))))
                (SIMPLIFY (MFUNCTION-CALL $SUPCONTEXT $SS_NEW_CONTEXT))
                (COND
                 ((AND (TRP-NOT (LIKE $LO (TRD-MSYMEVAL $MINF '$MINF)))
                       (TRP-NOT
                        (LIKE $LO (*MMINUS (TRD-MSYMEVAL $INF '$INF)))))
                  (SIMPLIFY
                   (LIST '(MLIST)
                         (ASSUME (SIMPLIFY (LIST '(MGEQP) $VAR $LO)))))))
                (COND
                 ((TRP-NOT (LIKE $HI (TRD-MSYMEVAL $INF '$INF)))
                  (SIMPLIFY
                   (LIST '(MLIST)
                         (ASSUME (SIMPLIFY (LIST '(MLEQP) $VAR $HI)))))))
                (PROGN
                 (IF (NOT (BOUNDP '$SUMMAND))
                     (ADD2LNC '$SUMMAND $VALUES))
                 (SETQ $SUMMAND
                         (SIMPLIFY (MFUNCTION-CALL $SIMPLIFY_SUM $SUMMAND))))
                (SIMPLIFY ($KILLCONTEXT $SS_NEW_CONTEXT))
                (PROGN
                 (IF (NOT (BOUNDP '$EXPR))
                     (ADD2LNC '$EXPR $VALUES))
                 (SETQ $EXPR
                         (SIMPLIFY
                          ($INTOSUM
                           (SIMPLIFY
                            (MFUNCALL (TRD-MSYMEVAL $SUM '$SUM) $SUMMAND $VAR
                                      $LO $HI))))))
                (COND
                 ((LIKE (TRD-MSYMEVAL $USE_SIMPSUM NIL) T)
                  (SIMPLIFY
                   ($SS_PRINT_MESSAGE 1. '"Trying with simpsum=true ..."))
                  (PROGN
                   (IF (NOT (BOUNDP '$SM1))
                       (ADD2LNC '$SM1 $VALUES))
                   (SETQ $SM1
                           (MEVAL
                            '(($EV
                               (168.
                                "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                                SRC))
                              (($APPLY
                                (168.
                                 "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                                 SRC))
                               $SUM
                               ((MLIST
                                 (168.
                                  "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                                  SRC))
                                $SUMMAND $VAR $LO $HI))
                              ((MEQUAL
                                (168.
                                 "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                                 SRC))
                               $SIMPSUM T)))))
                  (SIMPLIFY
                   ($SS_PRINT_MESSAGE 1. '"sum with simpsum=true returns:"
                    $SM1))))
                (COND
                 ((AND (LIKE (TRD-MSYMEVAL $USE_HARMONIC NIL) T)
                       (NOT
                        (IS-BOOLE-CHECK
                         (SIMPLIFY (MFUNCTION-CALL $FREEOF_SUM $SM1))))
                       (TRP-NOT (LIKE $HI (TRD-MSYMEVAL $INF '$INF))))
                  ((LAMBDA ($A $B $HARMONIC_NUMBER_ARGS $HARMONIC_PART)
                     (DECLARE
                      (SPECIAL $HARMONIC_PART $HARMONIC_NUMBER_ARGS $B $A))
                     (COND
                      ((> ($LENGTH $HARMONIC_NUMBER_ARGS) 0.)
                       (PROGN
                        (IF (NOT (BOUNDP '$HARMONIC_PART))
                            (ADD2LNC '$HARMONIC_PART $VALUES))
                        (SETQ $HARMONIC_PART
                                (SIMPLIFY
                                 (MAPPLY-TR
                                  (TRD-MSYMEVAL $GEN_HARMONIC_NUMBER
                                                '$GEN_HARMONIC_NUMBER)
                                  (SIMPLIFY ($FIRST $HARMONIC_NUMBER_ARGS))))))
                       (MSET
                        '((MLIST
                           (176.
                            "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                            SRC))
                          $A $B)
                        (SIMPLIFY ($BOTHCOEF $SUMMAND $HARMONIC_PART)))
                       (SIMPLIFY
                        ($SS_PRINT_MESSAGE 1. '"Trying with sum_by_parts"))
                       (SIMPLIFY
                        ($SS_PRINT_MESSAGE 2. '"harmonic_number by parts"))
                       (SIMPLIFY ($SS_PRINT_MESSAGE 2. '"Coefficients" $A $B))
                       (COND
                        ((TRP-NOT (LIKE $A 0.))
                         (IF (NOT (BOUNDP '$SM1))
                             (ADD2LNC '$SM1 $VALUES))
                         (SETQ $SM1
                                 (ADD*
                                  (SIMPLIFY
                                   (MFUNCTION-CALL $SIMPLIFY_SUM
                                                   (SIMPLIFY
                                                    (MFUNCTION-CALL
                                                     $SUM_BY_PARTS
                                                     (ADD* $SUMMAND
                                                           (*MMINUS $B))
                                                     $A $VAR $LO $HI))))
                                  (SIMPLIFY
                                   (MFUNCTION-CALL $SIMPLIFY_SUM
                                                   (SIMPLIFY
                                                    (MFUNCALL '$SUM $B $VAR $LO
                                                              $HI))))))))))
                     (SIMPLIFY
                      ($SS_PRINT_MESSAGE 1. '"sum_by_parts returns" $SM1)))
                   '$A '$B
                   (SIMPLIFY
                    (MFUNCTION-CALL $GET_HARMONIC_NUMBER_ARGS $SUMMAND))
                   '$HARMONIC_PART)))
                (COND
                 ((AND (LIKE (TRD-MSYMEVAL $USE_INTEGRAL NIL) T)
                       (NOT
                        (IS-BOOLE-CHECK
                         (SIMPLIFY (MFUNCTION-CALL $FREEOF_SUM $SM1)))))
                  (SIMPLIFY
                   ($SS_PRINT_MESSAGE 1.
                    '"Trying with integral representation."))
                  (PROGN
                   (IF (NOT (BOUNDP '$SM1))
                       (ADD2LNC '$SM1 $VALUES))
                   (SETQ $SM1
                           (SIMPLIFY
                            (MFUNCTION-CALL $SUM_BY_INTEGRAL $SUMMAND $VAR $LO
                                            $HI))))
                  (SIMPLIFY
                   (MFUNCTION-CALL $SS_PRINT 1.
                                   '"Integral representation returns" $SM1))))
                (COND
                 ((LIKE
                   ((LAMBDA (ERRCATCH RET)
                      (DECLARE (SPECIAL ERRCATCH))
                      (COND
                       ((NULL
                         (SETQ RET
                                 (ERRSET
                                  (PROGN
                                   (COND
                                    ((AND (TRD-MSYMEVAL $USE_GOSPER NIL)
                                          (NOT ($ATOM $SM1))
                                          (NOT
                                           (IS-BOOLE-CHECK
                                            (SIMPLIFY
                                             (MFUNCTION-CALL $FREEOF_SUM
                                                             $SM1)))))
                                     ((LAMBDA ($HI1 $LO1)
                                        (DECLARE (SPECIAL $LO1 $HI1))
                                        (SIMPLIFY
                                         ($SS_PRINT_MESSAGE 1.
                                          '"Trying with Gosper ..."))
                                        (PROGN
                                         (IF (NOT (BOUNDP '$SM1))
                                             (ADD2LNC '$SM1 $VALUES))
                                         (SETQ $SM1
                                                 ((LAMBDA (^W)
                                                    (DECLARE (SPECIAL ^W))
                                                    (SIMPLIFY
                                                     (MFUNCTION-CALL $NUSUM
                                                                     $SUMMAND
                                                                     $VAR $LO1
                                                                     $HI1)))
                                                  T)))
                                        (COND
                                         ((IS-BOOLE-CHECK
                                           (SIMPLIFY
                                            (MFUNCTION-CALL $FREEOF_SUM $SM1)))
                                          (SIMPLIFY
                                           ($SS_PRINT_MESSAGE 1.
                                            '"Gosper returns:" $SM1))
                                          (COND
                                           ((OR
                                             (LIKE $LO
                                                   (TRD-MSYMEVAL $MINF '$MINF))
                                             (LIKE $LO
                                                   (*MMINUS
                                                    (TRD-MSYMEVAL $INF
                                                                  '$INF))))
                                            (IF (NOT (BOUNDP '$SM1))
                                                (ADD2LNC '$SM1 $VALUES))
                                            (SETQ $SM1
                                                    (SIMPLIFY
                                                     ($LIMIT $SM1 $LO1 $LO))))
                                           (T
                                            (IF (NOT (BOUNDP '$SM1))
                                                (ADD2LNC '$SM1 $VALUES))
                                            (SETQ $SM1
                                                    (SIMPLIFY
                                                     ($SUBSTITUTE
                                                      (SIMPLIFY
                                                       (LIST '(MEQUAL) $LO1
                                                             $LO))
                                                      $SM1)))))
                                          (COND
                                           ((LIKE $HI
                                                  (TRD-MSYMEVAL $INF '$INF))
                                            (IF (NOT (BOUNDP '$SM1))
                                                (ADD2LNC '$SM1 $VALUES))
                                            (SETQ $SM1
                                                    (SIMPLIFY
                                                     ($LIMIT $SM1 $HI1 $HI))))
                                           (T
                                            (IF (NOT (BOUNDP '$SM1))
                                                (ADD2LNC '$SM1 $VALUES))
                                            (SETQ $SM1
                                                    (SIMPLIFY
                                                     ($SUBSTITUTE
                                                      (SIMPLIFY
                                                       (LIST '(MEQUAL) $HI1
                                                             $HI))
                                                      $SM1)))))
                                          (COND
                                           ((OR
                                             (NOT
                                              (IS-BOOLE-CHECK
                                               (SIMPLIFY
                                                (MFUNCTION-CALL $FREEOF_LIMIT
                                                                $SM1))))
                                             (NOT ($FREEOF '$UND $SM1)))
                                            (IF (NOT (BOUNDP '$SM1))
                                                (ADD2LNC '$SM1 $VALUES))
                                            (SETQ $SM1 $EXPR))))
                                         (T
                                          (IF (NOT (BOUNDP '$SM1))
                                              (ADD2LNC '$SM1 $VALUES))
                                          (SETQ $SM1 $EXPR))))
                                      (SIMPLIFY (MFUNCTION-CALL GENSYM))
                                      (SIMPLIFY (MFUNCTION-CALL GENSYM))))))
                                  LISPERRPRINT)))
                        (ERRLFUN1 ERRCATCH)))
                      (CONS '(MLIST) RET))
                    (CONS BINDLIST LOCLIST) NIL)
                   '((MLIST)))
                  (IF (NOT (BOUNDP '$SM1))
                      (ADD2LNC '$SM1 $VALUES))
                  (SETQ $SM1 $EXPR)))
                (COND
                 ((LIKE
                   ((LAMBDA (ERRCATCH RET)
                      (DECLARE (SPECIAL ERRCATCH))
                      (COND
                       ((NULL
                         (SETQ RET
                                 (ERRSET
                                  (PROGN
                                   (COND
                                    ((AND (TRD-MSYMEVAL $USE_GOSPER NIL)
                                          (NOT ($ATOM $SM1))
                                          (NOT
                                           (IS-BOOLE-CHECK
                                            (SIMPLIFY
                                             (MFUNCTION-CALL $FREEOF_SUM
                                                             $SM1)))))
                                     ((LAMBDA ($HI1 $LO1)
                                        (DECLARE (SPECIAL $LO1 $HI1))
                                        (SIMPLIFY
                                         ($SS_PRINT_MESSAGE 1.
                                          '"Trying with extended Gosper ..."))
                                        (PROGN
                                         (IF (NOT (BOUNDP '$SM1))
                                             (ADD2LNC '$SM1 $VALUES))
                                         (SETQ $SM1
                                                 ((LAMBDA (^W)
                                                    (DECLARE (SPECIAL ^W))
                                                    (SIMPLIFY
                                                     (MFUNCTION-CALL
                                                      $EXTENDED_NUSUM $SUMMAND
                                                      $VAR $LO1 $HI1)))
                                                  T)))
                                        (COND
                                         ((IS-BOOLE-CHECK
                                           (SIMPLIFY
                                            (MFUNCTION-CALL $FREEOF_SUM $SM1)))
                                          (SIMPLIFY
                                           ($SS_PRINT_MESSAGE 1.
                                            '"Extended Gosper returns:" $SM1))
                                          (COND
                                           ((OR
                                             (LIKE $LO
                                                   (TRD-MSYMEVAL $MINF '$MINF))
                                             (LIKE $LO
                                                   (*MMINUS
                                                    (TRD-MSYMEVAL $INF
                                                                  '$INF))))
                                            (IF (NOT (BOUNDP '$SM1))
                                                (ADD2LNC '$SM1 $VALUES))
                                            (SETQ $SM1
                                                    (SIMPLIFY
                                                     ($LIMIT $SM1 $LO1 $LO))))
                                           (T
                                            (IF (NOT (BOUNDP '$SM1))
                                                (ADD2LNC '$SM1 $VALUES))
                                            (SETQ $SM1
                                                    (SIMPLIFY
                                                     ($SUBSTITUTE
                                                      (SIMPLIFY
                                                       (LIST '(MEQUAL) $LO1
                                                             $LO))
                                                      $SM1)))))
                                          (COND
                                           ((LIKE $HI
                                                  (TRD-MSYMEVAL $INF '$INF))
                                            (IF (NOT (BOUNDP '$SM1))
                                                (ADD2LNC '$SM1 $VALUES))
                                            (SETQ $SM1
                                                    (SIMPLIFY
                                                     ($LIMIT $SM1 $HI1 $HI))))
                                           (T
                                            (IF (NOT (BOUNDP '$SM1))
                                                (ADD2LNC '$SM1 $VALUES))
                                            (SETQ $SM1
                                                    (SIMPLIFY
                                                     ($SUBSTITUTE
                                                      (SIMPLIFY
                                                       (LIST '(MEQUAL) $HI1
                                                             $HI))
                                                      $SM1)))))
                                          (COND
                                           ((NOT
                                             (IS-BOOLE-CHECK
                                              (SIMPLIFY
                                               (MFUNCTION-CALL $FREEOF_LIMIT
                                                               $SM1))))
                                            (IF (NOT (BOUNDP '$SM1))
                                                (ADD2LNC '$SM1 $VALUES))
                                            (SETQ $SM1 $EXPR))))
                                         (T
                                          (IF (NOT (BOUNDP '$SM1))
                                              (ADD2LNC '$SM1 $VALUES))
                                          (SETQ $SM1 $EXPR))))
                                      (SIMPLIFY (MFUNCTION-CALL GENSYM))
                                      (SIMPLIFY (MFUNCTION-CALL GENSYM))))))
                                  LISPERRPRINT)))
                        (ERRLFUN1 ERRCATCH)))
                      (CONS '(MLIST) RET))
                    (CONS BINDLIST LOCLIST) NIL)
                   '((MLIST)))
                  (IF (NOT (BOUNDP '$SM1))
                      (ADD2LNC '$SM1 $VALUES))
                  (SETQ $SM1 $EXPR)))
                (COND
                 ((AND (TRD-MSYMEVAL $USE_RATFUN NIL) (NOT ($ATOM $SM1))
                       (NOT
                        (IS-BOOLE-CHECK
                         (SIMPLIFY (MFUNCTION-CALL $FREEOF_SUM $SM1))))
                       (IS-BOOLE-CHECK (SIMPLIFY (RATP $SUMMAND $VAR))))
                  ((LAMBDA ($RATFUN $EXPR1)
                     (DECLARE (SPECIAL $EXPR1 $RATFUN))
                     (SIMPLIFY
                      ($SS_PRINT_MESSAGE 1. '"Trying ratfun -> psi ..."))
                     (PROGN
                      (IF (NOT (BOUNDP '$RATFUN))
                          (ADD2LNC '$RATFUN $VALUES))
                      (SETQ $RATFUN ($PART $EXPR1 1.)))
                     (COND
                      ((AND (LIKE $HI (TRD-MSYMEVAL $INF '$INF))
                            (IS-BOOLE-CHECK
                             (MGRP (SIMPLIFY ($HIPOW ($NUM $RATFUN) $VAR))
                                   (ADD*
                                    (SIMPLIFY ($HIPOW ($DENOM $RATFUN) $VAR))
                                    -2.))))
                       (SIMPLIFY ($ERROR '"Sum is divergent!"))))
                     (PROGN
                      (IF (NOT (BOUNDP '$POLYPART))
                          (ADD2LNC '$POLYPART $VALUES))
                      (SETQ $POLYPART
                              (SIMPLIFY
                               ($FIRST
                                (SIMPLIFY
                                 ($DIVIDE ($NUM $RATFUN) ($DENOM $RATFUN)
                                          $VAR))))))
                     (PROGN
                      (IF (NOT (BOUNDP '$EXPR1))
                          (ADD2LNC '$EXPR1 $VALUES))
                      (SETQ $EXPR1
                              (SIMPLIFY
                               ($INTOSUM
                                (SIMPLIFY
                                 (PART1
                                  (LIST
                                   (LIST '(MQUOTE SIMP)
                                         (SIMPLIFY
                                          ($RATSIMP
                                           (ADD* $RATFUN
                                                 (*MMINUS
                                                  (TRD-MSYMEVAL $POLYPART
                                                                '$POLYPART))))))
                                   (LIST '(MQUOTE SIMP) $EXPR1)
                                   (LIST '(MQUOTE SIMP) 1.))
                                  T NIL $INFLAG))))))
                     (SIMPLIFY
                      ($SS_PRINT_MESSAGE 3. '"Polynomial part"
                       (TRD-MSYMEVAL $POLYPART '$POLYPART)))
                     (SIMPLIFY
                      ($SS_PRINT_MESSAGE 3. '"Without polynomial part" $EXPR1))
                     (PROGN
                      (IF (NOT (BOUNDP '$SM1))
                          (ADD2LNC '$SM1 $VALUES))
                      (SETQ $SM1
                              (SIMPLIFY
                               (MFUNCTION-CALL $SIMPLIFY_SUM
                                               (SIMPLIFY
                                                (MFUNCALL
                                                 (TRD-MSYMEVAL $SUM '$SUM)
                                                 (TRD-MSYMEVAL $POLYPART
                                                               '$POLYPART)
                                                 $VAR $LO $HI))))))
                     (SIMPLIFY
                      ($SS_PRINT_MESSAGE 4. '"Polynomial part contributes"
                       $SM1))
                     (PROGN
                      (IF (NOT (BOUNDP '$RATFUN))
                          (ADD2LNC '$RATFUN $VALUES))
                      (SETQ $RATFUN ($PART $EXPR1 1.)))
                     (PROGN
                      (IF (NOT (BOUNDP '$SM1))
                          (ADD2LNC '$SM1 $VALUES))
                      (SETQ $SM1
                              (ADD* $SM1
                                    (SIMPLIFY
                                     (MFUNCTION-CALL $RATFUN_TO_PSI $RATFUN
                                                     $VAR $LO $HI))))))
                   '$RATFUN $EXPR)))
                (COND
                 ((AND (TRD-MSYMEVAL $USE_RATFUN NIL) (NOT ($ATOM $SM1))
                       (NOT
                        (IS-BOOLE-CHECK
                         (SIMPLIFY (MFUNCTION-CALL $FREEOF_SUM $SM1))))
                       (IS-BOOLE-CHECK
                        (SIMPLIFY
                         (RATP
                          (SIMPLIFY ($RATSIMP (DIV $SUMMAND (POWER -1. $VAR))))
                          $VAR)))
                       (LIKE $HI (TRD-MSYMEVAL $INF '$INF)))
                  ((LAMBDA ($RATFUN $NEW_VAR $EXPR1)
                     (DECLARE (SPECIAL $EXPR1 $NEW_VAR $RATFUN))
                     (SIMPLIFY
                      ($SS_PRINT_MESSAGE 1. '"Trying ratfun -> psi ..."))
                     (PROGN
                      (IF (NOT (BOUNDP '$EXPR1))
                          (ADD2LNC '$EXPR1 $VALUES))
                      (SETQ $EXPR1
                              (SIMPLIFY
                               ($INTOSUM
                                (SIMPLIFY
                                 ($CHANGEVAR $EXPR
                                             (SIMPLIFY
                                              (LIST '(MEQUAL) $NEW_VAR
                                                    (ADD* $VAR (*MMINUS $LO)
                                                          1.)))
                                             $NEW_VAR $VAR))))))
                     (PROGN
                      (IF (NOT (BOUNDP '$RATFUN))
                          (ADD2LNC '$RATFUN $VALUES))
                      (SETQ $RATFUN
                              (DIV ($PART $EXPR1 1.) (POWER -1. $NEW_VAR))))
                     (COND
                      ((TRP-NOT
                        (IS-BOOLE-CHECK
                         (MGRP (SIMPLIFY ($HIPOW ($NUM $RATFUN) $NEW_VAR))
                               (ADD*
                                (SIMPLIFY ($HIPOW ($DENOM $RATFUN) $NEW_VAR))
                                -1.))))
                       (IF (NOT (BOUNDP '$SM1))
                           (ADD2LNC '$SM1 $VALUES))
                       (SETQ $SM1
                               (ADD*
                                (SIMPLIFY
                                 (MFUNCTION-CALL $RATFUN_TO_PSI
                                                 (SIMPLIFY
                                                  ($SUBSTITUTE
                                                   (SIMPLIFY
                                                    (LIST '(MEQUAL) $NEW_VAR
                                                          (MUL* 2. $NEW_VAR)))
                                                   $RATFUN))
                                                 $NEW_VAR 1.
                                                 (TRD-MSYMEVAL $INF '$INF)))
                                (*MMINUS
                                 (SIMPLIFY
                                  (MFUNCTION-CALL $RATFUN_TO_PSI
                                                  (SIMPLIFY
                                                   ($SUBSTITUTE
                                                    (SIMPLIFY
                                                     (LIST '(MEQUAL) $NEW_VAR
                                                           (ADD*
                                                            (MUL* 2. $NEW_VAR)
                                                            -1.)))
                                                    $RATFUN))
                                                  $NEW_VAR 1.
                                                  (TRD-MSYMEVAL $INF
                                                                '$INF)))))))
                      (T
                       (IF (NOT (BOUNDP '$SM1))
                           (ADD2LNC '$SM1 $VALUES))
                       (SETQ $SM1 (TRD-MSYMEVAL $UND '$UND)))))
                   '$RATFUN (SIMPLIFY (MFUNCTION-CALL GENSYM)) '$EXPR1)))
                (SIMPLIFY (MFUNCTION-CALL $SUPCONTEXT $SS_NEW_CONTEXT))
                (COND
                 ((LIKE
                   ((LAMBDA (ERRCATCH RET)
                      (DECLARE (SPECIAL ERRCATCH))
                      (COND
                       ((NULL
                         (SETQ RET
                                 (ERRSET
                                  (PROGN
                                   (COND
                                    ((AND (TRD-MSYMEVAL $USE_ZEILBERGER NIL)
                                          (NOT ($ATOM $SM1))
                                          (NOT
                                           (IS-BOOLE-CHECK
                                            (SIMPLIFY
                                             (MFUNCTION-CALL $FREEOF_SUM
                                                             $SM1)))))
                                     ((LAMBDA ($SUMMAND $VAR $LO $HI $NV $SUPP)
                                        (DECLARE
                                         (SPECIAL $SUPP $NV $HI $LO $VAR
                                          $SUMMAND))
                                        (SIMPLIFY
                                         ($SS_PRINT_MESSAGE 1.
                                          '"Trying with Zeilberger ..."))
                                        (SIMPLIFY
                                         (LIST '(MLIST)
                                               (ASSUME
                                                (SIMPLIFY
                                                 (LIST '(MGREATERP) $VAR
                                                       $LO)))))
                                        (SIMPLIFY
                                         (LIST '(MLIST)
                                               (ASSUME
                                                (SIMPLIFY
                                                 (LIST '(MLESSP) $VAR $HI)))))
                                        (PROGN
                                         (IF (NOT (BOUNDP '$SUPPORT))
                                             (ADD2LNC '$SUPPORT $VALUES))
                                         (SETQ $SUPPORT
                                                 (SIMPLIFY
                                                  (MFUNCTION-CALL $SS_SUPPORT
                                                                  $SUMMAND
                                                                  $VAR))))
                                        (COND
                                         ((AND
                                           ($ATOM
                                            (MARRAYREF
                                             (TRD-MSYMEVAL $SUPPORT '$SUPPORT)
                                             1.))
                                           (TRP-NOT
                                            (LIKE
                                             (MARRAYREF
                                              (TRD-MSYMEVAL $SUPPORT '$SUPPORT)
                                              1.)
                                             (TRD-MSYMEVAL $MINF '$MINF))))
                                          (MSET
                                           '((MLIST
                                              (273.
                                               "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                                               SRC))
                                             $SUMMAND $VAR $LO $HI)
                                           (SIMPLIFY
                                            ($ARGS
                                             (SIMPLIFY
                                              ($INTOSUM
                                               (SIMPLIFY
                                                ($CHANGEVAR
                                                 (SIMPLIFY
                                                  (MFUNCALL '$SUM $SUMMAND $VAR
                                                            $LO $HI))
                                                 (SIMPLIFY
                                                  (LIST '(MEQUAL) $NV
                                                        (ADD* $VAR
                                                              (*MMINUS
                                                               (MARRAYREF
                                                                (TRD-MSYMEVAL
                                                                 $SUPPORT
                                                                 '$SUPPORT)
                                                                1.))
                                                              (TRD-MSYMEVAL
                                                               $SUM_MIN
                                                               '$SUM_MIN))))
                                                 $NV $VAR))))))))
                                         ((TRP-NOT
                                           (LIKE $LO
                                                 (TRD-MSYMEVAL $SUM_MIN
                                                               '$SUM_MIN)))
                                          (MSET
                                           '((MLIST
                                              (277.
                                               "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                                               SRC))
                                             $SUMMAND $VAR $LO $HI)
                                           (SIMPLIFY
                                            ($ARGS
                                             (SIMPLIFY
                                              ($INTOSUM
                                               (SIMPLIFY
                                                ($CHANGEVAR
                                                 (SIMPLIFY
                                                  (MFUNCALL '$SUM $SUMMAND $VAR
                                                            $LO $HI))
                                                 (SIMPLIFY
                                                  (LIST '(MEQUAL) $NV
                                                        (ADD* $VAR
                                                              (*MMINUS $LO)
                                                              (TRD-MSYMEVAL
                                                               $SUM_MIN
                                                               '$SUM_MIN))))
                                                 $NV $VAR)))))))))
                                        (PROGN
                                         (IF (NOT (BOUNDP '$SM1))
                                             (ADD2LNC '$SM1 $VALUES))
                                         (SETQ $SM1
                                                 (SIMPLIFY
                                                  (MFUNCTION-CALL $SS_ZEILB
                                                                  $SUMMAND $VAR
                                                                  $LO $HI))))
                                        (SIMPLIFY
                                         ($SS_PRINT_MESSAGE 1.
                                          '"Zeilberger method returns:" $SM1)))
                                      $SUMMAND $VAR $LO $HI
                                      (SIMPLIFY (MFUNCTION-CALL $GENSYM))
                                      '$SUPP))))
                                  LISPERRPRINT)))
                        (ERRLFUN1 ERRCATCH)))
                      (CONS '(MLIST) RET))
                    (CONS BINDLIST LOCLIST) NIL)
                   '((MLIST)))
                  (IF (NOT (BOUNDP '$SM1))
                      (ADD2LNC '$SM1 $VALUES))
                  (SETQ $SM1 $EXPR)))
                (SIMPLIFY ($KILLCONTEXT $SS_NEW_CONTEXT))
                (COND
                 ((LIKE $SM1 NIL)
                  (IF (NOT (BOUNDP '$SM1))
                      (ADD2LNC '$SM1 $VALUES))
                  (SETQ $SM1 $EXPR)))
                (COND
                 ((AND (NOT ($ATOM $SM1))
                       (NOT
                        (IS-BOOLE-CHECK
                         (SIMPLIFY (MFUNCTION-CALL $FREEOF_SUM $SM1))))
                       (LIKE (TRD-MSYMEVAL $USE_HYPERGEOMETRIC NIL) T)
                       (LIKE $HI (TRD-MSYMEVAL $INF '$INF))
                       (TRP-NOT (LIKE $LO (*MMINUS (TRD-MSYMEVAL $INF '$INF))))
                       (TRP-NOT (LIKE $LO (TRD-MSYMEVAL $MINF '$MINF))))
                  (SIMPLIFY
                   ($SS_PRINT_MESSAGE 1.
                    '"Converting to hypergeometrical sum ..."))
                  (PROGN
                   (IF (NOT (BOUNDP '$SM1))
                       (ADD2LNC '$SM1 $VALUES))
                   (SETQ $SM1
                           (SIMPLIFY
                            (MFUNCTION-CALL $TO_HYPERGEOMETRIC $SUMMAND $VAR
                                            $LO $HI))))
                  (SIMPLIFY
                   ($SS_PRINT_MESSAGE 1. '"hgfred method returns:" $SM1))))
                (COND
                 ((LIKE $SM1 NIL)
                  (IF (NOT (BOUNDP '$SM1))
                      (ADD2LNC '$SM1 $VALUES))
                  (SETQ $SM1 $EXPR)))
                (COND
                 ((AND (NOT ($ATOM $SM1))
                       (NOT
                        (IS-BOOLE-CHECK
                         (SIMPLIFY (MFUNCTION-CALL $FREEOF_SUM $SM1))))
                       (LIKE (TRD-MSYMEVAL $USE_TELESCOPING NIL) T))
                  (SIMPLIFY
                   (MFUNCTION-CALL $SS_PRIMT_MESSAGE 1.
                                   '"Using telescoping ..."))
                  (PROGN
                   (IF (NOT (BOUNDP '$SM1))
                       (ADD2LNC '$SM1 $VALUES))
                   (SETQ $SM1
                           (SIMPLIFY
                            (MFUNCTION-CALL $TELESCOPING_SUM $SUMMAND $VAR $LO
                                            $HI))))
                  (SIMPLIFY
                   (MFUNCTION-CALL $SS_PRIMT_SEMMACE 1.
                                   '"telescoping method returns:" $SM1))))
                (COND
                 ((LIKE $SM1 NIL)
                  (IF (NOT (BOUNDP '$SM1))
                      (ADD2LNC '$SM1 $VALUES))
                  (SETQ $SM1 $EXPR)))
                (RETURN $SM1)))
            NIL (SIMPLIFY ($RATSIMP ($PART $EXPR 1.))) ($PART $EXPR 2.)
            ($PART $EXPR 3.) ($PART $EXPR 4.) $EXPR NIL
            (+ (TRD-MSYMEVAL $SIMPLIFY_SUM_DEPTH 0.) 1.)
            (SIMPLIFY
             (MFUNCTION-CALL $CONCAT '$SS_CONTEXT
                             (TRD-MSYMEVAL $SIMPLIFY_SUM_DEPTH 0.))))))
    ))
(PROGN
 (DEFPROP $FREEOF_SUM T TRANSLATED)
 (ADD2LNC '$FREEOF_SUM $PROPS)
 (DEFMTRFUN ($FREEOF_SUM $ANY MDEFINE NIL NIL)
      ($EXPR)
    (DECLARE (SPECIAL $EXPR))
    (COND (($ATOM $EXPR) T)
          ((LIKE ($PART $EXPR 0.)
                 (SIMPLIFY ($NOUNIFY (TRD-MSYMEVAL $SUM '$SUM))))
           NIL)
          ((LIKE $EXPR '((MLIST))) T)
          (T
           (SIMPLIFY
            (MFUNCTION-CALL $XREDUCE '"and"
                            (SIMPLIFY
                             (MAP1
                              (GETOPR (TRD-MSYMEVAL $FREEOF_SUM '$FREEOF_SUM))
                              (SIMPLIFY ($ARGS $EXPR))))))))
    ))
(PROGN
 (DEFPROP $FREEOF_INTEGRATE T TRANSLATED)
 (ADD2LNC '$FREEOF_INTEGRATE $PROPS)
 (DEFMTRFUN ($FREEOF_INTEGRATE $ANY MDEFINE NIL NIL)
      ($EXPR)
    (DECLARE (SPECIAL $EXPR))
    (COND (($ATOM $EXPR) T)
          ((LIKE ($PART $EXPR 0.)
                 (SIMPLIFY ($NOUNIFY (TRD-MSYMEVAL $INTEGRATE '$INTEGRATE))))
           NIL)
          ((LIKE $EXPR '((MLIST))) T)
          (T
           (SIMPLIFY
            (MFUNCTION-CALL $XREDUCE '"and"
                            (SIMPLIFY
                             (MAP1
                              (GETOPR
                               (TRD-MSYMEVAL $FREEOF_INTEGRATE
                                             '$FREEOF_INTEGRATE))
                              (SIMPLIFY ($ARGS $EXPR))))))))
    ))
(PROGN
 (DEFPROP $FREEOF_LIMIT T TRANSLATED)
 (ADD2LNC '$FREEOF_LIMIT $PROPS)
 (DEFMTRFUN ($FREEOF_LIMIT $ANY MDEFINE NIL NIL)
      ($EXPR)
    (DECLARE (SPECIAL $EXPR))
    (COND (($ATOM $EXPR) T)
          ((LIKE ($PART $EXPR 0.)
                 (SIMPLIFY ($NOUNIFY (TRD-MSYMEVAL $LIMIT '$LIMIT))))
           NIL)
          ((LIKE $EXPR '((MLIST))) T)
          (T
           (SIMPLIFY
            (MFUNCTION-CALL $XREDUCE '"and"
                            (SIMPLIFY
                             (MAP1
                              (GETOPR
                               (TRD-MSYMEVAL $FREEOF_LIMIT '$FREEOF_LIMIT))
                              (SIMPLIFY ($ARGS $EXPR))))))))
    ))
(PROGN
 (DEFPROP $SS_LINEARP T TRANSLATED)
 (ADD2LNC '$SS_LINEARP $PROPS)
 (DEFMTRFUN ($SS_LINEARP $ANY MDEFINE NIL NIL)
      ($EXPR $VAR)
    (DECLARE (SPECIAL $VAR $EXPR))
    ((LAMBDA ($A $B)
       (DECLARE (SPECIAL $B $A))
       (MSET
        '((MLIST
           (351.
            "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
            SRC))
          $A $B)
        (SIMPLIFY ($BOTHCOEF (SIMPLIFY ($EXPAND $EXPR)) $VAR)))
       (COND ((AND ($FREEOF $VAR $A) ($FREEOF $VAR $B)) (LIST '(MLIST) $A $B))
             (T '((MLIST)))))
     '$A '$B)
    ))
(PROGN
 (DEFPROP $FIND_COEFFS T TRANSLATED)
 (ADD2LNC '$FIND_COEFFS $PROPS)
 (DEFMTRFUN ($FIND_COEFFS $ANY MDEFINE NIL NIL)
      ($EXPR $VAR)
    (DECLARE (SPECIAL $VAR $EXPR))
    ((LAMBDA ($COEFFS)
       (DECLARE (SPECIAL $COEFFS))
       (PROGN
        (IF (NOT (BOUNDP '$COEFFS))
            (ADD2LNC '$COEFFS $VALUES))
        (SETQ $COEFFS (SIMPLIFY ($SS_LINEARP $EXPR $VAR))))
       (COND
        ((LIKE $COEFFS '((MLIST)))
         (COND
          (($MEMBER ($PART $EXPR 0.)
                    (LIST '(MLIST) '"+" '"-" '"*" '"/"
                          (TRD-MSYMEVAL %GAMMA '%GAMMA) '"!"
                          (TRD-MSYMEVAL %BINOMIAL '%BINOMIAL)))
           (SIMPLIFY
            (MAPPLY-TR (TRD-MSYMEVAL $APPEND '$APPEND)
                       (SIMPLIFY
                        (MAP1
                         (GETOPR
                          (M-TLAMBDA&ENV (($E) ($VAR))
                            (DECLARE (SPECIAL $E))
                            (SIMPLIFY (MFUNCTION-CALL $FIND_COEFFS $E $VAR))))
                         (SIMPLIFY ($ARGS $EXPR)))))))
          ((AND (LIKE ($PART $EXPR 0.) '"^") ($FREEOF $VAR ($PART $EXPR 2.)))
           (SIMPLIFY (MFUNCTION-CALL $FIND_COEFFS ($PART $EXPR 1.) $VAR)))
          ((AND (LIKE ($PART $EXPR 0.) '"^") ($FREEOF $VAR ($PART $EXPR 1.)))
           (SIMPLIFY (MFUNCTION-CALL $FIND_COEFFS ($PART $EXPR 2.) $VAR)))
          (T (SIMPLIFY ($ERROR)))))
        (T (LIST '(MLIST) (MARRAYREF $COEFFS 1.)))))
     '$COEFFS)
    ))
(PROGN
 (DEFPROP $FIND_MFOLD T TRANSLATED)
 (ADD2LNC '$FIND_MFOLD $PROPS)
 (DEFMTRFUN ($FIND_MFOLD $ANY MDEFINE NIL NIL)
      ($EXPR $VAR)
    (DECLARE (SPECIAL $VAR $EXPR))
    ((LAMBDA ($COEFFS)
       (DECLARE (SPECIAL $COEFFS))
       (PROGN
        (IF (NOT (BOUNDP '$COEFFS))
            (ADD2LNC '$COEFFS $VALUES))
        (SETQ $COEFFS
                (SIMPLIFY
                 (MAP1 (GETOPR (TRD-MSYMEVAL $DENOM '$DENOM)) $COEFFS))))
       (SIMPLIFY
        (MFUNCTION-CALL $XREDUCE
                        (M-TLAMBDA ($A $B)
                          (DECLARE (SPECIAL $B $A))
                          (DIV (MUL* $A $B) (SIMPLIFY ($GCD $A $B))))
                        $COEFFS)))
     (SIMPLIFY ($FIND_COEFFS $EXPR $VAR)))
    ))
(PROGN
 (DEFPROP $EXTENDED_NUSUM T TRANSLATED)
 (ADD2LNC '$EXTENDED_NUSUM $PROPS)
 (DEFMTRFUN ($EXTENDED_NUSUM $ANY MDEFINE NIL NIL)
      ($EXPR $VAR $LO $HI)
    (DECLARE (SPECIAL $HI $LO $VAR $EXPR))
    ((LAMBDA ($%M% $EXPRM $TK $SK)
       (DECLARE (SPECIAL $SK $TK $EXPRM $%M%))
       (PROGN
        (IF (NOT (BOUNDP '$EXPRM))
            (ADD2LNC '$EXPRM $VALUES))
        (SETQ $EXPRM
                (SIMPLIFY
                 ($SUBSTITUTE (SIMPLIFY (LIST '(MEQUAL) $VAR (MUL* $%M% $VAR)))
                              $EXPR))))
       (PROGN
        (IF (NOT (BOUNDP '$TK))
            (ADD2LNC '$TK $VALUES))
        (SETQ $TK (SIMPLIFY (MFUNCTION-CALL $NUSUM $EXPRM $VAR 1. $VAR))))
       (COND
        ((NOT (IS-BOOLE-CHECK (SIMPLIFY ($FREEOF_SUM $TK))))
         (SIMPLIFY ($ERROR))))
       (PROGN
        (IF (NOT (BOUNDP '$SK))
            (ADD2LNC '$SK $VALUES))
        (SETQ $SK
                (SIMPLIFY
                 ($SUBSTITUTE (SIMPLIFY (LIST '(MEQUAL) $VAR (DIV $VAR $%M%)))
                              $TK))))
       (ADD*
        (SIMPLIFY (MFUNCALL '$SUM $SK $VAR (ADD* $HI (*MMINUS $%M%) 1.) $HI))
        (*MMINUS
         (SIMPLIFY
          (MFUNCALL '$SUM $SK $VAR (ADD* $LO (*MMINUS $%M%))
                    (ADD* $LO -1.))))))
     (SIMPLIFY ($FIND_MFOLD $EXPR $VAR)) '$EXPRM '$TK '$SK)
    ))
(PROGN
 (DEFPROP $SS_ZEILB T TRANSLATED)
 (ADD2LNC '$SS_ZEILB $PROPS)
 (DEFMTRFUN ($SS_ZEILB $ANY MDEFINE T NIL)
      ($EXPR $%K% $LO $HI $IN_ZR)
    (DECLARE (SPECIAL $IN_ZR $HI $LO $%K% $EXPR))
    ((LAMBDA
         ($VARS $%N% $EQ $SM $ZB $DEG $COND $EQ_RHS $CERT $%I% $EXPR1 $IHOM
          $SUPPORT $SUM_MIN $UPPER_BOUND_IMPLICIT $LOWER_BOUND_IMPLICIT
          $SOLVE_REC_WARN $WARNINGS |$Gosper_in_Zeilberger| $CONT)
       (DECLARE
        (SPECIAL $CONT |$Gosper_in_Zeilberger| $WARNINGS $SOLVE_REC_WARN
         $LOWER_BOUND_IMPLICIT $UPPER_BOUND_IMPLICIT $SUM_MIN $SUPPORT $IHOM
         $EXPR1 $%I% $CERT $EQ_RHS $COND $DEG $ZB $SM $EQ $%N% $VARS))
       (PROG ()
         (COND
          ((LIKE $LO (*MMINUS (TRD-MSYMEVAL $INF '$INF)))
           (IF (NOT (BOUNDP '$LO))
               (ADD2LNC '$LO $VALUES))
           (SETQ $LO (TRD-MSYMEVAL $MINF '$MINF))))
         (PROGN
          (IF (NOT (BOUNDP '$EXPR1))
              (ADD2LNC '$EXPR1 $VALUES))
          (SETQ $EXPR1
                  (SIMPLIFY
                   ($FACTOR
                    (SIMPLIFY
                     ($MINFACTORIAL
                      (SIMPLIFY ($FACTCOMB (SIMPLIFY ($MAKEFACT $EXPR))))))))))
         (SIMPLIFY ($SS_PRINT_MESSAGE 2. '"Summand:" $EXPR))
         (SIMPLIFY ($SS_PRINT_MESSAGE 2. '"Changed to:" $EXPR1))
         (COND
          ((EQL ($LENGTH $IN_ZR) 0.)
           (COND
            ((< ($LENGTH $VARS) 1.)
             (SIMPLIFY (MFUNCTION-CALL $SS_PRINT 3. '"Not enough variables"))
             (RETURN NIL)))
           (COND
            ((> ($LENGTH (SIMPLIFY ($LISTOFVARS $HI))) 0.)
             (IF (NOT (BOUNDP '$%N%))
                 (ADD2LNC '$%N% $VALUES))
             (SETQ $%N% (SIMPLIFY ($FIRST (SIMPLIFY ($LISTOFVARS $HI))))))
            ((> ($LENGTH (SIMPLIFY ($LISTOFVARS $LO))) 0.)
             (IF (NOT (BOUNDP '$%N%))
                 (ADD2LNC '$%N% $VALUES))
             (SETQ $%N% (SIMPLIFY ($FIRST (SIMPLIFY ($LISTOFVARS $LO))))))
            (T
             (IF (NOT (BOUNDP '$%N%))
                 (ADD2LNC '$%N% $VALUES))
             (SETQ $%N% (MARRAYREF $VARS 1.)))))
          (T
           (IF (NOT (BOUNDP '$%N%))
               (ADD2LNC '$%N% $VALUES))
           (SETQ $%N% (MARRAYREF $IN_ZR 1.))))
         (SIMPLIFY
          (LIST '(MLIST) (ASSUME (SIMPLIFY (LIST '(MGREATERP) $%K% $LO)))))
         (SIMPLIFY
          (LIST '(MLIST) (ASSUME (SIMPLIFY (LIST '(MLESSP) $%K% $HI)))))
         (PROGN
          (IF (NOT (BOUNDP '$SUPPORT))
              (ADD2LNC '$SUPPORT $VALUES))
          (SETQ $SUPPORT (SIMPLIFY (MFUNCTION-CALL $SS_SUPPORT $EXPR1 $%K%))))
         (PROGN
          (IF (NOT (BOUNDP '$SUPPORT))
              (ADD2LNC '$SUPPORT $VALUES))
          (SETQ $SUPPORT
                  (LIST '(MLIST)
                        (COND
                         (($NUMBERP (MARRAYREF $SUPPORT 1.))
                          (SIMPLIFY
                           (LIST '($CEILING) (MARRAYREF $SUPPORT 1.))))
                         (T (MARRAYREF $SUPPORT 1.)))
                        (COND
                         (($NUMBERP (MARRAYREF $SUPPORT 2.))
                          (SIMPLIFY (LIST '($FLOOR) (MARRAYREF $SUPPORT 2.))))
                         (T (MARRAYREF $SUPPORT 2.))))))
         (COND
          ((OR (IS-BOOLE-CHECK (MLSP (MARRAYREF $SUPPORT 2.) $LO))
               (IS-BOOLE-CHECK (MGRP (MARRAYREF $SUPPORT 1.) $HI)))
           (RETURN 0.)))
         (COND
          ((LIKE
            (SIMPLIFY (MFUNCTION-CALL $SS_MAX $LO (MARRAYREF $SUPPORT 1.)))
            (MARRAYREF $SUPPORT 1.))
           (IF (NOT (BOUNDP '$LOWER_BOUND_IMPLICIT))
               (ADD2LNC '$LOWER_BOUND_IMPLICIT $VALUES))
           (SETQ $LOWER_BOUND_IMPLICIT T)))
         (COND
          ((LIKE
            (SIMPLIFY (MFUNCTION-CALL $SS_MIN $HI (MARRAYREF $SUPPORT 2.)))
            (MARRAYREF $SUPPORT 2.))
           (IF (NOT (BOUNDP '$UPPER_BOUND_IMPLICIT))
               (ADD2LNC '$UPPER_BOUND_IMPLICIT $VALUES))
           (SETQ $UPPER_BOUND_IMPLICIT T)))
         (COND
          ((LIKE $LO (TRD-MSYMEVAL $MINF '$MINF))
           (IF (NOT (BOUNDP '$LO))
               (ADD2LNC '$LO $VALUES))
           (SETQ $LO (MARRAYREF $SUPPORT 1.))))
         (COND
          ((LIKE $HI (TRD-MSYMEVAL $INF '$INF))
           (IF (NOT (BOUNDP '$HI))
               (ADD2LNC '$HI $VALUES))
           (SETQ $HI (MARRAYREF $SUPPORT 2.))))
         (SIMPLIFY ($SS_PRINT_MESSAGE 2. '"Found support:" $SUPPORT))
         (COND
          (($NUMBERP (MARRAYREF $SUPPORT 1.))
           (IF (NOT (BOUNDP '$SUM_MIN))
               (ADD2LNC '$SUM_MIN $VALUES))
           (SETQ $SUM_MIN
                   ($LMAX (LIST '(MLIST) (MARRAYREF $SUPPORT 1.) $LO)))))
         (COND
          ((OR
            (AND (LIKE (MARRAYREF $SUPPORT 1.) (TRD-MSYMEVAL $MINF '$MINF))
                 (IS-BOOLE-CHECK $LOWER_BOUND_IMPLICIT))
            (AND (LIKE (MARRAYREF $SUPPORT 2.) (TRD-MSYMEVAL $INF '$INF))
                 (IS-BOOLE-CHECK $UPPER_BOUND_IMPLICIT)))
           (SIMPLIFY ($SS_PRINT_MESSAGE 3. '"Support not finite!"))
           (RETURN NIL)))
         (PROGN
          (IF (NOT (BOUNDP '$ZB))
              (ADD2LNC '$ZB $VALUES))
          (SETQ $ZB
                  (SIMPLIFY (MFUNCTION-CALL |$Zeilberger| $EXPR1 $%K% $%N%))))
         (SIMPLIFY ($SS_PRINT_MESSAGE 3. '"Zeilberger returns:" $ZB))
         (COND ((EQL ($LENGTH $ZB) 0.) (SIMPLIFY ($ERROR))))
         (COND ((NOT ($LISTP (MARRAYREF $ZB 1.))) (SIMPLIFY ($ERROR))))
         (PROGN
          (IF (NOT (BOUNDP '$DEG))
              (ADD2LNC '$DEG $VALUES))
          (SETQ $DEG ($LENGTH ($PART $ZB 1. 2.))))
         (PROGN
          (IF (NOT (BOUNDP '$CERT))
              (ADD2LNC '$CERT $VALUES))
          (SETQ $CERT ($PART $ZB 1. 1.)))
         (PROGN
          (IF (NOT (BOUNDP '$EQ))
              (ADD2LNC '$EQ $VALUES))
          (SETQ $EQ
                  (NCMUL2 ($PART $ZB 1. 2.)
                          ((LAMBDA (TR-GENSYM1 TR-GENSYM2)
                             (PROGN
                              (SETQ TR-GENSYM2
                                      ($FLOAT (SUB TR-GENSYM2 TR-GENSYM1)))
                              (IF (NUMBERP TR-GENSYM2)
                                  (DO (($%I% TR-GENSYM1 (ADD 1. $%I%))
                                       (TR-GENSYM4 0. (ADD 1. TR-GENSYM4))
                                       (TR-GENSYM3 NIL
                                                   (CONS
                                                    (MARRAYREF $SM
                                                               (ADD* $%N%
                                                                     $%I%))
                                                    TR-GENSYM3)))
                                      ((> TR-GENSYM4 TR-GENSYM2)
                                       (CONS '(MLIST) (NREVERSE TR-GENSYM3)))
                                    (DECLARE (SPECIAL $%I%)))
                                  (MERROR
                                   (INTL:GETTEXT
                                    "makelist: the fourth argument minus the third one must evaluate to a number; found: ~M")
                                   TR-GENSYM2))))
                           0. (ADD* $DEG -1.)))))
         (PROGN
          (IF (NOT (BOUNDP '$CONT))
              (ADD2LNC '$CONT $VALUES))
          (SETQ $CONT (SIMPLIFY ($FIRST (SIMPLIFY ($CONTENT $EQ))))))
         (DO ((MDO 1. (+ 1. MDO)))
             ((NOT
               (LIKE
                (SIMPLIFY
                 ($SUBSTITUTE (SIMPLIFY (LIST '(MEQUAL) $%N% $SUM_MIN)) $CONT))
                0.))
              '$DONE)
           (DECLARE (SPECIAL MDO))
           (IF (NOT (BOUNDP '$SUM_MIN))
               (ADD2LNC '$SUM_MIN $VALUES))
           (SETQ $SUM_MIN (ADD* $SUM_MIN 1.)))
         (COND
          ((OR
            (TRP-NOT
             (LIKE
              (SIMPLIFY
               ($SUBSTITUTE
                (SIMPLIFY
                 (LIST '(MEQUAL) $%N%
                       ($LMAX (LIST '(MLIST) (MARRAYREF $SUPPORT 1.) $LO))))
                $CONT))
              0.))
            (LIKE
             ((LAMBDA (ERRCATCH RET)
                (DECLARE (SPECIAL ERRCATCH))
                (COND
                 ((NULL
                   (SETQ RET
                           (ERRSET
                            (PROGN
                             (PROGN
                              (IF (NOT (BOUNDP '$COND))
                                  (ADD2LNC '$COND $VALUES))
                              (SETQ $COND
                                      (SIMPLIFY
                                       (MFUNCTION-CALL $SS_ZEILB_INIT $EXPR
                                                       $%N%
                                                       ($LMAX
                                                        (LIST '(MLIST)
                                                              (MARRAYREF
                                                               $SUPPORT 1.)
                                                              $LO))
                                                       ($LMIN
                                                        (LIST '(MLIST)
                                                              (MARRAYREF
                                                               $SUPPORT 2.)
                                                              $HI))
                                                       ($LMAX
                                                        (LIST '(MLIST)
                                                              (MARRAYREF
                                                               $SUPPORT 1.)
                                                              $LO))
                                                       $DEG)))))
                            LISPERRPRINT)))
                  (ERRLFUN1 ERRCATCH)))
                (CONS '(MLIST) RET))
              (CONS BINDLIST LOCLIST) NIL)
             '((MLIST)))
            (NOT (IS-BOOLE-CHECK (SIMPLIFY ($FREEOF_SUM $COND)))))
           (IF (NOT (BOUNDP '$COND))
               (ADD2LNC '$COND $VALUES))
           (SETQ $COND
                   (SIMPLIFY
                    (MFUNCTION-CALL $SS_ZEILB_INIT $EXPR $%N% $LO $HI $SUM_MIN
                                    $DEG))))
          (T
           (IF (NOT (BOUNDP '$SUM_MIN))
               (ADD2LNC '$SUM_MIN $VALUES))
           (SETQ $SUM_MIN
                   ($LMAX (LIST '(MLIST) (MARRAYREF $SUPPORT 1.) $LO)))))
         (COND
          ((NOT (IS-BOOLE-CHECK (SIMPLIFY ($FREEOF_SUM $COND))))
           (SIMPLIFY ($SS_PRINT_MESSAGE 3. '"Wrong initial conditions:" $COND))
           (RETURN NIL)))
         (PROGN
          (IF (NOT (BOUNDP '$IHOM))
              (ADD2LNC '$IHOM $VALUES))
          (SETQ $IHOM
                  (SIMPLIFY
                   ($MINFACTORIAL (SIMPLIFY ($MAKEFACT (MUL* $CERT $EXPR)))))))
         (PROGN
          (IF (NOT (BOUNDP '$EQ_RHS))
              (ADD2LNC '$EQ_RHS $VALUES))
          (SETQ $EQ_RHS 0.))
         (COND
          ((NOT (IS-BOOLE-CHECK $UPPER_BOUND_IMPLICIT))
           (DO (($%I% 0. (+ 1. $%I%)))
               ((IS-BOOLE-CHECK (MGRP $%I% (ADD* $DEG -1.))) '$DONE)
             (DECLARE (SPECIAL $%I%))
             (IF (NOT (BOUNDP '$EQ_RHS))
                 (ADD2LNC '$EQ_RHS $VALUES))
             (SETQ $EQ_RHS
                     (ADD* $EQ_RHS
                           (MUL* ($PART $ZB 1. 2. (+ $%I% 1.))
                                 (SIMPLIFY
                                  (MFUNCALL (TRD-MSYMEVAL $SUM '$SUM)
                                            (SIMPLIFY
                                             ($SUBSTITUTE
                                              (SIMPLIFY
                                               (LIST '(MEQUAL) $%N%
                                                     (ADD* $%N% $%I%)))
                                              $EXPR))
                                            $%K% (ADD* $HI 1.)
                                            (SIMPLIFY
                                             ($SUBSTITUTE
                                              (SIMPLIFY
                                               (LIST '(MEQUAL) $%N%
                                                     (ADD* $%N% $%I%)))
                                              $HI))))))))
           (PROGN
            (IF (NOT (BOUNDP '$EQ_RHS))
                (ADD2LNC '$EQ_RHS $VALUES))
            (SETQ $EQ_RHS
                    (ADD* $EQ_RHS
                          (SIMPLIFY
                           ($SUBSTITUTE
                            (SIMPLIFY (LIST '(MEQUAL) $%K% (ADD* $HI 1.)))
                            $IHOM)))))))
         (COND
          ((NOT (IS-BOOLE-CHECK $LOWER_BOUND_IMPLICIT))
           (DO (($%I% 0. (+ 1. $%I%)))
               ((IS-BOOLE-CHECK (MGRP $%I% (ADD* $DEG -1.))) '$DONE)
             (DECLARE (SPECIAL $%I%))
             (IF (NOT (BOUNDP '$EQ_RHS))
                 (ADD2LNC '$EQ_RHS $VALUES))
             (SETQ $EQ_RHS
                     (ADD* $EQ_RHS
                           (MUL* ($PART $ZB 1. 2. (+ $%I% 1.))
                                 (SIMPLIFY
                                  (MFUNCALL (TRD-MSYMEVAL $SUM '$SUM)
                                            (SIMPLIFY
                                             ($SUBSTITUTE
                                              (SIMPLIFY
                                               (LIST '(MEQUAL) $%N%
                                                     (ADD* $%N% $%I%)))
                                              $EXPR))
                                            $%K%
                                            (SIMPLIFY
                                             ($SUBSTITUTE
                                              (SIMPLIFY
                                               (LIST '(MEQUAL) $%N%
                                                     (ADD* $%N% $%I%)))
                                              $LO))
                                            (ADD* $LO -1.)))))))
           (PROGN
            (IF (NOT (BOUNDP '$EQ_RHS))
                (ADD2LNC '$EQ_RHS $VALUES))
            (SETQ $EQ_RHS
                    (ADD* $EQ_RHS
                          (*MMINUS
                           (SIMPLIFY
                            ($SUBSTITUTE (SIMPLIFY (LIST '(MEQUAL) $%K% $LO))
                                         $IHOM))))))))
         (PROGN
          (IF (NOT (BOUNDP '$EQ_RHS))
              (ADD2LNC '$EQ_RHS $VALUES))
          (SETQ $EQ_RHS
                  (SIMPLIFY
                   ($FACTOR
                    (SIMPLIFY
                     ($MINFACTORIAL
                      (SIMPLIFY
                       ($FACTCOMB (SIMPLIFY ($MAKEFACT $EQ_RHS))))))))))
         (COND
          ((NOT (IS-BOOLE-CHECK (SIMPLIFY ($FREEOF_SUM $EQ_RHS))))
           (SIMPLIFY
            ($SS_PRINT_MESSAGE 3. '"Recurrence contains sums!" $EQ_RHS))
           (RETURN NIL)))
         (PROGN
          (IF (NOT (BOUNDP '$EQ))
              (ADD2LNC '$EQ $VALUES))
          (SETQ $EQ (SIMPLIFY (LIST '(MEQUAL) $EQ $EQ_RHS))))
         (SIMPLIFY
          ($SS_PRINT_MESSAGE 2. '"Degree of recurrence:" (ADD* $DEG -1.)))
         (SIMPLIFY ($SS_PRINT_MESSAGE 2. '"Zeilberger recurrence:" $EQ))
         (SIMPLIFY ($SS_PRINT_MESSAGE 2. '"Initial conditions:" $COND))
         (COND ((> ($LENGTH $IN_ZR) 0.) (RETURN $EQ)))
         (PROGN
          (IF (NOT (BOUNDP '$EQ))
              (ADD2LNC '$EQ $VALUES))
          (SETQ $EQ
                  (SIMPLIFY
                   (MAPPLY-TR (TRD-MSYMEVAL $SOLVE_REC '$SOLVE_REC)
                              ($APPEND (LIST '(MLIST) $EQ (MARRAYREF $SM $%N%))
                                       $COND)))))
         (SIMPLIFY ($SS_PRINT_MESSAGE 2. '"Solving recurrence returns:" $EQ))
         (COND ((LIKE $EQ NIL) (RETURN NIL)))
         (COND
          ((NOT (IS-BOOLE-CHECK (SIMPLIFY ($FREEOF_SUM $EQ)))) (RETURN NIL)))
         (PROGN
          (IF (NOT (BOUNDP '$EQ))
              (ADD2LNC '$EQ $VALUES))
          (SETQ $EQ
                  (SIMPLIFY
                   ($RATSIMP
                    (SIMPLIFY
                     ($MINFACTORIAL (SIMPLIFY ($MAKEFACT ($RHS $EQ)))))))))
         (SIMPLIFY ($SS_PRINT_MESSAGE 4. '"Simplified solution:" $EQ))
         (RETURN
          (COND
           ((IS-BOOLE-CHECK
             (SIMPLIFY
              (MFUNCTION-CALL $CHECK_SUM $EXPR $%K% $%N% $LO $HI $DEG $EQ)))
            $EQ)))))
     (SIMPLIFY ($DELETE $%K% (SIMPLIFY ($LISTOFVARS $EXPR)))) '$%N% '$EQ '$SM
     '$ZB '$DEG '$COND '$EQ_RHS '$CERT '$%I% '$EXPR1 '$IHOM '$SUPPORT
     (TRD-MSYMEVAL $SUM_MIN '$SUM_MIN) NIL NIL NIL NIL NIL '$CONT)
    ))
(PROGN
 (DEFPROP $SS_ZEILB_INIT T TRANSLATED)
 (ADD2LNC '$SS_ZEILB_INIT $PROPS)
 (DEFMTRFUN ($SS_ZEILB_INIT $ANY MDEFINE NIL NIL)
      ($EXPR $%N% $LO $HI $SUM_MIN $DEG)
    (DECLARE (SPECIAL $DEG $SUM_MIN $HI $LO $%N% $EXPR))
    ((LAMBDA ($COND)
       (DECLARE (SPECIAL $COND))
       (PROGN
        (IF (NOT (BOUNDP '$COND))
            (ADD2LNC '$COND $VALUES))
        (SETQ $COND
                ((LAMBDA (TR-GENSYM5 TR-GENSYM6)
                   (PROGN
                    (SETQ TR-GENSYM6 ($FLOAT (SUB TR-GENSYM6 TR-GENSYM5)))
                    (IF (NUMBERP TR-GENSYM6)
                        (DO (($%I% TR-GENSYM5 (ADD 1. $%I%))
                             (TR-GENSYM8 0. (ADD 1. TR-GENSYM8))
                             (TR-GENSYM7 NIL
                                         (CONS
                                          (SIMPLIFY
                                           (LIST '(MEQUAL)
                                                 (MARRAYREF
                                                  (TRD-MSYMEVAL $SM '$SM) $%I%)
                                                 (SIMPLIFY
                                                  ($SUBSTITUTE
                                                   (SIMPLIFY
                                                    (LIST '(MEQUAL) $%N% $%I%))
                                                   (SIMPLIFY
                                                    (MFUNCALL '$SUM
                                                              (SIMPLIFY
                                                               ($MINFACTORIAL
                                                                $EXPR))
                                                              (TRD-MSYMEVAL
                                                               $%K% '$%K%)
                                                              $LO $HI))))))
                                          TR-GENSYM7)))
                            ((> TR-GENSYM8 TR-GENSYM6)
                             (CONS '(MLIST) (NREVERSE TR-GENSYM7)))
                          (DECLARE (SPECIAL $%I%)))
                        (MERROR
                         (INTL:GETTEXT
                          "makelist: the fourth argument minus the third one must evaluate to a number; found: ~M")
                         TR-GENSYM6))))
                 $SUM_MIN (ADD* $SUM_MIN $DEG -2.))))
       (PROGN
        (IF (NOT (BOUNDP '$COND))
            (ADD2LNC '$COND $VALUES))
        (SETQ $COND
                (SIMPLIFY
                 ($FACTOR
                  (SIMPLIFY
                   ($MINFACTORIAL (SIMPLIFY ($SIMPLIFY_SUM $COND))))))))
       $COND)
     '$COND)
    ))
(PROGN
 (DEFPROP $SUMMAND_TO_REC T TRANSLATED)
 (ADD2LNC '$SUMMAND_TO_REC $PROPS)
 (DEFMTRFUN ($SUMMAND_TO_REC $ANY MDEFINE NIL NIL)
      ($EXPR $K $N)
    (DECLARE (SPECIAL $N $K $EXPR))
    ((LAMBDA ($ZR $LINSOLVEWARN $LO $HI)
       (DECLARE (SPECIAL $HI $LO $LINSOLVEWARN $ZR))
       (COND
        (($LISTP $K)
         (PROGN
          (IF (NOT (BOUNDP '$LO))
              (ADD2LNC '$LO $VALUES))
          (SETQ $LO (MARRAYREF $K 2.)))
         (PROGN
          (IF (NOT (BOUNDP '$HI))
              (ADD2LNC '$HI $VALUES))
          (SETQ $HI (MARRAYREF $K 3.)))
         (PROGN
          (IF (NOT (BOUNDP '$K))
              (ADD2LNC '$K $VALUES))
          (SETQ $K (MARRAYREF $K 1.)))))
       (SIMPLIFY (MFUNCTION-CALL $SUPCONTEXT '$SS_CONTEXT))
       (COND
        ((LIKE
          ((LAMBDA (ERRCATCH RET)
             (DECLARE (SPECIAL ERRCATCH))
             (COND
              ((NULL
                (SETQ RET
                        (ERRSET
                         (PROGN
                          (PROGN
                           (IF (NOT (BOUNDP '$ZR))
                               (ADD2LNC '$ZR $VALUES))
                           (SETQ $ZR
                                   (SIMPLIFY
                                    ($SS_ZEILB $EXPR $K $LO $HI $N)))))
                         LISPERRPRINT)))
               (ERRLFUN1 ERRCATCH)))
             (CONS '(MLIST) RET))
           (CONS BINDLIST LOCLIST) NIL)
          '((MLIST)))
         (IF (NOT (BOUNDP '$ZR))
             (ADD2LNC '$ZR $VALUES))
         (SETQ $ZR '$FAILED)))
       (SIMPLIFY ($KILLCONTEXT '$SS_CONTEXT))
       $ZR)
     '$ZR NIL (TRD-MSYMEVAL $MINF '$MINF) (TRD-MSYMEVAL $INF '$INF))
    ))
(PROGN
 (DEFPROP $CHECK_SUM T TRANSLATED)
 (ADD2LNC '$CHECK_SUM $PROPS)
 (DEFMTRFUN ($CHECK_SUM $BOOLEAN MDEFINE NIL NIL)
      ($EXPR $%K% $%N% $LO $HI $DEG $SM)
    (DECLARE (SPECIAL $SM $DEG $HI $LO $%N% $%K% $EXPR))
    (COND ((NOT (TRD-MSYMEVAL $ZEILBERGER_CHECK NIL)) T)
          (T
           ((LAMBDA ()
              ((LAMBDA (MCATCH)
                 (PROG2 NIL
                     (CATCH 'MCATCH
                       (PROGN
                        ((LAMBDA ($%I% $TMP_SUM $REAL_SUM $SIMPSUM $SUM_MIN)
                           (DECLARE
                            (SPECIAL $SUM_MIN $SIMPSUM $REAL_SUM $TMP_SUM
                             $%I%))
                           (DO (($%I% $SUM_MIN (ADD* 1. $%I%)))
                               ((IS-BOOLE-CHECK
                                 (MGRP $%I% (ADD* $DEG $SUM_MIN)))
                                '$DONE)
                             (DECLARE (SPECIAL $%I%))
                             (PROGN
                              (IF (NOT (BOUNDP '$REAL_SUM))
                                  (ADD2LNC '$REAL_SUM $VALUES))
                              (SETQ $REAL_SUM
                                      (SIMPLIFY
                                       ($MINFACTORIAL
                                        (SIMPLIFY
                                         ($FACTCOMB
                                          (SIMPLIFY
                                           ($MAKEFACT
                                            (SIMPLIFY
                                             ($SIMPLIFY_SUM
                                              (SIMPLIFY
                                               ($SUBSTITUTE
                                                (SIMPLIFY
                                                 (LIST '(MEQUAL) $%N% $%I%))
                                                (SIMPLIFY
                                                 (MFUNCALL
                                                  (TRD-MSYMEVAL $SUM '$SUM)
                                                  $EXPR $%K% $LO
                                                  $HI))))))))))))))
                             (PROGN
                              (IF (NOT (BOUNDP '$TMP_SUM))
                                  (ADD2LNC '$TMP_SUM $VALUES))
                              (SETQ $TMP_SUM
                                      (SIMPLIFY
                                       ($MINFACTORIAL
                                        (SIMPLIFY
                                         ($FACTCOMB
                                          (SIMPLIFY
                                           ($MAKEFACT
                                            (SIMPLIFY
                                             ($SUBSTITUTE
                                              (SIMPLIFY
                                               (LIST '(MEQUAL) $%N% $%I%))
                                              $SM))))))))))
                             (PROGN
                              (IF (NOT (BOUNDP '$DIF))
                                  (ADD2LNC '$DIF $VALUES))
                              (SETQ $DIF
                                      (SIMPLIFY
                                       ($RECTFORM
                                        (ADD* $REAL_SUM (*MMINUS $TMP_SUM))))))
                             (COND
                              ((OR
                                (NOT
                                 (IS-BOOLE-CHECK
                                  (SIMPLIFY ($FREEOF_SUM $REAL_SUM))))
                                (AND ($NUMBERP (TRD-MSYMEVAL $DIF '$DIF))
                                     (TRP-NOT
                                      (LIKE (TRD-MSYMEVAL $DIF '$DIF) 0.))))
                               (COND
                                ((TRP-NOT (LIKE (TRD-MSYMEVAL $DIF '$DIF) 0.))
                                 (SIMPLIFY
                                  ($SS_PRINT_MESSAGE 2.
                                   '"Sum check failed with: "
                                   (SIMPLIFY (LIST '(MEQUAL) '$I $%I%))
                                   (SIMPLIFY
                                    (LIST '(MEQUAL) '$TMP_SUM $TMP_SUM))
                                   (SIMPLIFY
                                    (LIST '(MEQUAL) '$DIF
                                          (TRD-MSYMEVAL $DIF '$DIF)))))
                                 ((LAMBDA (X)
                                    (COND
                                     ((NULL MCATCH) (DISPLA X)
                                      (MERROR
                                       (INTL:GETTEXT
                                        "throw: not within 'catch'."))))
                                    (THROW 'MCATCH X))
                                  NIL))
                                (T
                                 ($PRINT
                                  '"Warning: sum check could not be completed!")))))))
                         '$%I% '$TMP_SUM '$REAL_SUM T
                         (ADD* (TRD-MSYMEVAL $SUM_MIN '$SUM_MIN) $DEG))
                        T))
                   (ERRLFUN1 MCATCH)))
               (CONS BINDLIST LOCLIST))))))
    ))
(PROGN
 (DEFPROP $SS_SUPPORT T TRANSLATED)
 (ADD2LNC '$SS_SUPPORT $PROPS)
 (DEFMTRFUN ($SS_SUPPORT $ANY MDEFINE NIL NIL)
      ($EXPR $%K%)
    (DECLARE (SPECIAL $%K% $EXPR))
    ((LAMBDA ()
       NIL
       (COND
        ((OR ($FREEOF $%K% $EXPR) (LIKE $EXPR $%K%))
         (LIST '(MLIST) (TRD-MSYMEVAL $MINF '$MINF) (TRD-MSYMEVAL $INF '$INF)))
        (($MEMBER ($PART $EXPR 0.) (LIST '(MLIST) '"+" '"-"))
         (SIMPLIFY
          (MFUNCTION-CALL $LREDUCE (TRD-MSYMEVAL $SS_UNION '$SS_UNION)
                          (SIMPLIFY
                           (MAP1
                            (GETOPR
                             (M-TLAMBDA&ENV (($U) ($%K%))
                               (DECLARE (SPECIAL $U))
                               (SIMPLIFY
                                (MFUNCTION-CALL $SS_SUPPORT $U $%K%))))
                            (SIMPLIFY ($ARGS $EXPR)))))))
        ((LIKE ($PART $EXPR 0.) '"*")
         (SIMPLIFY
          (MFUNCTION-CALL $LREDUCE
                          (TRD-MSYMEVAL $SS_INTERSECTION '$SS_INTERSECTION)
                          (SIMPLIFY
                           (MAP1
                            (GETOPR
                             (M-TLAMBDA&ENV (($U) ($%K%))
                               (DECLARE (SPECIAL $U))
                               (SIMPLIFY
                                (MFUNCTION-CALL $SS_SUPPORT $U $%K%))))
                            (SIMPLIFY ($ARGS $EXPR)))))))
        ((LIKE ($PART $EXPR 0.) '"/")
         (SIMPLIFY
          (MFUNCTION-CALL $LREDUCE
                          (TRD-MSYMEVAL $SS_INTERSECTION '$SS_INTERSECTION)
                          (SIMPLIFY
                           (MAP1
                            (GETOPR
                             (M-TLAMBDA&ENV (($U) ($%K%))
                               (DECLARE (SPECIAL $U))
                               (SIMPLIFY
                                (MFUNCTION-CALL $SS_SUPPORT
                                                (SIMPLIFY ($FACTCOMB $U))
                                                $%K%))))
                            (SIMPLIFY ($ARGS $EXPR)))))))
        (($MEMBER ($PART $EXPR 0.) (LIST '(MLIST) '"^"))
         (SIMPLIFY (MFUNCTION-CALL $SS_SUPPORT ($PART $EXPR 1.) $%K%)))
        ((LIKE ($PART $EXPR 0.) (TRD-MSYMEVAL %BINOMIAL '%BINOMIAL))
         (SIMPLIFY (MFUNCTION-CALL $SS_SUPPORT_BINOMIAL $EXPR $%K%)))
        ((LIKE ($PART $EXPR 0.) '"!")
         (SIMPLIFY (MFUNCTION-CALL $SS_SUPPORT_FACTORIAL $EXPR $%K%)))
        (T
         (LIST '(MLIST) (TRD-MSYMEVAL $MINF '$MINF)
               (TRD-MSYMEVAL $INF '$INF))))))
    ))
(PROGN
 (DEFPROP $SS_SUPPORT_FACTORIAL T TRANSLATED)
 (ADD2LNC '$SS_SUPPORT_FACTORIAL $PROPS)
 (DEFMTRFUN ($SS_SUPPORT_FACTORIAL $ANY MDEFINE NIL NIL)
      ($EXPR $%K%)
    (DECLARE (SPECIAL $%K% $EXPR))
    (SIMPLIFY
     (MFUNCTION-CALL $SOLVE_LIN_INEQ
                     (SIMPLIFY (LIST '(MGREATERP) ($PART $EXPR 1.) 0.)) $%K%))
    ))
(PROGN
 (DEFPROP $SS_SUPPORT_BINOMIAL T TRANSLATED)
 (ADD2LNC '$SS_SUPPORT_BINOMIAL $PROPS)
 (DEFMTRFUN ($SS_SUPPORT_BINOMIAL $ANY MDEFINE NIL NIL)
      ($EXPR $%K%)
    (DECLARE (SPECIAL $%K% $EXPR))
    ((LAMBDA ($S1 $S2)
       (DECLARE (SPECIAL $S2 $S1))
       (PROGN
        (IF (NOT (BOUNDP '$S1))
            (ADD2LNC '$S1 $VALUES))
        (SETQ $S1
                (SIMPLIFY
                 (MFUNCTION-CALL $SOLVE_LIN_INEQ
                                 (SIMPLIFY
                                  (LIST '(MGREATERP) ($PART $EXPR 2.) 0.))
                                 $%K%))))
       (PROGN
        (IF (NOT (BOUNDP '$S2))
            (ADD2LNC '$S2 $VALUES))
        (SETQ $S2
                (SIMPLIFY
                 (MFUNCTION-CALL $SOLVE_LIN_INEQ
                                 (SIMPLIFY
                                  (LIST '(MLESSP) ($PART $EXPR 2.)
                                        ($PART $EXPR 1.)))
                                 $%K%))))
       (SIMPLIFY (MFUNCTION-CALL $SS_INTERSECTION $S1 $S2)))
     '$S1 '$S2)
    ))
(PROGN
 (DEFPROP $SOLVE_LIN_INEQ T TRANSLATED)
 (ADD2LNC '$SOLVE_LIN_INEQ $PROPS)
 (DEFMTRFUN ($SOLVE_LIN_INEQ $ANY MDEFINE NIL NIL)
      ($EQ $K)
    (DECLARE (SPECIAL $K $EQ))
    ((LAMBDA ($EQ1 $BC $A $B)
       (DECLARE (SPECIAL $B $A $BC $EQ1))
       (COND
        ((LIKE (SIMPLIFY ($OP $EQ)) '">")
         (IF (NOT (BOUNDP '$EQ1))
             (ADD2LNC '$EQ1 $VALUES))
         (SETQ $EQ1 (ADD* ($LHS $EQ) (*MMINUS ($RHS $EQ)))))
        (T
         (IF (NOT (BOUNDP '$EQ1))
             (ADD2LNC '$EQ1 $VALUES))
         (SETQ $EQ1 (ADD* ($RHS $EQ) (*MMINUS ($LHS $EQ))))))
       (PROGN
        (IF (NOT (BOUNDP '$BC))
            (ADD2LNC '$BC $VALUES))
        (SETQ $BC (SIMPLIFY ($BOTHCOEF (SIMPLIFY ($EXPAND $EQ1)) $K))))
       (PROGN
        (IF (NOT (BOUNDP '$A))
            (ADD2LNC '$A $VALUES))
        (SETQ $A (MARRAYREF $BC 1.)))
       (PROGN
        (IF (NOT (BOUNDP '$B))
            (ADD2LNC '$B $VALUES))
        (SETQ $B (MARRAYREF $BC 2.)))
       (COND
        ((LIKE $A 0.)
         (LIST '(MLIST) (TRD-MSYMEVAL $MINF '$MINF) (TRD-MSYMEVAL $INF '$INF)))
        ((NOT ($FREEOF $K $B))
         (LIST '(MLIST) (TRD-MSYMEVAL $MINF '$MINF) (TRD-MSYMEVAL $INF '$INF)))
        ((NOT ($NUMBERP $A))
         (LIST '(MLIST) (TRD-MSYMEVAL $MINF '$MINF) (TRD-MSYMEVAL $INF '$INF)))
        ((IS-BOOLE-CHECK (MGRP $A 0.))
         (LIST '(MLIST) (DIV (*MMINUS $B) $A) (TRD-MSYMEVAL $INF '$INF)))
        (T (LIST '(MLIST) (TRD-MSYMEVAL $MINF '$MINF) (DIV (*MMINUS $B) $A)))))
     '$EQ1 '$BC '$A '$B)
    ))
(PROGN
 (DEFPROP $SS_UNION T TRANSLATED)
 (ADD2LNC '$SS_UNION $PROPS)
 (DEFMTRFUN ($SS_UNION $ANY MDEFINE NIL NIL)
      ($L1 $L2)
    (DECLARE (SPECIAL $L2 $L1))
    (LIST '(MLIST)
          (SIMPLIFY
           (MFUNCTION-CALL $SS_MIN (SIMPLIFY ($FIRST $L1))
                           (SIMPLIFY ($FIRST $L2))))
          (SIMPLIFY
           (MFUNCTION-CALL $SS_MAX (SIMPLIFY ($SECOND $L1))
                           (SIMPLIFY ($SECOND $L2)))))
    ))
(PROGN
 (DEFPROP $SS_INTERSECTION T TRANSLATED)
 (ADD2LNC '$SS_INTERSECTION $PROPS)
 (DEFMTRFUN ($SS_INTERSECTION $ANY MDEFINE NIL NIL)
      ($L1 $L2)
    (DECLARE (SPECIAL $L2 $L1))
    (LIST '(MLIST)
          (SIMPLIFY
           (MFUNCTION-CALL $SS_MAX (SIMPLIFY ($FIRST $L1))
                           (SIMPLIFY ($FIRST $L2))))
          (SIMPLIFY
           (MFUNCTION-CALL $SS_MIN (SIMPLIFY ($SECOND $L1))
                           (SIMPLIFY ($SECOND $L2)))))
    ))
(PROGN
 (DEFPROP $SS_MAX T TRANSLATED)
 (ADD2LNC '$SS_MAX $PROPS)
 (DEFMTRFUN ($SS_MAX $ANY MDEFINE NIL NIL)
      ($E1 $E2)
    (DECLARE (SPECIAL $E2 $E1))
    ((LAMBDA ($PNZ)
       (DECLARE (SPECIAL $PNZ))
       (COND ((OR (LIKE $PNZ '$POS) (LIKE $PNZ '$ZERO)) $E1) (T $E2)))
     (SIMPLIFY ($ASKSIGN (ADD* $E1 (*MMINUS $E2)))))
    ))
(PROGN
 (DEFPROP $SS_MIN T TRANSLATED)
 (ADD2LNC '$SS_MIN $PROPS)
 (DEFMTRFUN ($SS_MIN $ANY MDEFINE NIL NIL)
      ($E1 $E2)
    (DECLARE (SPECIAL $E2 $E1))
    ((LAMBDA ($PNZ)
       (DECLARE (SPECIAL $PNZ))
       (COND ((OR (LIKE $PNZ '$NEG) (LIKE $PNZ '$ZERO)) $E1) (T $E2)))
     (SIMPLIFY ($ASKSIGN (ADD* $E1 (*MMINUS $E2)))))
    ))
(PROGN
 (DEFPROP $EXPAND_SUM T TRANSLATED)
 (ADD2LNC '$EXPAND_SUM $PROPS)
 (DEFMTRFUN ($EXPAND_SUM $ANY MDEFINE NIL NIL)
      ($EXPR $K%% $LO%% $HI%%)
    (DECLARE (SPECIAL $HI%% $LO%% $K%% $EXPR))
    (COND
     ((AND (NOT ($ATOM $EXPR)) (LIKE ($PART $EXPR 0.) '"+"))
      (SIMPLIFY
       (MAP1
        (GETOPR
         (M-TLAMBDA&ENV (($U) ($K%% $LO%% $HI%%))
           (DECLARE (SPECIAL $U))
           (SIMPLIFY
            (MFUNCALL (TRD-MSYMEVAL $SUM '$SUM) $U $K%% $LO%% $HI%%))))
        $EXPR)))
     (T
      (SIMPLIFY (MFUNCALL (TRD-MSYMEVAL $SUM '$SUM) $EXPR $K%% $LO%% $HI%%))))
    ))
(PROGN
 (DEFPROP $SPLIT_SUM T TRANSLATED)
 (ADD2LNC '$SPLIT_SUM $PROPS)
 (DEFMTRFUN ($SPLIT_SUM $ANY MDEFINE NIL NIL)
      ($EXPR)
    (DECLARE (SPECIAL $EXPR))
    ((LAMBDA ($SM%%)
       (DECLARE (SPECIAL $SM%%))
       (MEVAL
        '(($EV
           (650.
            "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
            SRC))
          $SM%% $EXPAND_SUM)))
     (SIMPLIFY
      (MFUNCTION-CALL $OPSUBST
                      (SIMPLIFY
                       (LIST '(MEQUAL)
                             (SIMPLIFY ($NOUNIFY (TRD-MSYMEVAL $SUM '$SUM)))
                             (TRD-MSYMEVAL $EXPAND_SUM '$EXPAND_SUM)))
                      $EXPR)))
    ))
(PROGN
 (DEFPROP $RATFUN_TO_PSI T TRANSLATED)
 (ADD2LNC '$RATFUN_TO_PSI $PROPS)
 (DEFMTRFUN ($RATFUN_TO_PSI $ANY MDEFINE NIL NIL)
      ($RATFUN $VAR $LO $HI)
    (DECLARE (SPECIAL $HI $LO $VAR $RATFUN))
    ((LAMBDA ($PF $SUM $DENOM_F)
       (DECLARE (SPECIAL $DENOM_F $SUM $PF))
       (PROGN
        (IF (NOT (BOUNDP '$PF))
            (ADD2LNC '$PF $VALUES))
        (SETQ $PF (SIMPLIFY ($PARTFRAC (DIV ($NUM $RATFUN) $DENOM_F) $VAR))))
       (COND
        ((LIKE (SIMPLIFY ($INPART $PF 0.)) '"+")
         (IF (NOT (BOUNDP '$PF))
             (ADD2LNC '$PF $VALUES))
         (SETQ $PF (SIMPLIFY ($ARGS $PF))))
        (T
         (IF (NOT (BOUNDP '$PF))
             (ADD2LNC '$PF $VALUES))
         (SETQ $PF (LIST '(MLIST) $PF))))
       (SIMPLIFY ($SS_PRINT_MESSAGE 2. '"Partial fractions" $PF))
       (DO (($PRT)
            (MDO (CDR $PF) (CDR MDO)))
           ((NULL MDO) '$DONE)
         (DECLARE (SPECIAL $PRT))
         (SETQ $PRT (CAR MDO))
         ((LAMBDA ($TERM $EXPONENT $A $B)
            (DECLARE (SPECIAL $B $A $EXPONENT $TERM))
            (SIMPLIFY ($SS_PRINT_MESSAGE 3. '"Working on term" $PRT))
            (PROGN
             (IF (NOT (BOUNDP '$PRT))
                 (ADD2LNC '$PRT $VALUES))
             (SETQ $PRT (DIV $PRT $TERM)))
            (PROGN
             (IF (NOT (BOUNDP '$TERM))
                 (ADD2LNC '$TERM $VALUES))
             (SETQ $TERM (MUL* $TERM ($NUM $PRT))))
            (PROGN
             (IF (NOT (BOUNDP '$PRT))
                 (ADD2LNC '$PRT $VALUES))
             (SETQ $PRT ($DENOM $PRT)))
            (COND
             ((AND (NOT ($ATOM $PRT)) (LIKE ($PART $PRT 0.) '"^"))
              (PROGN
               (IF (NOT (BOUNDP '$EXPONENT))
                   (ADD2LNC '$EXPONENT $VALUES))
               (SETQ $EXPONENT ($PART $PRT 2.)))
              (PROGN
               (IF (NOT (BOUNDP '$PRT))
                   (ADD2LNC '$PRT $VALUES))
               (SETQ $PRT ($PART $PRT 1.))))
             (T
              (IF (NOT (BOUNDP '$EXPONENT))
                  (ADD2LNC '$EXPONENT $VALUES))
              (SETQ $EXPONENT 1.)))
            (SIMPLIFY ($SS_PRINT_MESSAGE 3. '"Linear part" $PRT))
            (PROGN
             (IF (NOT (BOUNDP '$A))
                 (ADD2LNC '$A $VALUES))
             (SETQ $A
                     (SIMPLIFY
                      ($RATSIMP
                       (SIMPLIFY
                        ($BOTHCOEF (SIMPLIFY ($EXPAND $PRT)) $VAR))))))
            (PROGN
             (IF (NOT (BOUNDP '$B))
                 (ADD2LNC '$B $VALUES))
             (SETQ $B (MARRAYREF $A 2.)))
            (PROGN
             (IF (NOT (BOUNDP '$A))
                 (ADD2LNC '$A $VALUES))
             (SETQ $A (MARRAYREF $A 1.)))
            (COND
             ((NOT (AND ($FREEOF $VAR $A) ($FREEOF $VAR $B)))
              (SIMPLIFY ($ERROR))))
            (COND
             ((LIKE $HI (TRD-MSYMEVAL $INF '$INF))
              (COND
               ((TRP-NOT (LIKE $EXPONENT 1.))
                (IF (NOT (BOUNDP '$TERM))
                    (ADD2LNC '$TERM $VALUES))
                (SETQ $TERM
                        (DIV
                         (MUL* $TERM
                               (ADD* (SIMPLIFY (LIST '(%ZETA) $EXPONENT))
                                     (*MMINUS
                                      (SIMPLIFY
                                       (MFUNCTION-CALL $GEN_HARMONIC_NUMBER
                                                       $EXPONENT
                                                       (SIMPLIFY
                                                        ($SUBSTITUTE
                                                         (SIMPLIFY
                                                          (LIST '(MEQUAL) $VAR
                                                                (ADD* $LO
                                                                      -1.)))
                                                         (DIV $PRT $A))))))))
                         (POWER $A $EXPONENT))))
               (T
                (IF (NOT (BOUNDP '$TERM))
                    (ADD2LNC '$TERM $VALUES))
                (SETQ $TERM
                        (DIV
                         (MUL* (*MMINUS $TERM)
                               (SIMPLIFY
                                (MFUNCTION-CALL $GEN_HARMONIC_NUMBER $EXPONENT
                                                (SIMPLIFY
                                                 ($SUBSTITUTE
                                                  (SIMPLIFY
                                                   (LIST '(MEQUAL) $VAR
                                                         (ADD* $LO -1.)))
                                                  (DIV $PRT $A))))))
                         (POWER $A $EXPONENT))))))
             (T
              (IF (NOT (BOUNDP '$TERM))
                  (ADD2LNC '$TERM $VALUES))
              (SETQ $TERM
                      (DIV
                       (MUL* $TERM
                             (ADD*
                              (SIMPLIFY
                               (MFUNCTION-CALL $GEN_HARMONIC_NUMBER $EXPONENT
                                               (SIMPLIFY
                                                ($SUBSTITUTE
                                                 (SIMPLIFY
                                                  (LIST '(MEQUAL) $VAR $HI))
                                                 (DIV $PRT $A)))))
                              (*MMINUS
                               (SIMPLIFY
                                (MFUNCTION-CALL $GEN_HARMONIC_NUMBER $EXPONENT
                                                (SIMPLIFY
                                                 ($SUBSTITUTE
                                                  (SIMPLIFY
                                                   (LIST '(MEQUAL) $VAR
                                                         (ADD* $LO -1.)))
                                                  (DIV $PRT $A))))))))
                       (POWER $A $EXPONENT)))))
            (SIMPLIFY
             ($SS_PRINT_MESSAGE 3. '"Corresponding term in sum" $TERM))
            (PROGN
             (IF (NOT (BOUNDP '$SUM))
                 (ADD2LNC '$SUM $VALUES))
             (SETQ $SUM (ADD* $SUM $TERM))))
          (SIMPLIFY ($NUMFACTOR $PRT)) '$EXPONENT '$A '$B))
       $SUM)
     '$PF 0.
     (SIMPLIFY (MFUNCTION-CALL $FACTOR_WITH_SOLVE ($DENOM $RATFUN) $VAR)))
    ))
(PROGN
 (DEFPROP $FACTOR_WITH_SOLVE T TRANSLATED)
 (ADD2LNC '$FACTOR_WITH_SOLVE $PROPS)
 (DEFMTRFUN ($FACTOR_WITH_SOLVE $ANY MDEFINE NIL NIL)
      ($EXPR $N)
    (DECLARE (SPECIAL $N $EXPR))
    ((LAMBDA ($SOL $FAC $EXPR1)
       (DECLARE (SPECIAL $EXPR1 $FAC $SOL))
       (PROGN
        (IF (NOT (BOUNDP '$SOL))
            (ADD2LNC '$SOL $VALUES))
        (SETQ $SOL (SIMPLIFY ($SOLVE $EXPR $N))))
       (PROGN
        (IF (NOT (BOUNDP '$EXPR))
            (ADD2LNC '$EXPR $VALUES))
        (SETQ $EXPR (SIMPLIFY ($RATEXPAND $EXPR))))
       (PROGN
        (IF (NOT (BOUNDP '$FAC))
            (ADD2LNC '$FAC $VALUES))
        (SETQ $FAC
                (SIMPLIFY ($RATCOEF $EXPR $N (SIMPLIFY ($HIPOW $EXPR $N))))))
       (DO (($I 1. (+ 1. $I)))
           ((> $I ($LENGTH $SOL)) '$DONE)
         (DECLARE (SPECIAL $I))
         (COND
          ((NOT ($FREEOF $N ($RHS (MARRAYREF $SOL $I)))) (SIMPLIFY ($ERROR))))
         (PROGN
          (IF (NOT (BOUNDP '$FAC))
              (ADD2LNC '$FAC $VALUES))
          (SETQ $FAC
                  (MUL* $FAC
                        (POWER (ADD* $N (*MMINUS ($RHS (MARRAYREF $SOL $I))))
                               (MARRAYREF
                                (TRD-MSYMEVAL $MULTIPLICITIES '$MULTIPLICITIES)
                                $I))))))
       $FAC)
     '$SOL '$FAC '$EXPR1)
    ))
(PROGN
 (DEFPROP $TO_HYPERGEOMETRIC T TRANSLATED)
 (ADD2LNC '$TO_HYPERGEOMETRIC $PROPS)
 (DEFMTRFUN ($TO_HYPERGEOMETRIC $ANY MDEFINE NIL NIL)
      ($EXPR $VAR $LO $HI)
    (DECLARE (SPECIAL $HI $LO $VAR $EXPR))
    ((LAMBDA ($QUO $UPPER $LOWER $A $B $X $C $WARNINGS)
       (DECLARE (SPECIAL $WARNINGS $C $X $B $A $LOWER $UPPER $QUO))
       (PROG ()
         (DO (($I 1. (+ 1. $I)))
             ((OR (> $I 100.)
                  (NOT
                   (LIKE
                    (SIMPLIFY
                     ($SUBSTITUTE (SIMPLIFY (LIST '(MEQUAL) $VAR $LO)) $EXPR))
                    0.)))
              '$DONE)
           (DECLARE (SPECIAL $I))
           (IF (NOT (BOUNDP '$LO))
               (ADD2LNC '$LO $VALUES))
           (SETQ $LO (ADD* $LO 1.)))
         (PROGN
          (IF (NOT (BOUNDP '$EXPR))
              (ADD2LNC '$EXPR $VALUES))
          (SETQ $EXPR
                  (SIMPLIFY
                   ($SUBSTITUTE
                    (SIMPLIFY (LIST '(MEQUAL) $VAR (ADD* $VAR $LO))) $EXPR))))
         (PROGN
          (IF (NOT (BOUNDP '$QUO))
              (ADD2LNC '$QUO $VALUES))
          (SETQ $QUO
                  (SIMPLIFY
                   ($RATSIMP
                    (SIMPLIFY
                     (MFUNCTION-CALL |$shiftQuo|
                                     (SIMPLIFY
                                      ($FACTOR
                                       (MUL* (SIMPLIFY ($MAKEFACT $EXPR))
                                             (SIMPLIFY
                                              `((MFACTORIAL) ,$VAR)))))
                                     $VAR))))))
         (COND
          ((NOT (IS-BOOLE-CHECK (SIMPLIFY (RATP $QUO $VAR)))) (RETURN NIL)))
         (SIMPLIFY ($SS_PRINT_MESSAGE 2. '"Shift quotient" $QUO))
         (PROGN
          (IF (NOT (BOUNDP '$UPPER))
              (ADD2LNC '$UPPER $VALUES))
          (SETQ $UPPER
                  (*MMINUS
                   (SIMPLIFY
                    (MAP1 (GETOPR (TRD-MSYMEVAL $RHS '$RHS))
                          (SIMPLIFY ($SOLVE ($NUM $QUO) $VAR)))))))
         (COND
          ((NOT
            (IS-BOOLE-CHECK
             (SIMPLIFY
              (MFUNCTION-CALL $EVERY
                              (M-TLAMBDA&ENV (($U) ($VAR))
                                (DECLARE (SPECIAL $U))
                                ($FREEOF $VAR $U))
                              $UPPER))))
           (RETURN NIL)))
         (DO (($I 1. (+ 1. $I)))
             ((> $I ($LENGTH $UPPER)) '$DONE)
           (DECLARE (SPECIAL $I))
           (DO (($J 1. (+ 1. $J)))
               ((IS-BOOLE-CHECK
                 (MGRP $J
                       (MARRAYREF
                        (TRD-MSYMEVAL $MULTIPLICITIES '$MULTIPLICITIES) $I)))
                '$DONE)
             (DECLARE (SPECIAL $J))
             (IF (NOT (BOUNDP '$A))
                 (ADD2LNC '$A $VALUES))
             (SETQ $A ($CONS (MARRAYREF $UPPER $I) $A))))
         (SIMPLIFY ($SS_PRINT_MESSAGE 2. '"a=" $A))
         (PROGN
          (IF (NOT (BOUNDP '$LOWER))
              (ADD2LNC '$LOWER $VALUES))
          (SETQ $LOWER
                  (*MMINUS
                   (SIMPLIFY
                    (MAP1 (GETOPR (TRD-MSYMEVAL $RHS '$RHS))
                          (SIMPLIFY ($SOLVE ($DENOM $QUO) $VAR)))))))
         (COND
          ((NOT
            (IS-BOOLE-CHECK
             (SIMPLIFY
              (MFUNCTION-CALL $EVERY
                              (M-TLAMBDA&ENV (($U) ($VAR))
                                (DECLARE (SPECIAL $U))
                                ($FREEOF $VAR $U))
                              $LOWER))))
           (RETURN NIL)))
         (DO (($I 1. (+ 1. $I)))
             ((> $I ($LENGTH $LOWER)) '$DONE)
           (DECLARE (SPECIAL $I))
           (DO (($J 1. (+ 1. $J)))
               ((IS-BOOLE-CHECK
                 (MGRP $J
                       (MARRAYREF
                        (TRD-MSYMEVAL $MULTIPLICITIES '$MULTIPLICITIES) $I)))
                '$DONE)
             (DECLARE (SPECIAL $J))
             (IF (NOT (BOUNDP '$B))
                 (ADD2LNC '$B $VALUES))
             (SETQ $B ($CONS (MARRAYREF $LOWER $I) $B))))
         (PROGN
          (IF (NOT (BOUNDP '$NI_COEFFS))
              (ADD2LNC '$NI_COEFFS $VALUES))
          (SETQ $NI_COEFFS
                  (SIMPLIFY
                   ($SUBLIST ($APPEND $UPPER $LOWER)
                             (M-TLAMBDA ($NI)
                               (DECLARE (SPECIAL $NI))
                               (AND ($INTEGERP $NI)
                                    (IS-BOOLE-CHECK (MLSP $NI 0.))))))))
         (RETURN
          (COND
           ((TRP-NOT (LIKE (TRD-MSYMEVAL $NI_COEFFS '$NI_COEFFS) '((MLIST))))
            ((LAMBDA
                 ($USE_SIMPSUM $USE_HARMONIC $USE_INTEGRAL $USE_RATFUN
                  $USE_GOSPER $USE_ZEILBERGER $USE_TELESCOPING $MIN_NI)
               (DECLARE
                (SPECIAL $MIN_NI $USE_TELESCOPING $USE_ZEILBERGER $USE_GOSPER
                 $USE_RATFUN $USE_INTEGRAL $USE_HARMONIC $USE_SIMPSUM))
               (ASSIGN-MODE-CHECK '$USE_TELESCOPING $USE_TELESCOPING)
               (ASSIGN-MODE-CHECK '$USE_ZEILBERGER $USE_ZEILBERGER)
               (ASSIGN-MODE-CHECK '$USE_GOSPER $USE_GOSPER)
               (ASSIGN-MODE-CHECK '$USE_RATFUN $USE_RATFUN)
               (ASSIGN-MODE-CHECK '$USE_INTEGRAL $USE_INTEGRAL)
               (ASSIGN-MODE-CHECK '$USE_HARMONIC $USE_HARMONIC)
               (ASSIGN-MODE-CHECK '$USE_SIMPSUM $USE_SIMPSUM)
               (ADD*
                (SIMPLIFY (MFUNCALL '$SUM $EXPR $VAR $LO (*MMINUS $MIN_NI)))
                (SIMPLIFY
                 ($SIMPLIFY_SUM
                  (SIMPLIFY
                   (MFUNCALL (TRD-MSYMEVAL $SUM '$SUM) $EXPR $VAR
                             (*MMINUS $MIN_NI) $HI))))))
             NIL NIL NIL NIL NIL NIL NIL
             (SIMPLIFY ($LMIN (TRD-MSYMEVAL $NI_COEFFS '$NI_COEFFS)))))
           (T
            (SIMPLIFY
             (MFUNCTION-CALL $TO_HYPERGEOMETRIC1 $EXPR $VAR $LO $HI)))))))
     '$QUO '$UPPER '$LOWER '((MLIST)) '((MLIST)) '$X '$C NIL)
    ))
(PROGN
 (DEFPROP $TO_HYPERGEOMETRIC1 T TRANSLATED)
 (ADD2LNC '$TO_HYPERGEOMETRIC1 $PROPS)
 (DEFMTRFUN ($TO_HYPERGEOMETRIC1 $ANY MDEFINE NIL NIL)
      ($EXPR $VAR $LO $HI)
    (DECLARE (SPECIAL $HI $LO $VAR $EXPR))
    ((LAMBDA ($QUO $UPPER $LOWER $A $B $X $C $WARNINGS $BESSELEXPAND)
       (DECLARE
        (SPECIAL $BESSELEXPAND $WARNINGS $C $X $B $A $LOWER $UPPER $QUO))
       (PROG ()
         (DO (($I 1. (+ 1. $I)))
             ((OR (> $I 100.)
                  (NOT
                   (LIKE
                    (SIMPLIFY
                     ($SUBSTITUTE (SIMPLIFY (LIST '(MEQUAL) $VAR $LO)) $EXPR))
                    0.)))
              '$DONE)
           (DECLARE (SPECIAL $I))
           (IF (NOT (BOUNDP '$LO))
               (ADD2LNC '$LO $VALUES))
           (SETQ $LO (ADD* $LO 1.)))
         (PROGN
          (IF (NOT (BOUNDP '$QUO))
              (ADD2LNC '$QUO $VALUES))
          (SETQ $QUO
                  (SIMPLIFY
                   ($RATSIMP
                    (SIMPLIFY
                     (MFUNCTION-CALL |$shiftQuo|
                                     (SIMPLIFY
                                      ($FACTOR
                                       (MUL* (SIMPLIFY ($MAKEFACT $EXPR))
                                             (SIMPLIFY
                                              `((MFACTORIAL) ,$VAR)))))
                                     $VAR))))))
         (COND
          ((NOT (IS-BOOLE-CHECK (SIMPLIFY (RATP $QUO $VAR)))) (RETURN NIL)))
         (SIMPLIFY ($SS_PRINT_MESSAGE 2. '"Shift quotient" $QUO))
         (PROGN
          (IF (NOT (BOUNDP '$QUOLIM))
              (ADD2LNC '$QUOLIM $VALUES))
          (SETQ $QUOLIM
                  (SIMPLIFY
                   ($LIMIT (DIV $QUO (ADD* $VAR 1.)) $VAR
                           (TRD-MSYMEVAL $INF '$INF)))))
         (COND
          ((AND
            (IS-BOOLE-CHECK
             (SIMPLIFY ($FREEOF_LIMIT (TRD-MSYMEVAL $QUOLIM '$QUOLIM))))
            (IS-BOOLE-CHECK
             (MGRP (SIMPLIFY (LIST '(MABS) (TRD-MSYMEVAL $QUOLIM '$QUOLIM)))
                   1.)))
           (SIMPLIFY ($ERROR '"Sum is divergent!"))))
         (PROGN
          (IF (NOT (BOUNDP '$UPPER))
              (ADD2LNC '$UPPER $VALUES))
          (SETQ $UPPER
                  (*MMINUS
                   (SIMPLIFY
                    (MAP1 (GETOPR (TRD-MSYMEVAL $RHS '$RHS))
                          (SIMPLIFY ($SOLVE ($NUM $QUO) $VAR)))))))
         (COND
          ((NOT
            (IS-BOOLE-CHECK
             (SIMPLIFY
              (MFUNCTION-CALL $EVERY
                              (M-TLAMBDA&ENV (($U) ($VAR))
                                (DECLARE (SPECIAL $U))
                                ($FREEOF $VAR $U))
                              $UPPER))))
           (RETURN NIL)))
         (DO (($I 1. (+ 1. $I)))
             ((> $I ($LENGTH $UPPER)) '$DONE)
           (DECLARE (SPECIAL $I))
           (DO (($J 1. (+ 1. $J)))
               ((IS-BOOLE-CHECK
                 (MGRP $J
                       (MARRAYREF
                        (TRD-MSYMEVAL $MULTIPLICITIES '$MULTIPLICITIES) $I)))
                '$DONE)
             (DECLARE (SPECIAL $J))
             (IF (NOT (BOUNDP '$A))
                 (ADD2LNC '$A $VALUES))
             (SETQ $A ($CONS (MARRAYREF $UPPER $I) $A))))
         (SIMPLIFY ($SS_PRINT_MESSAGE 2. '"a=" $A))
         (PROGN
          (IF (NOT (BOUNDP '$LOWER))
              (ADD2LNC '$LOWER $VALUES))
          (SETQ $LOWER
                  (*MMINUS
                   (SIMPLIFY
                    (MAP1 (GETOPR (TRD-MSYMEVAL $RHS '$RHS))
                          (SIMPLIFY ($SOLVE ($DENOM $QUO) $VAR)))))))
         (COND
          ((NOT
            (IS-BOOLE-CHECK
             (SIMPLIFY
              (MFUNCTION-CALL $EVERY
                              (M-TLAMBDA&ENV (($U) ($VAR))
                                (DECLARE (SPECIAL $U))
                                ($FREEOF $VAR $U))
                              $LOWER))))
           (RETURN NIL)))
         (DO (($I 1. (+ 1. $I)))
             ((> $I ($LENGTH $LOWER)) '$DONE)
           (DECLARE (SPECIAL $I))
           (DO (($J 1. (+ 1. $J)))
               ((IS-BOOLE-CHECK
                 (MGRP $J
                       (MARRAYREF
                        (TRD-MSYMEVAL $MULTIPLICITIES '$MULTIPLICITIES) $I)))
                '$DONE)
             (DECLARE (SPECIAL $J))
             (IF (NOT (BOUNDP '$B))
                 (ADD2LNC '$B $VALUES))
             (SETQ $B ($CONS (MARRAYREF $LOWER $I) $B))))
         (SIMPLIFY ($SS_PRINT_MESSAGE 2. '"b=" $B))
         (PROGN
          (IF (NOT (BOUNDP '$X))
              (ADD2LNC '$X $VALUES))
          (SETQ $X
                  (SIMPLIFY
                   ($RATSIMP
                    (MUL*
                     (DIV $QUO
                          (SIMPLIFY
                           (MAPPLY-TR '"*"
                                      (SIMPLIFY
                                       (MAP1
                                        (GETOPR
                                         (M-TLAMBDA&ENV (($U) ($VAR))
                                           (DECLARE (SPECIAL $U))
                                           (ADD* $VAR $U)))
                                        $A)))))
                     (SIMPLIFY
                      (MAPPLY-TR '"*"
                                 (SIMPLIFY
                                  (MAP1
                                   (GETOPR
                                    (M-TLAMBDA&ENV (($U) ($VAR))
                                      (DECLARE (SPECIAL $U))
                                      (ADD* $VAR $U)))
                                   $B)))))))))
         (SIMPLIFY ($SS_PRINT_MESSAGE 2. '"x=" $X))
         (PROGN
          (IF (NOT (BOUNDP '$C))
              (ADD2LNC '$C $VALUES))
          (SETQ $C
                  (SIMPLIFY
                   ($SUBSTITUTE (SIMPLIFY (LIST '(MEQUAL) $VAR 0.)) $EXPR))))
         (SIMPLIFY ($SS_PRINT_MESSAGE 2. '"c=" $C))
         (COND ((LIKE $C 0.) (RETURN NIL)))
         (RETURN
          (SIMPLIFY
           ($RATSIMP
            (MUL* $C (SIMPLIFY (MFUNCTION-CALL $HGFRED $A $B $X))))))))
     '$QUO '$UPPER '$LOWER '((MLIST)) '((MLIST)) '$X '$C NIL T)
    ))
(EVAL-WHEN (:COMPILE-TOPLEVEL :LOAD-TOPLEVEL :EXECUTE)
  (MEVAL* '(($MODEDECLARE) $HARMONIC_NUMBER_EXPAND $BOOLEAN))
  (DEFPROP $HARMONIC_NUMBER_EXPAND ASSIGN-MODE-CHECK ASSIGN)
  (DEF-MTRVAR $HARMONIC_NUMBER_EXPAND NIL))
(PROGN
 (DEFPROP $SIMP_HARMONIC_NUMBER T TRANSLATED)
 (ADD2LNC '$SIMP_HARMONIC_NUMBER $PROPS)
 (DEFMTRFUN ($SIMP_HARMONIC_NUMBER $ANY MDEFINE NIL NIL)
      ($X__)
    (DECLARE (SPECIAL $X__))
    (COND ((LIKE $X__ 0.) 0.)
          ((AND ($INTEGERP $X__) (IS-BOOLE-CHECK (MLSP $X__ 1.)))
           (SIMPLIFY ($ERROR '"Zero to negative power computed.")))
          (($INTEGERP $X__)
           (SIMPLIFY (MFUNCTION-CALL $NUM_HARMONIC_NUMBER 1. $X__)))
          ((AND ($NUMBERP $X__) (IS-BOOLE-CHECK (MLSP $X__ -1.)))
           ((LAMBDA ($A $K%)
              (DECLARE (SPECIAL $K% $A))
              (ADD*
               (SIMPLIFY (MFUNCTION-CALL $SIMP_HARMONIC_NUMBER (ADD* $X__ $A)))
               (*MMINUS
                (SIMPLIFY
                 (MFUNCALL '$SUM (DIV 1. $K%) $K% $X__ (ADD* $X__ $A -1.))))))
            (*MMINUS (SIMPLIFY (LIST '($FLOOR) $X__))) '$K%))
          ((OR ($NUMBERP $X__) (TRP-NOT (LIKE (SIMPLIFY ($IMAGPART $X__)) 0.)))
           (ADD*
            (SIMPLIFY
             (MAPPLY (MARRAYREF (TRD-MSYMEVAL $PSI '$PSI) 0.)
                     (LIST (ADD* $X__ 1.))
                     '(($PSI ARRAY
                        (811.
                         "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                         SRC))
                       0.)))
            '$%GAMMA))
          (T
           ((LAMBDA ($A $B $VAR $K%)
              (DECLARE (SPECIAL $K% $VAR $B $A))
              (COND
               ((TRD-MSYMEVAL $HARMONIC_NUMBER_EXPAND NIL)
                (MSET
                 '((MLIST
                    (815.
                     "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                     SRC))
                   $A $B)
                 (SIMPLIFY (MFUNCTION-CALL $SPLIT_INTEGER_PART $X__)))
                (COND
                 ((AND (TRD-MSYMEVAL $HARMONIC_NUMBER_EXPAND NIL)
                       (IS-BOOLE-CHECK (MGRP $B 0.)))
                  (ADD*
                   (SIMPLIFY
                    (MFUNCTION-CALL $SIMPFUNCALL '$HARMONIC_NUMBER $A))
                   (SIMPLIFY
                    (MFUNCALL '$SUM (DIV 1. $K%) $K% (ADD* $A 1.)
                              (ADD* $A $B)))))
                 (T
                  (SIMPLIFY
                   (MFUNCTION-CALL $SIMPFUNCALL '$HARMONIC_NUMBER $X__)))))
               (T
                (SIMPLIFY
                 (MFUNCTION-CALL $SIMPFUNCALL '$HARMONIC_NUMBER $X__)))))
            '$A '$B '$VAR '$K%)))
    ))
(PROGN
 (DEFPROP $NUM_HARMONIC_NUMBER T TRANSLATED)
 (ADD2LNC '$NUM_HARMONIC_NUMBER $PROPS)
 (DEFMTRFUN ($NUM_HARMONIC_NUMBER $ANY MDEFINE NIL NIL)
      ($L $H)
    (DECLARE (SPECIAL $H $L))
    (COND ((IS-BOOLE-CHECK (MLSP $H $L)) 0.) ((LIKE $H $L) (DIV 1. $L))
          ((IS-BOOLE-CHECK (MLSP (ADD* $H (*MMINUS $L)) 50.))
           (MEVAL
            '(($SUM
               (824.
                "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                SRC))
              ((MQUOTIENT
                (824.
                 "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                 SRC))
               1. $I)
              $I $L $H)))
          (T
           ((LAMBDA ($MID)
              (DECLARE (SPECIAL $MID))
              (ADD* (SIMPLIFY (MFUNCTION-CALL $NUM_HARMONIC_NUMBER $L $MID))
                    (SIMPLIFY
                     (MFUNCTION-CALL $NUM_HARMONIC_NUMBER (ADD* $MID 1.) $H))))
            (SIMPLIFY (LIST '($FLOOR) (DIV (ADD* $L $H) 2.))))))
    ))
(SIMPLIFY
 (MFUNCTION-CALL $SIMPLIFYING '$HARMONIC_NUMBER '$SIMP_HARMONIC_NUMBER))
(PROGN
 (DEFPROP $SIMP_GEN_HARMONIC_NUMBER T TRANSLATED)
 (ADD2LNC '$SIMP_GEN_HARMONIC_NUMBER $PROPS)
 (DEFMTRFUN ($SIMP_GEN_HARMONIC_NUMBER $ANY MDEFINE NIL NIL)
      ($EXP__ $X__)
    (DECLARE (SPECIAL $X__ $EXP__))
    (COND ((LIKE $X__ 0.) 0.)
          ((AND ($INTEGERP $X__) (IS-BOOLE-CHECK (MLSP $X__ 1.)))
           (SIMPLIFY ($ERROR '"Zero to negative power computed.")))
          ((LIKE $EXP__ 1.) (SIMPLIFY (MFUNCTION-CALL $HARMONIC_NUMBER $X__)))
          ((TRP-NOT (IS-BOOLE-CHECK (MLSP $X__ (TRD-MSYMEVAL $INF '$INF))))
           (SIMPLIFY (LIST '(%ZETA) $EXP__)))
          ((AND ($INTEGERP $X__) ($INTEGERP $EXP__))
           (SIMPLIFY (MFUNCTION-CALL $NUM_GEN_HARMONIC_NUMBER $EXP__ 1. $X__)))
          (($INTEGERP $X__)
           (MEVAL
            '(($SUM
               (839.
                "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                SRC))
              ((MQUOTIENT
                (839.
                 "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                 SRC))
               1.
               ((MEXPT
                 (839.
                  "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                  SRC))
                $I $EXP__))
              $I 1. $X__)))
          ((OR (AND ($NUMBERP $X__) ($NUMBERP $EXP__))
               (TRP-NOT (LIKE (SIMPLIFY ($IMAGPART $X__)) 0.)))
           (MUL*
            (DIV (POWER -1. (ADD* $EXP__ 1.))
                 (SIMPLIFY `((MFACTORIAL) ,(ADD* $EXP__ -1.))))
            (ADD*
             (SIMPLIFY
              (MAPPLY (MARRAYREF (TRD-MSYMEVAL $PSI '$PSI) (ADD* $EXP__ -1.))
                      (LIST (ADD* $X__ 1.))
                      '(($PSI ARRAY
                         (841.
                          "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                          SRC))
                        ((MPLUS
                          (841.
                           "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                           SRC))
                         $EXP__
                         ((MMINUS
                           (841.
                            "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                            SRC))
                          1.)))))
             (*MMINUS
              (SIMPLIFY
               (MAPPLY (MARRAYREF (TRD-MSYMEVAL $PSI '$PSI) (ADD* $EXP__ -1.))
                       (LIST 1.)
                       '(($PSI ARRAY
                          (841.
                           "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                           SRC))
                         ((MPLUS
                           (841.
                            "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                            SRC))
                          $EXP__
                          ((MMINUS
                            (841.
                             "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                             SRC))
                           1.)))))))))
          (T
           ((LAMBDA ($A $B $VAR $K%)
              (DECLARE (SPECIAL $K% $VAR $B $A))
              (COND
               ((TRD-MSYMEVAL $HARMONIC_NUMBER_EXPAND NIL)
                (MSET
                 '((MLIST
                    (845.
                     "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                     SRC))
                   $A $B)
                 (SIMPLIFY (MFUNCTION-CALL $SPLIT_INTEGER_PART $X__)))
                (COND
                 ((AND (TRD-MSYMEVAL $HARMONIC_NUMBER_EXPAND NIL)
                       (IS-BOOLE-CHECK (MGRP $B 0.)))
                  (ADD*
                   (SIMPLIFY
                    (MFUNCTION-CALL $SIMPFUNCALL '$GEN_HARMONIC_NUMBER $EXP__
                                    $A))
                   (SIMPLIFY
                    (MFUNCALL '$SUM (DIV 1. (POWER $K% $EXP__)) $K%
                              (ADD* $A 1.) (ADD* $A $B)))))
                 (T
                  (SIMPLIFY
                   (MFUNCTION-CALL $SIMPFUNCALL '$GEN_HARMONIC_NUMBER $EXP__
                                   $X__)))))
               (T
                (SIMPLIFY
                 (MFUNCTION-CALL $SIMPFUNCALL '$GEN_HARMONIC_NUMBER $EXP__
                                 $X__)))))
            '$A '$B '$VAR '$K%)))
    ))
(PROGN
 (DEFPROP $NUM_GEN_HARMONIC_NUMBER T TRANSLATED)
 (ADD2LNC '$NUM_GEN_HARMONIC_NUMBER $PROPS)
 (DEFMTRFUN ($NUM_GEN_HARMONIC_NUMBER $ANY MDEFINE NIL NIL)
      ($A $L $H)
    (DECLARE (SPECIAL $H $L $A))
    (COND ((IS-BOOLE-CHECK (MLSP $H $L)) 0.) ((LIKE $H $L) (DIV 1. $L))
          ((IS-BOOLE-CHECK (MLSP (ADD* $H (*MMINUS $L)) 50.))
           (MEVAL
            '(($SUM
               (854.
                "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                SRC))
              ((MQUOTIENT
                (854.
                 "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                 SRC))
               1.
               ((MEXPT
                 (854.
                  "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                  SRC))
                $I $A))
              $I $L $H)))
          (T
           ((LAMBDA ($MID)
              (DECLARE (SPECIAL $MID))
              (ADD*
               (SIMPLIFY (MFUNCTION-CALL $NUM_GEN_HARMONIC_NUMBER $A $L $MID))
               (SIMPLIFY
                (MFUNCTION-CALL $NUM_GEN_HARMONIC_NUMBER $A (ADD* $MID 1.)
                                $H))))
            (SIMPLIFY (LIST '($FLOOR) (DIV (ADD* $L $H) 2.))))))
    ))
(SIMPLIFY
 (MFUNCTION-CALL $SIMPLIFYING '$GEN_HARMONIC_NUMBER '$SIMP_GEN_HARMONIC_NUMBER))
(PROGN
 (DEFPROP $GET_HARMONIC_NUMBER_ARGS T TRANSLATED)
 (ADD2LNC '$GET_HARMONIC_NUMBER_ARGS $PROPS)
 (DEFMTRFUN ($GET_HARMONIC_NUMBER_ARGS $ANY MDEFINE NIL NIL)
      ($EXPR)
    (DECLARE (SPECIAL $EXPR))
    (COND (($ATOM $EXPR) (SIMPLIFY (LIST '($SET))))
          ((LIKE ($PART $EXPR 0.)
                 (TRD-MSYMEVAL $HARMONIC_NUMBER '$HARMONIC_NUMBER))
           (SIMPLIFY (LIST '($SET) (LIST '(MLIST) 1. ($PART $EXPR 1.)))))
          ((LIKE ($PART $EXPR 0.)
                 (TRD-MSYMEVAL $GEN_HARMONIC_NUMBER '$GEN_HARMONIC_NUMBER))
           (SIMPLIFY
            (LIST '($SET) (LIST '(MLIST) ($PART $EXPR 1.) ($PART $EXPR 2.)))))
          (T
           (SIMPLIFY
            (MFUNCTION-CALL $XREDUCE (TRD-MSYMEVAL $UNION '$UNION)
                            (SIMPLIFY
                             (MAP1
                              (GETOPR
                               (TRD-MSYMEVAL $GET_HARMONIC_NUMBER_ARGS
                                             '$GET_HARMONIC_NUMBER_ARGS))
                              (SIMPLIFY ($ARGS $EXPR))))))))
    ))
(PROGN
 (DEFPROP $SPLIT_INTEGER_PART T TRANSLATED)
 (ADD2LNC '$SPLIT_INTEGER_PART $PROPS)
 (DEFMTRFUN ($SPLIT_INTEGER_PART $ANY MDEFINE NIL NIL)
      ($EXPR)
    (DECLARE (SPECIAL $EXPR))
    (COND (($INTEGERP $EXPR) (LIST '(MLIST) 0. $EXPR))
          (($ATOM $EXPR) (LIST '(MLIST) $EXPR 0.))
          ((LIKE ($PART $EXPR 0.) '"+")
           ((LAMBDA ($A $B)
              (DECLARE (SPECIAL $B $A))
              (DO (($ARG)
                   (MDO (CDR (SIMPLIFY ($ARGS $EXPR))) (CDR MDO)))
                  ((NULL MDO) '$DONE)
                (DECLARE (SPECIAL $ARG))
                (SETQ $ARG (CAR MDO))
                (COND
                 (($INTEGERP $ARG)
                  (IF (NOT (BOUNDP '$B))
                      (ADD2LNC '$B $VALUES))
                  (SETQ $B (ADD* $B $ARG)))
                 (T
                  (IF (NOT (BOUNDP '$A))
                      (ADD2LNC '$A $VALUES))
                  (SETQ $A (ADD* $A $ARG)))))
              (LIST '(MLIST) $A $B))
            0. 0.))
          (T (LIST '(MLIST) $EXPR 0.)))
    ))
(MEVAL*
 '((MDEFINE
    (879. "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
     SRC))
   (($HARMONIC_TO_PSI
     (879. "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
      SRC))
    $EXPR)
   (($OPSUBST
     (880. "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
      SRC))
    ((MLIST
      (880. "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
       SRC))
     ((MEQUAL
       (881. "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
        SRC))
      $HARMONIC_NUMBER
      ((LAMBDA
           (881.
            "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
            SRC))
       ((MLIST
         (881.
          "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
          SRC))
        $X__)
       ((MPLUS
         (881.
          "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
          SRC))
        ((MQAPPLY)
         (($PSI ARRAY
           (881.
            "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
            SRC))
          0.)
         ((MPLUS
           (881.
            "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
            SRC))
          $X__ 1.))
        $%GAMMA)))
     ((MEQUAL
       (882. "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
        SRC))
      $GEN_HARMONIC_NUMBER
      ((LAMBDA
           (882.
            "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
            SRC))
       ((MLIST
         (882.
          "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
          SRC))
        $EXP__ $X__)
       ((MTIMES
         (883.
          "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
          SRC))
        ((MQUOTIENT
          (883.
           "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
           SRC))
         ((MEXPT
           (883.
            "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
            SRC))
          ((MMINUS
            (883.
             "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
             SRC))
           1.)
          ((MPLUS
            (883.
             "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
             SRC))
           $EXP__ 1.))
         ((MFACTORIAL
           (883.
            "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
            SRC))
          ((MPLUS
            (883.
             "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
             SRC))
           $EXP__
           ((MMINUS
             (883.
              "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
              SRC))
            1.))))
        ((MPLUS
          (883.
           "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
           SRC))
         ((MQAPPLY)
          (($PSI ARRAY
            (883.
             "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
             SRC))
           ((MPLUS
             (883.
              "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
              SRC))
            $EXP__
            ((MMINUS
              (883.
               "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
               SRC))
             1.)))
          ((MPLUS
            (883.
             "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
             SRC))
           $X__ 1.))
         ((MMINUS
           (883.
            "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
            SRC))
          ((MQAPPLY)
           (($PSI ARRAY
             (883.
              "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
              SRC))
            ((MPLUS
              (883.
               "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
               SRC))
             $EXP__
             ((MMINUS
               (883.
                "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                SRC))
              1.)))
           1.)))))))
    $EXPR)))
(PROGN
 (DEFPROP $SUM_BY_PARTS T TRANSLATED)
 (ADD2LNC '$SUM_BY_PARTS $PROPS)
 (DEFMTRFUN ($SUM_BY_PARTS $ANY MDEFINE NIL NIL)
      ($FKGK $GK $K__ $M__ $N__)
    (DECLARE (SPECIAL $N__ $M__ $K__ $GK $FKGK))
    ((LAMBDA ($FK $J__ $GJ $OTH $HARMONIC_NUMBER_EXPAND)
       (DECLARE (SPECIAL $HARMONIC_NUMBER_EXPAND $OTH $GJ $J__ $FK))
       (ASSIGN-MODE-CHECK '$HARMONIC_NUMBER_EXPAND $HARMONIC_NUMBER_EXPAND)
       (PROGN
        (IF (NOT (BOUNDP '$GJ))
            (ADD2LNC '$GJ $VALUES))
        (SETQ $GJ
                (SIMPLIFY
                 ($SUBSTITUTE (SIMPLIFY (LIST '(MEQUAL) $K__ $J__)) $GK))))
       (PROGN
        (IF (NOT (BOUNDP '$OTH))
            (ADD2LNC '$OTH $VALUES))
        (SETQ $OTH
                (MUL*
                 (ADD*
                  (SIMPLIFY
                   ($SUBSTITUTE (SIMPLIFY (LIST '(MEQUAL) $K__ (ADD* $K__ 1.)))
                                $FK))
                  (*MMINUS $FK))
                 (SIMPLIFY (MFUNCALL '$SUM $GJ $J__ $M__ $K__)))))
       (ADD*
        (MUL*
         (SIMPLIFY
          ($SUBSTITUTE (SIMPLIFY (LIST '(MEQUAL) $K__ (ADD* $N__ 1.))) $FK))
         (SIMPLIFY (MFUNCALL '$SUM $GJ $J__ $M__ $N__)))
        (*MMINUS (SIMPLIFY (MFUNCALL '$SUM $OTH $K__ $M__ $N__)))))
     (DIV $FKGK $GK) (SIMPLIFY (MFUNCTION-CALL GENSYM)) '$GJ '$OTH T)
    ))
(EVAL-WHEN (:COMPILE-TOPLEVEL :LOAD-TOPLEVEL :EXECUTE)
  (MEVAL* '(($MODEDECLARE) $SUM_BY_INTEGRAL_TRANSFORMS $LIST))
  (DEFPROP $SUM_BY_INTEGRAL_TRANSFORMS ASSIGN-MODE-CHECK ASSIGN)
  (DEF-MTRVAR $SUM_BY_INTEGRAL_TRANSFORMS '((MLIST))))
(PROGN
 (DEFPROP $SUM_BY_INTEGRAL T TRANSLATED)
 (ADD2LNC '$SUM_BY_INTEGRAL $PROPS)
 (DEFMTRFUN ($SUM_BY_INTEGRAL $ANY MDEFINE NIL NIL)
      ($EXPR $VAR $LO $HI)
    (DECLARE (SPECIAL $HI $LO $VAR $EXPR))
    (COND
     ((LIKE
       ((LAMBDA ()
          ((LAMBDA (MCATCH)
             (PROG2 NIL
                 (CATCH 'MCATCH
                   (PROGN
                    (SIMPLIFY
                     (SCANMAP1
                      (GETOPR
                       (M-TLAMBDA ($U)
                         (DECLARE (SPECIAL $U))
                         (COND
                          ((AND (NOT ($ATOM $U))
                                ($MEMBER ($PART $U 0.)
                                         (LIST '(MLIST)
                                               (TRD-MSYMEVAL $HARMONIC_NUMBER
                                                             '$HARMONIC_NUMBER))))
                           ((LAMBDA (X)
                              (COND
                               ((NULL MCATCH) (DISPLA X)
                                (MERROR
                                 (INTL:GETTEXT "throw: not within 'catch'."))))
                              (THROW 'MCATCH X))
                            T)))))
                      $EXPR (TRD-MSYMEVAL $BOTTOMUP '$BOTTOMUP)))))
               (ERRLFUN1 MCATCH)))
           (CONS BINDLIST LOCLIST))))
       T)
      ((LAMBDA ($EXPR1 $X_)
         (DECLARE (SPECIAL $X_ $EXPR1))
         (SIMPLIFY
          (MFUNCTION-CALL $SUPCONTEXT
                          (SIMPLIFY
                           (MFUNCTION-CALL $CONCAT '$SUM_BY_INTEGRAL
                                           (TRD-MSYMEVAL $SIMPLIFY_SUM_DEPTH
                                                         0.)))))
         (SIMPLIFY
          (LIST '(MLIST) (ASSUME (SIMPLIFY (LIST '(MGREATERP) $X_ 0.)))
                (ASSUME (SIMPLIFY (LIST '(MLESSP) $X_ 1.)))
                (ASSUME (SIMPLIFY (LIST '(MGEQP) $VAR $LO)))
                (ASSUME (SIMPLIFY (LIST '(MLEQP) $VAR $HI)))))
         (PROGN
          (IF (NOT (BOUNDP '$EXPR1))
              (ADD2LNC '$EXPR1 $VALUES))
          (SETQ $EXPR1
                  (SIMPLIFY
                   (MFUNCTION-CALL $OPSUBST
                                   (SIMPLIFY
                                    (LIST '(MEQUAL)
                                          (TRD-MSYMEVAL $HARMONIC_NUMBER
                                                        '$HARMONIC_NUMBER)
                                          (M-TLAMBDA&ENV (($U) ($X_))
                                            (DECLARE (SPECIAL $U))
                                            (DIV
                                             (ADD* 1. (*MMINUS (POWER $X_ $U)))
                                             (ADD* 1. (*MMINUS $X_))))))
                                   $EXPR))))
         (COND
          ((LIKE
            ((LAMBDA (ERRCATCH RET)
               (DECLARE (SPECIAL ERRCATCH))
               (COND
                ((NULL
                  (SETQ RET
                          (ERRSET
                           (PROGN
                            (PROGN
                             (IF (NOT (BOUNDP '$EXPR1))
                                 (ADD2LNC '$EXPR1 $VALUES))
                             (SETQ $EXPR1
                                     (SIMPLIFY
                                      ($SIMPLIFY_SUM
                                       (SIMPLIFY
                                        ($SPLIT_SUM
                                         (SIMPLIFY
                                          ($EXPAND
                                           (SIMPLIFY
                                            (MFUNCALL '$SUM $EXPR1 $VAR $LO
                                                      $HI)))))))))))
                           LISPERRPRINT)))
                 (ERRLFUN1 ERRCATCH)))
               (CONS '(MLIST) RET))
             (CONS BINDLIST LOCLIST) NIL)
            '((MLIST)))
           (IF (NOT (BOUNDP '$EXPR1))
               (ADD2LNC '$EXPR1 $VALUES))
           (SETQ $EXPR1 NIL)))
         (SIMPLIFY
          ($KILLCONTEXT
           (SIMPLIFY
            (MFUNCTION-CALL $CONCAT '$SUM_BY_INTEGRAL
                            (TRD-MSYMEVAL $SIMPLIFY_SUM_DEPTH 0.)))))
         (DO (($TR)
              (MDO (CDR (TRD-MSYMEVAL $SUM_BY_INTEGRAL_TRANSFORMS '((MLIST))))
                   (CDR MDO)))
             ((NULL MDO) '$DONE)
           (DECLARE (SPECIAL $TR))
           (SETQ $TR (CAR MDO))
           (IF (NOT (BOUNDP '$EXPR1))
               (ADD2LNC '$EXPR1 $VALUES))
           (SETQ $EXPR1 (SIMPLIFY (MFUNCALL $TR $EXPR1))))
         (COND
          ((TRP-NOT (LIKE $EXPR1 NIL))
           (IF (NOT (BOUNDP '$EXPR1))
               (ADD2LNC '$EXPR1 $VALUES))
           (SETQ $EXPR1 (SIMPLIFY ($INTEGRATE $EXPR1 $X_ 0. 1.))))
          (T
           (IF (NOT (BOUNDP '$EXPR1))
               (ADD2LNC '$EXPR1 $VALUES))
           (SETQ $EXPR1 (SIMPLIFY (MFUNCALL '$SUM $EXPR $VAR $LO $HI)))))
         (COND
          ((AND (IS-BOOLE-CHECK (SIMPLIFY ($FREEOF_INTEGRATE $EXPR1)))
                (IS-BOOLE-CHECK (SIMPLIFY ($FREEOF_LIMIT $EXPR1))))
           $EXPR1)
          (T (SIMPLIFY (MFUNCALL '$SUM $EXPR $VAR $LO $HI)))))
       '$EXPR1 (SIMPLIFY (MFUNCTION-CALL GENSYM))))
     (T (SIMPLIFY (MFUNCALL '$SUM $EXPR $VAR $LO $HI))))
    ))
(PROGN
 (DEFPROP $FIND_F2 T TRANSLATED)
 (ADD2LNC '$FIND_F2 $PROPS)
 (DEFMTRFUN ($FIND_F2 $ANY MDEFINE NIL NIL)
      ($EXPR)
    (DECLARE (SPECIAL $EXPR))
    (COND
     (($MAPATOM $EXPR)
      (COND (($SUBVARP $EXPR) (LIST '(MLIST) $EXPR)) (T '((MLIST)))))
     (($MEMBER ($PART $EXPR 0.) (LIST '(MLIST) '"+" '"-" '"/" '"*"))
      (SIMPLIFY
       (MAPPLY-TR (TRD-MSYMEVAL $APPEND '$APPEND)
                  (SIMPLIFY
                   (MAP1 (GETOPR (TRD-MSYMEVAL $FIND_F2 '$FIND_F2))
                         (SIMPLIFY ($ARGS $EXPR)))))))
     (T (LIST '(MLIST) $EXPR)))
    ))
(PROGN
 (DEFPROP $FIND_F1 T TRANSLATED)
 (ADD2LNC '$FIND_F1 $PROPS)
 (DEFMTRFUN ($FIND_F1 $ANY MDEFINE NIL NIL)
      ($EXPR $F2 $VAR)
    (DECLARE (SPECIAL $VAR $F2 $EXPR))
    ((LAMBDA ($F21 $F1 $F11 $ALGEBRAIC)
       (DECLARE (SPECIAL $ALGEBRAIC $F11 $F1 $F21))
       (PROGN
        (IF (NOT (BOUNDP '$EXPR))
            (ADD2LNC '$EXPR $VALUES))
        (SETQ $EXPR (SIMPLIFY ($RATSIMP (MUL* $EXPR $F2 $F21)))))
       (PROGN
        (IF (NOT (BOUNDP '$F1))
            (ADD2LNC '$F1 $VALUES))
        (SETQ $F1 (SIMPLIFY ($COEFF (SIMPLIFY ($RATSIMP $EXPR)) $F21))))
       (PROGN
        (IF (NOT (BOUNDP '$F11))
            (ADD2LNC '$F11 $VALUES))
        (SETQ $F11
                (SIMPLIFY
                 ($SUBSTITUTE (SIMPLIFY (LIST '(MEQUAL) $VAR (ADD* $VAR 1.)))
                              $F1))))
       (PROGN
        (IF (NOT (BOUNDP '$EXPR))
            (ADD2LNC '$EXPR $VALUES))
        (SETQ $EXPR
                (SIMPLIFY
                 ($RADCAN
                  (ADD* $EXPR (*MMINUS (MUL* $F21 $F1)) (MUL* $F2 $F11))))))
       (COND ((LIKE $EXPR 0.) $F1)))
     (SIMPLIFY
      ($RATSIMP
       (SIMPLIFY
        ($SUBSTITUTE (SIMPLIFY (LIST '(MEQUAL) $VAR (ADD* $VAR 1.))) $F2))))
     '$F1 '$F11 T)
    ))
(PROGN
 (DEFPROP $FIND_QUOTIENT T TRANSLATED)
 (ADD2LNC '$FIND_QUOTIENT $PROPS)
 (DEFMTRFUN ($FIND_QUOTIENT $ANY MDEFINE NIL NIL)
      ($EXPR $VAR)
    (DECLARE (SPECIAL $VAR $EXPR))
    ((LAMBDA ($F2_LIST $F1 $QUOTIENT)
       (DECLARE (SPECIAL $QUOTIENT $F1 $F2_LIST))
       (PROGN
        (IF (NOT (BOUNDP '$F2_LIST))
            (ADD2LNC '$F2_LIST $VALUES))
        (SETQ $F2_LIST (SIMPLIFY ($FIND_F2 $EXPR))))
       (MEVAL
        '((MDOIN) $F2 $F2_LIST NIL NIL NIL
          ((MNOT
            (962.
             "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
             SRC))
           ((MEQUAL
             (962.
              "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
              SRC))
            $QUOTIENT NIL))
          ((MPROGN
            (962.
             "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
             SRC))
           ((MSETQ
             (963.
              "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
              SRC))
            $F1
            (($FIND_F1
              (963.
               "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
               SRC))
             $EXPR $F2 $VAR))
           ((MCOND
             (964.
              "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
              SRC))
            ((MNOTEQUAL
              (964.
               "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
               SRC))
             $F1 NIL)
            ((MSETQ
              (965.
               "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
               SRC))
             $QUOTIENT
             ((MQUOTIENT
               (965.
                "/home/robert/maxima/maxima-code/share/solve_rec/simplify_sum.mac"
                SRC))
              $F1 $F2))
            T $FALSE))))
       $QUOTIENT)
     '$F2_LIST '$F1 NIL)
    ))
(PROGN
 (DEFPROP $TELESCOPING_SUM T TRANSLATED)
 (ADD2LNC '$TELESCOPING_SUM $PROPS)
 (DEFMTRFUN ($TELESCOPING_SUM $ANY MDEFINE NIL NIL)
      ($EXPR $VAR $LO $HI)
    (DECLARE (SPECIAL $HI $LO $VAR $EXPR))
    ((LAMBDA ($QUOTIENT)
       (DECLARE (SPECIAL $QUOTIENT))
       (COND
        ((TRP-NOT (LIKE $QUOTIENT NIL))
         (ADD*
          (COND
           ((LIKE $LO (TRD-MSYMEVAL $MINF '$MINF))
            (SIMPLIFY ($LIMIT $QUOTIENT $VAR $LO)))
           (T
            (SIMPLIFY
             ($SUBSTITUTE (SIMPLIFY (LIST '(MEQUAL) $VAR $LO)) $QUOTIENT))))
          (*MMINUS
           (COND
            ((LIKE $HI (TRD-MSYMEVAL $INF '$INF))
             (SIMPLIFY ($LIMIT $QUOTIENT $VAR $HI)))
            (T
             (SIMPLIFY
              ($SUBSTITUTE (SIMPLIFY (LIST '(MEQUAL) $VAR (ADD* $HI 1.)))
                           $QUOTIENT)))))))))
     (SIMPLIFY ($FIND_QUOTIENT $EXPR $VAR)))
    ))
NIL