CFLAGS := -O2 -pthread
LDLIBS := -pthread

all: thread-mmul thread-mmul-avx gen-random gen-ident print-matrix gen-doub

thread-mmul: mmul.c
	$(CC) $(CFLAGS) -o $@ $< $(LDLIBS)

# same source, same -O2, plus the native ISA and a cost model that lets the
# vectorizer use it; -ffp-contract=off keeps the rounding identical to the
# scalar build so the cmp in bench.sh still passes
thread-mmul-avx: mmul.c
	$(CC) $(CFLAGS) -march=native -ffp-contract=off -fvect-cost-model=unlimited -o $@ $< $(LDLIBS)

gen-random: gen-random.c

gen-ident: gen-ident.c

gen-doub: gen-doub.c

print-matrix: print-matrix.c

clean:
	rm -f thread-mmul thread-mmul-avx gen-random gen-ident print-matrix gen-doub

.PHONY: all
