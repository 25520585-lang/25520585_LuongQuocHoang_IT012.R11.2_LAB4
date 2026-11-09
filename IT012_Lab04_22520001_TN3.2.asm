.data
m1:      .asciiz "Thang "
m2:      .asciiz ": "
mt:      .asciiz "Tong: "
mm:      .asciiz "Thang cao nhat: "
lp:      .asciiz " ("
rp:      .asciiz ")"
nl:      .asciiz "\n"
reading: .word 1000, 1095, 1205, 1345, 1510, 1715, 1955
         .word 2210, 2440, 2625, 2775, 2895, 2995
usage:   .space 48
# Ma nguon 8 – dien nang tung thang
.text
.globl main
main:
  la   $s0, reading     # $s0 = dia chi nen reading
  la   $s1, usage       # $s1 = dia chi nen usage
  addi $s2, $zero, 0    # i = 0
  addi $s3, $zero, 12   # n = 12 thang
  
  addi $s4, $zero, 0    # $s4 = tong dien nang (ban dau = 0)
  addi $s5, $zero, -1   # $s5 = dien nang max (ban dau = -1)
  addi $s6, $zero, 0    # $s6 = thang max
Loop:
  # >>> thoat neu i == n
    beq  $s2, $s3, Done   
    # >>> tinh dia chi reading[i]
    sll  $t1, $s2, 2      # $t1 = i * 4
    add  $t1, $t1, $s0    # $t1 = &reading[i]
    # >>> $t3 = reading[i], $t4 = reading[i+1]
    lw   $t3, 0($t1)      # $t3 = reading[i]
    lw   $t4, 4($t1)      # $t4 = reading[i+1]
    # >>> $t5 = $t4 - $t3 (dien nang thang i+1)
    sub  $t5, $t4, $t3    
    # >>> tinh dia chi usage[i], luu $t5 vao usage[i]
    sll  $t2, $s2, 2      # $t2 = i * 4
    add  $t2, $t2, $s1    # $t2 = &usage[i]
    sw   $t5, 0($t2)      # usage[i] = $t5
    add  $s4, $s4, $t5    # C?ng d?n t?ng ?i?n n?ng vào $s4
    
    slt  $t6, $s5, $t5    # So sánh: N?u $s5 < $t5 thì $t6 = 1
    beq  $t6, $zero, Skip_Max
    move $s5, $t5         # C?p nh?t m?c ?i?n n?ng l?n nh?t m?i
    addi $s6, $s2, 1      # C?p nh?t s? tháng t??ng ?ng (i + 1)
 Skip_Max:
    # >>> in "Thang ", i+1, ": ", $t5, xuong dong
    # In "Thang "
    li   $v0, 4
    la   $a0, m1
    syscall
    # In i + 1 (s? tháng t? 1 ??n 12)
    li   $v0, 1
    addi $a0, $s2, 1
    syscall
    # In ": "
    li   $v0, 4
    la   $a0, m2
    syscall
    # In ?i?n n?ng ($t5)
    li   $v0, 1
    move $a0, $t5
    syscall
    # In xu?ng dòng "\n"
    li   $v0, 4
    la   $a0, nl
    syscall
    # >>> i = i + 1, quay lai Loop
    addi $s2, $s2, 1
    j    Loop
Done:
    # In "Tong: <tong>\n"
    li   $v0, 4
    la   $a0, mt
    syscall
    li   $v0, 1
    move $a0, $s4
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall
    # In "Thang cao nhat: <thang> (<dien nang>)\n"
    li   $v0, 4
    la   $a0, mm
    syscall
    li   $v0, 1
    move $a0, $s6
    syscall
    li   $v0, 4
    la   $a0, lp
    syscall
    li   $v0, 1
    move $a0, $s5
    syscall
    li   $v0, 4
    la   $a0, rp
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall
    li   $v0, 10
  syscall
