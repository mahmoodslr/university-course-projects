mov sp,4000H
    
MainLoop:
    call CheckKeys
    mov ax,0
    mov dx,3fcaH 
    out dx, al
    mov cx,20H
    loop $
    in al,dx
    mov bl,al
    mov dh,4
    int 10H
    mov cx,0
    loop $
    mov dx,offset back
    mov ah,9
    int 21H
    cmp bl,67H
    ja FlashLeds
    jmp MainLoop
    
  
FlashLeds:
    mov dx,3fd2H
    mov al,11110000B
    out dx,al 
    mov cx,1fffh
    L1:loop L1
    mov al,00000000b
    out dx,al
    call CheckKeys  
    jmp MainLoop


CheckKeys:
    mov dx,3fd0H
    in al,dx
    cmp al,11111100b
    je Stop    
    ret
    
    
Stop:
    hlt
    
    
back  db  8,8,8,8,'$'  