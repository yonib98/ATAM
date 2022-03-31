.global _start

.section .text

  mov

  movq $60, %rax
  movq $0, %rdi
  syscall

bad_exit:
  movq $60, %rax
  movq $1, %rdi
  syscall

.section .data
source: .quad 0x12345
dest: .quad 0x6789
num: .int 11
