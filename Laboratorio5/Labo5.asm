org 100h

    section .text
    xor AX, AX
    xor SI, SI
    xor BX, BX
    XOR CX, CX
    xor DX, DX

    MOV SI, 0
    MOV DI, 0
    MOV DH, 10 ;Fila en la que se mostrará el cursor.
    MOV DL, 20 ;Columna en la que se mostrará el cursor.
    
    call modotexto

    iterarcadena:
        call movercursor
        call comparing
        MOV CL, [string+SI] ;Colocar en CL el caracter actual de la cadena.
        call escribircaracter
        INC SI ; Se suma 1 a SI para continuar con el siguiente caracter.
        INC DL ; Se suma 1 a DL para mover el cursor a la siguiente columna.
        INC DI ; Contador para terminar la ejecución del programa al llegar a 30
        CMP DI, 30d ;Comparación de DI con 30d (Largo de la cadena de mi nombre)
        JB iterarcadena ; si DI es menor a 30 sigue iterando.
        jmp esperartecla

    cambiarLinea:
        add DH, 2 
        INC SI 
        MOV DL, 20
        INC DI 
        jmp iterarcadena

    comparing:
        CMP DI, 4d ;Comparación de DI con 4d (Largo de la cadena de mi  1 nombre)
        JE cambiarLinea
        CMP DI, 14d ;Comparación de DI con 14d (Largo de la cadena de mi 1 nombre + 2 nombre)
        JE cambiarLinea
        CMP DI, 24d ;Comparación de DI con 4d (Largo de la cadena de mi 1 nombre + 2 nombre +1 apellido)
        JE cambiarLinea
        INT 10h
        RET    

    modotexto: 
        MOV AH, 0h ;Activa modo texto.
        MOV AL, 03h ;Modo gráfico deseado.
        INT 10h
        RET

    movercursor:
        MOV AH, 02h  ;Posiciona el cursor en pantalla.
        MOV BH, 0h
        INT 10h
        RET

    escribircaracter:
        MOV AH, 0Ah ;Escribe el caracter en pantalla según la posición del cursor.
        MOV AL, CL ; Se indica el caracter a escribir en pantalla según el código hexadecimal de la tabla ASCII.
        MOV BH, 0h
        MOV CX, 1h ; Indicamos el número de veces a escribir el caracter.
        INT 10h
        RET

    esperartecla:
    ;Se espera que el usuario presione una tecla.
        MOV AH, 00h
        INT 16h

    exit:
        int 20h

section .data

string DB "Rene Francisco Henriquez Rodas" 