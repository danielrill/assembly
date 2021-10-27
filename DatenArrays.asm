	.data

	N: .word 6
	A: .word 1 2 3 4 5 6

	.text
	lw $t1, N
	la $t0, A
	addi $s0, $zero, 0
	jal ARRAY
	j EXIT
ARRAY:
loop: 	beq $t1, 0, Exit
	lw $t2, 0($t0)
	add $s0, $s0, $t2
	addi $t0, $t0, 4
	addi $t1, $t1, -1
	
	j loop

Exit: 	jr $ra
EXIT:
