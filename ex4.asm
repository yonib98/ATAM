.global main
.section .data
root:
    .quad A
A:
.quad 20
.quad B
.quad C

B:
.quad 10
.quad 0
.quad D

C:
.quad 26
.quad 0
.quad 0

D:
.quad 13
.quad 0
.quad 0

new_node: .quad 26,0,0
.section .text
main:
movq (new_node),%r10 #r10=new_node->data
movq (root),%r12 #r12 = root =A

search:
movq (%r12),%r11  #r11=A->data
cmp %r11,%r10
je end
jg turn_right
turn_left:
movq 8(%r12),%rax
cmp $0,%rax
je create_left_son
add $24,%r12
jmp search

turn_right:
movq 16(%r12),%rax
cmp $0,%rax
je create_right_son
add $48,%r12
jmp search

create_left_son:
lea new_node,%rbx
movq %rbx,8(%r12)
jmp end

create_right_son:
lea new_node,%rbx
movq %rbx,16(%r12)
jmp end

end: