.data
  enterMessage: .asciiz "Enter 5 numbers: "
  printMessage: .asciiz "The numbers are: "
  space:        .asciiz " "

.text
.globl main

# $s0     -> n
# $t0     -> conditional result
# $t1     -> input integer
# $s1     -> integer to print
# $sp     -> stack that stores numbers
# $v0, a0 -> registries used for system calls

main:
	li $v0, 4
	la $a0, enterMessage
	syscall                   # print "Enter 4 numbers: "

store:
	slti $t0, $s0, 5          # -
	beq $t0, $zero, numbers   # - if n > 5 print items
	
	addi $s0, $s0, 1          # increment n
	addi $sp, $sp, -4         # add room for an integer in stack

	li $v0, 5
	syscall
	move $t1, $v0             # read integer and store in $t1

	sw $t1, 0($sp)            # add integer to stack
	j stores                  # call function again

numbers:
	li $s0, 0                 # reset n

	li $v0, 4
	la $a0, printMessage
	syscall                   # print "The numbers are: "

printLoop:
	slti $t0, $s0, 5          # -
	beq $t0, $zero, exit      # - if n < 1 goto exit
	addi $s0, $s0, 1          # decrement n
	lw $s1, 0($sp)            # get integer from stack
	addi $sp, $sp, 4          # pop item out of stack
	
	li $v0, 1
	move $a0, $s1
	syscall                   # print integer

	li $v0, 4
	la $a0, space
	syscall                   # print space between items

	j printLoop               # call function again

exit:
	li $v0, 10
	syscall                   # exit the program
