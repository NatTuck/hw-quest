#!/bin/bash

if [ -z "$1" ]; then
  echo "need size"
  exit 1
fi

make

./gen-ident $1 /tmp/ident.mat
./gen-random $1 /tmp/rando.mat
#time ./mmul /tmp/ident.mat /tmp/rando.mat /tmp/outp.mat
time ./mmul2 /tmp/ident.mat /tmp/rando.mat /tmp/outp.mat

cmp /tmp/rando.mat /tmp/outp.mat
