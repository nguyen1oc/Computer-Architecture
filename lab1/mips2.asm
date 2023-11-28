.data
myAr: .word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20

# Data for strings
string0: .asciiz "Original string:\n"
string1: .asciiz " "  # Space
string3: .asciiz "\nAfter reverse:\n"
.text
.globl main

main:
    # Initialize loop control variables
    li $t0, 20          # Number of elements
    li $t4, 20
    la $t2, myAr        # Load the base address of myAr
    
    li $v0,4
    la $a0,string0
    syscall

while:
    # Load the current element into $t1
    lw $t1, 0($t2)

    # Print the current element
    li $v0, 1           # Print integer
    move $a0, $t1
    syscall

    # Print a space (string1)
    li $v0, 4           # Print string
    la $a0, string1
    syscall

    # Update loop control variables
    addi $t0, $t0, -1   # Decrement the loop counter
    addi $t2, $t2, 4    # Move to the next element

    # Check if we have reached the end of the array
    beqz $t0, letsreverse

    # Continue the loop
    j while

letsreverse:
    li $v0,4
    la $a0,string3
    syscall
    
    addi $t2, $t2, -4 #back to the pos of 20
    	
reverse:
    #Load the curent element into $t1  
    lw $t1,0($t2)
    
    li $v0,1
    move $a0,$t1
    syscall
    
    # Print a space (string1)
    li $v0, 4           # Print string
    la $a0, string1
    syscall
    
    addi $t2,$t2,-4
    addi $t4,$t4,-1
    
    beqz $t4,exit
            
    j reverse
exit:
   li $v0,10
   syscall
   
 
