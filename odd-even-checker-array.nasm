;Sison, Ji

section .data
    arr dq  18446744073709551611, 2, 3, 10, 11 ;unsigned int can go up to 2^64
    len equ $ - arr     
    
    odd db 'ODD', 0xa
    even db 'EVEN', 0xa 
    lastd db 0 ;last digits
    
    quo db 0
    rem db 0
    
segment .bss
    count resb 1
    
section .text
    global _start

_start:

    ;len is divided by 8 to know how many elements are stored in arr1
    mov ax, len
    mov cx, 8
    div word cx
    
    add al, '0'     
    mov [count], al ;quotient stored in count for loop index
    
    mov eax, 0
    mov ecx, [count] ;number of elements in arr1 as loop index
    mov ebx, arr ;move arr address to ebx

        mov edx, [ebx]
        add edx, '0'
        mov [lastd], dl
        
        mov dx, 0
        mov ax, [lastd]
        mov cx, 2
        div word cx
        
        
    add ax, '0'     ;this is same as adding 48 to al, to display as ASCII
    add dx, '0'
    mov [quo], ax
    mov [rem], dx
        
    
    mov ecx, rem
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80
    
    
    ;prints lenr
    mov ecx, count
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80
    
    ;prints last digits in ascii
    mov ecx, lastd
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80

exit:
    mov eax, 1
    int 0x80