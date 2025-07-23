.text
.globl main

main:
    li x4, 0          # 初始�? x4 = 0
    li x5, 1          # 初始�? x5 = 1
    li x3, 1          # 初始�? x3 = 1 (用于存储当前 Fibonacci �?)
    li x2, 10

loop:
    addi x2, x2, -1   # x2 = x2 - 1
    beq x2, x0, end   # 如果 x2 == 0，跳转到结束程序
    add x3, x4, x5    # x3 = x4 + x5
    mv x4, x5         # x4 = x5
    mv x5, x3         # x5 = x3
    j loop

end:
    li a7, 10         # ecall 结束程序
    ecall
    
