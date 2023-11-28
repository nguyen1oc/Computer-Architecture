.data
	number2: .float 2.0
	number3: .float 3.0
	number4: .float 4.0
	number6: .float 6.0
	pi: .float 3.14
.text
shape:
	li $v0,4
	la $a0,msg1
	syscall
	
	li $v0,4
	la $a0,msg2
	syscall
	
	li $v0,4
	la $a0,msg3
	syscall
	
	li $v0,4
	la $a0,msg4
	syscall
	
	li $v0,4
	la $a0,msg5
	syscall
	
	li $v0,4
	la $a0,msg6
	syscall
	
	li $v0,4
	la $a0,msg7
	syscall
	
	again:
	li $v0,4
	la $a0,msg8
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0
	
	blt $t0,0,rein
	bgt $t0,6,rein
	j recheck
		rein:
		li $v0,4
		la $a0,msg11
		syscall
		
		j again
			
	recheck:
	beq $t0,1,rectangular
	beq $t0,2,cube
	beq $t0,3,cylinder
	beq $t0,4,prism
	beq $t0,5,sphere
	beq $t0,6,pyramid
	beq $t0,0,exit
rectangular:
	li $v0,4
	la $a0,msg9
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0
	
	blt $t0,0,rein1
	bgt $t0,1,rein1
	j recheck1
		rein1:
		li $v0,4
		la $a0,msg10
		syscall
		
		j rectangular
			
	recheck1:
	li $v0,4
	la $a0,recvo
	syscall
	
	li $v0,6
	syscall
	mov.s $f1,$f0
	
	li $v0,4
	la $a0,recvo1
	syscall
	
	li $v0,6
	syscall
	mov.s $f2,$f0
	
	li $v0,4
	la $a0,recvo2
	syscall
	
	li $v0,6
	syscall
	mov.s $f3,$f0
	
	beq $t0,0,volume
	beq $t0,1,totalarea
		volume:
			mul.s $f1,$f1,$f2
			mul.s $f1,$f1,$f3
			
			li $v0,4
			la $a0,msg10
			syscall
			
			li $v0,2
			mov.s $f12,$f1
			syscall
			
			li $v0,4
			la $a0,enter
			syscall
			
			j shape
			
		totalarea:
			l.s $f7,number2
			
			mul.s $f4,$f1,$f2
			mul.s $f4,$f4,$f7
			
			mul.s $f5,$f1,$f3
			mul.s $f5,$f5,$f7
			
			mul.s $f6,$f2,$f3
			mul.s $f6,$f6,$f7
			
			add.s $f4,$f4,$f5
			add.s $f4,$f4,$f6
			
			li $v0,4
			la $a0,msg10
			syscall
			
			li $v0,2
			mov.s $f12,$f4
			syscall
			
			li $v0,4
			la $a0,enter
			syscall
			
			j shape
cube:
	li $v0,4
	la $a0,msg9
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0
	
	blt $t0,0,rein2
	bgt $t0,1,rein2
	j recheck2
		rein2:
		li $v0,4
		la $a0,msg10
		syscall
		
		j cube
			
	recheck2:
	li $v0,4
	la $a0,cubevo
	syscall
	
	li $v0,6
	syscall
	mov.s $f1,$f0
	
	beq $t0,0,volume1
	beq $t0,1,totalarea1
		volume1:
			mov.s $f2,$f1
			mul.s $f2,$f1,$f1
			mul.s $f2,$f2,$f1
			
			li $v0,4
			la $a0,msg10
			syscall
			
			li $v0,2
			mov.s $f12,$f2
			syscall
			
			li $v0,4
			la $a0,enter
			syscall
			
			j shape
			
		totalarea1:
			l.s $f7,number6
			mul.s $f1,$f1,$f1
			mul.s $f1,$f1,$f7
			
			li $v0,4
			la $a0,msg10
			syscall
			
			li $v0,2
			mov.s $f12,$f1
			syscall
			
			li $v0,4
			la $a0,enter
			syscall
			
			j shape
