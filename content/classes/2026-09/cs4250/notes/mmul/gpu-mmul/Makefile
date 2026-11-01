HIPCC ?= hipcc
GPU_ARCH ?= native

HIPFLAGS := -O2 --offload-arch=$(GPU_ARCH)
CFLAGS := -O2

all: gpu-mmul gpu-mmul-blas gen-random gen-ident print-matrix gen-doub

# -x hip so the source can stay named mmul.c and diff against the other versions
gpu-mmul: mmul.c
	$(HIPCC) $(HIPFLAGS) -x hip -o $@ $<

# same host code, the gemm handed to rocblas
gpu-mmul-blas: mmul-blas.c
	$(HIPCC) $(HIPFLAGS) -x hip -o $@ $< -lrocblas

gen-random: gen-random.c

gen-ident: gen-ident.c

gen-doub: gen-doub.c

print-matrix: print-matrix.c

clean:
	rm -f gpu-mmul gpu-mmul-blas gen-random gen-ident print-matrix gen-doub

.PHONY: all
