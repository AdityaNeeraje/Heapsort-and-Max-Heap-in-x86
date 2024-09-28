extern init_v
extern pop_v
extern push_v
extern size_v
extern get_element_v
extern resize_v
extern delete_v

section .text
global init_h
global delete_h
global size_h
global insert_h
global get_max
global pop_max
global heapify
global heapsort
global heapsort_reverse

init_h:
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
        mov [rbp - 8], rdi
        call init_v
        mov rdi, [rbp - 8]
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

delete_h:
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
        mov [rbp - 8], rdi
        call delete_v
        mov rdi, [rbp - 8]
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


size_h:
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
        mov [rbp - 8], rdi
        call size_v
        mov rdi, [rbp - 8]
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


insert_h:
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
        ; First, we need to call push_v
        ; Then, we need to call size_h to get the size
        ; Then, we assign the size to i, and then we run the while loop with 3 conditions.
        sub rsp, 16
        mov [rbp - 16], rsi
        mov [rbp - 8], rdi
        call push_v
        mov rdi, [rbp - 8]
        call size_h
        mov rdx, rax
        ; size_h returns the size of the vector. sutract 1 to get the index
        sub rdx, 1
        mov rdi, [rbp - 8]
        mov rsi, [rbp - 16]
        mov rcx, rdx
        ; Now, we need to create the while loop. rdx and rax contain the size of the vector
.check_loop:
        cmp rdx, 0
        jle .break_loop
        ; compare -> rsi (present at [rbp - 16]) and element at (i-1)/2. i is present at rdx and rax
        ; TODO We need to store i at two stable places. We will divide rdx, and then convert i to rdx
        ; i is stored at rcx and rdx (rdx will be reduced)
        sub rdx, 1
        sar rdx, 1
        mov rsi, rdx
        call get_element_v
        mov rsi, [rbp - 16]
        ; TODO This is not working as intended.
        mov rax, [rax]
        cmp rsi, rax
        jle .break_loop
        ; Code here for what will be executed in the while loop
        ; We need a register to store temp, rdi, rsi, i, new_i
        ; If rdx stores temp, then rcx can be converted to i-1/2 at the end
        mov rdx, rsi
        mov rdi, [rdi + 16]
        sal rcx, 3
        add rdi, rcx
        mov [rdi], rax
        mov rdi, [rbp - 8]
        sar rcx, 3
        sub rcx, 1
        sar rcx, 1
        sal rcx, 3
        mov rdi, [rdi + 16]
        add rdi, rcx
        sar rcx, 3
        mov [rdi], rdx
        mov rdi, [rbp - 8]
        mov rdx, rcx
        jmp .check_loop 
.break_loop:
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

get_max:
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
        mov rsi, 0
        call get_element_v
        ; Let rax store value rather than address
        mov rax, [rax]
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

pop_max:
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
        mov [rbp - 8], rdi
        mov rsi, 0
        call get_element_v
        ; Let rdx store max_value
        mov rdx, [rax]
        ; Now, we need to store the address of the first element
        ; Note that [rdi] is a vector, [[rdi]] is a pointer to the element
        ; Now, rsi is the size
        mov rsi, [rdi + 8]
        ; I am storing size in rcx for later usage
        mov rcx, rsi
        sub rsi, 1
        call get_element_v
        ; Move element in arr.ptr[heap.size - 1] to rax
        mov rax, [rax]
        ; rdi is an address of a heap. [rdi] is a vector
        mov rdi, [rbp - 8]
        mov rdi, [rdi + 16]
        mov [rdi], rax
        mov rdi, [rbp - 8]
        mov rsi, [rdi + 8]
        sub rsi, 1
        mov [rdi + 8], rsi
        ; Let rcx store the value of i and rax store the size
        mov rcx, 0
.check_loop:
        ; rax has size (ensured at start of loop), rdx has max_value, rcx has i (ensured at end of loop)
        mov rdi, [rbp - 8]
        mov rax, [rdi + 8]
        sal rcx, 1
        add rcx, 1
        cmp rax, rcx
        jle .break_loop
        ; reset rcx to i, but store j in r8
        mov r8, rcx
        sar rcx, 1
        add r8, 1
        ; compare j+1 and given_heap->arr.size
        cmp rax, r8
        sub r8, 1
        jle .dont_increment
        ; Store size in r9
        mov r9, rax
        mov rsi, r8
        call get_element_v
        ; rcx currently has given_heap->arr.ptr[j]
        mov r10, [rax]
        mov rsi, r8
        add rsi, 1
        call get_element_v
        mov rax, [rax]
        ; rax has ptr[j+1], rcx has ptr[j]
        ; rax is 15, rcx is 5
        mov rcx, r8
        sar rcx, 1
        cmp rax, r10
        jle .dont_increment
        add r8, 1
