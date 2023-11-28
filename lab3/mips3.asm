.data
	
.text
	#open
	li $v0,13
	la $a0,fout
	li $a1,0
	li $a2,0
	syscall
	move $s6,$v0
	
	#read
	li $v0,14
	move $a0,$s6
	la $a1,fspace
	la $a2,1024
	syscall
	
	la $t0,fspace
	
	li $v0,4
	la $a0,msg1
	syscall
	
	li $v0,4
	la $a0,msg2
	syscall
	loop_mssv:
			lb $a0,($t0)
			beq $a0,44,movet
			beq $a0,32,next
			
			li $v0,11
			syscall
			
			movet:
			addi $t0,$t0,1
			j loop_mssv
				
	next:
		addi $t0,$t0,1		
	
	li $v0,4
	la $a0,msg3
	syscall
	loop_name:
			lb $a0,($t0)
			beq $a0,44,movet1
			beq $a0,32,next1
			
			li $v0,11
			syscall
			
			movet1:
			addi $t0,$t0,1
			j loop_name
				
	next1:
		addi $t0,$t0,1		
	
	li $v0,4
	la $a0,msg4
	syscall
	loop_weight:
			lb $a0,($t0)
			beq $a0,44,movet2
			beq $a0,32,next2
			
			li $v0,11
			syscall
			
			movet2:
			addi $t0,$t0,1
			j loop_weight
				
	next2:
		addi $t0,$t0,1	
	
	li $v0,4
	la $a0,msg5
	syscall
	
	loop_height:
			lb $a0,($t0)
			beq $a0,44,movet3
			beq $a0,32,next3
			
			li $v0,11
			syscall
			
			movet3:
			addi $t0,$t0,1
			j loop_height
				
	next3:
		addi $t0,$t0,1	
	
	li $v0,4
	la $a0,msg6
	syscall
	
	loop_medical:
			lb $a0,($t0)
			beq $a0,44,movet4
			beq $a0,32,next4
			
			li $v0,11
			syscall
			
			movet4:
			addi $t0,$t0,1
			j loop_medical
				
	next4:
		addi $t0,$t0,1
	
print:
	#close
	li $v0,16
	move $a0,$s6
	syscall
.data
fout : .asciiz "C:/info.txt"
fspace: .space 1024
msg1: .asciiz "Studen medical information: "
msg2: .asciiz "\nID: "
msg3: .asciiz "\nName: "
msg4: .asciiz "\nWeight: "
msg5: .asciiz "\nWHeight: "
msg6: .asciiz "\nMedical history: "
space: .asciiz " "
comma: .asciiz ","
enter: .asciiz "."
