.text
.globl main

# $s0 -> result
# $t0 -> temporary value
# $t1 -> n
# $t2 -> conditional result
# $s1 -> value from stack
# $v0 -> register for system calls

main:
	move $s0, $zero     # set result to 0
	addi $sp, $sp, -4   # initialize stack
	
	li $t0, 16
	sw $t0, 0($sp)      # load first value
	
	li $t0, 2
	sw $t0, 4($sp)      # load second value
	
	li $t0, 77
	sw $t0, 8($sp)      # load third value
	
	li $t0, 40
	sw $t0, 12($sp)     # load fourth value
	
	li $t0, 12071
	sw $t0, 16($sp)     # load fifth value

	move $t1, $zero     # set n to 0

loop1:
	slti $t2, $t1, 5    # while n < 5 return 1
	bne $t2, 1, exit

	addi $t1, $t1, 1    # increment n
	lw $s1, 0($sp)
	add $s0, $s0, $s1   # add stack item to result
	addi $sp, $sp, 4    # pop one item out of stack
	j loop1             # call function again

exit:
	li $v0, 1
	move $a0, $s0
	syscall             # print result

	li $v0, 10
	syscall             # exit program