org 	100h

section	.text

    mov  DX, firstMessage	
    call writeKey 

    mov BP, input      
    call readKey    

    cmp DI, 0
    jg error  

    call writeKey 
    call waitKey  

    int 20h


readKey:
        xor     SI, SI  

while:  
        call    waitKey    
        cmp     AL, 0x0D        
        je      exit           
        mov     [BP+SI], AL   	
        jmp     compare       

correct:       
        xor DX, DX
	mov 	DX, correctPassword
	jmp while

incorrect:
        xor DI,DI
        inc DI		
	jmp     while

compare:   
    mov BH, [SI + input]
    mov BL, [SI + pass]
    INC SI
    cmp BH, BL
    je correct
    jnp incorrect    
    jmp while



error:
        MOV DX, incorrectPassword           
        call writeKey 
        call waitKey   


waitKey:
        mov     AH, 01h         
        int     21h
        ret
writeKey:
	mov 	AH, 09h
	int 	21h
	ret
exit:
	mov 	byte [BP+SI], "$"	
        ret
section	.data
firstMessage		db	"Ingrese Clave: ", "$"
correctPassword		db 	"BIENVENIDO", "$"
incorrectPassword		db	"INCORRECTO", "$"
input 	times 5 db  " " 	
pass 	 db "rodas$"