.dont_increment:
        ; Notes at this point: rcx stores i, r8 stores j, rdi stores ptr to heap, rdx stores max_value
        mov rsi, r8
        mov rdi, [rbp - 8]
        call get_element_v
        ; r9 will store i from now on, rcx stores arr.ptr[j]
        mov r9, rcx
        mov rcx, [rax]
        mov rsi, r9
        mov rdi, [rbp - 8]
        call get_element_v
        ; rax has arr.ptr[i] and rcx has arr.ptr[j]
        mov rax, [rax]
        cmp rcx, rax
        jle .break_loop
        ; rax stores given_heap->arr.ptr[i]
        ; rcx stores given_heap->arr.ptr[j]
        mov rdi, [rbp - 8]
        mov rdi, [rdi + 16]
        sal r9, 3
        add rdi, r9
        sar r9, 3
        mov [rdi], rcx
        mov rdi, [rbp - 8]
        mov rdi, [rdi + 16]
        sal r8, 3
        add rdi, r8
        sar r8, 3
        mov [rdi], rax
        mov rcx, r8
        ; sal 
        ; mov rcx, r8
        ; mov rsi, rcx
        ; call get_element_v
        ; mov rdi, [rbp - 8]
        jmp .check_loop
.break_loop:
        ; Set the max to the return register 
        mov rax, rdx  
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

heapify:
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
        mov [rbp - 8], rdi
        mov rdx, [rdi + 8]
        sar rdx, 1
        add rdx, 1
.check_loop:
        cmp rdx, 0
        jle .break_loop
        ; Let rcx be j
        mov rcx, rdx
        sub rcx, 1
.while_loop_check:
        mov r8, rcx
        sal r8, 1
        add r8, 1
        cmp r8, [rdi + 8]
        jge .exit_while_loop
        ; r8 contains the value of k
        mov rsi, r8
        add rsi, 1
        cmp r8, [rdi + 8]
        jge .dont_increment
        sub rsi, 1
        mov rdi, [rbp - 8]
        call get_element_v
        ; r9 stores the value at arr.ptr[k]
        mov r9, [rax]
        add r8, 1
        mov rsi, r8
        sub r8, 1
        mov rdi, [rbp - 8]
        call get_element_v
        ; rax stores the value at arr.ptr[k+1]
        mov rax, [rax]
        cmp rax, r9
        jle .dont_increment
        add r8, 1
.dont_increment:
        mov rsi, r8
        mov rdi, [rbp - 8]
        call get_element_v
        mov r9, [rax]
        mov rsi, rcx
        mov rdi, [rbp - 8]
        call get_element_v
        ; rax stores the value at arr.ptr[j]
        mov rax, [rax]
        cmp rax, r9
        jge .exit_while_loop
        ; Note: rax still has the value of arr.ptr[j]
        mov rdi, [rdi + 16]
        sal rcx, 3
        add rdi, rcx
        sar rcx, 3
        mov [rdi], r9
        mov rdi, [rbp - 8]
        mov rdi, [rdi + 16]
        sal r8, 3
        add rdi, r8
        sar r8, 3
        mov [rdi], rax
        mov rdi, [rbp - 8]
        mov rcx, r8
        ; Here we check for the while loop
        jmp .while_loop_check
        ; Below is the end of the loop. Decrement rsi and compare
.exit_while_loop:
        sub rdx, 1
        jmp .check_loop
.break_loop:
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

heapsort_reverse:
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
        mov [rbp - 8], rdi
        ; rdx increments from 0 to size - 1
        mov rdx, 0
.check_loop:
        ; assert rdi has the vector pointer, rdx has the value of i
        add rdx, 1
        mov rdi, [rbp - 8]
        cmp rdx, [rdi + 8]
        jge .break_loop
        sub rdx, 1
        ; Let rcx store the value of right_size
        mov rdi, [rbp - 8]
        mov rcx, [rdi + 8]
        sub rcx, rdx
        ; Let r8 store the value of x
        mov r8, rcx
        sar r8, 1
        add r8, 1
        add r8, rdx
        ; r12 also stores the value of x
        mov r12, r8
