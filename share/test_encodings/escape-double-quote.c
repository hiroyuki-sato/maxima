#include <stdio.h>

main (int argc, char **argv) {

    int c1, c2;

    c1 = getchar ();
    while ((c2 = getchar ()) != -1) {
        if ((c1 == ' ') && (c2 == '"')) {
            putchar ('\\');
            putchar (c2);
            c1 = getchar ();
        }
        else {
            putchar (c1);
            c1 = c2;
        }
    }

    putchar (c1);

    return(0);
}
