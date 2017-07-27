         .data       
# label:   .asciiz "\n1234 x 321 = "
         .text
         .globl main
main:
         li $t1, 1234
         li $t2, 321
#         addiu $sp, $sp, -8
         addiu $sp, $sp, -23
         li $t0, '\n'
         sb $t0,     0($sp)
         li $t0, '1'
         sb $t0,     1($sp)
         li $t0, '2'
         sb $t0,     2($sp)
         li $t0, '3'
         sb $t0,     3($sp)
         li $t0, '4'
         sb $t0,     4($sp)
         li $t0, ' '
         sb $t0,     5($sp)
         li $t0, 'x'
         sb $t0,     6($sp)
         li $t0, ' '
         sb $t0,     7($sp)
         li $t0, '3'
         sb $t0,     8($sp)
         li $t0, '2'
         sb $t0,     9($sp)
         li $t0, '1'
         sb $t0,     10($sp)
         li $t0, ' '
         sb $t0,     11($sp)
         li $t0, '='
         sb $t0,     12($sp)
         li $t0, ' '
         sb $t0,     13($sp)
         li $t0, '\0'
         sb $t0,     14($sp)
#         
# can economize lines of code but . . .
#
         li $t0, '\n'
         sb $t0, 0($sp)
         li $t0, '1'
         sb $t0, 1($sp)
         sb $t0, 10($sp)
         li $t0, '2'
         sb $t0, 2($sp)
         sb $t0, 9($sp)
         li $t0, '3'
         sb $t0, 3($sp)
         sb $t0, 8($sp)
         li $t0, '4'
         sb $t0, 4($sp)
         li $t0, 'x'
         sb $t0, 6($sp)
         li $t0, ' '
         sb $t0, 5($sp)
         sb $t0, 7($sp)
         sb $t0, 11($sp)
         sb $t0, 13($sp)
         li $t0, '='
         sb $t0, 12($sp)
         li $t0, '\0'
         sb $t0, 14($sp)

#         sw $t1, 4($sp)
#         sw $t2, 0($sp)
         sw $t1, 15($sp)
         sw $t2, 19($sp)

#         la $a0, label
         move $a0, $sp

         li $v0, 4
         syscall
#         lw $t3, 4($sp)
#         lw $t4, 0($sp)
         lw $t3, 15($sp)
         lw $t4, 19($sp)
         mul $a0, $t3, $t4
         li $v0, 1
         syscall
#         addiu $sp, $sp, 8
         addiu $sp, $sp, 23
         li $v0, 10
         syscall
