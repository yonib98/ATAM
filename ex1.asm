.global _start

.section .text
_start:
movq (num), %rax
xor %ecx,%ecx  #i=0
mov $2, %r9
for_HW1:
 cqo
 div %r9
 addl %edx,%ecx
 shr $1, %rax
 test %rax,%rax
 jne for_HW1
 movl %ecx, (CountBits)
 
 