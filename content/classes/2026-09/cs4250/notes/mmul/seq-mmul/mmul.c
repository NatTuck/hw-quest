
#include <assert.h>

#include "matrix.h"

matrix*
mmul(matrix* aa, matrix* bb)
{
    assert(aa->size == bb->size);
    long nn = aa->size;

    matrix* cc = alloc_matrix(nn);

    for (int ii = 0; ii < nn; ++ii) {
        for (int jj = 0; jj < nn; ++jj) {
            // matrix is already zeroed
            for (int kk = 0; kk < nn; ++kk) {
                cc->data[ii * nn + jj] += aa->data[ii * nn + kk] * bb->data[kk * nn + jj];
            }
        }
    }

    return cc;
}

int
main(int argc, char* argv[])
{
    assert(argc == 3 || argc == 4);
    matrix* aa = read_matrix(argv[1]);
    matrix* bb = read_matrix(argv[2]);
    matrix* cc = mmul(aa, bb);

    if (cc->size <= 8) {
        print_matrix(cc);
    }

    if (argc == 4) {
        write_matrix(cc, argv[3]);
    }

    return 0;
}
