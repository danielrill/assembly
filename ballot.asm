#Ballot.s
#Beispielprogramm für die SPIM Prozedurkonvention
# Zur verdeutlichung der Konvention seien die Register $a1 bis $a3 nict existent

.data
input1:	.asciiz "\nBallot (n,m)\nn=0: Ende \n\tn= "
input2:	.asciiz	"\tm= "
output:	.asciiz	"\nBallot (n,m) = "

.text
main:
#TestUmgebung fuer die Prozedur Ballot
#ruft ballot mit den vom Benutzer eingegebenen Werten
#auf bis dieser mit n oder m = 0 beendet.
	li	$v0, 4			#Eingabe anfordern
	la	$a0, input1
	syscall
	li 	$v0, 5
	syscall
	beqz	$v0, exit
	move	$t0, $v0			# $t0 = n
	li	$v0, 4
	la	$a0, input2
	syscall
	li	$v0, 5
	syscall
	beqz	$v0, exit
	sub	$sp, $sp, 4
	
	sw	$v0, 4($sp)
	move	$a0, $t0
	jal	ballot
	
	add	$sp, $sp, 4		# sp wiederherstellen
	move	$t0, $v0			# t0 = ballot(n,m)
	li	$v0, 4			# Ergebnis ausgeben
	la	$a0, output
	syscall
	li	$v0, 1
	move	$a0, $t0
	syscall
	j	main
exit:	li	$v0, 10
	syscall
	
ballot:
# Berechnet die Ballot-Zahl ballot(n,m)
# Argument 1 ($a0)	: n
# Argument 2 (Stack)	: m --> 4($fp)
# Ergebnis in $v0
# Registerbelegung innerhalb Prozedur:
# $a0 : n
# $s0 : m  (besser wäre $t0)
# $t0 : ZwischenErgebnis

	sub	$sp, $sp, 12		#Erstelle Stackframe
	sw	$fp, 12($sp)		#Register sichern
	sw	$ra, 8($sp)
	sw	$s0, 4($sp)
	
	addi	$fp, $sp, 12		#FramePointer erstellen
	lw	$s0, 4($fp)		# m laden
	
					#Berechne BallotZahlen
	beq	$a0, 1, min1		# If n = 1,  then ballot = -1
	beq	$s0, 1, plus1		# ElseIf m = 1,  then ballot = 1
					# Else ballot (n,m) =
					# ballot(n, m-1) + 
					# ballot(n-1,m) END;
					# Aufruf ballot (n, m-1)
	sub	$sp, $sp, 12		# Register sichern
	sw	$a0, 12($sp)
	sw	$s0, 8($sp)		# a0 und s0 nochmal neu sichern
	sub	$s0, $s0, 1		# t0 wurde bisher nicht genutzt
	
	sw	$s0, 4($sp)		# (m-1) muss berechnet werden
	jal	ballot			# Prozedurstart
	
	lw	$s0, 12($sp)		# Register wiederherstellen
	lw	$s0, 8($sp)
	addi	$sp, $sp , 12		# Register sichern
	move	$t0, $v0			# Ergebnis sichern		
	sub	$a0, $a0, 1		# Aufruf ballot (n-1, m)
	
	sub	$sp, $sp, 8		# Register sichern
	sw	$t0, 8($sp)		# t0 sichern, a0 nicht mehr benutzt
	sw	$s0, 4($sp)		# Argument übergeben
	
	jal	ballot
	
	lw	$t0, 8($sp)		# Register wiederherstellen
	addi	$sp, $sp, 8		# stackPointer wiederherstellen
	add	$v0, $v0, $t0		# Funktionsergebnis berechnen

tollab:	
	lw	$fp, 12($sp)		# register wiederherstellen
	lw	$ra, 8($sp)
	lw	$s0, 4($sp)
	addi	$sp, $sp, 12		# Stackframe löschen
	jr	$ra			# Rücksprung
	
min1:	li	$v0, -1			# ballot = -1
	j	tollab
	
plus1:	li	$v0, 1			# ballot = 1
	j	tollab