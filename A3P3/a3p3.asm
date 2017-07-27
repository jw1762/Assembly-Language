################################################################################
# Name:		Jordan Williamson
# Class:	CS2318 - 252, Spring 2016
# Subject:	Assignment 3 Part 3
# Date:		5/2/2016 
################################################################################
#void CoutCstr(char cstr[]);
#void CoutCstrNL(char cstr[]);
#void CoutOneInt(int oneInt);
#void PopulateArray(int a[], int* usedPtr, int cap);
#void SPFN(int used1, int a1[], int* nNegPtr, int* nPosPtr);
#void CopyArray(int a2[], int a1[], int n);
#void BUM(int a1[], int iL, int iR, int iE, int a2[]);
#void BUMS(int a1[], int a2[], int used);
#void ProcArray(int used1, int a1[], int a2[], int* nNegPtr, int* nPosPtr);
#void ShowArray(int a[], int used);
#void ShowArrayLabeled(int a[], int used, char label[]);
#void Swap(int* intPtr1, int* intPtr2);
#int  Min(int int1, int int2);
#
			.text
			.globl main
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#int main()
#{
###############################################################################
main:
#################
# Register usage:
#################
# $t0: holder for a value/address
# $t4: reply
# (usual ones for syscall & function call)
###############################################################################
#               int  a1[12],
#                    a2[12];
#		char reply;
#		int  used1,
#                    nNeg,
#                    nPos;
#		char begA1Str[]  = "beginning a1: ";
#		char procA1Str[] = "processed a1: ";
#		char dlStr[]     = "================================";
#		char byeStr[]    = "bye...";

			# PROLOG:
			addiu $sp, $sp, -256
			sw $ra, 252($sp)
			sw $fp, 248($sp)
			addiu $fp, $sp, 256
			
			j begDataInitM				# "clutter-reduction" jump
endDataInitM:

			# BODY:
#		reply = 'y';
			li $t4, 'y'
#		goto WTest1;
			j WTest1
begW1:
#		PopulateArray(a1, &used1, 12);
			addi $a0, $sp, 152
			addi $a1, $sp, 148
			li $a2, 12
			jal PopulateArray
#               cout << endl;
			li $v0, 11
			li $a0, '\n'
			syscall
#		ShowArrayLabeled(a1, used1, begA1Str);
			addi $a0, $sp, 152
			lw $a1, 148($sp)
			addi $a2, $sp, 24
			jal ShowArrayLabeled
#               ProcArray(used1, a1, a2, &nNeg, &nPos);
			########## (6) ##########
			lw $a0, 148($sp)
			addiu $a1, $sp, 152
			addiu $a2, $sp, 200
			addiu $a3, $sp, 144
			addiu $t0, $sp, 140
			sw $t0, 16($sp)
			jal ProcArray
#               cout << nNeg << '-' << ' ' << nPos << '+' << endl;
			li $v0, 1
			lw $a0, 144($sp)
			syscall
			li $v0, 11
			li $a0, '-'
			syscall
			li $a0, ' '
			syscall
			li $v0, 1
			lw $a0, 140($sp)
			syscall
			li $v0, 11
			li $a0, '+'
			syscall
			li $a0, ' '
			syscall
			li $v0, 11
			li $a0, '\n'
			syscall
#		ShowArrayLabeled(a1, used1, procA1Str);
			addi $a0, $sp, 152
			lw $a1, 148($sp)
			addi $a2, $sp, 46
			jal ShowArrayLabeled
#               cout << endl;
			li $v0, 11
			li $a0, '\n'
			syscall
#		cout << dacStr;
			addi $a0, $sp, 61
			jal CoutCstr
#		cin >> reply;
			li $v0, 12
			syscall
			move $t4, $v0				# $t4 is reply			
			# newline to offset shortcoming of syscall #12
			li $v0, 11
			li $a0, '\n'
			syscall
#WTest1:	if (reply == 'n') goto xitW1;
#		if (reply != 'N') goto begW1;
WTest1:			li $t0, 'n'
			beq $t4, $t0, xitW1
			li $t0, 'N'
			bne $t4, $t0, begW1
endW1:
xitW1:
#               cout << endl;
			li $v0, 11
			li $a0, '\n'
			syscall
#		cout << dlStr << '\n';
			addi $a0, $sp, 107
			jal CoutCstrNL			
#		cout << byeStr << '\n';
			addi $a0, $sp, 39
			jal CoutCstrNL			
#		cout << dlStr << '\n';
			addi $a0, $sp, 107
			jal CoutCstrNL			

			# EPILOG:
			lw $fp, 248($sp)
			lw $ra, 252($sp)
			addiu $sp, $sp, 256
#		return 0;
#}
			li $v0, 10
			syscall


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void CoutCstr(char cstr[])
#{
###############################################################################
CoutCstr:
#################
# Register usage:
#################
# (usual ones for syscall)
###############################################################################
			# PROLOG:
				# no stack frame needed
			# BODY:
#		cout << cstr;
			li $v0, 4
			syscall
			
			# EPILOG:
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void CoutCstrNL(char cstr[])
#{
###############################################################################
CoutCstrNL:
#################
# Register usage:
#################
# (usual ones for syscall & function call)
###############################################################################
			# PROLOG:
			addiu $sp, $sp, -32
			sw $ra, 28($sp)
			sw $fp, 24($sp)
			addiu $fp, $sp, 32

			# BODY:
#		CoutCstr(cstr);
			jal CoutCstr
#		cout << '\n';
			li $a0, '\n'
			li $v0, 11
			syscall
			
			# EPILOG:
			lw $fp, 24($sp)
			lw $ra, 28($sp)
			addiu $sp, $sp, 32
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void CoutOneInt(int oneInt)
#{
###############################################################################
CoutOneInt:
#################
# Register usage:
#################
# (usual ones for syscall)
###############################################################################
			# PROLOG:
				# no stack frame needed
			# BODY:
#		cout << oneInt;
			li $v0, 1
			syscall
			
			# EPILOG:
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void PopulateArray(int a[], int* usedPtr, int cap)
#{
###############################################################################
PopulateArray:
#################
# Register usage:
#################
# $s1: hopPtr
# $t0: holder for a value/address
# $t1: another holder for a value/address
# $t2: yet another holder for a value/address
# $t4: reply
# (usual ones for syscall & function call)
###############################################################################
#		char reply;
#		char einStr[]    = "Enter integer #";
#		char moStr[]     = "Max of ";
#		char ieStr[]     = " ints entered...";
#		char emiStr[]    = "Enter more ints? (n or N = no, others = yes) ";
#		int *hopPtr;

			# PROLOG:
			addiu $sp, $sp, -120
			sw $ra, 116($sp)
			sw $fp, 112($sp)
			addiu $fp, $sp, 120
	
			j begDataInitPA				# "clutter-reduction" jump
endDataInitPA:

			sw $a1, 4($fp)				# usedPtr as received saved in caller's frame
			sw $a2, 8($fp)				# cap as received saved in caller's frame
			sw $s1, 16($sp)				# save $s1 (callee-saved)
			
			# BODY:
#		reply = 'y';
			li $t4, 'y'				# $t4 is reply
#		*usedPtr = 0;
			sw $0, 0($a1)				# $a1 still has usedPtr as received
#		hopPtr = a;
			move $s1, $a0				# $a0 still has a as received
#		goto WTest2;
			j WTest2
begW2:
#		CoutCstr(einStr);
			addi $a0, $sp, 24
			jal CoutCstr
#		CoutOneInt(*usedPtr + 1);
			lw $a1, 4($fp)				# usedPtr as received re-loaded into $a1
				# CoutCstr might have clobbered $a1
			lw $a0, 0($a1)				# $a0 has *usedPtr
			addi $a0, $a0, 1			# *usedPtr + 1 as arg1
			jal CoutOneInt
#		cout << ':' << ' ';
			li $v0, 11
			li $a0, ':'
			syscall
			li $a0, ' '
			syscall
#		cin >> *hopPtr;
			li $v0, 5			
			syscall			# $v0 has user-entered int
			sw $v0, 0($s1)				# $s1 is hopPtr
#		++(*usedPtr);
			lw $a1, 4($fp)				# usedPtr as received re-loaded into $a1
				# CoutOneInt might have clobbered $a1
			lw $t1, 0($a1)				# $t1 has *usedPtr
			addi $t1, $t1, 1			# $t1 has *usedPtr + 1
			sw $t1, 0($a1)				# ++(*usedPtr)
#		++hopPtr;
			addi $s1, $s1, 4			# $s1 is hopPtr
#		if (*usedPtr >= cap) goto else1;
			lw $a2, 8($fp)				# cap as received re-loaded into $a2
				# CoutOneInt might have clobbered $a2
			bge $t1, $a2, else1			# if (*usedPtr >= cap) goto else1
				# $t1 still has up-to-date *usedPtr
begI1:
#		CoutCstr(emiStr);
			addi $a0, $sp, 48
			jal CoutCstr
#		cin >> reply;
			li $v0, 12
			syscall
			move $t4, $v0				# $t4 is reply
			# newline to offset shortcoming of syscall #12
			li $v0, 11
			li $a0, '\n'
			syscall
#		goto endI1;
			j endI1
else1:
#		CoutCstr(moStr);
			addi $a0, $sp, 40
			jal CoutCstr
#		CoutOneInt(cap);
			lw $a0, 8($fp)				# cap as received loaded into $a0
				# not using $a2 as CoutCstr might have clobbered it
			jal CoutOneInt
#		CoutCstr(ieStr);
			addi $a0, $sp, 94
			jal CoutCstr
#		cout << endl;
			li $v0, 11
			li $a0, '\n'
			syscall
#		reply = 'n';
			li $t4, 'n'				# $t4 is reply
endI1:
#WTest2:	if (reply == 'n') goto xitW2;
#		if (reply != 'N') goto begW2;
WTest2:			li $t0, 'n'
			beq $t4, $t0, xitW2
			li $t0, 'N'
			bne $t4, $t0, begW2
endW2:
xitW2:
			# EPILOG:
			lw $s1, 16($sp)				# restore $s1 (callee-saved)
			lw $fp, 112($sp)
			lw $ra, 116($sp)
			addiu $sp, $sp, 120  
#		return;
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void ShowArray(int a[], int used)
#{
###############################################################################
ShowArray:
#################
# Register usage:
#################
# $t1: hopPtr
# $t9: endPtr
# $a1: used (as received)
# (usual ones for syscall & function call)
###############################################################################
			# PROLOG:
				# no stack frame needed
			
			# BODY:
#		int *hopPtr;
#		int *endPtr;

#		if (used <= 0) goto endI2;
			blez $a1, endI2
begI2:
#		hopPtr = a;
			move $t1, $a0
#		endPtr = a + used;
			move $t9, $a1				# $t9 has used
			sll $t9, $t9, 2				# $t9 has 4*used
			add $t9, $t9, $t1			# $t9 has &a[used]
begDW1:
#		cout << *hopPtr << ' ' << ' ';
			li $v0, 1
			lw $a0, 0($t1)				# $a0 has *hopPtr
			syscall
			li $v0, 11
			li $a0, ' '
			syscall
			syscall
#		++hopPtr;
			addi $t1, $t1, 4
endDW1:
#DWTest1:	if (hopPtr < endPtr) goto begDW1;
DWTest1:		blt $t1, $t9, begDW1
endI2:
#		cout << endl;
			li $v0, 11
			li $a0, '\n'
			syscall
			
			# EPILOG:
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void ShowArrayLabeled(int a[], int used, char label[])
#{
###############################################################################
ShowArrayLabeled:
#################
# Register usage:
#################
# $t1: i
# $v1: holder for a value/address
# (usual ones for function call)
###############################################################################
			# PROLOG:
			addiu $sp, $sp, -32
			sw $ra, 28($sp)
			sw $fp, 24($sp)
			addiu $fp, $sp, 32
			
			sw $a0, 0($fp)				# a as received saved in caller's frame
			sw $a1, 4($fp)				# used as received saved in caller's frame
			
			# BODY:
#		CoutCstr(label);
			move $a0, $a2
			jal CoutCstr
#		ShowArray(a, used);
			lw $a0, 0($fp)				# a as received re-loaded into $a0
			lw $a1, 4($fp)				# used as received re-loaded into $a1
								# CoutCstr might have clobbered $a0 & $a1
			jal ShowArray			
			
			# EPILOG:
			lw $fp, 24($sp)
			lw $ra, 28($sp)
			addiu $sp, $sp, 32  
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void Swap(int* intPtr1, int* intPtr2)
#{
###############################################################################
Swap:
#################
# Register usage:
#################
# $v0: temp
# $v1: holder for a value/address
###############################################################################
			# PROLOG:			# no stack frame needed
			
			# BODY:
#               int temp = *intPtr1;
#               *intPtr1 = *intPtr2;
#               *intPtr2 = temp;
			lw $v0, 0($a0)
			lw $v1, 0($a1)			# $v1 has *intPtr2
			sw $v1, 0($a0)			# *intPtr1 = *intPtr2
			sw $v0, 0($a1)

			# EPILOG:
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#int  Min(int int1, int int2)
#{
###############################################################################
Min:
#################
# Register usage:
#################
# $v0: holder for a value/address
# $v1: holder for a value/address
###############################################################################
			# PROLOG:			# no stack frame needed
			
			# BODY:
#                if (int1 >= int2) goto else_M
			bge $a0, $a1, else_M
begI_M:#     {
#                   return int1;
			move $v0, $a0
#                goto endI_M
			j endI_M
#                }
else_M:#         else
#                {
#                   return int2;
			move $v0, $a1
endI_M:#     }

			# EPILOG:
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
########################li $v0, 999999999
			li $v1, 999999999
#########################################
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void SPFN(int used1, int a1[], int* nNegPtr, int* nPosPtr)
#                $a0       $a1           $a2           $a3
#{
###############################################################################
SPFN:
#################
# Register usage:
#################
# $t1: hopPtr1
# $t2: hopPtr2
# $t3: counter
# $v1: holder for a value/address
# (usual ones for function call)
###############################################################################
			########## (53) ##########
			# PROLOG:
			addiu $sp, $sp, -40
			sw $ra, 36($sp)
			sw $fp, 32($sp)
			addiu $fp, $sp, 40
			
			sw $a0, 0($fp)
			sw $a1, 4($fp)
			sw $a2, 8($fp)
			sw $a3, 12($fp)
												
			# BODY:
#                int* hopPtr1;
#                int* hopPtr2;
#                int counter;
			
#                hopPtr1 = a1;
			move $t1, $a1		# $t1 (hopPtr) has a1
#                hopPtr2 = a1 + used1 - 1;
			addi $t2, $a0, -1
			sll $t2, $t2, 2
			add $t2, $t2, $a1
#                counter = 0;
			li $t3, 0	#counter = 0
#                goto WTest1_SPFN
			j WTest1_SPFN
begW1_SPFN:#     {
#                  goto WTest2_SPFN
			j WTest2_SPFN
begW2_SPFN:#       {
#                      if (*hopPtr1 >= 0) break;
			lw $v1, 0($t1)
			bgez $v1, xitW2_SPFN
#                      ++hopPtr1;
			addi $t1, $t1, 4
#                      ++counter;
			addi $t3, $t3, 1
endW2_SPFN:#       }
WTest2_SPFN:#      if (hopPtr1 <= hopPtr2) goto begW2_SPFN;
			ble $t1, $t2, begW2_SPFN
xitW2_SPFN:

#                  if (hopPtr1 > hopPtr2) break;
			bgt $t1, $t2, xitW1_SPFN
			
#                  goto WTest3_SPFN;
			j WTest3_SPFN
begW3_SPFN:#       {
#                     if (*hopPtr2 >= 0) goto endI1_SPFN;
			lw $v1, 0($t2)
			bgez $v1, endI1_SPFN
begI1_SPFN:#          {
#                        if (hopPtr1 == hopPtr2) goto endI2_SPFN;
			beq $t1, $t2, endI2_SPFN
begI2_SPFN:#             {
#                            ++counter;
			addi $t3, $t3, 1
endI2_SPFN:#             }
#                         break;
			j xitW3_SPFN
endI1_SPFN:#          }
#                     --hopPtr2;
			addi $t2, $t2, -4
endW3_SPFN:#       }
WTest3_SPFN:#      if (hopPtr2 >= hopPtr1) goto begW3_SPFN;
			bge $t2, $t1, begW3_SPFN
xitW3_SPFN:			
#                  if (hopPtr1 > hopPtr2) break;
			bgt $t1, $t2, xitW1_SPFN
			
#                  if (hopPtr1 == hopPtr2) goto endI3_SPFN;
			beq $t1, $t2, endI3_SPFN
begI3_SPFN:#       {
#                      Swap(hopPtr1, hopPtr2);
			move $a0, $t1
			move $a1, $t2
			sw $t1, 16($sp)
			sw $t2, 20($sp)
			sw $t3, 24($sp)
			jal Swap
			lw $t1, 16($sp)
			lw $t2, 20($sp)
			lw $t3, 24($sp)
endI3_SPFN:#       }
#                  ++hopPtr1;
			addi $t1, $t1, 4
#                  --hopPtr2;
			addi $t2, $t2, -4
endW1_SPFN:#       }
WTest1_SPFN:#      if (hopPtr1 <= hopPtr2) goto begW1_SPFN
			ble $t1, $t2, begW1_SPFN
xitW1_SPFN:                
#                *nNegPtr = counter;
			lw $a2, 8($fp)
			sw $t3, 0($a2)			
#                *nPosPtr = used1 - counter;
			lw $a0, 0($fp)
			lw $a3, 12($fp)
			sub $v1, $a0, $t3
			sw $v1, 0($a3)
			# EPILOG:
			lw $fp, 32($sp)				
			lw $ra, 36($sp)
			addiu $sp, $sp, 40
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#// Sort array in non-decreasing order
#// a1[] has items to sort; a2[] is work array
#void BUMS(int a1[], int a2[], int used)
#                $a0      $a1       $a2
#{
###############################################################################
BUMS:
#################
# Register usage:
#################
# $s0: i
# $s1: width
# $t1: min1
# $t2: min2
# $v1: holder for a value/address
# (usual ones for function call)
###############################################################################
			########## (47) ##########
			# PROLOG:
			addiu $sp, $sp, -48
			sw $ra, 44($sp)
			sw $fp, 40($sp)
			addiu $fp, $sp, 48
			
			sw $a0, 0($fp)
			sw $a1, 4($fp)
			sw $a2, 8($fp)
			
			sw $s0, 20($sp)
			sw $s1, 24($sp)
			# BODY:			
#               int i;			
#               int width;
#               int min1;
#               int min2;
#               width = 1;
			li $s1, 1
#               goto WTest1_BUMS
			j WTest1_BUMS
begW1_BUMS:#    {
#                  i = 0;
			li $s0, 0
#                  goto WTest2_BUMS
			j WTest2_BUMS
begW2_BUMS:#       {
#                     min1 = Min(i+width, used);
			addu $a0, $s0, $s1
			lw $a1, 8($fp)
			sw $t1, 28($sp)
			sw $t2, 32($sp)
			jal Min
			lw $t1, 28($sp)
			lw $t2, 32($sp)
			move $t1, $v0
#                     min2 = Min(i+2*width, used);
			sll $a0, $s1, 1
			addu $a0, $s0, $a0
			lw $a1, 8($fp)
			sw $t1, 28($sp)
			sw $t2, 32($sp)
			jal Min
			lw $t1, 28($sp)
			lw $t2, 32($sp)
			move $t2, $v0
#                     BUM(a1, i, min1, min2, a2);
			lw $a0, 0($fp)
			move $a1, $s0
			move $a2, $t1
			move $a3, $t2
			lw $v0, 4($fp)
			sw $v0, 16($sp)
			sw $t1, 28($sp)
			sw $t2, 32($sp)
			jal BUM
			lw $t1, 28($sp)
			lw $t2, 32($sp)
#                     i = i + 2 * width;
			sll $v1, $s1, 1
			addu, $s0, $s0, $v1 
endW2_BUMS:#       }
WTest2_BUMS:#   if (i < used) goto begW2_BUMS;
			lw $a2, 8($fp)
			blt $s0, $a2, begW2_BUMS

#                  CopyArray(a2, a1, used);
			lw $a0, 4($fp)
			lw $a1, 0($fp)
			sw $t1, 28($sp)
			sw $t2, 32($sp)
			
			jal CopyArray
			lw $t1, 28($sp)
			lw $t2, 32($sp)
#                  width = 2 * width;
			sll $s1, $s1, 1		#width = 2*Width
endW1_BUMS:#    }
WTest1_BUMS:#   if (width < used) goto begW1_BUMS;
			lw $a2, 8($fp)
			blt $s1, $a2, begW1_BUMS
                
			# EPILOG:
			lw $s0, 20($sp)
			lw $s1, 24($sp)
			lw $fp, 40($sp)				
			lw $ra, 44($sp)
			addiu $sp, $sp, 48  
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#// Combine (sub-)arrays:
#//   Left  run is a1[iL :iR-1]
#//   Right run is a1[iR :iE-1]
#void BUM(int a1[], int iL, int iR, int iE, int a2[])
#              $a0     $a1     $a2     $a3   16($..)
#{
###############################################################################
BUM:
#################
# Register usage:
#################
# $s0: hopPtr11
# $s1: hopPtr12
# $s2: hopPtr2
# $t0: endPtr11
# $t1: endPtr12
# $t2: endPtr2
# $v0: holder 1 for a value/address
# $v1: holder 2 for a value/address
###############################################################################
			########## (40) ##########
			# PROLOG:
			addiu $sp, $sp, -32
			sw $ra, 28($sp)
			sw $fp, 24($sp)
			addiu $fp, $sp, 32
			
			sw $s0, 0($sp)
			sw $s1, 4($sp)
			sw $s2, 8($sp)
			# BODY:
#               int *hopPtr11;
#               int *hopPtr12;
#               int *hopPtr2;
#               int *endPtr11;
#               int *endPtr12;
#               int *endPtr2;

#               hopPtr11 = a1 + iL;
			sll $s0, $a1, 2
			add $s0, $s0, $a0 
#               hopPtr12 = a1 + iR;
			sll $s1, $a2, 2
			add $s1, $s1, $a0 
#               endPtr11 = a1 + iR;
			sll $t0, $a2, 2
			add $t0, $t0, $a0 
#               endPtr12 = a1 + iE;
			sll $t1, $a3, 2
			add $t1, $t1, $a0 
#               hopPtr2 = a2 + iL;
			sll $s2, $a1, 2
			lw $v0, 16($fp)
			add $s2, $s2, $v0 
#               endPtr2 = a2 + iE;
			sll $t2, $a3, 2
			lw $v0, 16($fp)
			add $t2, $t2, $v0 
#               goto FTest_BUM;
			j FTest_BUM
begF_BUM:#      {
#                  if (hopPtr11 >= endPtr11) goto else_BUM;
			bge $s0, $t0, else_BUM
#                  if (hopPtr12 >= endPtr12) goto begI_BUM;
			bge $s1, $t1, begI_BUM
#                  if (*hopPtr11 > *hopPtr12) goto else_BUM;
			lw $v0, 0($s0)
			lw $v1, 0($s1) 			
			bgt $v0, $v1, else_BUM
begI_BUM:#         {
#                     *hopPtr2 = *hopPtr11;
			lw $v0, 0($s0)
			sw $v0, 0($s2)
#                     ++hopPtr11;
			addiu $s0, $s0, 4
#                     goto endI_BUM;
			j endI_BUM
#                  }
else_BUM:#         else
#                  {
#                     *hopPtr2 = *hopPtr12;
			lw $v0, 0($s1)
			sw $v0, 0($s2)
#                     ++hopPtr12;
			addiu $s1, $s1, 4
endI_BUM:#         }
#                  ++hopPtr2;
			addiu $s2, $s2, 4
endF_BUM:#      }
FTest_BUM:#     if (hopPtr2 < endPtr2) goto begF_BUM;
			blt $s2, $t2, begF_BUM
			
			# EPILOG:
			lw $s0, 0($sp)
			lw $s1, 4($sp)
			lw $s2, 8($sp)
					
			lw $fp, 24($sp)				
			lw $ra, 28($sp)
			addiu $sp, $sp, 32
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#// Copy a2[0]...a2[numEle2 - 1]
#//   to a1[0]...a1[numEle2 - 1]
#void CopyArray(int a2[], int a1[], int numEle2)
#                   $a0       $a1       $a2
#{
###############################################################################
CopyArray:
#################
# Register usage:
#################
# $t1: hopPtr1
# $t2: hopPtr2
# $t8: endPtr2
# $v1: holder for a value/address
###############################################################################
			# PROLOG:			# no stack frame needed
			
			# BODY:
#               int *hopPtr1;
#               int *hopPtr2;
#               int *endPtr2;

#               hopPtr1 = a1;
			move $t1, $a1
#               hopPtr2 = a2;
			move $t2, $a0
#               endPtr2 = a2 + numEle2;
			sll $t8, $a2, 2			# $t8 has 4*numEle2
			add $t8 $t8, $a0
#               goto WTest_CA
			j WTest_CA
begW_CA:#       {
#                  *hopPtr1 = *hopPtr2;
			lw $v1, 0($t2)
			sw $v1, 0($t1)
#                  ++hopPtr1;
			addi $t1, $t1, 4
#                  ++hopPtr2;
			addi $t2, $t2, 4
endW_CA:#       }
WTest_CA:#      if (hopPtr2 < endPtr2) goto begW_CA;
			blt $t2, $t8, begW_CA
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void ProcArray(int used1, int a1[], int a2[], int* nNegPtr, int* nPosPtr)
#                     $a0       $a1       $a2           $a3       16($fp)
#{
###############################################################################
ProcArray:
#################
# Register usage:
#################
# $t0: holder for a value/address
# $t1: truncAvg
# $v1: holder for a value/address
# (usual ones for function call)
###############################################################################
			# PROLOG:
			addiu $sp, $sp, -56
			sw $ra, 52($sp)
			sw $fp, 48($sp)
			addiu $fp, $sp, 56
			
			sw $a0, 0($fp)				# used1   as received saved in caller's frame
			sw $a1, 4($fp)				# a1      as received saved in caller's frame
			sw $a2, 8($fp)				# a2      as received saved in caller's frame
			sw $a3, 12($fp)				# nNegPtr as received saved in caller's frame
			
			# BODY:
#               char negaA1Str[] = "a1 negatives: ";
#               char posiA1Str[] = "a1 positives: ";
			j begDataInitPrAr			# "clutter-reduction" jump			
endDataInitPrAr:			
#               SPFN(used1, a1, nNegPtr, nPosPtr);
			#move $a0, $a0				# just pass on $a0 as recieved
			#move $a1, $a1				# just pass on $a1 as recieved
			########## (2) ##########
			move $a2, $a3
			lw $a3, 16($fp)
			jal SPFN				
			
			j begDebugSPFN				# uncomment this instruction if useful when debugging 
endDebugSPFN:			

#               ShowArrayLabeled(a1, *nNegPtr, negaA1Str);
			########## (4) ##########
			lw $a0, 4($fp)
			lw $a1, 12($fp)
			lw $a1, 0($a1)
			addi $a2, $sp, 16
						
			jal ShowArrayLabeled
#               ShowArrayLabeled(a1 + *nNegPtr, *nPosPtr, posiA1Str);
			########## (8) ##########
			lw $a0, 12($fp)
			lw $a0, 0($a0)
			sll $a0, $a0, 2
			lw $t0, 4($fp)
			addu $a0, $a0, $t0
			lw $a1, 16($fp)
			lw $a1, 0($a1)
			addiu $a2, $sp, 31
			
			jal ShowArrayLabeled
#               BUMS(a1, a2, used1);
			lw $a0, 4($fp)				# a1 as received (saved on stack coming in) as arg1
			lw $a1, 8($fp)				# a2 as received (saved on stack coming in) as arg2
			lw $a2, 0($fp)				# used1 as received (saved on stack coming in) as arg3
			jal BUMS

			# EPILOG:
			lw $fp, 48($sp)				
			lw $ra, 52($sp)
			addiu $sp, $sp, 56  
#}
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# main's string initialization code moved out of the way to reduce clutter
###############################################################################
begDataInitM:
			li $t0, 'b'
			sb $t0, 24($sp)
			li $t0, 'e'
			sb $t0, 25($sp)
			li $t0, 'g'
			sb $t0, 26($sp)
			li $t0, 'i'
			sb $t0, 27($sp)
			li $t0, 'n'
			sb $t0, 28($sp)
			li $t0, 'n'
			sb $t0, 29($sp)
			li $t0, 'i'
			sb $t0, 30($sp)
			li $t0, 'n'
			sb $t0, 31($sp)
			li $t0, 'g'
			sb $t0, 32($sp)
			li $t0, ' '
			sb $t0, 33($sp)
			li $t0, 'a'
			sb $t0, 34($sp)
			li $t0, '1'
			sb $t0, 35($sp)
			li $t0, ':'
			sb $t0, 36($sp)
			li $t0, ' '
			sb $t0, 37($sp)
			li $t0, '\0'
			sb $t0, 38($sp)
			li $t0, 'b'
			sb $t0, 39($sp)
			li $t0, 'y'
			sb $t0, 40($sp)
			li $t0, 'e'
			sb $t0, 41($sp)
			li $t0, '.'
			sb $t0, 42($sp)
			li $t0, '.'
			sb $t0, 43($sp)
			li $t0, '.'
			sb $t0, 44($sp)
			li $t0, '\0'
			sb $t0, 45($sp)
			li $t0, 'p'
			sb $t0, 46($sp)
			li $t0, 'r'
			sb $t0, 47($sp)
			li $t0, 'o'
			sb $t0, 48($sp)
			li $t0, 'c'
			sb $t0, 49($sp)
			li $t0, 'e'
			sb $t0, 50($sp)
			li $t0, 's'
			sb $t0, 51($sp)
			li $t0, 's'
			sb $t0, 52($sp)
			li $t0, 'e'
			sb $t0, 53($sp)
			li $t0, 'd'
			sb $t0, 54($sp)
			li $t0, ' '
			sb $t0, 55($sp)
			li $t0, 'a'
			sb $t0, 56($sp)
			li $t0, '1'
			sb $t0, 57($sp)
			li $t0, ':'
			sb $t0, 58($sp)
			li $t0, ' '
			sb $t0, 59($sp)
			li $t0, '\0'
			sb $t0, 60($sp)
			
			li $t0, 'D'
			sb $t0, 61($sp)
			li $t0, 'o'
			sb $t0, 62($sp)
			li $t0, ' '
			sb $t0, 63($sp)
			li $t0, 'a'
			sb $t0, 64($sp)
			li $t0, 'n'
			sb $t0, 65($sp)
			li $t0, 'o'
			sb $t0, 66($sp)
			li $t0, 't'
			sb $t0, 67($sp)
			li $t0, 'h'
			sb $t0, 68($sp)
			li $t0, 'e'
			sb $t0, 69($sp)
			li $t0, 'r'
			sb $t0, 70($sp)
			li $t0, ' '
			sb $t0, 71($sp)
			li $t0, 'c'
			sb $t0, 72($sp)
			li $t0, 'a'
			sb $t0, 73($sp)
			li $t0, 's'
			sb $t0, 74($sp)
			li $t0, 'e'
			sb $t0, 75($sp)
			li $t0, '?'
			sb $t0, 76($sp)
			li $t0, ' '
			sb $t0, 77($sp)
			li $t0, '('
			sb $t0, 78($sp)
			li $t0, 'n'
			sb $t0, 79($sp)
			li $t0, ' '
			sb $t0, 80($sp)
			li $t0, 'o'
			sb $t0, 81($sp)
			li $t0, 'r'
			sb $t0, 82($sp)
			li $t0, ' '
			sb $t0, 83($sp)
			li $t0, 'N'
			sb $t0, 84($sp)
			li $t0, ' '
			sb $t0, 85($sp)
			li $t0, '='
			sb $t0, 86($sp)
			li $t0, ' '
			sb $t0, 87($sp)
			li $t0, 'n'
			sb $t0, 88($sp)
			li $t0, 'o'
			sb $t0, 89($sp)
			li $t0, ','
			sb $t0, 90($sp)
			li $t0, ' '
			sb $t0, 91($sp)
			li $t0, 'o'
			sb $t0, 92($sp)
			li $t0, 't'
			sb $t0, 93($sp)
			li $t0, 'h'
			sb $t0, 94($sp)
			li $t0, 'e'
			sb $t0, 95($sp)
			li $t0, 'r'
			sb $t0, 96($sp)
			li $t0, 's'
			sb $t0, 97($sp)
			li $t0, ' '
			sb $t0, 98($sp)
			li $t0, '='
			sb $t0, 99($sp)
			li $t0, ' '
			sb $t0, 100($sp)
			li $t0, 'y'
			sb $t0, 101($sp)
			li $t0, 'e'
			sb $t0, 102($sp)
			li $t0, 's'
			sb $t0, 103($sp)
			li $t0, ')'
			sb $t0, 104($sp)
			li $t0, ' '
			sb $t0, 105($sp)
			li $t0, '\0'
			sb $t0, 106($sp)
			
			li $t0, '='
			sb $t0, 107($sp)
			li $t0, '='
			sb $t0, 108($sp)
			li $t0, '='
			sb $t0, 109($sp)
			li $t0, '='
			sb $t0, 110($sp)
			li $t0, '='
			sb $t0, 111($sp)
			li $t0, '='
			sb $t0, 112($sp)
			li $t0, '='
			sb $t0, 113($sp)
			li $t0, '='
			sb $t0, 114($sp)
			li $t0, '='
			sb $t0, 115($sp)
			li $t0, '='
			sb $t0, 116($sp)
			li $t0, '='
			sb $t0, 117($sp)
			li $t0, '='
			sb $t0, 118($sp)
			li $t0, '='
			sb $t0, 119($sp)
			li $t0, '='
			sb $t0, 120($sp)
			li $t0, '='
			sb $t0, 121($sp)
			li $t0, '='
			sb $t0, 122($sp)
			li $t0, '='
			sb $t0, 123($sp)
			li $t0, '='
			sb $t0, 124($sp)
			li $t0, '='
			sb $t0, 125($sp)
			li $t0, '='
			sb $t0, 126($sp)
			li $t0, '='
			sb $t0, 127($sp)
			li $t0, '='
			sb $t0, 128($sp)
			li $t0, '='
			sb $t0, 129($sp)
			li $t0, '='
			sb $t0, 130($sp)
			li $t0, '='
			sb $t0, 131($sp)
			li $t0, '='
			sb $t0, 132($sp)
			li $t0, '='
			sb $t0, 133($sp)
			li $t0, '='
			sb $t0, 134($sp)
			li $t0, '='
			sb $t0, 135($sp)
			li $t0, '='
			sb $t0, 136($sp)
			li $t0, '='
			sb $t0, 137($sp)
			li $t0, '='
			sb $t0, 138($sp)
			li $t0, '\0'
			sb $t0, 139($sp)
			j endDataInitM				# back to main


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# PopulateArray's string initialization code moved out of the way to reduce clutter
###############################################################################
begDataInitPA:
			li $t0, 'E'
			sb $t0, 24($sp)
			li $t0, 'n'
			sb $t0, 25($sp)
			li $t0, 't'
			sb $t0, 26($sp)
			li $t0, 'e'
			sb $t0, 27($sp)
			li $t0, 'r'
			sb $t0, 28($sp)
			li $t0, ' '
			sb $t0, 29($sp)
			li $t0, 'i'
			sb $t0, 30($sp)
			li $t0, 'n'
			sb $t0, 31($sp)
			li $t0, 't'
			sb $t0, 32($sp)
			li $t0, 'e'
			sb $t0, 33($sp)
			li $t0, 'g'
			sb $t0, 34($sp)
			li $t0, 'e'
			sb $t0, 35($sp)
			li $t0, 'r'
			sb $t0, 36($sp)
			li $t0, ' '
			sb $t0, 37($sp)
			li $t0, '#'
			sb $t0, 38($sp)
			li $t0, '\0'
			sb $t0, 39($sp)
			li $t0, 'M'
			sb $t0, 40($sp)
			li $t0, 'a'
			sb $t0, 41($sp)
			li $t0, 'x'
			sb $t0, 42($sp)
			li $t0, ' '
			sb $t0, 43($sp)
			li $t0, 'o'
			sb $t0, 44($sp)
			li $t0, 'f'
			sb $t0, 45($sp)
			li $t0, ' '
			sb $t0, 46($sp)
			li $t0, '\0'
			sb $t0, 47($sp)
			li $t0, 'E'
			sb $t0, 48($sp)
			li $t0, 'n'
			sb $t0, 49($sp)
			li $t0, 't'
			sb $t0, 50($sp)
			li $t0, 'e'
			sb $t0, 51($sp)
			li $t0, 'r'
			sb $t0, 52($sp)
			li $t0, ' '
			sb $t0, 53($sp)
			li $t0, 'm'
			sb $t0, 54($sp)
			li $t0, 'o'
			sb $t0, 55($sp)
			li $t0, 'r'
			sb $t0, 56($sp)
			li $t0, 'e'
			sb $t0, 57($sp)
			li $t0, ' '
			sb $t0, 58($sp)
			li $t0, 'i'
			sb $t0, 59($sp)
			li $t0, 'n'
			sb $t0, 60($sp)
			li $t0, 't'
			sb $t0, 61($sp)
			li $t0, 's'
			sb $t0, 62($sp)
			li $t0, '?'
			sb $t0, 63($sp)
			li $t0, ' '
			sb $t0, 64($sp)
			li $t0, '('
			sb $t0, 65($sp)
			li $t0, 'n'
			sb $t0, 66($sp)
			li $t0, ' '
			sb $t0, 67($sp)
			li $t0, 'o'
			sb $t0, 68($sp)
			li $t0, 'r'
			sb $t0, 69($sp)
			li $t0, ' '
			sb $t0, 70($sp)
			li $t0, 'N'
			sb $t0, 71($sp)
			li $t0, ' '
			sb $t0, 72($sp)
			li $t0, '='
			sb $t0, 73($sp)
			li $t0, ' '
			sb $t0, 74($sp)
			li $t0, 'n'
			sb $t0, 75($sp)
			li $t0, 'o'
			sb $t0, 76($sp)
			li $t0, ','
			sb $t0, 77($sp)
			li $t0, ' '
			sb $t0, 78($sp)
			li $t0, 'o'
			sb $t0, 79($sp)
			li $t0, 't'
			sb $t0, 80($sp)
			li $t0, 'h'
			sb $t0, 81($sp)
			li $t0, 'e'
			sb $t0, 82($sp)
			li $t0, 'r'
			sb $t0, 83($sp)
			li $t0, 's'
			sb $t0, 84($sp)
			li $t0, ' '
			sb $t0, 85($sp)
			li $t0, '='
			sb $t0, 86($sp)
			li $t0, ' '
			sb $t0, 87($sp)
			li $t0, 'y'
			sb $t0, 88($sp)
			li $t0, 'e'
			sb $t0, 89($sp)
			li $t0, 's'
			sb $t0, 90($sp)
			li $t0, ')'
			sb $t0, 91($sp)
			li $t0, ' '
			sb $t0, 92($sp)
			li $t0, '\0'
			sb $t0, 93($sp)
			li $t0, ' '
			sb $t0, 94($sp)
			li $t0, 'i'
			sb $t0, 95($sp)
			li $t0, 'n'
			sb $t0, 96($sp)
			li $t0, 't'
			sb $t0, 97($sp)
			li $t0, 's'
			sb $t0, 98($sp)
			li $t0, ' '
			sb $t0, 99($sp)
			li $t0, 'e'
			sb $t0, 100($sp)
			li $t0, 'n'
			sb $t0, 101($sp)
			li $t0, 't'
			sb $t0, 102($sp)
			li $t0, 'e'
			sb $t0, 103($sp)
			li $t0, 'r'
			sb $t0, 104($sp)
			li $t0, 'e'
			sb $t0, 105($sp)
			li $t0, 'd'
			sb $t0, 106($sp)
			li $t0, '.'
			sb $t0, 107($sp)
			li $t0, '.'
			sb $t0, 108($sp)
			li $t0, '.'
			sb $t0, 109($sp)
			li $t0, '\0'
			sb $t0, 110($sp)
			j endDataInitPA				# back to PopulateArray


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# ProcArray's string initialization code moved out of the way to reduce clutter
###############################################################################
begDataInitPrAr:
			li $t0, 'a'
			sb $t0, 16($sp)
			li $t0, '1'
			sb $t0, 17($sp)
			li $t0, ' '
			sb $t0, 18($sp)
			li $t0, 'n'
			sb $t0, 19($sp)
			li $t0, 'e'
			sb $t0, 20($sp)
			li $t0, 'g'
			sb $t0, 21($sp)
			li $t0, 'a'
			sb $t0, 22($sp)
			li $t0, 't'
			sb $t0, 23($sp)
			li $t0, 'i'
			sb $t0, 24($sp)
			li $t0, 'v'
			sb $t0, 25($sp)
			li $t0, 'e'
			sb $t0, 26($sp)
			li $t0, 's'
			sb $t0, 27($sp)
			li $t0, ':'
			sb $t0, 28($sp)
			li $t0, ' '
			sb $t0, 29($sp)
			li $t0, '\0'
			sb $t0, 30($sp)
			li $t0, 'a'
			sb $t0, 31($sp)
			li $t0, '1'
			sb $t0, 32($sp)
			li $t0, ' '
			sb $t0, 33($sp)
			li $t0, 'p'
			sb $t0, 34($sp)
			li $t0, 'o'
			sb $t0, 35($sp)
			li $t0, 's'
			sb $t0, 36($sp)
			li $t0, 'i'
			sb $t0, 37($sp)
			li $t0, 't'
			sb $t0, 38($sp)
			li $t0, 'i'
			sb $t0, 39($sp)
			li $t0, 'v'
			sb $t0, 40($sp)
			li $t0, 'e'
			sb $t0, 41($sp)
			li $t0, 's'
			sb $t0, 42($sp)
			li $t0, ':'
			sb $t0, 43($sp)
			li $t0, ' '
			sb $t0, 44($sp)
			li $t0, '\0'
			sb $t0, 45($sp)
			j endDataInitPrAr			# back to ProcArray


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#################### code for used during debugging ###########################
################# show a1 contents after calling SPFN #########################
begDebugSPFN:
			li $v0, 11
			li $a0, '*'
			syscall
			syscall
			li $a0, 'a'
			syscall
			li $a0, 'f'
			syscall
			li $a0, '-'
			syscall
			li $a0, 'S'
			syscall
			li $a0, 'P'
			syscall
			li $a0, 'F'
			syscall
			li $a0, 'N'
			syscall
			li $a0, ' '
			syscall
			li $a0, 'a'
			syscall
			li $a0, '1'
			syscall
			li $a0, ':'
			syscall
			li $a0, ' '
			syscall
			lw $t1, 4($fp)				# $t1 (hopPtr) has a1
			lw $t9, 0($fp)				# $t9 has used1
			sll $t9, $t9, 2				# $t9 has 4*used1
			add $t9, $t9, $t1			# $t9 (endPtr) has (a1 + used1)
			j WTest_DSPFN
begW_DSPFN:
			li $v0, 1
			lw $a0, 0($t1)
			syscall			
			li $v0, 11
			li $a0, ' '
			syscall
			syscall
			addi $t1, $t1, 4
WTest_DSPFN:		blt $t1, $t9, begW_DSPFN
			li $v0, 11
			li $a0, '\n'
			syscall
			li $a0, '*'
			syscall
			syscall
			li $a0, '\n'
			syscall
			j endDebugSPFN				# back to ProcArray
###############################################################################
