org 100h

    section .text
    xor AX, AX
    xor SI, SI
    xor BX, BX
    XOR CX, CX
    xor DX, DX

    MOV SI, 0
    MOV DI, 0

    MOV DH, 10 ;fila en la que se mostrará el cursor
    MOV DL, 25 ;columna en la que se mostrará el cursor
    MOV byte[200h], 12; salto entre filas
    MOV byte[201h], 14; salto entre filas
    MOV byte[202h], 16;
    
    call modotexto

    firstName:
        call movercursor
        MOV CL, [cadenaNombre+SI]
        call escribircaracter
        XOR CL, CL
        INC SI ;Se suma 1 a SI para continuar con el siguiente caracter
        INC DL ;Se suma 1 a DI para mover cursor a la siguiente columna
        INC DI
        CMP DI, 9
        JB firstName ; si DI es menor a 9, entonces siga iterando
        call salto
        jmp secondName ; de caso contrario, que salte a esperar tecla 

    secondName:
        MOV DH, [200h]
        call movercursor ;llamada a mover cursor
        MOV CL, [cadenaNombre+SI] ;Colocar en CL el caracter actual de la cadena
        call escribircaracter; Llamada a escribircaracter
        XOR CL, CL
        INC SI ; SE SUMA 1 A SI PARA CONTINUAR CON EL SIGUIENTE CARACTER
        INC DL ; SE SUMA 1 A DL PARA MOVER CURSOR A LA SIGUIENTE COLUMNA
        INC DI 
        CMP DI, 8 
        JB secondName; si DI es menor a 8, entonces que siga iterando.
        call salto
        jmp lastName1 ; de caso contrario, que salte a esperar tecla 
    
    lastName1:
        MOV DH, [201h]
        call movercursor ;llamada a mover cursor
        MOV CL, [cadenaNombre+SI] ;Colocar en CL el caracter actual de la cadena
        call escribircaracter; Llamada a escribircaracter
        XOR CL, CL
        INC SI ; SE SUMA 1 A SI PARA CONTINUAR CON EL SIGUIENTE CARACTER
        INC DL ; SE SUMA 1 A DL PARA MOVER CURSOR A LA SIGUIENTE COLUMNA
        INC DI 
        CMP DI, 9 
        JB lastName1; si DI es menor a 9, entonces que siga iterando.
        call salto
        jmp lastName2 ; de caso contrario, que salte a esperar tecla 
    
    lastName2:
        MOV DH, [202h]
        call movercursor ;llamada a mover cursor
        MOV CL, [cadenaNombre+SI] ;Colocar en CL el caracter actual de la cadena
        call escribircaracter; Llamada a escribircaracter
        XOR CL, CL
        INC SI ; SE SUMA 1 A SI PARA CONTINUAR CON EL SIGUIENTE CARACTER
        INC DL ; SE SUMA 1 A DL PARA MOVER CURSOR A LA SIGUIENTE COLUMNA
        INC DI 
        CMP DI, 8 
        JB lastName2; si DI es menor a 8, entonces que siga iterando.
        call salto
        jmp esperartecla ; de caso contrario, que salte a esperar tecla 
    

    modotexto: 
        MOV AH, 0h ; activa modo texto
        MOV AL, 03h ; modo gráfico deseado(80 columnas, 25 filas)
        INT 10h
        RET

    salto: ;salto de columna
        MOV DI, 0
        MOV DL, 25
        RET

    movercursor:
        MOV AH, 02h ; posiciona el cursor en pantalla.
        ;MOV DH, 10 ;fila en la que se mostrará el cursor
        ;MOV DL, 20 ;columna en la que se mostrará el cursor
        MOV BH, 0h ; número de página
        INT 10h
        RET

    escribircaracter: ;utilizando interrupcion DOS
        MOV AH, 0Ah ; escribe cadena en pantalla según posición del cursor
        MOV AL, CL ; Caracter que aparecer'a en la pantalla, los valores deben de ser según el código ASCII
        MOV BH, 0h ; número de la página
        MOV CX, 1h ; cantidad de veces a escribir el caracter
        INT 10h
        RET

    esperartecla:
        MOV AH, 00h ; espera buffer del teclado para avanzar en la siguiente instrucción
        INT 16h
        ;ret
    exit:
        int 20h

section .data

cadenaNombre DB 'Gabriela Cecilia Salguero Moreno'