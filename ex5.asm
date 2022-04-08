.global _start

.section .text
_start:

movq (src), %rax #rax<-src
movq (dst), %rbx #rbx<-dst
cmp %rax, %rbx
je end

movq (head), %r12 #r12<-head
cmp $0, %r12
je end

xor %rcx, %rcx #counter src
xor %rdx, %rdx #counter dst
xor %rdi, %rdi
xor %rsp, %rsp

#r10 <- adress of src previous
#r11 <- adress of dst previous
#checking root
movq (%r12),%r13 #r13<- head
cmp %rax, %r13 #source==head?
je visited_src_from_root
cmp %rbx, %r13 #dest==head?
je visited_dst_from_root

main_loop:
movq 8(%r12), %r13
cmp %rax, (%r13)
je visited_src
cmp %rbx, (%r13)
je visited_dst
advance_head:
movq 8(%r12), %r12
cmp $0, 8(%r12)
je swap
jmp main_loop

swap:
cmp $1, %rcx
jne end
cmp $1, %rdx
jne end

cmp $0, %r10
je dst_source_update
movq %r15, 8(%r10) #src_previous->next=dst

dst_source_update:
cmp $0, %r11
je next_update
movq %r14, 8(%r11) #dst_previous->next= src

next_update:
movq 8(%r14), %rcx #source-> next goes to rcx
movq 8(%r15), %rdx #dest-> next goes to rdx
movq %rcx, 8(%r15)
movq %rdx, 8(%r14)
cmp $1, %rdi
je update_dst_to_head
cmp $1, %rsp
je update_src_to_head
jmp end

update_dst_to_head:
movq %r15, (head)
jmp end

update_src_to_head:
movq %r14, (head)
jmp end

visited_src:
incq %rcx
cmp $1, %rcx
je update_src_adress
jmp advance_head

update_src_adress:
lea (%r12), %r10 #src_previous
lea 8(%r12), %r14
movq (%r14), %r14 #src
jmp advance_head

visited_dst:
incq %rdx
cmp $1, %rdx
je update_dst_adress
jmp advance_head

update_dst_adress:
lea (%r12), %r11 #dst_previous
lea 8(%r12), %r15
movq (%r15), %r15 #dst 
jmp advance_head

visited_src_from_root:
incq %rcx
incq %rdi
cmp $1, %rcx
je update_src_adress_from_root
jmp main_loop

update_src_adress_from_root:
movq $0, %r10  #src_previous
lea (%r12), %r14 #src
jmp main_loop

visited_dst_from_root:
incq %rdx
incq %rsp
cmp $1, %rdx
je update_dst_adress_from_root
jmp main_loop

update_dst_adress_from_root:
movq $0, %r11 #dst_previous
lea (%r12), %r15 #dst 
jmp main_loop

end:



