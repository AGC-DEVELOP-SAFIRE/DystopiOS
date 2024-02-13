BITS 16           ; Set the mode to 16-bit
ORG 0x7C00        ; Set the origin address to where the bootloader will be loaded

section .text
    start:
        ; Clear all segment registers
        xor ax, ax
        mov ds, ax
        mov es, ax
        mov ss, ax
        mov sp, 0x7C00   ; Set stack pointer

        ; Load the kernel into memory
        mov bx, kernel_start
        mov ah, 02h      ; Function to read sectors
        mov al, 01h      ; Number of sectors to read
        mov ch, 00h      ; Cylinder
        mov cl, 02h      ; Sector
        mov dh, 00h      ; Head
        int 13h          ; BIOS interrupt for disk I/O

        ; Jump to the kernel
        jmp 0x0000:0x1000   ; Jump to the start of the kernel

    times 510 - ($-$$) db 0   ; Pad the bootloader to 510 bytes
    dw 0xAA55                  ; Boot signature

kernel_start:
