         .data       
# label:   .asciiz "\n1234 x 321 = "
         .text
         .globl main
main:
         li $t1, 1234
         li $t2, 321
#         addiu $sp, $sp, -8
###         addiu $sp, $sp, -23
         addiu $sp, $sp, -24
         li $t0, '\n'
         sb $t0,     8($sp)
         li $t0, '1'
         sb $t0,     9($sp)
         li $t0, '2'
         sb $t0,     10($sp)
         li $t0, '3'
         sb $t0,     11($sp)
         li $t0, '4'
         sb $t0,     12($sp)
         li $t0, ' '
         sb $t0,     13($sp)
         li $t0, 'x'
         sb $t0,     14($sp)
         li $t0, ' '
         sb $t0,     15($sp)
         li $t0, '3'
         sb $t0,     16($sp)
         li $t0, '2'
         sb $t0,     17($sp)
         li $t0, '1'
         sb $t0,     18($sp)
         li $t0, ' '
         sb $t0,     19($sp)
         li $t0, '='
         sb $t0,     20($sp)
         li $t0, ' '
         sb $t0,     21($sp)
         li $t0, '\0'
         sb $t0,     22($sp)

         sw $t1, 0($sp)
         sw $t2, 4($sp)
##         sw $t1, 15($sp)
##         sw $t2, 19($sp)         

#         la $a0, label
##         move $a0, $sp
         addi $a0, $sp, 8

         li $v0, 4
         syscall
         lw $t3, 4($sp)
         lw $t4, 0($sp)
##         lw $t3, 15($sp)
##         lw $t4, 19($sp)         
         mul $a0, $t3, $t4
         li $v0, 1
         syscall
#         addiu $sp, $sp, 8
         addiu $sp, $sp, 23
         li $v0, 10
         syscall
