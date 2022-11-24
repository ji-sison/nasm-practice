section .data
    newline db 0xa

    val1 dw 12
    val2 db 3

    quo db 0
    rem db 0

section .text
    global _start

_start:

    mov ax, [val1]
    div byte [val2]

    add al, '0'     ;this is same as adding 48 to al, to display as ASCII
    add ah, '0'
    mov [quo], al
    mov [rem], ah

    mov edx, 1      ;message length
    mov ecx, quo    ;message to write
    mov ebx, 1      ;file descriptor (std_out)
    mov eax, 4      ;system call number (sys_write)
    int 0x80        ;call kernel

    mov edx, 1         ;message length
    mov ecx, newline   ;message to write
    mov ebx, 1         ;file descriptor (std_out)
    mov eax, 4         ;system call number (sys_write)
    int 0x80           ;call kernel

    mov edx, 1      ;message length
    mov ecx, rem    ;message to write
    mov ebx, 1      ;file descriptor (std_out)
    mov eax, 4      ;system call number (sys_write)
    int 0x80        ;call kernel

exit:
    mov eax, 1      ;system call number (sys_exit)
    int 0x80        ;call kernel


    

