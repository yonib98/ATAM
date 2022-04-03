.global main
.section .data
source: .ascii "memmove can be very useful"
#:memmove is very very useful"
#         is very useful
num: .int 11
.section .text
main:
lea source+20, %rbx
lea source+15, %rdx
movl num, %r8d
movsx %r8d, %r8
cmp $0,%r8d
jl LABEL_1
LABEL2:
mov %rdx,%r9
sub %rbx,%r9 #destinaton-source is saved in r9
LABEL_COPY:
mov %r8, %rcx
dec %rcx
mov %r8, %r10 #r10<-num
sub %r9, %r10 #r10<-num-(destination-source)
cmp $0,%r10
jle FIX
BEFORE_LOOP:
mov %rdx, %r13
add %r8, %r13
dec %r13
LOOP_COPY:
movb (%rbx, %rcx,1), %r11b
movb %r11b, (%r13)
dec %rcx
dec %r13
cmp $0,%rcx
jge LOOP_COPY
jmp END

FIX:
mov $0, %r10
jmp BEFORE_LOOP

LABEL_1:
mov %rdx, %rcx
mov %rbx, %rdx
mov %rcx, %rbx
imul $-1,%r8,%r8
jmp LABEL2

END: