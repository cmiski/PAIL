section .text
global _start

_start:

    mov eax, x      ; pointer to numbers
    mov ebx, 0      ; EBX will store the sum
    mov ecx, 5      ; number of elements

top: 
    add bl, [eax]   ; add current element to sum
    inc eax         ; move pointer to next element
    loop top        ; repeat until ECX = 0

done:
    add bl, '0'     ; convert to ASCII
    mov [sum], bl   ; store result in "sum"

display:
    mov edx, 1      ; message length
    mov ecx, sum    ; message to write
    mov ebx, 1      ; file descriptor (stdout)
    mov eax, 4      ; system call number (sys_write)
    int 0x80        ; call kernel

    mov eax, 1      ; system call number (sys_exit)
    int 0x80        ; call kernel

section .data
x: 
    times 5 db 0    ; reserve 5 numbers (user can modify later)

sum:
    db 0, 0xa       ; result + newline

