	.data
string1: .asciiz "Enter the first number: "
string2: .asciiz "\nEnter the second number: "
string3: .asciiz "\nChoose a mathmatical opreation (num:0, subt:1, mul:2, div:3): "
string4: .asciiz "\nYour choice: "
string5: .asciiz "\nAnswer: "
	.text
	.globl main
main:	#print string1
	li $v0,4
	la $a0,string1
	syscall
	
	#take the first num
	li $v0,5
	syscall
	move $t0,$v0
	
	#print string2
	li $v0,4
	la $a0,string2
	syscall
	
	#take the second num
	li $v0,5
	syscall
	move $t1,$v0
	
	#choose a mathematical operation
	li $v0,4
	la $a0,string3
	syscall
	
	#result of operation
	li $v0,4
	la $a0,string4
	syscall
	
	#take operation
	li $v0,5
	syscall
	move $t2,$v0
	
	#move to calculate
	beq $t2,0,sum
	beq $t2,1,subt
	beq $t2,2,multi
	beq $t2,3,divi
	
	#sum
sum:	add $t3,$t0,$t1
	j result
subt:	sub $t3,$t0,$t1
	j result
multi:  mul $t3,$t0,$t1
	j result
divi: 	div $t3,$t0,$t1
	j result
result:
	li $v0,4
	la $a0,string5
	syscall
	
	li $v0,1
	move $a0,$t3
	syscall

	
	#exit
	li $v0,10
	syscall
	
