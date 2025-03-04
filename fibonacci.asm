section .data
    result db "First 100 Fibonacci numbers:", 10, 0
    lenght equ  $ - result
    newline db 10, 0
    space db " ", 0

section .bss
    a resq 1
    b resq 1
    counter resq 1
    buffer resb 21

section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    lea rsi, [result]
    mov rdx, lenght
    syscall

    mov qword [a], 0
    mov qword [b], 1
    mov qword [counter], 100

generate_fibonacci:
    mov rax, [a]
    call print_number

    mov rax, 1
    mov rdi, 1
    lea rsi, [space]
    mov rdx, 1
    syscall

    mov rax, [a]
    mov rbx, [b]
    add rax, rbx
    mov [a], rbx
    mov [b], rax

    dec qword [counter]
    jnz generate_fibonacci

    mov rax, 1
    mov rdi, 1
    lea rsi, [newline]
    mov rdx, 1
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

print_number:
    lea rsi, [buffer + 20]
    mov byte [rsi], 0
    mov rbx, 10
convert_loop:
    dec rsi
    xor rdx, rdx
    div rbx
    add dl, '0'
    mov [rsi], dl
    test rax, rax
    jnz convert_loop

    mov rax, 1
    mov rdi, 1
    mov rdx, buffer + 21
    sub rdx, rsi
    syscall
    ret
