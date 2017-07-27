###############################################################################
# Title: Assign02P3                     Author: Chelsie Woodall
# Class: CS 2318-251, Spring 2015	Submitted: 04/01/15
###############################################################################
# Program: MIPS tranlation of a given C++ program
###############################################################################
# Pseudocode description: supplied a2p2_SampSoln.cpp
###############################################################################

#include <iostream>
#using namespace std;
		.data
a1:		.space 48	#int a1[12]
a2:		.space 48	#int a2[12]
a3:		.space 48	#int a3[12]
einStr:		.asciiz "\nEnter integer #"
colSpace:	.asciiz ": "
moStr:		.asciiz "Max of "
ieStr:		.asciiz " ints entered..."
emiStr:		.asciiz "Enter more ints? (n or N = no, others = yes) "
begA1Str:	.asciiz "\nbeginning a1: "
nn09A1Str:	.asciiz "a1 (noneg09): "
procA1Str:	.asciiz "processed a1: "
procA2Str:	.asciiz "          a2: "
procA3Str:	.asciiz "          a3: "
dacStr:		.asciiz "Do another case? (n or N = no, others = yes) "
dlStr:		.asciiz "\n================================"
byeStr:		.asciiz "bye..."

#int main()
#{
		.text
		.globl main
				
main:
###############################################################################
# Register usage:
#################
# $a0: extra short-lived holder (where appropriate & as locally commented)
# $a1: endPtr1 
# $a2: endPtr2 
# $a3: endPtr3 
# $t0: target
# $t1: used1
# $t2: used2
# $t3: used3
# $t4: hopPtr1
# $t5: hopPtr2
# $t6: hopPtr11
# $t7: hopPtr3
# $t8: reply or intHolder or iter (non-overlappingly)
# $t9: count
# $v0: extra short-lived holder (where appropriate & as locally commented)
# $v1: short-lived holder (as locally commented)
###############################################################################
		#char reply;
		#int used1,
		#used2,
		#used3,
		#target,
		#intHolder,
		#count,
		#iter,
		#*hopPtr1,
		#*hopPtr11,
		#*hopPtr2,
		#*hopPtr3,
		#*endPtr1,
		#*endPtr2,
		#*endPtr3;
		
		#reply = 'y';
		li $t8, 'y'
		#goto WTest1;
		j WTest1
begW1:
		#used1 = 0;
		li $t1, 0
		#hopPtr1 = a1;
		la $t4, a1
		#goto WTest2;
		j WTest2
begW2:
		#cout << einStr;
		li $v0, 4
		la $a0, einStr
		syscall
		#cout << (used1 + 1);
		li $v0, 1
		addi $a0, $t1, 1
		syscall
		#cout << ':' << ' ';
		li $v0, 4
		la $a0, colSpace
		syscall
		#cin >> *hopPtr1;
		li $v0, 5
		syscall
		sw $v0, 0($t4)
		#++used1;
		addi $t1, $t1, 1
		#++hopPtr1;
		addi $t4, $t4, 4
		#if (used1 >= 12) goto else1;
		li $v1, 12
		bge $t1, $v1, else1
		#cout << emiStr;
		li $v0, 4
		la $a0, emiStr
		syscall
		#cin >> reply;
		li $v0, 12
		syscall
		move $t8, $v0
		#goto endI1;
		j endI1
else1:
		#cout << moStr << 12 << ieStr << endl;
		li $v0, 4
		la $a0, moStr
		syscall
		li $v0, 1
		li $a0, 12
		syscall
		li $v0, 4
		la $a0, ieStr
		syscall
		li $v0, 11
		li $a0, '\n'
		syscall
		#reply = 'n';
		li $t8, 'n'
endI1:
WTest2:         
		#if (reply == 'n') goto xitW2;
		li $v1, 'n'
		beq $t8, $v1, xitW2
		#if (reply != 'N') goto begW2;
		li $v1, 'N'
		bne $t8, $v1, begW2
xitW2:
		#cout << begA1Str;
		li $v0, 4
		la $a0, begA1Str
		syscall
		#if (used1 <= 0) goto endI2;
		blez $t1, endI2
		#hopPtr1 = a1;
		la $t4, a1
		#endPtr1 = a1 + used1;
		la $v1, a1
		sll $a1, $t1, 2
		add $a1, $a1, $v1
