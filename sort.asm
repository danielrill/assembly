# Swap und BubbleSort (Patterson & Hennessy)

.data
	n:	.word 10
	a:	.word 5 9 10 33 4 6 12 41 88 2
	outstr1: .asciiz "Die Sortierfolge lautet: "
	outstr2: .asciiz ". Primzahl ist "
	
.text
	# Hauptprogramm
	lw $t1, n
	la $t0, a
	
sort:	
	# Register retten
	addi	$sp, $sp, -20		#Platz im Stack für 5Reg
	sw	$ra, 16($sp)		#sichere ra im Stack
	sw	$s3, 12($sp)		#sichere s3 im Stack
	sw	$s2, 8($sp)		#sichere s2 im Stack
	sw	$s1, 4($sp)		#sichere s1 im Stack
	sw 	$s0, 0($sp)		#sichere s0 im Stack
	#Prozedurrumpf
	move	$s2, $a0			#kopiere a0 in s2 (sichere a0)
	move	$s3, $a1			#kopiere s3 in a1 (sichere a1)
	#Äußere Schleife
	move	$s2, $a0			# i = 0
for1tst:slt	$t0, $s1, $s3		# t0 = 0, wenn s0 <= s3	(i<=n)
	beq	$t0, $zero, exit1	#branch zu exit1, wenn s0 <= s3	(i<=n)
	#Innere Schleife
	addi	$s1, $s0, -1		#j = i-1
for2tst:slti	$t0, $s1, 0		#t1 = 1, wenn s1 < 0  (j<0)
	bne	$t0, $zero, exit2	#branch zu exit2, wenn s1 < 0  (j<0=)
	sll	$t1, $s1, 2		#Reg t1 = j*4
	add	$t2, $s2, $t1		#Reg t2 = v + (j*4)
	lw	$t3, 0($t2)		#Reg t3 = v[j]
	lw	$t4, 4($t2)		#Reg t4 = v[j+1]
	slt	$t0, $t4, $t3		#Reg t0 = 0, wenn t4 >= t3
	beq	$t0, $zero, exit2	#branch zu exit2, wenn t4 >= t3
	#Param übergeben und Aufruf
	move 	$a0, $s2			#1. Param von Swap ist v (alter Wert von a0)
	move	$a1, $s1			#2. Param von Swap ist j
	jal 	swap			#springe zu swap
	
	#Innere Schleife
	addi	$s1, $s1, -1		#j -= 1
	j	for2tst			#springe zum test der inneren Schleife
	#Äußere Schleife
exit2:	addi	$s0, $s0, 1		#i += 1
	j	for1tst			#springe zum test der äußeren Schleife
	#Register wiederherstellen
exit1:	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)
	lw	$s3, 12($sp)
	lw	$ra, 16($sp)
	addi	$sp, $sp, 20		#StackPointer wiederherstellen
	
	jr	$ra
swap:
	sll	$t1, $a1, 2		#Reg $t1 = k*4
	add	$t1, $a0, $t1		# t1 = v + (k*4)
					# Reg. hält die Adresse von v[k]
	lw 	$t0, 0($t1)		# temp Reg t0 = v[k]
	lw 	$t2, 4($t1)		# temp Reg t2 = v[k+1]
	
	sw 	$t2, 0($t1)		#v[k] = Reg t2
	sw 	$t0, 4($t1)		#v[k+1] = Reg t0
	
	jr 	$ra			#back zur Prozedur