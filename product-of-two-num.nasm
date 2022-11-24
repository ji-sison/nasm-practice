section .data

    str1 db 'No carry', 0xa
    len1 equ $ - str1

    str2 db 'carry', 0xa
    len2 equ $ - str2

    val1 dw 3h
    val2 dw 2h

    result dd 0

section .text
    global _start

_start:

    mov ax, [val1]
    mul word [val2]

    jc else_block
        add ax, 48
        mov [result], eax

        mov edx, len1   ;message length
        mov ecx, str1   ;message to write
        mov ebx, 1      ;file descriptor (std_out)
        mov eax, 4      ;system call number (sys_write)
        int 0x80        ;call kernel
        jmp endif

else_block:
        add ax, 48
        mov [result], eax

        mov edx, len2   ;message length
        mov ecx, str2   ;message to write
        mov ebx, 1      ;file descriptor (std_out)
        mov eax, 4      ;system call number (sys_write)
        int 0x80        ;call kernel
        jmp endif

endif:

mov ecx, result
mov edx, 1  ;message length
mov ebx, 1  ;message to write
mov eax, 4  ;file descriptor (std_out)
int 0x80    ;call kernel

exit:
        mov eax, 1      ;
        int 0x80
        