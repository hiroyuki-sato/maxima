(in-package :cl-info)
(let (
(deffn-defvr-pairs '(
; CONTENT: (<INDEX TOPIC> . (<FILENAME> <BYTE OFFSET> <LENGTH IN CHARACTERS> <NODE NAME>))
("kovacicODE" . ("kovacicODE.info" 716 1431 "Definitions for kovacicODE"))
))
(section-pairs '(
; CONTENT: (<NODE NAME> . (<FILENAME> <BYTE OFFSET> <LENGTH IN CHARACTERS>))
("Definitions for kovacicODE" . ("kovacicODE.info" 654 1493))
("Introduction to kovacicODE" . ("kovacicODE.info" 450 63))
)))
(load-info-hashtables (list (pathname-device #-gcl *load-pathname* #+gcl sys:*load-pathname*) (pathname-directory #-gcl *load-pathname* #+gcl sys:*load-pathname*)) deffn-defvr-pairs section-pairs))