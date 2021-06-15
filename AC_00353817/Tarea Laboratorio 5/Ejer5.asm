;Codigo base usado en la prática del laboratorio
org 100h

    section .text
    MOV SI, 0
    MOV DI, 0

    MOV DL, 21 ;columna en la que se mostrará el cursor

    MOV byte[200h], 10
    MOV byte[201h], 12
    MOV byte[202h], 14
    MOV byte[203h], 16

    call modotexto

    nombre1:
        MOV DH, [200h]
        call movercursor ;llamada a mover cursor 
        MOV CL, [cadena+SI] ;Colocar en CL el caracter actual de la cadena
        call escribircaracter ; Llamada a escribircaracter
        XOR CL, CL 
        INC DL ; SE SUMA 1 A SI PARA CONTINUAR CON EL SIGUIENTE CARACTER
        INC SI ; SE SUMA 1 A DL PARA MOVER CURSOR A LA SIGUIENTE COLUMNA
        CMP SI, 9 ; Comparación de DI con 10
        JB nombre1 ; si DI es menor a 10, entonces que siga iterando.
        call salto 
        jmp nombre2 ; de caso contrario, que salte a esperar tecla.

    nombre2:
        MOV DH, [201h]
        call movercursor ;llamada a mover cursor 
        MOV CL, [cadena+SI] ;Colocar en CL el caracter actual de la cadena
        call escribircaracter ; Llamada a escribircaracter
        INC DL ; SE SUMA 1 A SI PARA CONTINUAR CON EL SIGUIENTE CARACTER
        INC SI ; SE SUMA 1 A DL PARA MOVER CURSOR A LA SIGUIENTE COLUMNA
        CMP SI, 17 ; Comparación de DI con 11
        JB nombre2 ; si DI es menor a 11, entonces que siga iterando.
        call salto
        jmp apellido1 ; de caso contrario, que salte a esperar tecla.

    apellido1:
        MOV DH, [202h]
        call movercursor ;llamada a mover cursor 
        MOV CL, [cadena+SI] ;Colocar en CL el caracter actual de la cadena
        call escribircaracter ; Llamada a escribircaracter
        INC DL ; SE SUMA 1 A SI PARA CONTINUAR CON EL SIGUIENTE CARACTER
        INC SI ; SE SUMA 1 A DL PARA MOVER CURSOR A LA SIGUIENTE COLUMNA
        CMP SI, 26 ; Comparación de DI con 12
        JB apellido1 ; si DI es menor a 12, entonces que siga iterando.
        call salto
        jmp apellido2 ; de caso contrario, que salte a esperar tecla.

    apellido2:
        MOV DH, [203h]
        call movercursor ;llamada a mover cursor 
        MOV CL, [cadena+SI] ;Colocar en CL el caracter actual de la cadena
        call escribircaracter ; Llamada a escribircaracter
        INC DL ; SE SUMA 1 A SI PARA CONTINUAR CON EL SIGUIENTE CARACTER
        INC SI ; SE SUMA 1 A DL PARA MOVER CURSOR A LA SIGUIENTE COLUMNA
        CMP SI, 33 ; Comparación de DI con 13
        JB apellido2 ; si DI es menor a 13, entonces que siga iterando.
        call salto
        jmp esperartecla ; de caso contrario, que salte a esperar tecla.

    modotexto: 
        ;Similar a usar una función en alto nivel
        ;Modotexto(parametro1)
        ;Donde: parametro1= AL (modo gráfico deseado)
        MOV AH, 0h ; activa modo texto
        MOV AL, 03h ; modo gráfico deseado
        INT 10h
        RET

    movercursor:
        ;Similar a usar una función en alto nivel
        ;MoverCursor(parametro1, parametro2, parametro3,...)
        ;Donde: Parametro1 = DH (fila del cursor), parametro2 = DL (columna del cursor), parametro 3 = BH (número de página)
        MOV AH, 02h ; posiciona el cursor en pantalla.
        MOV BH, 0h 
        INT 10h
        RET

    escribircaracter:
        ;Similar a usar una función en alto nivel
        ;EscribirCaracter(parametro1, parametro2, parametro3,...)
        ;Donde: parametro1 = AL (caracter), parametro2 = BH (número de página), parametro3 = BL (estilo del texto en 8 bits)...
        MOV AH, 0Ah ; escribe caracter en pantalla según posición del cursor
        MOV AL, CL ; denotamos el caracter a escribir en pantalla, los valores deben ser según código hexadecimal de tabla ASCII
        MOV BH, 0h ; número de página
        MOV CX, 1h ; número de veces a escribir el caracter
        INT 10h
        RET

    esperartecla:
        ;Se espera que el usuario presione una tecla
        MOV AH, 00h ;espera buffer del teclado para avanzar en la siguiente instrucción
        INT 16h

    salto: ;iteracion que realiza el salto en las filas
        MOV DL,21
        RET 

    exit:
        int 20h

    section .data

    cadena DB ' Gabriela Cecilia Salguero Moreno'