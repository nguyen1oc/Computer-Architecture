.data
counter:.space 400
Array:.space 100
phay:.asciiz", "
cham:.asciiz"."
ketqua:.asciiz";"
string: .asciiz "abhffeegghh"
.text
.globl main
main:
	la $t2,string
	la $s0,Array
	la $s1,counter
	li $t1,1
	lb $t3,0($t2)
	sb $t3,0($s0)
	sw $t1,0($s1)
	addi $t2,$t2,1
	li $t3,1
vonglap:      
	la $s0,Array
	la $s1,counter
	lb $t4,0($t2)
	li $t6,0
canhcut:
	beq $t4,$zero,in
	beq $t6,$t3,xong
	lb $s2,0($s0)
	lw $s3,0($s1)
	beq $t4,$s2,truonghop1
	addi $s0,$s0,1
	addi $s1,$s1,4
	addi $t6,$t6,1
	j canhcut
truonghop1:
	addi $s3,$s3,1
	sw $s3,0($s1)
	addi $t2,$t2,1
	j vonglap
xong:	
	addi $t2,$t2,1
	addi $t3,$t3,1
	li $t6,1
	sw $t6,0($s1)
	sb $t4,0($s0)
	j vonglap
in:	
	la $s0,Array
	la $s1,counter
	li $t1,0
	li $t2,0
	lb $t5,0($s0)
	lw $t6,0($s1)
	li $t4,-1
vongngoai:
	beq $t1,$t3,ketthuc
	li $t0,0
	li $t2,0
	la $s0,Array
	la $s1,counter
vongtrong:
	beq $t2,$t3,inso
	lb $t5,0($s0)
	lw $t6,0($s1)
	slt $t7,$t6,$zero
	bne $t7,$zero,abc
	beq $t0,$zero,landau
	slt $t7,$t6,$s3
	bne $t7,$zero,doicho
	beq $t6,$s3,xetascii
abc:	addi $t2,$t2,1
	addi $s0,$s0,1
	addi $s1,$s1,4
	j vongtrong
landau:	addi $t0,$t0,1
	lb $s2,0($s0)
	lw $s3,0($s1)
	move $s4,$s1
	j abc
doicho:
	move $s2,$t5
	move $s3,$t6
	move $s4,$s1
	j abc
xetascii:
	slt $t7,$s2,$t5
	bne $t7,$zero,abc
	j doicho
inso:
	addi $t1,$t1,1
	li $v0,11
	move $a0,$s2
	syscall
	li $v0,4
	la $a0,phay
	syscall
	li $v0,1
	move $a0,$s3
	syscall
	beq $t1,$t3,vongngoai
	li $v0,4
	la $a0,ketqua
	syscall
	sw $t4,0($s4)
	j vongngoai
ketthuc:
	li $v0,4
	la $a0,cham
	syscall
	li $v0,10
	syscall
	

	
	
	
	
    
