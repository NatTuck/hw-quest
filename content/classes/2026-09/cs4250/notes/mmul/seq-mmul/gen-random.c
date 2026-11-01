#include <assert.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

#include "matrix.h"

matrix*
gen_random(long nn)
{
    matrix* aa = alloc_matrix(nn);

    for (long ii = 0; ii < nn; ++ii) {
        for (long jj = 0; jj < nn; ++jj) {
            aa->data[ii * nn + jj] = 10 * ((float)rand() / (float)RAND_MAX);
        }
    }

    return aa;
}

int
main(int argc, char* argv[])
{
    assert(argc == 3 || argc == 4);
    long nn = atol(argv[1]);
    assert(nn > 0);

    // optional argv[3] is the seed, for reproducible matrices
    if (argc == 4) {
        srand((unsigned)atol(argv[3]));
    }
    else {
        srand((unsigned)(time(0) ^ getpid()));
    }

    matrix* aa = gen_random(nn);
    write_matrix(aa, argv[2]);
    free_matrix(aa);

    return 0;
}
