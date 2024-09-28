extern realloc
extern malloc
extern free

section .text
global init_v
global delete_v
global resize_v
global get_element_v
global push_v
global pop_v
global size_v

init_v:
        push rbp
        mov rbp, rsp
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        ; First, we need the buff->size to be 0
        ; we need size to be 0
        ; we need pointer to be 0
        mov QWORD [rdi], 0
        mov QWORD [rdi+8], 0
        mov QWORD [rdi+16], 0
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

delete_v:
        push rbp
        mov rbp, rsp
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        sub rsp, 8
        ; I am passing rdi to rbp - 8 so that I can take it up later
        mov [rbp-8], rdi
        ; Now, I am moving the ptr to rdi
        mov rdi, [rdi + 16]
        ; I am freeing the pointer
        call free
        ; I am now moving back the original rbp - 8 to rdi
        mov rdi, [rbp - 8]
        mov QWORD [rdi], 0
        mov QWORD [rdi + 8], 0
        mov QWORD [rdi + 16], 0
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

resize_v:
        push rbp
        mov rbp, rsp
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        ; Compare the pointer with NULL
        sub rsp, 16
        mov QWORD [rbp - 16], rsi
        cmp QWORD [rdi + 16], 0
        ; If not equal to NULLPTR, then jump to .not_equal
        jne .not_equal
        ; Else, move the rdi to rbp for safekeeping
        mov QWORD [rbp - 8], rdi
        mov rdi, rsi
        sal rdi, 3
        call malloc
        mov rdi, [rbp - 8]
        mov [rdi + 16], rax
        jmp .skip_not_equal
.not_equal:
        mov [rbp - 8], rdi
        sal rsi, 3
        mov rdi, [rdi + 16]
        call realloc
        mov rdi, [rbp - 8]
        mov [rdi + 16], rax
.skip_not_equal:    
        mov rax, [rbp - 16]
        ; I am moving the size to the buff->size
        mov QWORD [rdi], rax
        ; For completeness sake, I think this is required to send exit code zero
        mov rax, 0
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

get_element_v:
        push rbp
        mov rbp, rsp
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        ; [rdi + 16] is the address referenced by the memory pointer
        ; [rdi + 16] + rsi * 8 is the address of the element
        sal rsi, 3
        mov rax, [rdi + 16]
        add rax, rsi
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

push_v:
        push rbp
        mov rbp, rsp
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        sub rsp, 16
        mov [rbp - 8], rdi
        mov [rbp - 16], rsi
        mov rax, [rdi]
        cmp rax, [rdi + 8]
        ; Remember to check the conditions for jumping next time :).
        ; I wasted a lot of time resolving segfaults because I wrote jmp instead of jne
        jne .not_full
        ; Find the buffer size make it 2 x + 1
        mov rax, [rdi]
        add rax, rax
        lea rdx, [rax+1]
        mov rsi, rdx
        mov rdi, [rbp - 8]
        call resize_v
        mov rdi, [rbp - 8]
        mov rsi, [rbp - 16]
.not_full:
        mov rdi, [rbp - 8]
        mov rsi, [rbp - 16]
        ; Move the size to rax
        mov rax, [rdi + 8]
        sal rax, 3
        ; Increment address pointed to by rsi * 8
        mov rdi, [rdi + 16]
        add rdi, rax
        ; Set the value in rdi to rsi
        mov [rdi], rsi
        ; Move the address with size to rax
        mov rdi, [rbp - 8]
        mov rax, [rdi + 8]
        ; Adds 16 to rax
        add rax, 1
        mov [rdi + 8], rax
        mov rax, 0
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

pop_v:
        push rbp
        mov rbp, rsp
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        mov rdx, [rdi + 8]
        sub rdx, 1
        mov [rdi + 8], rdx
        mov rax, [rdi + 16]
        sal rdx, 3
        mov rax, [rax + rdx]
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

size_v:
        push rbp
        mov rbp, rsp
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        mov rax, [rdi + 8]
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret
