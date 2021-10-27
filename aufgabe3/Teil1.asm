.data
N: .word 5
K: .word 6

.text
			
		addi $a0,$zero,K				# K
		addi $a1,$zero,N				# N
		jal f
f:
		addi $sp,$sp,-12
		sw   $ra,8($sp)
		sw   $a1,4($sp)				# a0 = N
		sw   $a0,0($sp)				# a1 = K		
		sub  $t0,$a1,$a0				# n-k
		beq  $t0,7,Else				# vgl auf t0 == 7
		slti $t0,$t0,7				# t0 < 7 --> t0 = 1	if (n - k >7)
		bne  $t0,$zero,Else			# t0 = 0 Else 
		
		add  $v0,$a0,$a1
		addi $v0,$v0,5				# n + k + 5
		addi $sp,$sp,12				# v0 is Return
		
				
ELSE:		addi $a1,$a1,-1				# n-1
		addi $s0,$zero,$a0			# speichere n-1 in s0
		

		jal G
		
		slti $t0,$v0,8				# t = g(k)<8 ?
		bne  $t0,$zero,NehmeAcht
		add  $a1,$zero,$v0
		j
		
NehmeAcht:	addi $a1,$zero,8
		jr

Jump:		addi $a0,$zero,-1

		
Return0: 	addi $a1,$a0,5				# n + k + 5
		jr $ra
		
		
G:		addi $a0,$a0,100
		addi $a1,$a0,100
		addi $a2,$a0,100
		addi $a3,$a0,100
		addi $t0,$a0,100
		addi $t1,$a0,100
		addi $t2,$a0,100
		addi $t3,$a0,100
		addi $t4,$a0,100
		addi $t5,$a0,100
		addi $t6,$a0,100
		addi $t7,$a0,100
		addi $t8,$a0,100
		addi $t9,$a0,100
		addi $v0,$a0,100
		addi $v1,$a0,100
		jr $ra

		jal f
		
