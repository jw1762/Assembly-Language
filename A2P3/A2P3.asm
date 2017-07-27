###############################################################################
# Title: Assign02P3                     Author: Jordan Williamson
# Class: CS 2318-252, Spring 2016       Submitted: 3/31/2016
###############################################################################
# Program: MIPS tranlation of a given C++ program
###############################################################################
# Pseudocode description: supplied a2p2_SampSoln.cpp
###############################################################################
#include <iostream>
#using namespace std;
			.data
a1:			.space 48 #int a1[12],	
a2:			.space 48 #int a2[12];
einStr:			.asciiz "\nEnter integer #"
#char einStr[]	  = "Enter integer #"
moStr:			.asciiz "Max of "
#char moStr[]	  = "Max of "
ieStr:			.asciiz " ints entered..." 
#char ieStr[]     = " ints entered...";
emiStr:			.asciiz "Enter more ints? (n or N = no, others = yes) " 
#char emiStr[]    = "Enter more ints? (n or N = no, others = yes) \n";
begA1Str:		.asciiz "beginning a1: "
#char begA1Str[]  = "beginning a1: ";
negaA1Str:		.asciiz "a1 negatives: "
#char negaA1Str[] = "a1 negatives: ";
posiA1Str:		.asciiz "a1 positives: "
#char posiA1Str[] = "a1 positives: ";
procA1Str:		.asciiz "processed a1: "
#char procA1Str[] = "processed a1: ";
dacStr:			.asciiz "Do another case? (n or N = no, others = yes) "
#char dacStr[]    = "Do another case? (n or N = no, others = yes) ";
d1Str:			.asciiz "================================"
#char dlStr[]     = "================================";
byeStr:			.asciiz "bye..."
#char byeStr[]    = "bye...";
colSp:			.asciiz ": "
endl:			.asciiz "\n"
#int main()
#{
			.text
			.globl main
			
main:
###############################################################################
# Register usage:
###############################################################################
# $a0 
# $a1 endl
# $a2 min1
# $a3 min2
# $v1 reply

# $s0 nNeg
# $s1 nPos
# $s2 counter
# $s3 width
# $s4 i
# $s5 iL
# $s6 iR
# $s7 iE

# $t0 hopPtr1
# $t1 hopPtr11
# $t2 hopPtr12
# $t3 hopPtr2
# $t4 used1
# $t5 temp (short lived)
# $t6 endPtr1
# $t7 endPtr11
# $t8 endPtr12
# $t9 endPtr2
###############################################################################
               #char reply;
               #int  used1,
                   # nNeg,
                   # nPos,
                   # counter,
                   # width,
                   # //min1,
                   # //min2,
                   # i,
                   # iL,
                   # iR,
                   # iE,
                   # temp,
                   #*hopPtr1,
                   #*hopPtr11,
                   #*hopPtr12,
                   #*hopPtr2,
                   #*endPtr1,
                   #*endPtr11,
                   #*endPtr12,
                   #*endPtr2;

              # reply = 'y';
			li $v1, 'y'
               #//while (reply != 'n' && reply != 'N')
               #goto WTest1;
			j WTest1
begW1:#//       {			
                  #used1 = 0;
			li $t4, 0                  
                  #hopPtr1 = a1;
			la $t0, a1                  
                  #//while (reply != 'n' && reply != 'N')
                  #goto WTest2;
			j WTest2
begW2:#//          {
                     #cout << einStr;
			li $v0, 4
			la $a0, einStr
			syscall                     
                     #cout << (used1 + 1);
                        li $v0, 1
                        addi $a0, $t4, 1
                        syscall
                     #cout << ':' << ' ';
                        li $v0, 4
                        la $a0, colSp
                        syscall
                     #cin >> *hopPtr1;
                        li $v0, 5
			syscall
			sw $v0, 0($t0)
                     #++used1;
                        addi $t4, $t4, 1
                     #++hopPtr1;
			addi $t0, $t0, 4 #Why 4?                    
                     #//if (used1 < 12)                
                     #if (used1 >= 12) goto elseI1;
                        li $t5, 12
                        bge $t4, $t5, elseI1