begDW1:
            	#cout << *hopPtr1 << ' ' << ' ';
            	li $v0, 1
		lw $a0, 0($t4)
		syscall
		li $v0, 11
		li $a0, ' '
		syscall
		li $v0, 11
		li $a0, ' '
		syscall
           	#++hopPtr1;
		addi $t4, $t4, 4
DWTest1:        
		#if (hopPtr1 < endPtr1) goto begDW1;
		blt $t4, $a1, begDW1
endI2:
            	#cout << endl;
           	li $v0, 11
		li $a0, '\n'
		syscall
            	#if (used1 <= 0) goto endI3;
            	blez $t1, endI3
            	#hopPtr1 = a1;
            	la $t4, a1
            	#endPtr1 = a1 + used1;
            	la $v1, a1
            	sll $a1, $t1, 2
            	add $a1, $a1, $v1
            	#goto FTest1;
            	j FTest1
begF1:
            	#target = *hopPtr1;
            	lw $t0, 0($t4)
            	#if (target < 0) goto goodI4;
            	bltz $t0, goodI4
            	#if (target <= 9) goto endI4;
            	li $v1, 9
            	ble $t0, $v1, endI4
goodI4:
            	#hopPtr11 = hopPtr1 + 1;
            	addi $t6, $t4, 4
begF2:
            	#*(hopPtr11 - 1) = *hopPtr11;
            	move $v1, $t6
            	addi $t6, $t6, -4
		sw $v1, 0($t6)
            	
            	#++hopPtr11;
		addi $t6, $t6, 4
FTest2:         
		#if (hopPtr11 < endPtr1) goto begF2;
		blt $t6, $a1, begF2
            	#--used1;
            	addi $t1, $t1, -1
            	#--endPtr1;
            	addi $a1, $a1, -4
            	#--hopPtr1;
            	addi $t4, $t4, -4
endI4:
            	#++hopPtr1;
		addi $t4, $t4, 4
FTest1:         
		#if (hopPtr1 < endPtr1) goto begF1;
		blt $t4, $a1, begF1

		#cout << nn09A1Str;
		li $v0, 4
		la $a0, nn09A1Str
		syscall
		#if (used1 <= 0) goto endI5;
		blez $t1, endI5
            	#hopPtr1 = a1;
		la $t4, a1
            	#endPtr1 = a1 + used1;
            	la $v1, a1
            	sll $a1, $t1, 2
            	add $a1, $a1, $v1
begDW2:
            	#cout << *hopPtr1 << ' ' << ' ';
            	li $v0, 1
		lw $a0, 0($t4)
		syscall
		li $v0, 11
		li $a0, ' '
		syscall
		li $v0, 11
		li $a0, ' '
		syscall
            	#++hopPtr1;
		addi $t4, $t4, 4
DWTest2:        
		#if (hopPtr1 < endPtr1) goto begDW2;
		blt $t4, $a1, begDW2
endI5:
            	#cout << endl;
           	li $v0, 11
		li $a0, '\n'
		syscall
            	#used2 = 0;
            	li $t2, 0
            	#used3 = 0;
            	li $t3, 0
            	#hopPtr1 = a1;
		la $t4, a1
            	#hopPtr2 = a2;
            	la $t5, a2
            	#hopPtr3 = a3;
            	la $t7, a3
            	#endPtr1 = a1 + used1;
            	la $v1, a1
            	sll $a1, $t1, 2
            	add $a1, $a1, $v1
           	#goto WTest3;
            	j WTest3
begW3:
            	#intHolder = *hopPtr1;
            	lw $v1, 0($t4)
            	#*hopPtr2 = intHolder;
            	sw $v1, 0($t5)
            	#++used2;
            	addi $t2, $t2, 1
            	#++hopPtr2;
            	addi $t5, $t5, 4
            	#*hopPtr3 = intHolder;
            	move $v1, $t7
            	#++used3;
            	addi $t3, $t3, 1
            	#++hopPtr3;
            	addi $t7, $t7, 4
            	#++hopPtr1;
		addi $t4, $t4, 4
WTest3:     	
		#if (hopPtr1 < endPtr1) goto begW3;
		blt $t4, $a1, begW3

            	#iter = 0;
            	li $a0, 0
