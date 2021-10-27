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
		blt $a1,0,REST
		
		
REST:				

		

# Prozedur getPrime(n)
getPrime: 
		addi $s0,$zero, 2    #für p =2
		move $s1 ,$zero # k  ;für Anzahl Primmzahlen
		move $s2,$zero # j  ;Laufvariable
		move $s ,	# Array A200
		
IF:		#If

		addi $sp,$sp,-4 #Stackpointer verschieben 
		sw   $ra,($sp) #Stackpointer
		
		blt $a0,200,LOOP # n < 200 ?
		beq $a0,200,LOOP # n = 200 ?  
		
		add $a0,$zero,$zero  # n = 0
		addi $v0,$a0,0	 # a0 in v0 sichern
	
		jr $ra

LOOP:	#While SChleife ( k < n)
		addi $sp,$sp,-4 #Stackpointer verschieben 
		sw   $ra,($sp) #Stackpointer
		
		blt $s1,$a0,WHILE1 # k < n
		sub $v1,$s0,1 # return p -1
		
		jr ENDE
				
WHILE1:		move $s2,$zero # j  ;Laufvariable
		
		addi $a1,$s0,0 # P in a1 speichern
		add $a2,$s2,   # adresse vom Array 
		blt $s2,$s1,isDivisor
		
		
		

		
		
	
	
	
	
	
		
		
