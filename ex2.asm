.global _start

.section .text
_start:
cmp $0,(num)
je END
lea source, %rbx 
lea destination, %rdx 
movl num, %r8d 
movsx %r8d, %r8 #r8=num
cmp $0,%r8d
jl negative_n

copy_start:
mov %rdx,%r9
sub %rbx,%r9 #destinaton-source is saved in r9
cmp $0, %r9
jl normal_copy
reverse_copy:
mov %r8, %rcx
dec %rcx
mov %rdx, %r13
add %r8, %r13
dec %r13
loop_reverse_copy:
movb (%rbx, %rcx,1), %r11b
movb %r11b, (%r13)
dec %rcx
dec %r13
cmp $0,%rcx
jge loop_reverse_copy
jmp END

negative_n:
mov %rdx, %rcx
mov %rbx, %rdx
mov %rcx, %rbx
imul $-1,%r8,%r8
jmp copy_start

normal_copy:
xor %rcx,%rcx
normal_copy_loop:
movb (%rbx,%rcx,1),%r11b
movb %r11b, (%rdx,%rcx,1)
inc %rcx
cmp %rcx, %r8
jne normal_copy_loop
jmp END

END:
