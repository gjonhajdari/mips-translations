.data		
	question: .asciiz "Enter a non-negative number: "
	result:   .asciiz "Factorial of "
	equals:   .asciiz " = "

.text
.globl main

# $s0       -> base factorial number
# $t2       -> copy of base factorial number used for calculations (n)
# $t0       -> condition result
# $t1       -> a
# $s1       -> factorial result
# $v0, $a0  -> registers for system calls

main:
	li $s1, 1             # set result to 1
	li $t1, 1             # set a to 1

	li $v0, 4
	la $a0, question
	syscall               # ask user for the factorial base

	li $v0, 5
	syscall
	move $s0, $v0				
	move $t2, $s0         # set user input as factorial base and copy to $t2

factorial:
	slt $t0, $t2, $t1
	bne $t0, $zero, print # if n < a goto print

	mult $s1, $t1         # multiply with a
	mflo $s1              # save as new result
	
	mult $s1, $t2         # multiply with the next number in line
	mflo $s1              # save as new result
	
	addi $t2, $t2, -1     # decrement n
	j factorial           # call function again
	
print:
	li $v0, 4
	la $a0, result
	syscall               # print "Factorial of "

	li $v0, 1
	move $a0, $s0
	syscall               # print base number

	li $v0, 4
	la $a0, equals
	syscall               # print " = "

	li $v0, 1
	move $a0, $s1
	syscall               # print factorial result

exit:                   # ticket used purely for aesthetics
	li $v0, 10
	syscall               # end the program