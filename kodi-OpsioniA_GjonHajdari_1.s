.data		
	question: .asciiz "Enter a non-negative number: "
	result:   .asciiz "Factorial of "
	equals:   .asciiz " = "

.text
.globl main

# $s0       -> base factorial number
# $t1       -> copy of base factorial number used for calculations
# $sp       -> stack that holds the number value for each iteration
# $t2       -> condition result
# $s1       -> factorial result
# $s2       -> a
# $v0, $a0  -> registers for system calls

main:
	addi $s2, $zero, 1    # set a to 1
	addi $s1, $zero, 1    # set result to 1

	li $v0, 4
	la $a0, question
	syscall               # ask user for the factorial base

	li $v0, 5
	syscall
	move $s0, $v0				
	move $t1, $s0         # set factorial base to user input

factorial:
	addi $sp, $sp, -4     # add room for an integer in stack
	sw $t1, 0($sp)        # store the number value in the stack
	slt $t2, $t1, 1       # -
	bne $t2, 1, decrement # - if (n > 1) goto decrement
	addi $sp, $sp, 4      # pop last item out of the stack
	j multiply            # goto multiply

decrement: 
	addi $t1, $t1, -1     # decrement n
	j Factorial           # goto factorial

multiply:
	beq $t0, $s0, print   # print resuls when you reach n repetitions (n = factorial base)
	addi $t0, $t0, 1      # increment count
	lw $t1, 0($sp)        # get the value of the last number
	addi $sp, $sp, 4      # pop last out of the stack
	mult $t1, $s1         # multiply the result with the next number
	mflo $s1              # save as new result
	mult $s1, $s2         # multiply with a
	mflo $s1              # save as new result
	
	j multiply            # goto multiply
	
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