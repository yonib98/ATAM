.global _start

.section .text
_start:
#num, countbits
movq (num), %rbx
xor %ecx, %ecx #counter=0
xor %ax,%ax
mov $2,%r8
for_HW1:
movb %bl,%al
divb %r8b
addb %ah,%cl

shr $1,%rbx
cmp $0, %rbx
jne for_HW1

movl %ecx,(CountBits)