begI1:#//             {
                        #cout << emiStr;
                        li $v0, 4
                        la $a0, emiStr
                        syscall
                        #cin >> reply;
                        li $v0, 12
                        syscall
                        move $v1, $v0
                     #goto endI1;
                     	j endI1
#//                   }
elseI1:#//            else
#//                   {
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
			li $v0, 4
			la $a0, endl
			syscall
                        #reply = 'n';
                        li $v1, 'n'
endI1:#//             }
endW2:#//          }
WTest2:
                  #///if (reply != 'n' && reply != 'N') goto begW2;
                  #if (reply == 'n') goto xitW2;
                  	li $t5, 'n'
                  	beq $v1, $t5, xitW2
                  #if (reply != 'N') goto begW2;
                  	li $t5, 'N'
                  	bne $v1, $t5, begW2
xitW2:
                  #cout << endl;
                  	li $v0, 4
                  	la $a0, endl
                  	syscall
                  #cout << begA1Str;
                  	li $v0, 4
                  	la $a0, begA1Str
                  	syscall
                  #//if (used1 > 0)
                  #if (used1 <= 0) goto endI2;
                  	blez $t4, endI2
begI2:#//          {
                     #hopPtr1 = a1;
                     	la $t0, a1
                     #endPtr1 = a1 + used1;
                     	la $t5, a1
                     	sll $t6, $t4, 2 
                     	add $t6, $t6, $t5                    	                     
                     #//do
begDW1:#//            {
                        #cout << *hopPtr1 << ' ' << ' ';
                        li $v0, 1
                        lw $a0, 0($t0)
                        syscall
                        li $v0, 11
			li $a0, ' '
			syscall
			li $v0, 11
			li $a0, ' '
			syscall
                        #++hopPtr1;                 
                        addi $t0, $t0, 4                  
#//                   }
#                     //while (hopPtr1 < endPtr1);
DWTest1:
                     #if (hopPtr1 < endPtr1) goto begDW1;
                     	blt $t0, $t6, begDW1
endI2:#//          }
                  #cout << endl;
                  	li $v0, 11
			li $a0, '\n'
			syscall
                  #hopPtr1 = a1;
                  	la $t0, a1
                  #hopPtr2 = a1 + used1 - 1;
                  	la $t5, a1			
                  	sll $t6, $t1, 2                        
                  	add $t6, $t5, $t6
                  	addi $t6, $t6, -1		
                  #counter = 0;
                  	li $s2, 0
                  #//while (hopPtr1 <= hopPtr2)
                  #goto WTest3;
                  	j WTest3
begW3:#//           {
                     #//while (hopPtr1 <= hopPtr2)
                     #goto WTest4;
                     	j WTest4
begW4:#//             {
                        #//if (*hopPtr1 >= 0) break;
                        #if (*hopPtr1 >= 0) goto xitW4;
                        li $t5, 0
                        bge $t0, $t5, xitW4
                        #++hopPtr1;
                        addi $t0, $t0, 4 
                        #++counter;
                        addi $s2, $s2, 1                     
endW4:#//             }
WTest4:
                     #if (hopPtr1 <= hopPtr2) goto begW4;
                     	ble $t0, $t3, begW4
xitW4:

                     #//if (hopPtr1 > hopPtr2) break;
                     #if (hopPtr1 > hopPtr2) goto xitW3;
                     	bgt $t0, $t3, xitW3
                     #//while (hopPtr2 >= hopPtr1)
                     #goto WTest5;
                     	j WTest5
begW5:#//             {
                        #//if (*hopPtr2 < 0)
                        #if (*hopPtr2 >= 0) goto endI5;
                        li $t5, 0
                        bge $t3, $t5, endI5
begI5:#//                {
                           #//if (hopPtr1 != hopPtr2)
                           #if (hopPtr1 == hopPtr2) goto endI6;
                        beq $t0, $t3, endI6   
