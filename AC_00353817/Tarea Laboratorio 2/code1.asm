        org 	100h

        section	.text

        mov byte[200h], "G"
        mov byte[201h], "C"
        mov byte[202h], "S"
        mov byte[203h], "M"

;       Direccionamiento directo
        mov     AX, [200h]

;       Direccionamiento indirecto por registro
        mov     BX, [201h]
        mov     CX, BX

;       Direccionamiento indirecto base mas indice
        mov     BP, 200h
        mov     SI, 002h
        mov     DX, [BP+SI]

;       Direccionamento relativo por registro
        mov     DI, [BP+003h]