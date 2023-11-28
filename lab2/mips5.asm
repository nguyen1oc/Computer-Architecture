.data
Array: .space 40
NewArray:.space 40
Duptime:.space 40
dauphay: .asciiz ", "
prompt: .asciiz "Please enter number: "
ketqua1:.asciiz"Unique value: "
ketqua2:.asciiz"Duplicated value: "
ketqua3:.asciiz"repeated "
ketqua4:.asciiz" times"
ketqua5:.asciiz"; "
cham:". "
.text
.globl main
main:
	li $t0,10
	li $t1,0
	la $t2,Array
	li $t3,0
	li $t7,0
input_loop:
	beq $t1, $t0, batdau
	li $v0, 4
	la $a0, prompt
	syscall
	li $v0, 5
	syscall
	move $t6, $v0
	sw $t6, 0($t2)
	addi $t1, $t1, 1
	addi $t2, $t2, 4
	j input_loop 
batdau:
	la $t2, Array
	li $t1,1
	la $s0,NewArray
	la $s1,Duptime
	li $t3,1
	lw $t4,0($t2)
	sw $t4,0($s0)
	addi $s0,$s0,4
	sw $t3,0($s1)
	addi $s1,$s1,4
	addi $t2,$t2,4
vonglap:      
	beq $t1,$t0,ketthuc
	la $s0,NewArray
	la $s1,Duptime
	lw $t4,0($t2)
	li $t6,0
canhcut:
	beq $t6,$t3,xong
	lw $s2,0($s0)
	lw $s3,0($s1)
	beq $t4,$s2,truonghop1
	addi $s0,$s0,4
	addi $s1,$s1,4
	addi $t6,$t6,1
	j canhcut
truonghop1:
	addi $s3,$s3,1
	sw $s3,0($s1)
	addi $t1,$t1,1
	addi $t2,$t2,4
	j vonglap
xong:	
	addi $t3,$t3,1
	li $t6,1
	sw $t4,0($s0)
	sw $t6,0($s1)
	addi $t1,$t1,1
	addi $t2,$t2,4
	j vonglap
ketthuc:
	la $s0,NewArray
	la $s1,Duptime
	li $t5,1
	li $t7,0
	li $t1,0
	li $v0,4
	la $a0,ketqua1
	syscall
in:	beq $t1,$t3,duplicated
	lw $s2,0($s0)
	lw $s3,0($s1)
	addi $s0,$s0,4
	addi $s1,$s1,4
	addi $t1,$t1,1
	bne $s3,$t5,in
	addi $t7,$t7,1
	beq $t7,$t5,inso
	li $v0, 4
	la $a0,dauphay
	syscall
inso:	li $v0,1
	move $a0,$s2
	syscall
	j in
duplicated:
	li $v0,4
	la $a0,cham
	syscall
	la $a0,ketqua2
	syscall
	la $s0,NewArray
	la $s1,Duptime
	li $t7,0
	li $t1,0
insolap:
	beq $t1,$t3,end
	lw $s2,0($s0)
	lw $s3,0($s1)
	addi $s0,$s0,4
	addi $s1,$s1,4
	addi $t1,$t1,1
	beq $s3,$t5,insolap
	addi $t7,$t7,1
	beq $t7,$t5,cuocdoibuonchan
	la $a0,ketqua5
	syscall
cuocdoibuonchan:
	li $v0,1
	move $a0,$s2
	syscall
	li $v0, 4
	la $a0,dauphay
	syscall
	la $a0,ketqua3
	syscall
	li $v0,1
	move $a0,$s3
	syscall
	li $v0,4
	la $a0,ketqua4
	syscall
	j insolap
end:	li $v0,4
	la $a0,cham
	syscall
	li $v0,10
	syscall
	
	
	                                                                                                                                                                                                                                                                               
	
	
	
	
