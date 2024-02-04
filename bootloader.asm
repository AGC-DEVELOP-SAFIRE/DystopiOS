section .text
    global _start

_start:
    ; Set up the stack pointer
    mov esp, stack_space

    ; Call the main kernel function
    call kernel_main

    ; Infinite loop to halt the CPU
    hlt

kernel_main:
    section .text
    global kernel_main

kernel_main:
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    ; Print message on the screen
    mov eax, 4
    mov ebx, 1
    mov ecx, message
    mov edx, message_len
    int 0x80
    hlt

section .data
    message db 'Kernel Code Running!', 0
    message_len equ $ - message
    mov eax, 4
    mov ebx, 1
    mov ecx, message
    mov edx, message_len
    int 0x80

    ; Return from kernel_main
    ret

section .data
    message db 'Hello, World!', 0
    message_len equ $ - message

section .bss
    stack_space resb 8192  ; 8 KB stack space
