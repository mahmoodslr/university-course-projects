#start=led_display.exe#


#make_bin#

name "led"

mov ax, 30
x1:
  out 199, ax
  dec ax
  push ax
  mov cx,0fh
  mov dx,4240h
  mov ah,86h
  int 15h     
  pop ax
jnz x1

hlt


