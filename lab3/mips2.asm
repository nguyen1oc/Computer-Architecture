.data
	number5: .float 5
	number4: .float 4
	number3: .float 3
.text
	 #mss 2252461
	li $v0,4
	la $a0,a
	syscall
	
	li $v0,6
	syscall
	mov.s $f1,$f0
	
	li $v0,4
	la $a0,b
	syscall
	
	li $v0,6
	syscall
	mov.s $f2,$f0
	
	li $v0,4
	la $a0,c
	syscall 
	
	li $v0,6
	syscall
	mov.s $f3,$f0
	
	li $v0,4
	la $a0,d
	syscall
	
	li $v0,6
	syscall
	mov.s $f4,$f0
	
	li $v0,4
	la $a0,u
	syscall
	
	li $v0,6
	syscall
	mov.s $f5,$f0
	
	li $v0,4
	la $a0,v
	syscall
	
	li $v0,6
	syscall
	mov.s $f6,$f0
	
	li $v0,4
	la $a0,e
	syscall
	
	li $v0,6
	syscall
	mov.s $f7,$f0
	
caculate:
cum1:
	mul.s $f8,$f5,$f5
	mul.s $f8,$f8,$f5
	mul.s $f8,$f8,$f5
	mul.s $f8,$f8,$f5
	
	mul.s $f9,$f6,$f6
	mul.s $f9,$f9,$f6
	mul.s $f9,$f9,$f6
	mul.s $f9,$f9,$f6
	
	sub.s $f8,$f8,$f9
	mul.s $f1,$f8,$f1
	l.s $f9,number5
	div.s $f1,$f1,$f9
	
cum2:	
	mul.s $f8,$f5,$f5
	mul.s $f8,$f8,$f5
	mul.s $f8,$f8,$f5
	
	mul.s $f9,$f6,$f6
	mul.s $f9,$f9,$f6
	mul.s $f9,$f9,$f6
	
	sub.s $f8,$f8,$f9
	mul.s $f2,$f8,$f2
	l.s $f9,number4
	div.s $f2,$f2,$f9

cum3:
	mul.s $f8,$f5,$f5
	mul.s $f8,$f8,$f5
	
	mul.s $f9,$f6,$f6
	mul.s $f9,$f9,$f6
	
	sub.s $f8,$f8,$f9
	mul.s $f3,$f8,$f3
	l.s $f9,number3
	div.s $f3,$f3,$f9
	
cum4:
	sub.s $f5,$f5,$f6
	mul.s $f4,$f4,$f5

total:	
	mul.s $f7,$f7,$f7
	
	add.s $f13,$f1,$f2
	add.s $f13,$f13,$f3
	add.s $f13,$f13,$f4
	
	div.s $f13,$f13,$f7
	
print:	
	li $v0,4
	la $a0,result
	syscall
	
	li $v0,2
	mov.s $f12,$f13
	syscall
		
.data
a: .asciiz "a: "
b: .asciiz "b: "
c: .asciiz "c: "
d: .asciiz "d: "
u: .asciiz "u: "
v: .asciiz "v: "
e: .asciiz "e: "
result: .asciiz"Result: "