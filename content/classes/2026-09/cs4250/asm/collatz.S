# collatz.S -- recipe demo: translate a C function to RISC-V.
#
# Build and run natively on the SG2000:
#   gcc -no-pie -o collatz collatz.S
#   ./collatz
#
# C version:
#
#   long iterate(long x) {
#       if (x % 2 == 0) {
#           return x / 2;
#       } else {
#           return x * 3 + 1;
#       }
#   }
#
#   int main(int argc, char* argv[]) {
#       long x = 27;
#       long i = 0;
#       while (x > 1) {
#           printf("%ld\n", x);
#           x = iterate(x);
#           i++;
#       }
#       printf("i = %ld\n", i);
#       return 0;
#   }

.global main
.section .text

# long iterate(long x) -- leaf function, no stack frame needed.
#   x in a0, result in a0.
iterate:
    # if (x % 2 == 0)
    li   t0, 2
    rem  t1, a0, t0        # t1 = x % 2
    bnez t1, iterate_odd   # if (x % 2 != 0) skip to the odd branch

    # return x / 2;
    div  a0, a0, t0
    ret

iterate_odd:
    # return x * 3 + 1;
    li   t0, 3
    mul  a0, a0, t0
    addi a0, a0, 1
    ret

main:
    # Prologue: 3 saved values -> 24 bytes, rounded up to 32.
    # x lives in s0, i lives in s1: both must survive calls to iterate/printf.
    addi sp, sp, -32
    sd   ra, 24(sp)
    sd   s0, 16(sp)
    sd   s1, 8(sp)

    # long x = 27;
    li   s0, 27

    # long i = 0;
    li   s1, 0

loop_start:
    # while (x > 1) -- exit the loop when x <= 1.
    li   t0, 1
    ble  s0, t0, loop_end

    # printf("%ld\n", x);
    la   a0, long_fmt
    mv   a1, s0
    call printf

    # x = iterate(x);
    mv   a0, s0
    call iterate
    mv   s0, a0

    # i++;
    addi s1, s1, 1

    j    loop_start

loop_end:
    # printf("i = %ld\n", i);
    la   a0, iter_fmt
    mv   a1, s1
    call printf

    # return 0;
    li   a0, 0
    ld   s1, 8(sp)
    ld   s0, 16(sp)
    ld   ra, 24(sp)
    addi sp, sp, 32
    ret

.section .data
long_fmt: .string "%ld\n"
iter_fmt: .string "i = %ld\n"