.check_for_loop:
        cmp r12, rdx
        jle .break_for_loop
        mov r8, r12
        sub r8, 1
        sub r8, rdx
        ; Henceforth, r8 stores the value of j, r9 stores k
.start_while_loop:
        mov r9, r8
        sal r9, 1
        add r9, 1
        cmp r9, rcx
        jge .exit_while_loop
        ; r11 stores k + 1
        mov r11, r9
        add r11, 1
        cmp r11, rcx
        jge .dont_increment
        ; Make rsi k + i temporarily. This will be brought back to k
        mov rsi, r9
        add rsi, rdx
        mov rdi, [rbp - 8]
        call get_element_v
        mov r11, [rax]
        mov rsi, r9
        add rsi, rdx
        add rsi, 1
        mov rdi, [rbp - 8]
        call get_element_v
        mov rax, [rax]
        ; Now, rax has arr->ptr[k+1+i] and r11 has arr->ptr[k+i]
        cmp rax, r11
        jle .dont_increment
        add r9, 1
.dont_increment:
        ; Set k = k + i, j = j + i
        add r9, rdx
        add r8, rdx
        mov rsi, r9
        mov rdi, [rbp - 8]
        call get_element_v
        mov r11, [rax]
        mov rsi, r8
        mov rdi, [rbp - 8]
        call get_element_v
        mov rax, [rax]
        ; rax has arr->ptr[j+i] and r11 has arr->ptr[k+i]
        cmp rax, r11
        jge .exit_while_loop
        mov rdi, [rbp - 8]
        mov rdi, [rdi + 16]
        sal r8, 3
        add rdi, r8
        sar r8, 3
        mov [rdi], r11
        mov rdi, [rbp - 8]
        mov rdi, [rdi + 16]
        sal r9, 3
        add rdi, r9
        sar r9, 3
        mov [rdi], rax
        mov r8, r9
        jmp .start_while_loop
.exit_while_loop:
        ; We have to reduce x. Note that r8 stores x at the for loop check
        sub r12, 1
        jmp .check_for_loop
.break_for_loop:
        add rdx, 1
        jmp .check_loop
.break_loop:
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

heapsort:
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
        mov [rbp - 8], rdi
        call heapify
        mov rdi, [rbp - 8]
        ; rdx decrements from size - 1 to 1
        mov rdx, [rdi + 8]
        sub rdx, 1
.check_loop:
        cmp rdx, 0
        jle .break_loop
        mov rsi, rdx
        mov rdi, [rbp - 8]
        call get_element_v
        mov rax, [rax]
        mov rdi, [rbp - 8]
        mov rdi, [rdi + 16]
        mov rsi, [rdi]
        mov [rdi], rax
        sal rdx, 3
        add rdi, rdx
        sar rdx, 3
        mov [rdi], rsi
        mov rdi, [rbp - 8]
        ; Let r8 store j
        mov r8, 0
.check_while_loop:
        ; assert that r8 stores j and rdx stores i
        mov r9, r8
        sal r9, 1
        add r9, 1
        cmp r9, rdx
        jge .exit_while_loop
        ; assert that r9 stores k
        mov r10, r9
        add r10, 1
        cmp r10, rdx
        jge .dont_increment
        mov rsi, r10
        mov rdi, [rbp - 8]
        call get_element_v
        ; r10 stores the value of arr.ptr[k+1]
        mov r10, [rax]
        mov rsi, r9
        mov rdi, [rbp - 8]
        call get_element_v
        mov rax, [rax]
        ; rax stores the value of arr.ptr[k]
        cmp rax, r10
        jge .dont_increment
        add r9, 1
.dont_increment:
        ; assert that r9 stores k
        mov rsi, r9
        mov rdi, [rbp - 8]
        call get_element_v
        ; r10 stores the value of arr.ptr[k]
        mov r10, [rax]
        mov rsi, r8
        mov rdi, [rbp - 8]
        call get_element_v
        ; rax stores value of arr.ptr[j]
        mov rax, [rax]
        cmp rax, r10
        jge .exit_while_loop
        mov rdi, [rbp - 8]
        mov rdi, [rdi + 16]
        sal r8, 3
        add rdi, r8
        sar r8, 3
        mov [rdi], r10
        mov rdi, [rbp - 8]
        mov rdi, [rdi + 16]
        sal r9, 3
        add rdi, r9
        sar r9, 3
        mov [rdi], rax
        mov rdi, [rbp - 8]
        mov r8, r9
        jmp .check_while_loop
.exit_while_loop:
        sub rdx, 1
        jmp .check_loop
.break_loop:
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
