#include <assert.h>

#include "matrix.h"

int
main(int argc, char* argv[])
{
    assert(argc == 2);
    matrix* aa = read_matrix(argv[1]);
    print_matrix(aa);
    free_matrix(aa);

    return 0;
}