begDW3:
            	#++iter;
            	addi $a0, $a0, 1
            	#count = 0;
            	li $t9, 0
            	#if (iter != 1) goto else6;
            	li $v1, 1
            	bne $a0, $v1, else6
            	#hopPtr1 = a1;
		la $t4, a1
            	#endPtr1 = a1 + used1;
            	la $v1, a1
            	sll $a1, $t1, 2
            	add $a1, $a1, $v1
            	#goto FTest3;
            	j FTest3
begF3:
            	#target = *hopPtr1;
            	lw $t0, 0($t4)
            	#if (target == 5) goto else7;
            	li $v1, 5
            	beq $t0, $v1, else7
            	#++count;
            	addi $t9, $t9, 1
            	#goto endI7;
            	j endI7
else7:
            	#if (count == 0) goto endI8;
            	beqz $t9, endI8
            	#*(hopPtr1 - count) = *hopPtr1;
            	move $v1, $t4
            	sub $t4, $t4, $t9
		sw $v1, 0($t4)
endI8:
endI7:
            	#++hopPtr1;
		addi $t4, $t4, 4
FTest3:         
		#if (hopPtr1 < endPtr1) goto begF3;
		blt $t4, $a1, begF3
		#used1 -= count;
		sub $t1, $t1, $t9 		
            	#if (used1 != 0) goto endI9;
            	bnez $t1, endI9
            	#hopPtr1 = a1;
		la $t4, a1
            	#*hopPtr1 = -99;
            	li $v1, -99
            	sw $v1, 0($t4)
            	#++used1;
		addi $t1, $t1, 1
endI9:
            	#goto endI6;
            	j endI6
else6:
            	#if (iter != 2) goto elseI10;
            	li $v1, 2
            	bne $a0, $v1, elseI10
            	#hopPtr2 = a2;
            	la $t5, a2
            	#endPtr2 = a2 + used2;
            	la $v1, a2
            	sll $a2, $t2, 2
            	add $a2, $a2, $v1
            	#goto FTest4;
            	j FTest4
begF4:
            	#target = *hopPtr2;
            	lw $t0, 0($t5)
            	#if (target <= 4) goto elseI11;
            	li $v1, 4
            	ble $t0, $v1, elseI11
            	#++count;
            	addi $t9, $t9, 1
            	#goto endI11;
            	j endI11
elseI11:
            	#if (count == 0) goto endI12;
            	beqz $t9, endI12
            	#*(hopPtr2 - count) = *hopPtr2;
            	move $v1, $t5
            	sub $t5, $t5, $t9
		sw $v1, 0($t5)
endI12:
endI11:
            	#++hopPtr2;
            	addi $t5, $t5, 4
FTest4:         
		#if (hopPtr2 < endPtr2) goto begF4;
		blt $t5, $a2, begF4
            	#used2 -= count;
            	sub $t2, $t2, $t9
            	#if (used2 != 0) goto endI13;
            	bnez $t2, endI13
            	#hopPtr2 = a2;
            	la $t5, a2
            	#*hopPtr2 = -99;
            	li $v1, -99
            	lw $v1, 0($t5)
            	#++used2;
            	addi $t2, $t2, 1
endI13:
            	#goto endI10;
            	j endI10
elseI10:
            	#hopPtr3 = a3;
            	la $t7, a3
            	#endPtr3 = a3 + used3;
            	la $v1, a3
            	sll $a3, $t3, 2
            	add $a3, $a3, $v1
            	#goto FTest5;
            	j FTest5
begF5:
            	#target = *hopPtr3;
            	lw $t0, 0($t7)
            	#if (target >= 6) goto elseI14;
            	li $v1, 6
            	bge $t0, $v1, elseI14
		#++count;
		addi $t9, $t9, 1
            	#goto endI14;
            	j endI14
elseI14:
            	#if (count == 0) goto endI15;
            	beqz $t9, endI15
            	#*(hopPtr3 - count) = *hopPtr3;
            	move $v1, $t7
            	sub $t7, $t7, $t9
		sw $v1, 0($t7)
endI15:
endI14:
            	#++hopPtr3;
            	addi $t7, $t7, 4
FTest5:         
		#if (hopPtr3 < endPtr3) goto begF5;
		blt $t7, $a3, begF5
            	#used3 -= count;
            	sub $t3, $t3, $t9
            	#if (used3 != 0) goto endI16;
            	bnez $t3, endI16
            	#hopPtr3 = a3;
            	la $t7, a3
            	#*hopPtr3 = -99;
            	li $v1, -99
            	lw $v1, 0($t7)
            	#++used3;
            	addi, $t3, $t3, 1
