.data
string1: .asciiz "Chose a number: "
string2: .asciiz "The number you want to multiple with: "
string3: .asciiz "how many time: "
string4: .asciiz "Result: "
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

while_and_while:
beq $t2,$zero,exit
mul $t0,$t0,$t1
subi $t2,$t2,1
j while_and_while

exit:
li $v0,4
la $a0,string4
syscall

li $v0,1
move $a0,$t0
syscall

#exit
li $v0,10
syscall
	