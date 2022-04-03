.global _start
 
.section .text
_start:
mov $-1,%eax
xor %rbx,%rbx #ia=0
xor %rdx,%rdx #ib=0
xor %rcx,%rcx
lea array1, %r12
lea array2, %r13
lea mergedArray, %r14
merge_loop:
movl (%r12,%rbx,4), %r10d
movl (%r13,%rdx,4),%r11d
cmp $0,%r10d
je leftovers_array2
cmp $0,%r11d
je leftovers_array1

cmp %r10d,%r11d
ja choose_array2

choose_array1:
cmp %r10d,%eax
je array1_next_element
movl %r10d,(%r14,%rcx,4)
inc %rcx
movl %r10d,%eax
array1_next_element:
inc %rbx
jmp merge_loop

choose_array2:
cmp %r11d,%eax
je array2_next_element
movl %r11d,(%r14,%rcx,4)
inc %rcx
movl %r11d,%eax

array2_next_element:
inc %rdx
jmp merge_loop


leftovers_array1:
cmp $0,%r10d
je end
cmp %eax,%r10d
je  next_element1
movl %r10d, (%r14,%rcx,4)
inc %rcx
next_element1:
inc %rbx
movl %r10d, %eax
movl (%r12,%rbx,4), %r10d
jmp leftovers_array1

leftovers_array2:

cmp $0,%r11d
je end
cmp %eax,%r11d
je  next_element2
movl %r11d, (%r14,%rcx,4)
inc %rcx
next_element2:
inc %rdx
movl %r11d, %eax
movl (%r13,%rdx,4), %r11d
jmp leftovers_array2

end:
movl  $0,(%r14,%rcx,4)
