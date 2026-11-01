#ifndef MATRIX_H
#define MATRIX_H

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

// size × size matrix
// [row,col] = [ii,jj] is at [ii*size + jj]
typedef struct {
    long size;
    float* data;
} matrix;

static matrix*
alloc_matrix(long nn)
{
    matrix* mm = (matrix*)calloc(1, sizeof(matrix));
    mm->size = nn;
    mm->data = (float*)calloc(nn * nn, sizeof(float));
    return mm;
}

static void
free_matrix(matrix* mm)
{
    free(mm->data);
    free(mm);
}

static matrix*
read_matrix(const char* path)
{
    long nn;
    size_t rv;

    FILE* fh = fopen(path, "r");
    assert(fh != 0);

    rv = fread(&nn, sizeof(long), 1, fh);
    assert(rv == 1);

    matrix* yy = alloc_matrix(nn);

    rv = fread(yy->data, sizeof(float), nn * nn, fh);
    assert(rv == (size_t)(nn * nn));

    fclose(fh);
    return yy;
}

static void
write_matrix(matrix* aa, const char* path)
{
    size_t rv;

    FILE* fh = fopen(path, "w");
    assert(fh != 0);

    rv = fwrite(&(aa->size), sizeof(long), 1, fh);
    assert(rv == 1);

    rv = fwrite(aa->data, sizeof(float), aa->size * aa->size, fh);
    assert(rv == (size_t)(aa->size * aa->size));

    fclose(fh);
}

static void
print_matrix(matrix* aa)
{
    for (long ii = 0; ii < aa->size; ++ii) {
        for (int jj = 0; jj < aa->size; ++jj) {
            printf("%.01f ", aa->data[ii * aa->size + jj]);
        }
        printf("\n");
    }
}

#endif
