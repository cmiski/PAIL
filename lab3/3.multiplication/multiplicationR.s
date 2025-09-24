section .data
    resmsg db "Result: ", 0
    lenr equ $-resmsg
    newline db 0xA, 0

section .bss
    result resb 12

section .text
    global _start

_start:
    mov eax, 29
    mov ebx, 29
    imul eax, ebx

    mov edi, result + 11
    mov byte [edi], 0

.convert_loop:
    xor edx, edx
    mov ecx, 10
    div ecx
    add dl, '0'
    dec edi
    mov [edi], dl
    test eax, eax
    jnz .convert_loop

    mov eax, 4
    mov ebx, 1
    mov ecx, resmsg
    mov edx, lenr
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, result + 11
    sub edx, edi
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80