cylinder:
	li $v0,4
	la $a0,msg9
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0
	
	blt $t0,0,rein3
	bgt $t0,1,rein3
	j recheck3
		rein3:
		li $v0,4
		la $a0,msg10
		syscall
		
		j cylinder
			
	recheck3:
	li $v0,4
	la $a0,radius
	syscall
	
	li $v0,6
	syscall
	mov.s $f1,$f0
	
	li $v0,4
	la $a0,cylinvo1
	syscall
	
	li $v0,6
	syscall
	mov.s $f2,$f0
	
	beq $t0,0,volume2
	beq $t0,1,totalarea2
	
		volume2:
			l.s $f7,pi
			mul.s $f1,$f1,$f1
			mul.s $f1,$f1,$f7
			mul.s $f1,$f1,$f2
			
			li $v0,4
			la $a0,msg10
			syscall
			
			li $v0,2
			mov.s $f12,$f1
			syscall
			
			li $v0,4
			la $a0,enter
			syscall
			
			j shape
			
		totalarea2:
			l.s $f7,pi
			l.s $f6,number2
			mul.s $f3,$f1,$f1
			mul.s $f3,$f3,$f6
			mul.s $f3,$f3,$f7
			
			mul.s $f4,$f1,$f2
			mul.s $f4,$f4,$f7
			mul.s $f4,$f4,$f6
			
			add.s $f3,$f4,$f3
			
			li $v0,4
			la $a0,msg10
			syscall
			
			li $v0,2
			mov.s $f12,$f3
			syscall
			
			li $v0,4
			la $a0,enter
			syscall
			
			j shape
prism:
	li $v0,4
	la $a0,msg9
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0
	
	blt $t0,0,rein6
	bgt $t0,1,rein6
	j recheck6
		rein6:
		li $v0,4
		la $a0,msg10
		syscall
		
		j prism
			
	recheck6:
	li $v0,4
	la $a0,triangle1
	syscall
	
	li $v0,6
	syscall
	mov.s $f1,$f0
	
	li $v0,4
	la $a0,triangle2
	syscall
	
	li $v0,6
	syscall
	mov.s $f2,$f0
	
	li $v0,4
	la $a0,triangle3
	syscall
	
	li $v0,6
	syscall
	mov.s $f3,$f0
	
	li $v0,4
	la $a0,cylinvo1
	syscall
	
	li $v0,6
	syscall
	mov.s $f4,$f0
	
	beq $t0,0,volume5
	beq $t0,1,totalarea5
	volume5:
			l.s $f6,number2
			add.s $f5,$f1,$f2
			add.s $f5,$f5,$f3
			div.s $f5,$f5,$f6
			
			sub.s $f7,$f5,$f1
			sub.s $f8,$f5,$f2
			sub.s $f9,$f5,$f3
			
			mul.s $f5,$f5,$f7
			mul.s $f5,$f5,$f8
			mul.s $f5,$f5,$f9
			sqrt.s $f5,$f5
			
			mul.s $f5,$f5,$f4
			
			li $v0,4
			la $a0,msg10
			syscall
			
			li $v0,2
			mov.s $f12,$f5
			syscall
			
			li $v0,4
			la $a0,enter
			syscall
			
			j shape
			
	totalarea5:
			l.s $f6,number2
			add.s $f5,$f1,$f2
			add.s $f5,$f5,$f3
			div.s $f5,$f5,$f6
			
			sub.s $f7,$f5,$f1
			sub.s $f8,$f5,$f2
			sub.s $f9,$f5,$f3
			
			mul.s $f5,$f5,$f7
			mul.s $f5,$f5,$f8
			mul.s $f5,$f5,$f9
			sqrt.s $f5,$f5
			
			mul.s $f7,$f1,$f4
			mul.s $f8,$f2,$f4
			mul.s $f9,$f3,$f4
			
			add.s $f5,$f5,$f7
			add.s $f5,$f5,$f8
			add.s $f5,$f5,$f9
			
			li $v0,4
			la $a0,msg10
			syscall
			
			li $v0,2
			mov.s $f12,$f5
			syscall
			
			li $v0,4
			la $a0,enter
			syscall
			
			j shape
	
