.data
 myA: .space 60
 myI: .space 60
 str1: .asciiz "Input: "
 str2: .asciiz "Result: "
 str2.1: .asciiz "\nSecond largest is "
 str2.2: .asciiz ","
 str2.3: .asciiz "found in index"
 str3: .asciiz " "
 str3.1: .asciiz "."
.text
vari: 
	la $t0,myA
	li $t1,15
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
	li $t1,15
print:
	lw $t2,0($t0)
	beqz $t1,new_patch
	
	li $v0,1
	move $a0,$t2
	syscall
	
	li $v0,4
	la $a0, str3
	syscall
	
	addi $t0,$t0,4
	subi $t1,$t1,1
	
	j print
#FIND THE SECOND AND INDEX
new_patch:
	la $t0,myA
	li $t1,15
	lw $t2,0($t0)
	move $t5,$t2
loop1:
	lw $t2,0($t0)
	beqz $t1,new_patch2
	bgt $t2,$t5,swap
	j loop1_1
		swap:
			move $t5,$t2
loop1_1:
	addi $t0,$t0,4
	subi $t1,$t1,1
	
	j loop1
new_patch2:
	la $t0,myA
	li $t1,15
	li $t6,0
loop2:
	lw $t2,($t0)
	beqz $t1,new_patch3
	bgt $t2,$t6,checkIfL
	j loop2_2
	checkIfL:
		beq $t2,$t5,loop2_2
		move $t6,$t2
loop2_2:
	addi $t0,$t0,4
	subi $t1,$t1,1
	
	j loop2	
new_patch3:
	li $v0,4
	la $a0,str2.1
	syscall
	
	li $v0,1
	move $a0,$t6
	syscall
	
	li $v0,4
	la $a0,str2.2
	syscall
	
	li $v0,4
	la $a0,str3
	syscall	
	
	la $t0,myA
	la $t7,myI
	lw $t2,0($t0)
	li $t3,0
loop3:
	lw $t2,0($t0)
	beq $t1,15,new_patch4
	beq $t2,$t6,print_index
	j loop3_3
		print_index:
			sw $t1,($t7)
			addi $t7,$t7,4
			addi $t3,$t3,1
loop3_3:
	addi $t0,$t0,4
	addi $t1,$t1,1
	
	j loop3
new_patch4:
	la $t7,myI
	
	li $v0,4
	la $a0,str2.3
	syscall
loop4:
	lw $t2,($t7)
	beqz $t3,exit
	
	li $v0,4
	la $a0,str3
	syscall
	
	li $v0,1
	move $a0,$t2
	syscall
	
	beq $t3,1,dot
	j loop4_4
		dot:
			li $v0,4
			la $a0,str3.1
			syscall
			j exit
loop4_4:
	li $v0,4
	la $a0,str2.2
	syscall
	subi $t3,$t3,1
	addi $t7,$t7,4
	
	j loop4															
exit:
 li $v0,10
 syscall
