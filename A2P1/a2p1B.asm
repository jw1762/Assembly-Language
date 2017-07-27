################################################################
#	Jordan Williamson       			      ##
#	CS 2318, Section 252				      ##
#	Assignment 2 - Part 1 Program B			      ##
################################################################
		.data
in_prompt1:	.asciiz "Enter 0 or 1 for integer 1: "
in_prompt2:	.asciiz "Enter 0 or 1 for integer 2: "
out_lab:	.asciiz "\nSum of the 2 integers is: "
############################ code segment ################################
		.text
		.globl main
main:
		li $v0, 4
		la $a0, in_prompt1        
		syscall                   # print input prompt 1
		
		li $v0, 5
		syscall                   # read integer entered
		move $t1, $v0             # $t1 has 1st integer entered
		
		li $v0, 4
		la $a0, in_prompt2        
		syscall                   # print input prompt 2
		
		li $v0, 5
		syscall                   # read integer entered
		move $t2, $v0             # $t2 has 1st integer entered
		
		li $v0, 4
		la $a0, out_lab        
		syscall                   # print output label out_lab
		li $v0, 1

		##########################################################
		# write 4 lines of code, each of which MUST involve a
		# bitwise operation (ANDing, ORing, SHIFTing or XORing), 
		# so that the program will work as shown in the sample
		# runs included at the bottom
		##########################################################
		# HINTS/TIPS:
		#
		#   LSB 1        :   0  0  1  1 
		#   LSB 2        :   0  1  0  1 
		#                   ============
		#   LSB1 and LSB2:   0  0  0  1  
		#   LSB1 or LSB2 :   0  1  1  1
		#   LSB1 xor LSB2:   0  1  1  0
		#   
		# - which is good for last bit of result?
		# - which is good for next to last bit of result?
		# - how to concatenate the 2 (last and next to last) bits?
		##########################################################		
		#
		# (insert 4 lines of code within the blank after this)
		
		and $t3, $t2, $t1	#Value sent to t3
		sll $t3, $t3, 1 	#shifted left in t3
		xor $t4, $t1, $t2	#add to t4
		xor $a0, $t3, $t4	#add t4 and t3 values.

                ##########################################################
                
		syscall                   # print sum of integers entered
                
                li $v0, 11
                li $a0, '\n'
                syscall
                
                li $v0, 10                # exit
                syscall

########################## sample test runs ##############################
# Enter 0 or 1 for integer 1: 0
# Enter 0 or 1 for integer 2: 0
# 
# Sum of the 2 integers is: 0
# 
# -- program is finished running --
# 
# Reset: reset completed.
# 
# Enter 0 or 1 for integer 1: 0
# Enter 0 or 1 for integer 2: 1
# 
# Sum of the 2 integers is: 1
# 
# -- program is finished running --
# 
# Reset: reset completed.
# 
# Enter 0 or 1 for integer 1: 1
# Enter 0 or 1 for integer 2: 0
# 
# Sum of the 2 integers is: 1
# 
# -- program is finished running --
# 
# Reset: reset completed.
# 
# Enter 0 or 1 for integer 1: 1
# Enter 0 or 1 for integer 2: 1
# 
# Sum of the 2 integers is: 2
# 
# -- program is finished running --
######################## end sample test runs ############################
