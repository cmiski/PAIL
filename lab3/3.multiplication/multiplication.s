section .data
    msg1 db "Enter first number: ", 0
    len1 equ $-msg1
    msg2 db "Enter second number: ", 0
    len2 equ $-msg2
    resmsg db "Result: ", 0
    lenr equ $-resmsg
    newline db 0xA, 0

section .bss
    num1 resb 12
    num2 resb 12
    result resb 24

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 12
    int 0x80

    mov esi, num1
    xor eax, eax
.convert1:
    mov bl, [esi]
    cmp bl, 0xA
    je .done1
    cmp bl, 0
    je .done1
    sub bl, '0'
    imul eax, eax, 10
    add eax, ebx
    inc esi
    jmp .convert1
.done1:
    mov ebx, eax

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 12
    int 0x80

    mov esi, num2
    xor eax, eax
.convert2:
    mov bl, [esi]
    cmp bl, 0xA
    je .done2
    cmp bl, 0
    je .done2
    sub bl, '0'
    imul eax, eax, 10
    add eax, ebx
    inc esi
    jmp .convert2
.done2:
    mov ecx, eax

    mov eax, ebx
    imul eax, ecx

    mov edi, result + 23
    mov byte [edi], 0

.convert_loop:
    xor edx, edx
    mov ebx, 10
    div ebx
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
    mov edx, result + 23
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

