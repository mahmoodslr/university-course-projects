    fnd equ 3FF0h 
    
input: 
    mov dx, 3FD0h
    in al, dx
    cmp al, 01111111b
    je cycle1 
    cmp al, 11111101b
    je cycle2
    cmp al, 11111011b
    je cycle3
    jmp input
    
cycle1:
    mov dx, fnd
l1: mov bl, 16    
    mov si, offset data
    add si, 15
l2: mov al, [si]
    out dx, al
    
    mov cx, 9990h
    loop $
    dec si
    dec bl
    jnz l2
    jmp input
    
cycle2:
    mov dx, fnd
l3: mov bl, 8
    mov si, offset data
    inc si    
l4: mov al, [si]
    out dx, al
    
    mov cx, 9990h
    loop $
    inc si
    inc si
    dec bl
    jnz l4
    jmp input
    
    
cycle3:    
    mov dx, fnd
l5: mov bl, 8    
    mov si, offset data
    add si, 14
l6: mov al, [si]
    out dx, al
    
    mov cx, 9990h
    loop $
    dec si
    dec si
    dec bl
    jnz l6
    jmp input
    hlt
    
data db 11000000b
     db 11111001b
     db 10100100b
     db 10110000b
     db 10011001b
     db 10010010b
     db 10000010b
     db 11011000b
     db 10000000b
     db 10010000b
     db 10001000b
     db 10000011b
     db 11000110b
     db 10100001b
     db 10000110b
     db 10001110b   
