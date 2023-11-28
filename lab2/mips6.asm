.data
string1: .asciiz "Enter the number: "
string2: .asciiz "Answer here: "
string3: .asciiz "A factorial for your number can not be found."
.text
li $t6,1

li $v0,4
la $a0,string1
syscall

li $v0,5
syscall
move $t0,$v0
move $t1,$v0

beq $t0,0,special
blt $t0,0,wrong_valid

while:
addi $t1,$t1,-1
beq $t1,$zero,exit
mul $t0,$t0,$t1
j while

exit:
li $v0,4
la $a0,string2
syscall

li $v0,1
move $a0,$t0
syscall
j end
special:
	li $v0,4
	la $a0,string2
	syscall

	move $t0,$t6
	li $v0,1
	move $a0,$t0
	syscall
	j end
	
wrong_valid:
	li $v0,4
	la $a0,string3
	syscall
end:

li $v0,10
syscall