Description: <short summary of the patch>
 TODO: Put a short summary on the line above and replace this paragraph
 with a longer explanation of this change. Complete the meta-information
 with other relevant fields (see below for details). To make it easier, the
 information below has been extracted from the changelog. Adjust it or drop
 it.
 .
 maxima (5.45.1-5) unstable; urgency=medium
 .
   * Bug fix: "fails to install with xemacs21", thanks to Andreas Beckmann
     (Closes: #999626).
Author: Camm Maguire <camm@debian.org>
Bug-Debian: https://bugs.debian.org/999626

---
The information above should follow the Patch Tagging Guidelines, please
checkout http://dep.debian.net/deps/dep3/ to learn about the format. Here
are templates for supplementary fields that you might want to add:

Origin: <vendor|upstream|other>, <url of original patch>
Bug: <url in upstream bugtracker>
Bug-Debian: https://bugs.debian.org/<bugnumber>
Bug-Ubuntu: https://launchpad.net/bugs/<bugnumber>
Forwarded: <no|not-needed|url proving that it has been forwarded>
Reviewed-By: <name and email of someone who approved the patch>
Last-Update: 2021-11-20

--- maxima-5.45.1.orig/interfaces/emacs/imaxima/imath.el
+++ maxima-5.45.1/interfaces/emacs/imaxima/imath.el
@@ -58,7 +58,7 @@
 ;;     A folder is created to store all the formula images. They
 ;;     are referenced from the HTML document by using <IMG> tag.
 
-(require 'cl-lib)
+(require 'cl);FIXME cl-lib, xemacs21 compatibility
 (require 'imaxima)
 
 (if (featurep 'xemacs)
