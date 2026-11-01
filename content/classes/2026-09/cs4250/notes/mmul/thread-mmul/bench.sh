#!/bin/bash

if [ -z "$1" ]; then
  echo "need size"
  exit 1
fi

# avoid power-of-two sizes (1024, 2048, ...): the row stride lands on one
# cache set and the timing measures that instead of the code
make

./gen-ident $1 /tmp/ident.mat
./gen-random $1 /tmp/rando.mat

echo "== Threads =="
time ./thread-mmul /tmp/ident.mat /tmp/rando.mat /tmp/outp.mat
echo
echo "== Threads + AVX =="
time ./thread-mmul-avx /tmp/ident.mat /tmp/rando.mat /tmp/outp.mat

cmp /tmp/rando.mat /tmp/outp.mat
