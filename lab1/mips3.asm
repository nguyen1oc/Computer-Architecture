.data
	myAr: .word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
	string0: .asciiz "Please chose mode (1:Print the value, 2:Print from the value): "
	string0.5: .asciiz "Invalid Value\n"
	string1: .asciiz "Enter the index you want (between 0 and 14): "
	string1.5: .asciiz "The answer is: "
	string2: .asciiz " "
.text
	la $t2,myAr #load address
	la $t0,15 #nums of element
takethemode:
	li $v0,4	#print the string
	la $a0,string0
	syscall
	
	li $v0,5	#take the mode
	syscall		
	move $t1,$v0
	
	beq $t1,1,mode_1 #move to mode
	beq $t1,2,mode_2
	
	li $v0,4	 #prin invalid
	la $a0,string0.5
	syscall
	j takethemode
mode_1:
	li $v0,4	#print string index
	la $a0,string1
	syscall
	
	li $v0,5	#take index
	syscall
	move $t3,$v0
	
whileandwhile:
		
	addi $t3,$t3,1
	
	li $v0,4
	la $a0,string1.5
	syscall
	
	li $v0,1	#print answer
	move $a0,$t3
	syscall
	
	j exit
	
mode_2:
	li $v0,4	#print string index
	la $a0,string1
	syscall
	
	li $v0,5	#take index
	syscall
	move $t3,$v0
	
	sub $t0,$t0,$t3
	
	li $v0,4
	la $a0,string1.5 #answeris
	syscall
whilemore:
	lw $t4,0($t2)
	addi $t2,$t2,4
	addi $t3,$t3,-1
	beq $t3,$zero,while
	j whilemore	
	
while:
	lw $t4,0($t2)
	
	li $v0,1
	move $a0,$t4
	syscall
	
	li $v0,4
	la $a0,string2
	syscall 
	
	addi $t2,$t2,4
	addi $t0,$t0,-1
	
	beq $t0,$zero,exit
	j while
	
	
exit:
	li $v0,10
	syscall