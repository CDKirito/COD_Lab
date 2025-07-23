.text
.globl main

main:
    li x4, 1
    li x3, 0
    li x6, 0
    li x5, 0
    li x8, 1
    li x7, 0

loop:
    addi x2, x2, -1
    beq x2, x0, end

    add x4, x8, x6
    sltu x9, x4, x8
    add x3, x7, x5
    add x3, x3, x9

    mv x6, x8
    mv x5, x7
    mv x8, x4
    mv x7, x3

    j loop

end:
    li a7, 10
    ecall