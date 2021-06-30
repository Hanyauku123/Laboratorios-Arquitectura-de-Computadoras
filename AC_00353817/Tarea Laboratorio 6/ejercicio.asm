; GUARDAR UNA CADENA EN UN VARIABLE Y COMPARARLA CON UNA CADENA PREVIAMENTE GUARDADA
; MAIN
	org 	100h

	section	.text

	; print pass
	mov 	DX, pass
	call  	EscribirCadena

	; input savePass
	mov 	BP, savePass
	call  	LeerCadena

	call	EsperarTecla

	int 	20h

	section	.data

correctPass	db	"admin", "$"
right   db  "Bienvenido!", "$"
wrong   db  "Incorrecto!", "$"

pass	db	"Enter your password: ", "$"
savePass 	times 	5  	db	" " 

; FUNCIONES

; Permite leer un carácter de la entrada estándar con echo
; Parámetros:   AH: 07h         
; Salida:       AL: caracter ASCII leído
EsperarTecla:
        mov     AH, 01h         
        int     21h
        ret


; Leer cadena de texto desde el teclado
; Salida:       SI: longitud de la cadena 		BP: direccion de guardado
LeerCadena:
        xor     SI, SI          ; SI = 0
while:  
        call    EsperarTecla    ; retorna un caracter en AL
        cmp     AL, 0x0D        ; comparar AL con caracter EnterKey
        ;je      exit	    	; si AL == EnterKey, saltar a exit
		je 	CompararPassword
        mov     [BP+SI], AL   	; guardar caracter en memoria
        inc     SI              ; SI++
        jmp     while           ; saltar a while

exit:
		mov 	byte [BP+SI], "$"	; agregar $ al final de la cadena
        ret

CompararPassword:
		xor SI, SI
loop:
		mov AL, [BP+SI]
		cmp [correctPass+SI], AL
		je LongCadenas
		jne wrongPass
		;jmp exit

rightPass: 
	mov AH, 09h
	mov DX, right
	int 21h
	jmp exit

wrongPass:
	mov AH, 09h
	mov DX, wrong
	int 21h
	jmp exit

LongCadenas:
	cmp SI, 4
	je rightPass
	inc SI
	jmp loop
	;jmp exit

; Permite escribir en la salida estándar una cadena de caracteres o string, este
; debe tener como terminación el carácter “$”
; Parámetros:	AH: 09h 	DX: dirección de la celda de memoria inicial de la cadena
EscribirCadena:
	mov 	AH, 09h
	int 	21h
	ret  