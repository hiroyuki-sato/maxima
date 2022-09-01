#!/bin/sh

usage () {
    echo "build_html.sh [-Dh?]"
    echo "    -D   Enable simple debugging of this script"
    echo "    -h   This help"
    echo "    -?   This help"
    echo "Build the html version of the manual, including both the single"
    echo "page version and the multi-page version.  This also builds all the"
    echo "category information."
    exit 1
}

while getopts "h?D" arg
do
  case $arg in
      D) DEBUG=yes ;;
      h) usage ;;
      \?) usage ;;
  esac
done

# If output dir exists, remove it so we start clean
if [ -d tmp_html ]; then
    rm -rf tmp_html
fi
mkdir tmp_html
cd tmp_html

for f in /home/vttoth/dev/maxima/doc/info/ja/*.texi
do
  filenamebase=`echo $f | /usr/bin/sed -e 's/^.*\///;s/\.texi//'`
  /usr/bin/sed -e "s/^@\(deffn\|defvr\)[x]*  *{[^}]*}  *\([^[:blank:]]*\).*/@anchor{Item: $filenamebase\/\1\/\2}\n&/;" -e "s/^@node  *\([^,]*\).*/@anchor{Item: $filenamebase\/node\/\1}\n&/" $f \
  | gawk 'BEGIN { iftex = 0; } /^@iftex/ {iftex = 1;} {if (!iftex) {print;}} /^@end iftex/ {iftex = 0;}' \
  | gawk '/@anchor/ {if (!(foo[$0])) {foo[$0] = 1; print;}} !/@anchor/' > $(basename $f)
done 

catprogname=make-categories.lisp
for f in *.texi
do
  filenamebase=`echo $f | /usr/bin/sed -e 's/^.*\///;s/\.texi//'`
  echo "(setq *filenamebase* \"$filenamebase\")"
  cat $f
done | gawk '!/^@c / && !/^@c$/ && (/^@deffn/ || /^@defvr/ || /^@end deffn/ || /^@end defvr/ || /@category/ || /@node/ || /^.setq .filenamebase/)' | /usr/bin/sed -f /home/vttoth/dev/maxima/doc/info/ja/../extract_categories1.sed | gawk -f /home/vttoth/dev/maxima/doc/info/ja/../extract_categories1.awk > $catprogname 

if [ "gcl" = "gcl" ]
    then lispprog="gcl"
         lispargs="-batch -load $catprogname"
elif [ "gcl" = "clisp" ]
    then lispprog="clisp"
         lispargs="$catprogname"
elif [ "gcl" = "cmucl" ]
    then lispprog="lisp"
         lispargs="-load $catprogname -eval (quit)"
elif [ "gcl" = "scl" ]
    then lispprog="scl"
         lispargs="-load $catprogname -eval (quit)"
elif [ "gcl" = "ecl" ]
    then lispprog="ecl"
         lispargs="--shell $catprogname"
elif [ "gcl" = "ccl64" ]
    then lispprog="dx86cl64"
         lispargs="--load $catprogname --eval (quit)"
# NOT SURE ABOUT OPENMCL; SAME ARGS AS CCL/CCL64 OR DIFFERENT ??
elif [ "gcl" = "ccl" -o "gcl" = "openmcl" ]
    then lispprog="openmcl"
         lispargs="--load $catprogname --eval (quit)"
elif [ "gcl" = "sbcl" ]
    then lispprog="sbcl"
         lispargs="--script $catprogname"
elif [ "gcl" = "abcl" ]
    then lispprog="java"
         lispargs="-jar /home/vttoth/dev/maxima/abcl.jar --load $catprogname --eval (quit)"
elif [ "gcl" = "acl" ]
    then lispprog="lisp"
         lispargs="-L $catprogname --kill"
else
    echo "$0: DEFAULTLISP = gcl not recognized, assume 'gcl $catprogname' is acceptable."
    lispprog="gcl"
    lispargs="$catprogname"
fi

echo "$0: execute category program: \"$lispprog\" $lispargs"
"$lispprog" $lispargs

/usr/bin/sed -e 's/^@bye/@node Documentation Categories, , Function and Variable Index\n@chapter Documentation Categories/' /home/vttoth/dev/maxima/doc/info/ja/maxima.texi > maxima.texi 
( for f in Category-*.texi; do echo '@include' $f; done ; echo @bye ) >> maxima.texi 

if [ "X$DEBUG" = "Xyes" ]; then
    set -x
fi

# --no-node-files so we don't have thousands of little html files
# --force -e 10000 because the category stuff causes lots of errors.
TEXIOPT="--html -c INLINE_CONTENTS=0 --force -e 10000 --document-lang=ja -I . -I .. -I /home/vttoth/dev/maxima/doc/info/ja -I /home/vttoth/dev/maxima/doc/info/ja/.. --css-include=/home/vttoth/dev/maxima/doc/info/ja/../manual.css --init-file /home/vttoth/dev/maxima/doc/info/ja/../texi2html.init"
makeinfo --split=chapter --no-node-files --output="/home/vttoth/dev/maxima/doc/info/ja" $TEXIOPT maxima.texi 
makeinfo --no-split --output="/home/vttoth/dev/maxima/doc/info/ja/maxima_singlepage.html" $TEXIOPT maxima.texi 

if [ "X$DEBUG" = "Xyes" ]; then
    set +x
fi

cd ..

if [ "X$DEBUG" != "Xyes" ]; then
    rm -r -f tmp_html
fi
