# add2.S -- initial RISC-V assembly demo.
#
# Build and run natively on the SG2000:
#   gcc -no-pie -o add2 add2.S
#   ./add2

.global main
.section .text

# long add2(long x)
#   argument x comes in a0, result goes in a0.
add2:
    addi a0, a0, 2
    ret

main:
    # Prologue: save ra, keep sp 16-byte aligned.
    addi sp, sp, -16
    sd   ra, 8(sp)

    # long x = 5;
    li   a0, 5

    # long y = add2(x);
    call add2

    # printf("%ld\n", y);
    mv   a1, a0
    la   a0, long_fmt
    call printf

    # return 0;
    li   a0, 0
    ld   ra, 8(sp)
    addi sp, sp, 16
    ret

.section .data
long_fmt: .string "%ld\n"
