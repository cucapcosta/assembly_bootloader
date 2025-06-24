bits 16
org 0x7C00

mov  bx, 0       
mov  si, 0
        
read:
mov  ah, 00h
int  16h            
mov  [buffer + bx], al
cmp  al, 0Dh
jz   check
mov ah, 0eh
int 10h
inc  bl
jmp  read
check:
mov  al, [buffer  + si]
cmp  al, [command + si]
jne  failed
cmp  al, 0Dh
jz   hw
inc  si
jmp  check
hw:     
mov  si, hello
jmp  print

failed: 
mov  si, notfound
print:
lodsb               
cmp al, 0x00
jz   done
mov  ah, 0Eh
int  10h
jmp  print

done:   
cli
hlt
jmp done

buffer    db 11 dup(0)         
command   db 'hello', 0Dh
hello     db 0xd,0xa,'N tanko isso mais nao', 0x00
notfound  db 0xd,0xa,'Command not found', 0x00       

times 510-($-$$) db 0
dw    0xAA55
