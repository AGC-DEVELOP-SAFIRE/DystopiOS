BITS 16           ; Set the mode to 16-bit

section .text
    global _start

_start:
    ; Set video mode
    mov ah, 00h    ; Function to set video mode
    mov al, 03h    ; Video mode 80x25 color text
    int 10h        ; BIOS interrupt for video services

    mov si, hello_msg
    call print_string

    ; Halt the system
    cli            ; Disable interrupts
    hlt            ; Halt the CPU

print_string:
    lodsb          ; Load the next byte from SI into AL
    test al, al    ; Check if AL is zero (end of string)
    jz .done       ; If zero, we're done
    mov ah, 0x0E   ; Function to print character
    mov bh, 0x00   ; Page number
    mov bl, 0x07   ; Text attribute (white on black)
    int 10h        ; BIOS interrupt for video services
    jmp print_string   ; Continue printing

.done:
    ret

hello_msg db "Disk startup successful", 0   ; Null-terminated string
