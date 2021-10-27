addi $s0,$zero, 9 #für K
addi $s1,$zero, 12 #für N

add $a0,$zero,$s0
add $a1,$zero,$s1

jal f
move $s0, $v0



f:		
		addi $sp,$sp,-4 #Stackpointer verschieben 
		sw   $ra,($sp) #Stackpointer		
		sub $t0,$a0,$a1 # n - k
		addi $t1,$zero,7 # 7
		slt $t2,$t1,$t0 # wenn 7 < n - k
		beq $t2,$zero,ELSE # If Jump
		
		
		add $t3,$a1,$a0 # n + k
		addi $v0,$t3,5 # Ergebnis von n + k + 5 in v0
		jr $ra #Rücksprung
		
ELSE:		
		add $t0,$a1,-1 # n- 1
		addi $sp, $sp, -4 # t0 sichern
		sw $t0,($sp) # Speichern von ursprüngliches a0
		
		jal G #G ausführen
		move $a1, $v0 # Rückgabe v0 in a0 schreiben 
		addi $a0,$zero, 8 #Konstante 8 für Funktion MAX
		jal MAX
		
		lw $t0, ($sp) # Laden t0
		addi $sp,$sp,4 #Stack freigeben
		
		move $a0,$t0 # n - 1
		add $a1,$zero,$v0 # von MAX
		jal f
		
		jr $ra #Rücksprung
		

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
		
MAX:	
		slt $t0, $a0, $a1
		beq $t0, $zero, MAXEQUAL
		add $v0, $zero, $a1
		jr $ra
		
MAXEQUAL:
		add $v0, $zero,$a1
		jr $ra



	
