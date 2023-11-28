.data
  string1:   .asciiz "Enter a 10-bit binary number: "
  empty:     .space 11   # 10 bits and 1 bit null terminator
  string2:    .asciiz "\nDecimal: "

.text

  li $v0, 4          # Print string system call
  la $a0, string1
  syscall

  la $a0, empty
  li $a1, 11         # Load 11 as max length to read into $a1
  li $v0, 8          # 8 is the string system call
  syscall

  li $t4, 0           # Initialize sum to 0

  la $t1, empty
  li $t9, 10          # Initialize counter to 10

while:
  lb $a0, ($t1)       # Load the first bit
  blt $a0, 48, result
  addi $t1, $t1, 1     # Increment offset
  subi $a0, $a0, 48    # Subtract 48 to convert to int value
  subi $t9, $t9, 1     # Decrement counter
  beq $a0, 0, isZero
  beq $a0, 1, isOne
  j result

isZero:
  j while

isOne:
  li $t8, 1            # Load 1
  sllv $t5, $t8, $t9   # Shift left by counter = 1 * 2^counter, store in $t5
  add $t4, $t4, $t5    # Add sum to the previous sum
  j while

result:
  srlv $t4, $t4, $t9

  la $a0, string2
  li $v0, 4
  syscall

  move $a0, $t4        
  li $v0, 1            
  syscall

exit:
  li $v0, 10           # Exit system call
  syscall
