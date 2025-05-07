MainLoop:
    mov dx,3FD0h
    in al,dx
    cmp al,11111101b
    je LED1
    cmp al,11110111b
    je LED2
    cmp al,11011111b
    je LED3
    jmp Flashing
    
LED1:
    mov bh,11111111b
    jmp Flashing
    
LED2:
    mov bh,00000101b
    jmp Flashing
    
LED3:
    mov bh,11110000b
    jmp Flashing
    
Flashing:
    mov al,bh
    mov dx,3FD2h
    out dx,al
    mov cx,1fffh
    L1:loop L1
    mov al,00000000b
    out dx,al
    mov cx,1fffh
    L2:loop L2
    jmp MainLoop
hlt     