endI16:
endI10:
endI6:
DWTest3:        
		#if (iter < 3) goto begDW3;
		li $v1, 3
		blt $a0, $v1, begDW3
endI3:

            	#cout << procA1Str;
            	li $v0, 4
            	la $a0, procA1Str
            	syscall
            	#if (used1 <= 0) goto endI17;
            	blez $t1, endI17
            	#hopPtr1 = a1;
		la $t4, a1
            	#endPtr1 = a1 + used1;
            	la $v0, a1
            	sll $a1, $t1, 2
            	add $a1, $a1, $v0
begDW4:
            	#cout << *hopPtr1 << ' ' << ' ';
            	li $v0, 1
		lw $a0, 0($t4)
		syscall
		li $v0, 11
		li $a0, ' '
		syscall
		li $v0, 11
		li $a0, ' '
		syscall
            	#++hopPtr1;
		addi $t4, $t4, 4
DWTest4:        
		#if (hopPtr1 < endPtr1) goto begDW4;
		blt $t4, $a1, begDW4
endI17:
            	#cout << endl;
           	li $v0, 11
		li $a0, '\n'
		syscall
            	#cout << procA2Str;
            	li $v0, 4
            	la $a0, procA2Str
            	syscall
            	#if (used2 <= 0) goto endI18;
            	blez $t2, endI18
            	#hopPtr2 = a2;
            	la $t5, a2
            	#endPtr2 = a2 + used2;
            	la $v0, a2
            	sll $a2, $t2, 2
            	add $a2, $a2, $v0
begDW5:
            	#cout << *hopPtr2 << ' ' << ' ';
            	li $v0, 1
		lw $a0, 0($t5)
		syscall
		li $v0, 11
		li $a0, ' '
		syscall
		li $v0, 11
		li $a0, ' '
		syscall
            	#++hopPtr2;
		addi $t5, $t5, 4            	
DWTest5:        
		#if (hopPtr2 < endPtr2) goto begDW5;
		blt $t5, $a2, begDW5
endI18:
            	#cout << endl;
           	li $v0, 11
		li $a0, '\n'
		syscall
            	#cout << procA3Str;
            	li $v0, 4
            	la $a0, procA3Str
            	syscall
            	#if (used3 <= 0) goto endI19;
            	blez $t3, endI19
            	#hopPtr3 = a3;
            	la $t7, a3
            	#endPtr3 = a3 + used3;
            	la $v0, a3
            	sll $a3, $t3, 2
            	add $a3, $a3, $v0
begDW6:
            	#cout << *hopPtr3 << ' ' << ' ';
            	li $v0, 1
		lw $a0, 0($t7)
		syscall
		li $v0, 11
		li $a0, ' '
		syscall
		li $v0, 11
		li $a0, ' '
		syscall
            	#++hopPtr3;
            	addi $t7, $t7, 4
DWTest6:    
		#if (hopPtr3 < endPtr3) goto begDW6;
		blt $t7, $a3, begDW6
endI19:
            	#cout << endl;
           	li $v0, 11
		li $a0, '\n'
		syscall
            	#cout << dacStr;
            	li $v0, 4
            	la $a0, dacStr
            	syscall
            	#cin >> reply;
		li $v0, 12
		syscall
		move $t8, $v0
WTest1:     
            	#if (reply == 'n') goto xitW1;
		li $v1, 'n'
		beq $t8, $v1, xitW1
		#if (reply != 'N') goto begW1;
		li $v1, 'N'
		bne $t8, $v1, begW1
xitW1:
            	#cout << dlStr << '\n';
            	li $v0, 4
            	la $a0, dlStr
            	syscall
           	li $v0, 11
		li $a0, '\n'
		syscall
            	#cout << byeStr << '\n';
            	li $v0, 4
            	la $a0, byeStr
            	syscall
            	li $v0, 11
		li $a0, '\n'
		syscall
            	#cout << dlStr << '\n';
            	li $v0, 4
            	la $a0, dlStr
            	syscall
           	li $v0, 11
		li $a0, '\n'
		syscall

            	#return 0;
            	li $v0, 10
            	syscall
#}
