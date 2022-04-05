.global _start

.section .text
_start:
movq (new_node),%r10 #r10=new_node->data
movq (root),%r12 #r12 = root =A
cmp $0, %r12
je create_root

search:
movq (%r12),%r11  #r11=A->data
cmp %r11,%r10
je end
ja turn_right

turn_left:
movq 8(%r12),%rax #rax<-left son pointer
cmp $0,%rax #rax=NULL?
je create_left_son
movq %rax,%r12
jmp search

turn_right:
movq 16(%r12),%rax #rax<- right son pointer
cmp $0,%rax
je create_right_son
movq %rax,%r12
jmp search

create_left_son:
lea new_node,%rbx
movq %rbx,8(%r12)
jmp end

create_right_son:
lea new_node,%rbx
movq %rbx,16(%r12)
jmp end

create_root:
lea new_node,%rbx
movq %rbx,(root)

end:
