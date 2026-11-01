#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <hip/hip_runtime.h>

#include "matrix.h"

#define BLOCK 16

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

// one thread per element of cc: cc[ii][jj] = sum_kk aa[ii][kk] * bb[kk][jj]
static __global__ void
mmul_kernel(const float* __restrict__ aa, const float* __restrict__ bb, float* __restrict__ cc, long nn)
{
    long jj = blockIdx.x * blockDim.x + threadIdx.x;
    long ii = blockIdx.y * blockDim.y + threadIdx.y;

    if (ii < nn && jj < nn) {
        float sum = 0.0;
        for (long kk = 0; kk < nn; ++kk) {
            sum += aa[ii * nn + kk] * bb[kk * nn + jj];
        }
        cc[ii * nn + jj] = sum;
    }
}

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

    unsigned blocks = (unsigned)((nn + BLOCK - 1) / BLOCK);
    dim3 block(BLOCK, BLOCK);
    dim3 grid(blocks, blocks);

    hipEvent_t start;
    hipEvent_t stop;
    HIP_CHECK(hipEventCreate(&start));
    HIP_CHECK(hipEventCreate(&stop));

    trace("kernel");
    HIP_CHECK(hipEventRecord(start));
    mmul_kernel<<<grid, block>>>(d_aa, d_bb, d_cc, nn);
    HIP_CHECK(hipGetLastError());
    HIP_CHECK(hipEventRecord(stop));
    HIP_CHECK(hipEventSynchronize(stop));

    float kernel_ms = 0.0;
    HIP_CHECK(hipEventElapsedTime(&kernel_ms, start, stop));

    trace("hipMemcpy device->host");
    HIP_CHECK(hipMemcpy(cc->data, d_cc, bytes, hipMemcpyDeviceToHost));

    fprintf(stderr, "kernel %8.3f ms\n", kernel_ms);

    trace("hipFree");
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
