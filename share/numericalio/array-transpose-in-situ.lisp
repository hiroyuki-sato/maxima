;; ARRAY-TRANSPOSE-IN-SITU -- in-situ transpose a 2-d array stored in a vector
;; copyright 2015 by Robert Dodier
;; I release this work under terms of the GNU General Public License.

;; see Ref. 1 for background and further info. I got some inspiration from
;; Brenner's article but the algorithm implemented here is simpler, because
;; here we keep a bit vector to mark all of the elements as assigned or not.
;; So there's no pressure to search for cycles -- we just march through the
;; bit vector, find an unassigned element, and loop through its cycle,
;; marking elements as we go. That requires additional storage proportional
;; to the size of the array, but that's acceptable assuming that bits are
;; much smaller than the elements (e.g. double floats) in the array.
;;
;; [1] Norman Brenner, Algorithm 467: Matrix Transposition in Place,
;; Communications of the ACM, November 1973, Volume 16, Number 11, pages 692-694.

(defun array-transpose-in-situ (a m n)
  (if (= m n)
    (array-transpose-in-situ-square a m)
    (array-transpose-in-situ-general a m n)))

(defun array-transpose-in-situ-square (a m)
  (dotimes (i m)
    (dotimes (j i)
      (let*
        ((ij (+ (* i m) j))
         (ji (+ (* j m) i))
         (foo (aref a ij)))
        (setf (aref a ij) (aref a ji))
        (setf (aref a ji) foo)))))

(defun array-transpose-in-situ-general (a m n)
  (let*
    ((mn (* m n))
     (mn1 (1- mn))
     (assigned-p (make-array mn :element-type 'bit :initial-element #b0)))
    ;; Omit first and last elements, as they never move
    ;; (and COMES-FROM handles MN1 incorrectly).
    (loop for i from 1 to (1- mn1) do
      (if (= (aref assigned-p i) #b0)
        (let ((j (comes-from i n mn)))
          (when (not (= j i))
            ;; Element I hasn't been assigned yet, and it has a nontrivial cycle.
            ;; Move all elements in its cycle, marking them as we go.
            (let* ((i0 i) (a-i0 (aref a i0)) (ii i))
              (loop until (= j i0) do
                    (setf (aref a ii) (aref a j))
                    (setf (aref assigned-p ii) #b1)
                    (setq ii j j (comes-from j n mn)))
              (setf (aref a ii) a-i0)
              (setf (aref assigned-p ii) #b1))))))))

(defun comes-from (i n mn)
  (mod (* i n) (1- mn)))

;; stuff for testing

#|
(defun make-array-ij (m n)
  (let ((stuff (apply #'append (loop for i from 0 to (1- m) collect (loop for j from 0 to (1- n) collect (list i j))))))
    (make-array (* m n) :initial-contents stuff)))

(defun make-array-ji (n m)
  (let ((stuff (apply #'append (loop for i from 0 to (1- n) collect (loop for j from 0 to (1- m) collect (list j i))))))
    (make-array (* n m) :initial-contents stuff)))

(defun test-general-transpose (m n)
  (let* ((a (make-array-ij m n)) (a0 (copy-seq a)))
   (array-transpose-in-situ-general a m n)
   (let ((a-should-be (make-array-ji n m)))
     (every #'equalp a a-should-be))))

(compile 'comes-from)
(compile 'array-transpose-in-situ-square)
(compile 'array-transpose-in-situ-general)
(compile 'array-transpose-in-situ)

(test-general-transpose 7 17)
(test-general-transpose 17 7)
(test-general-transpose 10 10)
(test-general-transpose 100 100)
(test-general-transpose 500 20)
(test-general-transpose 20 500)

(defparameter a1 (make-array 5000000 :element-type 'double-float :initial-element 1d0))

(array-transpose-in-situ-general a1 100 100)
(array-transpose-in-situ-general a1 20 500)
(array-transpose-in-situ-general a1 500 20)
(array-transpose-in-situ-general a1 2221 2239)

(time (array-transpose-in-situ-general a1 1000000 5))
(time (array-transpose-in-situ-general a1 5 1000000))
(time (array-transpose-in-situ-general a1 2236 2236))
(time (array-transpose-in-situ-square a1 2236))
 |#
