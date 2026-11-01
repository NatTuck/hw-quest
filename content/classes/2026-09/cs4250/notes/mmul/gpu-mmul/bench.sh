#!/bin/bash

# If a run dies instantly with a segfault and no output, check
# LD_LIBRARY_PATH: pointing it at a different ROCm than the one hipcc linked
# against loads a mismatched HSA runtime and crashes inside HSA init.
#   env -u LD_LIBRARY_PATH ./bench.sh <size>

if [ -z "$1" ]; then
  echo "need size"
  exit 1
fi

make || exit 1

./gen-ident $1 /tmp/ident.mat
./gen-random $1 /tmp/rando.mat

# drop any previous output first: if a run dies, cmp must not compare
# against a stale file and report a bogus difference (or a bogus pass)
run_one() {
  local bin=$1
  local out=$2

  rm -f "$out"
  echo "=== $bin ==="
  time ./$bin /tmp/ident.mat /tmp/rando.mat "$out"
  local rc=$?
  if [ $rc -ne 0 ]; then
    echo "$bin failed (rc=$rc) -- no output to compare"
    return 1
  fi

  # ident * rando == rando is exact for both, so cmp is still a valid check
  cmp /tmp/rando.mat "$out" || { echo "$bin: wrong result"; return 1; }
}

run_one gpu-mmul /tmp/outp.mat || exit 1
run_one gpu-mmul-blas /tmp/outp-blas.mat || exit 1
