.data
string1: .asciiz "Enter the first num: "
string2: .asciiz "\nEnter the second num: "
string3: .asciiz "\nEnter the third num: "
string3.5: .asciiz"\nEnter the fourth num: "
string4: .asciiz "\nF = "
string5: .asciiz "\nG = "
.text
	li $v0,4
	la $a0,string1
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0
	
	li $v0,4
	la $a0,string2
	syscall
	
	li $v0,5
	syscall
	move $t1,$v0
	
	li $v0,4
	la $a0,string3
	syscall
	
	li $v0,5
	syscall
	move $t2,$v0
	
	li $v0,4
	la $a0,string3.5
	syscall 
	
	li $v0,5
	syscall
	move $t3,$v0
	
	#calculate F
	add $t4,$t0,$t1
	sub $t5,$t2,$t3
	mul $t6,$t4,$t5
	mul $t7,$t0,$t0
	div $t7,$t6,$t7
	
	li $v0,4
	la $a0,string4
	syscall
	
	li $v0,1
	move $a0,$t7
	syscall
	
	#calculate G
	addi $t4,$t0,1
	addi $t5,$t1,2
	addi $t6,$t2,-3
	sub $t7,$t2,$t0
	mul $t4,$t4,$t5
	mul $t6,$t4,$t6
	div $t7,$t6,$t7
	
	li $v0,4
	la $a0,string5
	syscall
	
	li $v0,1
	move $a0,$t7
	syscall
	
	#exit
	li $v0,10
	syscall
	
	