begI6:#//                   {
                              #++counter;
                        addi $s2, $s2, 1     
endI6:#//                   }
                           #//break;
                           #goto xitW5;
                        j xitW5
endI5:#//                }
                        #--hopPtr2;
                        addi $t3, $t3, -4
endW5:#//             }
WTest5:
                     #if (hopPtr2 >= hopPtr1) goto begW5;
                     	bge $t3, $t0, begW5
xitW5:

                     #//if (hopPtr1 > hopPtr2) break;
                     #if (hopPtr1 > hopPtr2) goto xitW3;
                     	bgt $t0, $t3, xitW3
                     #//if (hopPtr1 != hopPtr2)
                     #if (hopPtr1 == hopPtr2) goto endI8;
                     	beq $t0, $t3, endI8
begI8:#//             {
                        #temp = *hopPtr1;
                        lw $t5, 0($t0)
                        #*hopPtr1 = *hopPtr2;
                        move $t0, $t3 		
                        #*hopPtr2 = temp;
                        sw $t5, 0($t3)
endI8:#//             }
                     #++hopPtr1;
                     	addi $t0, $t0, 4
                     #--hopPtr2;
                     	addi $t3, $t3, -4
endW3:#//          }
WTest3:
                  #if (hopPtr1 <= hopPtr2) goto begW3;
                  	ble $t0, $t3, begW3
xitW3:
                  #nNeg = counter;
                  	move $s0, $s2
                  #nPos = used1 - counter;
			move $s1, $t4
			sub $s1, $s1, $s2
                  #cout << negaA1Str;
                  	li $v0, 4
                  	la $a0, negaA1Str
                  	syscall
                  #//if (nNeg > 0)
                  #if (nNeg <= 0) goto endI9;               	
                  	ble $s0, $zero, endI9
begI9:#//          {
                     #hopPtr1 = a1;
                     	la $t0, a1
                     #endPtr1 = a1 + nNeg;
                     	la $t5, a1					
                     	sll $t6, $s0, 2                 	
                     	add $t6, $t6, $t5                    	              	
                     #//do
begDW2:#//            {
                        #cout << *hopPtr1 << ' ' << ' ';
                        li $v0, 1
			lw $a0, 0($t0)
			syscall
			li $v0, 11
			li $a0, ' '
			syscall
			li $v0, 11
			li $a0, ' '
			syscall
                        #++hopPtr1;
                        addi $t0, $t0, 4
endDW2:#//            }
DWTest2:
                     #//while (hopPtr1 < endPtr1);
                     #if (hopPtr1 < endPtr1) goto begDW2;
                     	blt $t0, $t6, begDW2
endI9:#//          }
                  #cout << endl;
			li $v0, 11
			li $a0, '\n'
			syscall
                  #cout << posiA1Str;
                  	li $v0, 4
                  	la $a0, posiA1Str
                  	syscall
                  #//if (nPos > 0)
                  #if (nPos <= 0) goto endIa;             
                  	ble $s1, $zero, endIa
begIa:#//          {
                     #hopPtr1 = a1 + nNeg;
                     	la $t5, a1
                     	sll $t0, $s0, 2
                     	add $t0, $t0, $t5  
                     #endPtr1 = hopPtr1 + nPos;
                     	add $t6, $s1, $t0	
                     	
                     #//do
begDW3:#//            {
                        #cout << *hopPtr1 << ' ' << ' ';
                        li $v0, 1
			lw $a0, 0($t0)
			syscall
			li $v0, 11
			li $a0, ' '
			syscall
			li $v0, 11
			li $a0, ' '
			syscall
                        #++hopPtr1;
                        addi $t0, $t0, 4                 
endDW3:#//            }
DWTest3:
                     #//while (hopPtr1 < endPtr1);
                     #if (hopPtr1 < endPtr1) goto begDW3;
                     	blt $t0, $t6, begDW3
