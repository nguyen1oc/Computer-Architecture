.data
string1: .asciiz "Enter the number: "
string2: .asciiz "Answer here: "
.text
li $v0,4
la $a0,string1
syscall

li $v0,5
syscall
move $t0,$v0
move $t1,$v0

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