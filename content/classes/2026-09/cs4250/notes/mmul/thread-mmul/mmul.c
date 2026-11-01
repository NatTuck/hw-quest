#include <assert.h>
#include <pthread.h>

#include "matrix.h"

#define NTHREADS 4

// rows [row0,row1) of cc
typedef struct {
    matrix* aa;
    matrix* bb;
    matrix* cc;
    long row0;
    long row1;
} worker_args;

static void*
mmul_rows(void* arg)
{
    worker_args* ww = (worker_args*)arg;
    long nn = ww->aa->size;

    for (long ii = ww->row0; ii < ww->row1; ++ii) {
        for (long kk = 0; kk < nn; ++kk) {
            float a = ww->aa->data[ii * nn + kk];
            for (long jj = 0; jj < nn; ++jj) {
                ww->cc->data[ii * nn + jj] += a * ww->bb->data[kk * nn + jj];
            }
        }
    }

    return 0;
}

matrix*
mmul(matrix* aa, matrix* bb)
{
    assert(aa->size == bb->size);
    long nn = aa->size;

    // alloc_matrix() calloc()s, so cc starts at zero for the += above
    matrix* cc = alloc_matrix(nn);

    pthread_t tids[NTHREADS];
    worker_args args[NTHREADS];

    for (long tt = 0; tt < NTHREADS; ++tt) {
        args[tt].aa = aa;
        args[tt].bb = bb;
        args[tt].cc = cc;
        args[tt].row0 = nn * tt / NTHREADS;
        args[tt].row1 = nn * (tt + 1) / NTHREADS;

        int rv = pthread_create(&tids[tt], 0, mmul_rows, &args[tt]);
        assert(rv == 0);
    }

    for (long tt = 0; tt < NTHREADS; ++tt) {
        int rv = pthread_join(tids[tt], 0);
        assert(rv == 0);
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
