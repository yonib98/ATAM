.global main
.section .data
head: .quad node_0
src: .quad 478
dst: .quad 328
node_0: 
 .quad 478
 .quad node_1
node_1: 
 .quad 53
 .quad node_2
node_2: 
 .quad 430
 .quad node_3
node_3: 
 .quad 241
 .quad node_4
node_4: 
 .quad 458
 .quad node_5
node_5: 
 .quad 53
 .quad node_6
node_6: 
 .quad 89
 .quad node_7
node_7: 
 .quad 386
 .quad node_8
node_8: 
 .quad 53
 .quad node_9
node_9: 
 .quad 393
 .quad node_10
node_10: 
 .quad 393
 .quad node_11
node_11: 
 .quad 10
 .quad node_12
node_12: 
 .quad 430
 .quad node_13
node_13: 
 .quad 109
 .quad node_14
node_14: 
 .quad 283
 .quad node_15
node_15: 
 .quad 386
 .quad node_16
node_16: 
 .quad 48
 .quad node_17
node_17: 
 .quad 10
 .quad node_18
node_18: 
 .quad 328
 .quad node_19
node_19: 
 .quad 109
 .quad node_20
node_20: 
 .quad 89
 .quad node_21
node_21: 
 .quad 53
 .quad node_22
node_22: 
 .quad 241
 .quad 0
.section .text
main:

movq (src), %rax #rax<-src
movq (dst), %rbx #rbx<-dst
cmp %rax, %rbx
je end

movq (head), %r12 #r12<-head
cmp $0, %r12
je end

xor %rcx, %rcx #counter src
xor %rdx, %rdx #counter dst

#r10 <- adress of src
#r11 <- adress of dst
movq (%r12),%r13
cmp %rax, %r13
je visited_src_from_root
cmp %rbx, %r13
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
movq 8(%r14), %rcx
movq 8(%r15), %rdx
movq %rcx, 8(%r15)
movq %rdx, 8(%r14)
jmp end

visited_src:
incq %rcx
cmp $1, %rcx
je update_src_adress
jmp advance_head

update_src_adress:
lea (%r12), %r10 #src_previous
lea 8(%r12), %r14 #src
jmp advance_head

visited_dst:
incq %rdx
cmp $1, %rdx
je update_dst_adress
jmp advance_head

update_dst_adress:
lea (%r12), %r11 #dst_previous
lea 8(%r12), %r15 #dst 
jmp advance_head

visited_src_from_root:
incq %rcx
cmp $1, %rcx
je update_src_adress_from_root
jmp main_loop

update_src_adress_from_root:
movq $0, %r10  #src_previous
lea (%r12), %r14 #src
jmp main_loop

visited_dst_from_root:
incq %rdx
cmp $1, %rdx
je update_dst_adress_from_root
jmp main_loop

update_dst_adress_from_root:
movq $0, %r11 #dst_previous
lea (%r12), %r15 #dst 
jmp main_loop

end:



