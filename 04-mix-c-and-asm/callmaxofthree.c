/*
 * A small program that illustrates how to call the maxofthree function we wrote
 * in assembly language.
 *
 * gcc -arch x86_64 -o mo3 callmaxofthree.c maxofthree.o
 */

#include <inttypes.h>
#include <stdio.h>

int64_t maxofthree(int64_t, int64_t, int64_t);

int main()
{
    printf("%lld\n", maxofthree(1, -4, -7));
    printf("%lld\n", maxofthree(2, -6, 1));
    printf("%lld\n", maxofthree(2, 3, 1));
    printf("%lld\n", maxofthree(-2, 4, 3));
    printf("%lld\n", maxofthree(2, -6, 5));
    printf("%lld\n", maxofthree(2, 4, 6));

    return 0;
}