sphere:
	li $v0,4
	la $a0,msg9
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0
	
	blt $t0,0,rein4
	bgt $t0,1,rein4
	j recheck4
		rein4:
		li $v0,4
		la $a0,msg10
		syscall
		
		j sphere
			
	recheck4:
	li $v0,4
	la $a0,radius
	syscall
	
	li $v0,6
	syscall
	mov.s $f1,$f0
	
	beq $t0,0,volume3
	beq $t0,1,totalarea3
	
		volume3:
			l.s $f2,pi
			l.s $f3,number3
			l.s $f4,number4
			mul.s $f1,$f1,$f1
			mul.s $f1,$f1,$f1
			mul.s $f1,$f1,$f2
			mul.s $f1,$f1,$f4
			div.s $f1,$f1,$f3
			
			li $v0,4
			la $a0,msg10
			syscall
			
			li $v0,2
			mov.s $f12,$f1
			syscall
			
			li $v0,4
			la $a0,enter
			syscall
			
			j shape
			
		totalarea3:
			l.s $f7,pi
			l.s $f3,number2
			l.s $f4,number4
			mul.s $f1,$f1,$f3
			mul.s $f1,$f1,$f4
			mul.s $f1,$f1,$f7
			
			li $v0,4
			la $a0,msg10
			syscall
			
			li $v0,2
			mov.s $f12,$f1
			syscall
			
			li $v0,4
			la $a0,enter
			syscall
			
			j shape
pyramid:
	li $v0,4
	la $a0,msg9
	syscall

	li $v0,5
	syscall
	move $t0,$v0
	
	blt $t0,0,rein5
	bgt $t0,1,rein5
	j recheck5
		rein5:
		li $v0,4
		la $a0,msg10
		syscall
		
		j pyramid
			
	recheck5:
	li $v0,4
	la $a0,pyramidLength
	syscall
	
	li $v0,6
	syscall
	mov.s $f1,$f0
	
	li $v0,4
	la $a0,pyramidWidth
	syscall
	
	li $v0,6
	syscall
	mov.s $f2,$f0
	
	li $v0,4
	la $a0,cylinvo1
	syscall
	
	li $v0,6
	syscall
	mov.s $f3,$f0
	
	beq $t0,0,volume4
	beq $t0,1,totalarea4
		volume4:
			l.s $f4,number3
			mul.s $f1,$f1,$f2
			mul.s $f1,$f1,$f3
			div.s $f1,$f1,$f4
			
			li $v0,4
			la $a0,msg10
			syscall
			
			li $v0,2
			mov.s $f12,$f1
			syscall
			
			li $v0,4
			la $a0,enter
			syscall
			
			j shape
			
		totalarea4:
			l.s $f4,number2
			mul.s $f5,$f1,$f2 #base area
			mul.s $f6,$f3,$f3
			
			div.s $f7,$f2,$f4
			mul.s $f7,$f7,$f7
			add.s $f8,$f6,$f7
			sqrt.s $f8,$f8
			mul.s $f8,$f8,$f1
			
			div.s $f9,$f1,$f4
			mul.s $f9,$f9,$f9
			add.s $f6,$f6,$f9
			sqrt.s $f6,$f6
			mul.s $f6,$f6,$f2
			
			add.s $f5,$f8,$f5
			add.s $f5,$f5,$f6
			
			li $v0,4
			la $a0,msg10
			syscall
			
			li $v0,2
			mov.s $f12,$f5
			syscall
			
			li $v0,4
			la $a0,enter
			syscall
			
			j shape
	j exit
exit:
	li $v0,10
	syscall
.data
	enter: .asciiz "\n
	msg1: .asciiz "Choose which shape you want do (0 to quit):"
	msg2: .asciiz "\n	1. Rectangular"
	msg3: .asciiz "\n	2. Cube"
	msg4: .asciiz "\n	3. Cylinder"
	msg5: .asciiz "\n	4. Prism"
	msg6: .asciiz "\n	5. Sphere"
	msg7: .asciiz "\n	6. Pyramid"
	msg8: .asciiz "\nYour choice: "
	msg9: .asciiz "Volume (std for 0) or total surface area (std for 1): "
	msg10: .asciiz "Result: "
	msg11: .asciiz "Again please!"
	recvo: .asciiz "Enter depth(d): "
	recvo1: .asciiz "Enter width(w): "
	recvo2: .asciiz "Enter length(l): "
	cubevo: .asciiz "Enter edge(e): "
	radius: .asciiz "Enter radius(r): "
	cylinvo1: .asciiz "Enter height(h): " #height
	pyramidLength: .asciiz "Enter base length: "
	pyramidWidth: .asciiz"Enter base width: "
	triangle1: .asciiz "Canh a: "
	triangle2: .asciiz "Canh b: "
	triangle3: .asciiz "Canh c: "
	
	
	