endIa:#//          }
                  #cout << endl;
			li $v0, 11
			li $a0, '\n'
			syscall
                  #width = 1;
                  	li $s3, 1                 
                  #//while (width < used1)
                  #goto WTest6;
                  	j WTest6
begW6:#//          {
                     #i = 0;
                     	li $s4, 0
                     #//while (i < used1)
                     #goto WTest7;
                     	j WTest7
begW7:#//             {
                        #iL = i;
                        move $s5, $s4                     
                        #temp = i + width;
                        move $t5, $s4
                        add $t5, $t5, $s3	
                        #//if (temp < used1)
                        #if (temp >= used1) goto elseIb;
                        bge $t5, $t4, elseIb
begIb:#//                {
                           #iR = temp;
                        move $s6, $t5
                        #goto endIb;
                        j endIb
#//                      }
elseIb:#//               else
#//                      {
                           #iR = used1;
                        move $s6, $t4
endIb:#//                }
                        #temp = i + 2*width;                      
                        move $t5, $s4
                        sll, $a1, $s3, 1	
                        add $t5, $t5, $a1
                        #//if (temp < used1)
                        #if (temp >= used1) goto elseIc;
                        bge $t5, $t4, elseIc
begIc:#//                {
                           #iE = temp;
                        move $s7, $t5
                        #goto endIc;
                        j endIc
#//                      }
elseIc:#//               else
#//                      {
                           #iE = used1;
                        move $s7, $t4   
endIc:#//                }
                        #hopPtr11 = a1 + iL;                        
                        la $t5, a1
                        sll $t1, $s5, 2
                        add $t1, $t1, $t5                        
                        #hopPtr12 = a1 + iR;
                        la $t5, a1
                        sll $t2, $s6, 2
                        add $t2, $t2, $t5 
                        #endPtr11 = a1 + iR;
                        la $t5, a1
                        sll $t7, $s6, 2
                        add $t7, $t7, $t5 
                        #endPtr12 = a1 + iE;
                        la $t5, a1
                        sll $t8, $s7, 2
                        add $t8, $t8, $t5 
                        #//for (hopPtr2 = a2 + iL, endPtr2 = a2 + iE;
                        #//     hopPtr2 < endPtr2; ++hopPtr2)
                        #hopPtr2 = a2 + iL;
                        la $t5, a2
                        sll $t3, $s5, 2
                        add $t3, $t3, $t5 
                        #endPtr2 = a2 + iE;
                        la $t5, a1
                        sll $t3, $s7, 2
                        add $t3, $t3, $t5 
                        #goto FTest1;
                        j FTest1
begF1:#//                {
                           #//if ( hopPtr11 < endPtr11 &&
                           #//     (hopPtr12 >= endPtr12 || *hopPtr11 <= *hopPtr12)
                           #//   )
                           #if (hopPtr11 >= endPtr11) goto elseId;
                        bge $t1, $t7, elseId
                           #if (hopPtr12 >= endPtr12) goto begId;
                        bge $t2, $t8, begId
                           #if (*hopPtr11 > *hopPtr12) goto elseId;
                        bgt $t1, $t2, elseId
begId:#//                   {
                              #*hopPtr2 = *hopPtr11;
                        move $t3, $t1		
                              #++hopPtr11;
                        addi $t1, $t1, 4 
                           #goto endId;
                           j endId
#//                         }
elseId:#//                  else
#//                         {
                              #*hopPtr2 = *hopPtr12;
                        move $t3, $t2   
                              #++hopPtr12;
                        addi $t2, $t2, 4
endId:#//                   }
                           #++hopPtr2;
                        addi $t3, $t3, 4
endF1:#//                }
FTest1:
                        #if ( hopPtr2 < endPtr2) goto begF1;
                        blt $t3, $t9, begF1   
                        #i = i + 2 * width;                  
                        sll $a1, $s3, 1	    
                        add $t5, $s4, $a1
                        move $s4, $t5
