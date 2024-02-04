section .text
    global _start

_start:
    ; Your bootloader will load the kernel at 0x1000, adjust as needed
    mov     rsp, 0x10000
    mov     rdi, msg
    call    print_message

    ; Infinite loop
    hlt

print_message:
    ; System call to write to standard output
    mov     rax, 1
    mov     rsi, rdi
    mov     rdx, msg_len
    mov     rdi, 1  ; File descriptor: STDOUT
    syscall
    ret

section .data
    msg db 'Disk startup successful', 0
    msg_len equ $ - msg
