.data
	n:	.word 20
	outstr1: .asciiz "Die "
	outstr2: .asciiz ". Primzahl ist "

.macro int_array_addr(%reg,%addr,%offset) # %reg <-- Adresse von %addr[%offset]
	move %reg,%offset
	sll %reg,%reg,2
	add %reg, %reg, %addr
.end_macro

.macro load_int(%dest,%aux,%addr,%offset)  # %dest <-- %addr[%offsetr], %aux: Hilfsregister
	int_array_addr(%aux,%addr,%offset)
	lw %dest,0(%aux)
.end_macro

.macro store_int(%store,%aux,%addr,%offset) # %store --> %addr[%offsetr], %aux: Hilfsregister
	int_array_addr(%aux,%addr,%offset)
	sw %store,0(%aux)
.end_macro
			
.text
	# Hauotprogramm
	lw $a0, n	# Laden von a
	jal getPrime	# Prozedur getPrime aufrufen
	move $s0,$v0	# Rückgabewert sichern
	# Ausgabe
	li $v0,4
	la $a0,outstr1
	syscall
	li $v0,1
	lw $a0, n
	syscall
	li $v0,4
	la $a0,outstr2
	syscall
	li $v0,1
	move $a0,$s0
	syscall
	# Programm mit Systemaufruf 10 beednen
	li $v0, 10
	syscall

# Prozedur isDivisor(a,b)
isDivisor:

# Prozedur getPrime(n)
getPrime:
		
		
	
		
		
		
	
	
	
	
	
		
		
