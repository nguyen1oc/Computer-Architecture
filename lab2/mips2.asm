.data
	str1: .asciiz "Input a: "
	str2: .asciiz "Input b: "
	str3: .asciiz "GCD = " 
	str4: .asciiz " LCM = "
	str5: .asciiz ","
	str6: .asciiz "."
	
.text
	li $v0,4
	la $a0,str1
	syscall
	
	li $v0,5
	syscall
	move $t1,$v0
	move $t3,$v0
	
	
	li $v0,4
	la $a0,str2
	syscall
	
	li $v0,5
	syscall
	move $t2,$v0
	move $t6,$v0
	
	move $t0,$t1
	
	jal GCD
	jal LCD
exit:	
	li $v0,4
	la $a0,str3
	syscall
	
	li $v0,1
	move $a0,$t1
	syscall
	
	li $v0,4
	la $a0,str5
	syscall
	
	li $v0,4
	la $a0,str4
	syscall
	
	li $v0,1
	move $a0,$t5
	syscall
	
	li $v0,4
	la $a0,str6
	syscall
	
 	li $v0,10
 	syscall
#FUNCTIONNNNNNNNNNNNNNNNNNNN
GCD:
	beqz $t2,exit_GCD
GCD_Real:
	beqz $t2,exit_GCD
	rem $t4,$t1,$t2
	move $t1,$t2
	move $t2,$t4
	j GCD_Real
exit_GCD:
	jr $ra
LCD:
	mul $t5,$t3,$t6
	div $t5,$t5,$t1
	jr $ra