endW7:#//             }
WTest7:
                     #if (i < used1) goto begW7;
                    	blt $s4, $t4, begW7
                     #hopPtr1 = a1;
                     	la $t0, a1
                     #hopPtr2 = a2;
                     	la $t3, a2
                     #endPtr2 = a2 + used1;
                     	la $t5, a2
                        sll $t9, $t4, 2
                        add $t9, $t9, $t5 
                     #//while(hopPtr2 < endPtr2)
                     #goto WTest8;
                     	j WTest8
begW8:#//             {
                        #*hopPtr1 = *hopPtr2;
                        move $t0, $t3
                        #++hopPtr1;
                        addi $t0, $t0, 4                        
                        #++hopPtr2;
                        addi $t3, $t3, 4                     
endW8:#//             }
WTest8:
                     #if (hopPtr2 < endPtr2) goto begW8;
                     	blt $t3, $t9, begW8

                     #width = 2 * width;
                     	sll $s3, $s3, 1
endW6:#//          }
WTest6:
                  #if (width < used1) goto begW6;
                  	blt $s3, $t4, begW6

                  #cout << nNeg << '-' << ' ' << nPos << '+' << endl;
                  	li $v0, 1
                  	move $a0, $s0
                  	syscall
                  	li $v0, 11
			li $a0, '-'
			syscall
			li $v0, 11
			li $a0, ' '
			syscall
			li $v0, 1
			move $a0, $s1
			syscall
			li $v0, 11
			li $a0, '+'
			syscall
			li $v0, 11
			li $a0, '\n'
			syscall                  	
                  #cout << procA1Str;
                  	li $v0, 4
                  	la $a0, procA1Str
                  	syscall
                  #//if (used1 > 0)
                  #if (used1 <= 0) goto endIe;
                  	ble $t4, $zero, endIe
begIe:#//          {
                     #hopPtr1 = a1;
                      	la $t0, a1                    
                     #endPtr1 = a1 + used1;
                     	la $t5, a1
                     	sll $t6, $t4, 2 
                     	add $t6, $t6, $t5             	
                     #//do
begDW4:#//            {
                        #cout << *hopPtr1 << ' ' << ' ';
                        li $v0, 1
                        lw $a0, 0($t0)
                        syscall
                        li $v0, 11
			li $a0, ' '
			syscall
			li $v0, 11
			li $a0, ' '
			syscall
                        #++hopPtr1;
                        addi $t0, $t0, 4
endDW4:#//            }
DWTest4:
                     #//while (hopPtr1 < endPtr1);
                     #if (hopPtr1 < endPtr1) goto begDW4;
                     	blt $t0, $t6, begDW4
                    
endIe:#//          }
                  #cout << endl;
               		li $v0, 4
                	la $a0, endl
                  	syscall
                  #cout << dacStr;
                  	li $v0, 4
                  	la $a0, dacStr
                  	syscall
                  #cin >> reply;
                  	li $v0, 12
                        syscall
                        move $v1, $v0
                  
endW1:#//       }
WTest1:
               #///if (reply != 'n' && reply != 'N') goto begW1;
               #if (reply == 'n') goto xitW1;
               		li $t5, 'n'
                  	beq $v1, $t5, xitW1
               #if (reply != 'N') goto begW1;
               		li $t5, 'N'
                  	bne $v1, $t5, begW1
xitW1:

               #cout << endl;
               		li $v0, 4
                	la $a0, endl
                  	syscall
               #cout << dlStr << '\n';
               		li $v0, 4
                	la $a0, d1Str
                  	syscall
               		li $v0, 4
                	la $a0, endl
                  	syscall
               #cout << byeStr << '\n';
               		li $v0, 4
                	la $a0, byeStr
                  	syscall
               		li $v0, 4
                	la $a0, endl
                  	syscall
               #cout << dlStr << '\n';
               		li $v0, 4
                	la $a0, d1Str
                  	syscall
               		li $v0, 4
                	la $a0, endl
                  	syscall
		
#               return 0;
			li $v0, 10
            		syscall
#}
