.data
N: .word 6
A: .word 3 4 6 8 11 13
B: .word 0 0 0 0 0 0
.text
lw $t1, N
la $t0, A
la $t2, B
addi $t6, $zero, 0
jal ARRAY
j EXIT
ARRAY:
addi $t5, $ra, 0
loop: beq $t1, 0, Exit
lw $t3, 0($t0)
jal ISODD
bne $t8, $zero, Else
sw $t3, 0($t2)
addi $t6, $t6, 1
Else: addi $t0, $t0, 4
addi $t2, $t2, 4
addi $t1, $t1, -1
j loop
Exit: addi $ra, $t5, 0
jr $ra
ISODD:
andi $t8, $t3, 1
jr $ra
EXIT:
