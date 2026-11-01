#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <hip/hip_runtime.h>
#include <rocblas/rocblas.h>

#include "matrix.h"

// a bare assert says which line died; this says which call failed and why
#define HIP_CHECK(call)                                                       \
    do {                                                                      \
        hipError_t rv_ = (call);                                              \
        if (rv_ != hipSuccess) {                                              \
            fprintf(stderr, "hip error: %s -> %s (%s:%d)\n", #call,           \
                    hipGetErrorString(rv_), __FILE__, __LINE__);              \
            exit(1);                                                          \
        }                                                                     \
    } while (0)

#define BLAS_CHECK(call)                                                      \
    do {                                                                      \
        rocblas_status rv_ = (call);                                          \
        if (rv_ != rocblas_status_success) {                                  \
            fprintf(stderr, "rocblas error: %s -> %s (%s:%d)\n", #call,       \
                    rocblas_status_to_string(rv_), __FILE__, __LINE__);       \
            exit(1);                                                          \
        }                                                                     \
    } while (0)

// GPU_MMUL_TRACE=1 prints each stage, so a crash says how far it got
static void
trace(const char* what)
{
    if (getenv("GPU_MMUL_TRACE")) {
        fprintf(stderr, "trace: %s\n", what);
    }
}

static double
now(void)
{
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec + ts.tv_nsec * 1e-9;
}

// rocblas is column-major, our matrices are row-major: row-major
// cc = aa * bb is the same as column-major cc^T = bb^T * aa^T, so the
// operands go in swapped and cc comes out row-major
static void
sgemm(rocblas_handle handle, float* d_aa, float* d_bb, float* d_cc, long nn)
{
    float alpha = 1.0;
    float beta = 0.0;

    BLAS_CHECK(rocblas_sgemm(handle, rocblas_operation_none, rocblas_operation_none,
                             (rocblas_int)nn, (rocblas_int)nn, (rocblas_int)nn,
                             &alpha, d_bb, (rocblas_int)nn, d_aa, (rocblas_int)nn,
                             &beta, d_cc, (rocblas_int)nn));
}

matrix*
mmul(matrix* aa, matrix* bb)
{
    assert(aa->size == bb->size);
    long nn = aa->size;
    size_t bytes = (size_t)(nn * nn) * sizeof(float);

    // print the device up front: if a run dies, this line says whether it
    // got past HIP initialization
    int device = 0;
    hipDeviceProp_t prop;
    trace("hipGetDevice");
    HIP_CHECK(hipGetDevice(&device));
    HIP_CHECK(hipGetDeviceProperties(&prop, device));
    fprintf(stderr, "device %d: %s (%s)\n", device, prop.name, prop.gcnArchName);

    matrix* cc = alloc_matrix(nn);
    assert(cc->data != 0);

    float* d_aa;
    float* d_bb;
    float* d_cc;

    trace("hipMalloc");
    HIP_CHECK(hipMalloc(&d_aa, bytes));
    HIP_CHECK(hipMalloc(&d_bb, bytes));
    HIP_CHECK(hipMalloc(&d_cc, bytes));

    trace("hipMemcpy host->device");
    HIP_CHECK(hipMemcpy(d_aa, aa->data, bytes, hipMemcpyHostToDevice));
    HIP_CHECK(hipMemcpy(d_bb, bb->data, bytes, hipMemcpyHostToDevice));

    rocblas_handle handle;
    BLAS_CHECK(rocblas_create_handle(&handle));

    hipEvent_t start;
    hipEvent_t stop;
    HIP_CHECK(hipEventCreate(&start));
    HIP_CHECK(hipEventCreate(&stop));

    // the first call loads the rocblas kernel module, which costs seconds;
    // beta = 0 so repeating the gemm is not an accumulation
    trace("rocblas_sgemm (first call)");
    HIP_CHECK(hipEventRecord(start));
    sgemm(handle, d_aa, d_bb, d_cc, nn);
    HIP_CHECK(hipEventRecord(stop));
    HIP_CHECK(hipEventSynchronize(stop));

    float first_ms = 0.0;
    HIP_CHECK(hipEventElapsedTime(&first_ms, start, stop));

    trace("rocblas_sgemm");
    HIP_CHECK(hipEventRecord(start));
    sgemm(handle, d_aa, d_bb, d_cc, nn);
    HIP_CHECK(hipEventRecord(stop));
    HIP_CHECK(hipEventSynchronize(stop));

    float kernel_ms = 0.0;
    HIP_CHECK(hipEventElapsedTime(&kernel_ms, start, stop));

    trace("hipMemcpy device->host");
    HIP_CHECK(hipMemcpy(cc->data, d_cc, bytes, hipMemcpyDeviceToHost));

    fprintf(stderr, "kernel %8.3f ms (first call %8.3f ms)\n", kernel_ms, first_ms);

    trace("hipFree");
    BLAS_CHECK(rocblas_destroy_handle(handle));
    HIP_CHECK(hipEventDestroy(start));
    HIP_CHECK(hipEventDestroy(stop));
    HIP_CHECK(hipFree(d_aa));
    HIP_CHECK(hipFree(d_bb));
    HIP_CHECK(hipFree(d_cc));

    return cc;
}

int
main(int argc, char* argv[])
{
    assert(argc == 3 || argc == 4);

    double t0 = now();

    matrix* aa = read_matrix(argv[1]);
    trace("read_matrix A");
    matrix* bb = read_matrix(argv[2]);
    trace("read_matrix B");
    matrix* cc = mmul(aa, bb);

    if (cc->size <= 8) {
        print_matrix(cc);
    }

    if (argc == 4) {
        write_matrix(cc, argv[3]);
        trace("write_matrix");
    }

    // total includes reading the inputs, both copies, and writing the result
    fprintf(stderr, "total  %8.3f ms\n", (now() - t0) * 1e3);

    return 0;
}
