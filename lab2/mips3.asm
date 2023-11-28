.data
 myA: .space 28
 str1: .asciiz "Input: "
 str2: .asciiz "Result: "
 str3: .asciiz " "
.text
vari: 
	la $t0,myA
	li $t1,7
input:
	beqz $t1,next_step
	
	li $v0,4
	la $a0,str1
	syscall
	
	li $v0,5
	syscall
	move $t2,$v0
	check_div:
		rem $t4,$t2,4
		bnez $t4,check_again
		div $t2,$t2,4 
		j input_last
			check_again:
				addi $t2,$t2,1
				rem $t4,$t2,4
				bnez $t4,again_again
				j input_last
					again_again:
						subi $t2,$t2,1
						blt $t2,3,changeway
						j steplast
							changeway:
								addi $t2,$t2,1
								rem $t4,$t2,4
								beqz $t4,input_last
								j changeway
						steplast:
						rem $t4,$t2,4
						beqz $t4,input_last
						j again_again
			
input_last:
	sw $t2,($t0)
	addi $t0,$t0,4
	subi $t1,$t1,1
	
	j input
next_step:
	li $v0,4
	la $a0,str2
	syscall
	
	la $t0,myA
	li $t1,7
print:
	lw $t2,0($t0)
	beqz $t1,exit
	
	li $v0,1
	move $a0,$t2
	syscall
	
	li $v0,4
	la $a0, str3
	syscall
	
	addi $t0,$t0,4
	subi $t1,$t1,1
	
	j print
exit:
	li $v0,10
	syscall
