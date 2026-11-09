# Ma nguon 5 – phan bac dien nang
.data
prompt: .asciiz "Nhap dien nang (kWh): "
msg:    .asciiz "Bac: "
nl:     .asciiz "\n"
 
.text
.globl main
main:
  li  $v0, 4
  la  $a0, prompt
  syscall
  li  $v0, 5            # doc kWh, ket qua o $v0
  syscall
  add $s0, $v0, $zero   # $s0 = dien nang (kWh)
  # >>> xac dinh bac (1..4) theo Bang 6, dat vao $s1
  ble  $s0, 100, Bac1    # Neu kWh <= 100 -> Bac 1
    ble  $s0, 150, Bac2    # Neu kWh <= 150 -> Bac 2
    ble  $s0, 200, Bac3    # Neu kWh <= 200 -> Bac 3
 li   $s1, 4
    j    Print
Bac1:
    li   $s1, 1
    j    Print
Bac2:
    li   $s1, 2
    j    Print
Bac3:
    li   $s1, 3
Print:
    # >>> in "Bac: ", roi $s1, roi xuong dong
    li   $v0, 4
    la   $a0, msg
    syscall
    li   $v0, 1
    move $a0, $s1
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall
  
  li  $v0, 10
  syscall
