;this is makes the code simpler when performing operations on large int that only requires the last digits of that int
;e.g. a program that checks whether an int in an array is odd or even, or checks if an int is divisible by 4,5, or 10

section .data
    msg dq  18446744073709551610, 2, 3 ;unsigned int can go up to 2^64
    len equ $ - msg     
    ;checks the length of msg, outputs multiples of 8
    ;size of msg is quadword, 8 bytes
    
segment .bss
    lenr resb 1
    
section .text
    global _start

_start:

    ;len is divided by 8 to know how many elements are stored in msg
    mov     ax, len
    mov     cx, 8
    div     word cx
    
    add     al, '0'     ;quotient is stored in al register, added '0' to display in ASCII
    mov     [lenr], al ;store quotient in lenr for printing
    
    
    mov     eax, [msg]  ;first element of array stored in eax
    add     eax, '0'    ;added '0' to display in ASCII
    mov     [msg], al   ;only access the low register of eax 
    
    ;prints lenr
    mov     ecx, lenr
    mov     edx, 1
    mov     ebx, 1
    mov     eax, 4
    int     0x80
    
    ;prints msg
    mov     ecx, msg
    mov     edx, 1
    mov     ebx, 1
    mov     eax, 4
    int     0x80

exit:
    mov     eax, 1
    int     0x80