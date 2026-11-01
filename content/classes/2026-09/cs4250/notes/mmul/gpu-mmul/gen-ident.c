#include <assert.h>
#include <stdlib.h>

#include "matrix.h"

matrix*
gen_ident(long nn)
{
    matrix* aa = alloc_matrix(nn);

    for (long ii = 0; ii < nn; ++ii) {
        aa->data[ii * nn + ii] = 1.0;
    }

    return aa;
}

int
main(int argc, char* argv[])
{
    assert(argc == 3);
    long nn = atol(argv[1]);
    assert(nn > 0);

    matrix* aa = gen_ident(nn);
    write_matrix(aa, argv[2]);
    free_matrix(aa);

    return 0;
}
